import Foundation
import StoreKit

struct Paywall {
    let id: String
    let experimentName: String?
    let variationName: String?
    let json: [String: Any]?
    let subscriptions: [SubscriptionTerm]

    struct SubscriptionTerm {
        let productId: String
        let localizedPeriod: String
        let localizedPrice: String
        let price: Double
        let currencySymbol: String
        let periodType: PeriodType
        let trialPeriod: String?
        let introductoryOfferType: SKProductDiscount.PaymentMode?
        let introductoryOfferDurationDays: Int
        let payAsYouGoPrice: Double?
        let payAsYouGolocalizedPrice: String?

        enum PeriodType: String {
            case weekly
            case monthly
            case quarterly
            case halfYearly
            case yearly
            case lifetime
            case other

            func getLocalizedString() -> String {
                switch self {
                case .weekly:
                    return  String(localized: "paywall.weekly")
                case .monthly:
                    return String(localized: "paywall.monthly")
                case .quarterly:
                    return String(localized: "paywall.quarterly")
                case .halfYearly:
                    return String(localized: "paywall.halfYearly")
                case .yearly:
                    return String(localized: "paywall.annual")
                case .lifetime:
                    return String(localized: "paywall.lifetime")
                case .other:
                    return String()
                }
            }

            func numberOfWeek() -> Int {
                switch self {
                case .weekly:
                    return 1
                case .monthly:
                    return 4
                case .quarterly:
                    return 12
                case .halfYearly:
                    return 26
                case .yearly:
                    return 48
                case .lifetime:
                    return 0
                case .other:
                    return 0
                }
            }

            func numberOfMonths() -> Int {
                switch self {
                case .weekly:
                    return 1 / 4  // Примерно 0, т.к. 1 неделя это не полный месяц
                case .monthly:
                    return 1
                case .quarterly:
                    return 3
                case .halfYearly:
                    return 6
                case .yearly:
                    return 12
                case .lifetime:
                    return 0
                case .other:
                    return 0
                }
            }
        }
    }
}

protocol SubscriptionService {
    var isPremium: Bool { get }

    func loadPaywall(exactId: String, completion: @escaping (Paywall?) -> Void)
    func purchase(productId: String) async throws
    func restorePurchases() async throws
    func paywallClosed()
}
