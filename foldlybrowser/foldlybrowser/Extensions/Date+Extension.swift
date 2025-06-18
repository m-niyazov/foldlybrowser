//
//  Date+Extension.swift
//  tralala-creator
//
//  Created by TapticGroup on 27.03.2025.
//

import Foundation

extension Date {
    /// Возвращает строку в формате "yyyy-MM-dd" с фиксированной временной зоной
        func toString(format: String = "yyyy-MM-dd") -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: self)
        }

    var iso8601: String {
        let iso8601DateFormatter = ISO8601DateFormatter()
        iso8601DateFormatter.formatOptions = [.withFullDate]
        return iso8601DateFormatter.string(from: self)
    }

    var getTimeString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.locale = .current
        return dateFormatter.string(from: self)
    }

    static func getTodayDateWitCustomTime(hour: Int, minute: Int) -> Date {
        Calendar.current.date(bySettingHour: hour, minute: minute, second: 0, of: Date())!
    }
}
