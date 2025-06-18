import Foundation
import StoreKit

extension SKProduct.PeriodUnit {
    func toCalendarUnit() -> NSCalendar.Unit {
        switch self {
        case .day:
            return .day
        case .month:
            return .month
        case .week:
            return .weekOfMonth
        case .year:
            return .year
        @unknown default:
            debugPrint("Unknown period unit")
        }
        return .day
    }
}

extension SKProductSubscriptionPeriod {
    func periodType() -> String {
        if unit == .day && numberOfUnits == 7 {
            return "weekly"
        } else if unit == .month && numberOfUnits == 1 {
            return "monthly"
        } else if unit == .month && numberOfUnits == 3 {
            return "quarterly"
        } else if unit == .month && numberOfUnits == 6 {
            return "half-yearly"
        } else if unit == .year && numberOfUnits == 1 {
            return "yearly"
        } else {
            return "other"
        }
    }

    func localized() -> String? {
        return PeriodFormatter.format(unit: unit.toCalendarUnit(), numberOfUnits: numberOfUnits)
    }
}

extension SKProductDiscount {
    func localizedDiscount() -> String? {
        switch paymentMode {
        case PaymentMode.freeTrial:
            return subscriptionPeriod.localized()
        default:
            return nil
        }
    }
}

extension SKProduct {
    func localizedPrice() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = self.priceLocale
        return formatter.string(from: self.price) ?? ""
    }

    func localizedIntroOfferPrice() -> String? {
        if let price = self.introductoryPrice?.price as? NSNumber {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.locale = self.priceLocale
            return formatter.string(from: price) ?? ""
        } else {
            return nil
        }
    }
}
