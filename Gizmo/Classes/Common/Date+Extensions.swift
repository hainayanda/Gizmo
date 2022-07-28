//
//  Date+Extensions.swift
//  Gizmo
//
//  Created by Nayanda Haberty on 27/07/22.
//

import Foundation

public extension Date {
    
    @inlinable var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    @inlinable var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    @inlinable var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }
    
    @inlinable var isPast: Bool {
        Date() > self
    }
    
    @inlinable var isFuture: Bool {
        Date() < self
    }
    
    /// true if the date is considered as now. The error tolerable is +- 1 microsecond from actual Date now
    @inlinable var isNow: Bool {
        abs(self.timeLeft(to: Date())) < 1.microSeconds
    }
    
    /// Return time left from this date to another date
    /// It will be negative if another date is less than this date
    /// - Parameter other: other date
    /// - Returns: time left to other date
    func timeLeft(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - timeIntervalSinceReferenceDate
    }
    
    /// Convert date to given string format
    /// Formatting is using default DateFormatter from Swift
    /// Please refer to those classes for more information
    /// - Parameter format: Date string format
    /// - Parameter timeZone: timezone used, it will use NSTimeZone.default defaultly
    /// - Returns: Formatted String from this Date
    func dateString(_ format: String, timeZone: TimeZone = NSTimeZone.default) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

public extension Date {
    /// Initialize date from String with a given format
    /// It will produce nil if fail
    /// Formatting is using default DateFormatter from Swift
    /// Please refer to those classes for more information
    /// - Parameters:
    ///   - string: string with the given format
    ///   - format: Date string format
    ///   - timeZone: timezone used, it will use NSTimeZone.default defaultly
    init?(_ string: String, format: String, timeZone: TimeZone = NSTimeZone.default) {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZone
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: string) else { return nil }
        self = date
    }
}
