import ApphudSDK
import StoreKit

final class ApphudSubscriptionService: SubscriptionService {
    var isPremium: Bool {
        Apphud.hasPremiumAccess() ||
        Apphud.hasActiveSubscription()
    }

    private var selectedPaywall: ApphudPaywall?

    @MainActor private var isTrialEnabled: Bool {
        guard let subscriptions = Apphud.subscriptions() else {
            return false
        }
        return !subscriptions.contains(where: { $0.isIntroductoryActivated })
    }

    @MainActor
    func loadPaywall(exactId: String, completion: @escaping (Paywall?) -> Void) {
        let apphud = Apphud.self
        var terms = [Paywall.SubscriptionTerm]()

        apphud.paywallsDidLoadCallback { paywalls, _ in
            let apphudPaywall = paywalls.first { $0.identifier == exactId }

            guard let apphudPaywall = apphudPaywall,
                  apphudPaywall.products.isEmpty == false else {
                completion(nil)
                return
            }

            self.selectedPaywall = apphudPaywall

            let products = apphudPaywall.products.compactMap({ product in
                product.skProduct
            })

            products.enumerated().forEach { index, product in
                let trialPeriod = product.introductoryPrice?.subscriptionPeriod.localized()
                let trial = (trialPeriod != nil) ? trialPeriod : nil
                let product = products[index]
                let introductoryOfferType = product.introductoryPrice?.paymentMode
                var localizedPeriod = String()
                var periodType: Paywall.SubscriptionTerm.PeriodType = .other
                if let subscriptionPeriod = product.subscriptionPeriod {
                    localizedPeriod = subscriptionPeriod.localized() ?? ""
                    periodType = .init(rawValue: subscriptionPeriod.periodType())!
                } else {
                    localizedPeriod = String(localized: "paywall.lifetime")
                    periodType = .lifetime
                }
                let term = Paywall.SubscriptionTerm(
                    productId: product.productIdentifier,
                    localizedPeriod: localizedPeriod,
                    localizedPrice: product.localizedPrice(),
                    price: product.price.doubleValue,
                    currencySymbol: product.priceLocale.currencySymbol ?? "$",
                    periodType: periodType,
                    trialPeriod: trial,
                    introductoryOfferType: introductoryOfferType,
                    introductoryOfferDurationDays: product.introductoryPrice?.subscriptionPeriod.numberOfUnits ?? 0,
                    payAsYouGoPrice: product.introductoryPrice?.price as? Double,
                    payAsYouGolocalizedPrice: product.localizedIntroOfferPrice()
                )
                terms.append(term)
            }
            Apphud.paywallShown(apphudPaywall)
            completion(
                Paywall(
                    id: apphudPaywall.identifier,
                    experimentName: apphudPaywall.experimentName,
                    variationName: apphudPaywall.variationName,
                    json: apphudPaywall.json,
                    subscriptions: terms
                )
            )
        }
    }

    func paywallClosed() {
        guard let selectedPaywall = selectedPaywall else {
            return
        }
        Apphud.paywallClosed(selectedPaywall)
    }

    @MainActor
    func purchase(productId: String) async throws {
        let product = self.selectedPaywall?.products.first { $0.productId == productId }
        guard let product = product else {
            throw PaywallErrors.other("Not Found Product")
        }
        let result = await Apphud.purchase(product, isPurchasing: nil)
        if result.success {
            if let subscription = result.subscription, subscription.isActive() {
                return
            } else if let purchase = result.nonRenewingPurchase, purchase.isActive() {
                return
            } else {
                throw PaywallErrors.cancelled
            }
        } else if let error = result.error as? SKError {
            if error.code == .paymentCancelled {
                throw PaywallErrors.cancelled
            } else {
                throw PaywallErrors.other(error.localizedDescription)
            }
        } else {
            throw PaywallErrors.other("Unexpected Error")
        }
    }

    func restorePurchases() async throws {
        let error = await Apphud.restorePurchases()
        if let error = error {
            throw PaywallErrors.other(error.localizedDescription)
        }
        guard Apphud.hasActiveSubscription() || Apphud.hasPremiumAccess() else {
            throw PaywallErrors.other("Not Active Premium: Line 114")
        }
        return
    }
}

enum PaywallErrors: Error {
    case cancelled
    case other(String)
    case loading
}
