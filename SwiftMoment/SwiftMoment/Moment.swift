//
//  Moment.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

// Swift adaptation of Moment.js http://momentjs.com
// Github: https://github.com/moment/moment/

import Foundation

/**
 Returns a moment representing the current instant in time at the current timezone

 - parameter timeZone:   An NSTimeZone object
 - parameter locale:     An NSLocale object

 - returns: A moment instance.
 */
public func moment(_ timeZone: TimeZone = TimeZone.default,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment {
    return Moment(timeZone: timeZone, locale: locale)
}

public func utc() -> Moment {
    let zone = TimeZone(abbreviation: "UTC")!
    return moment(zone)
}

/**
 Returns an Optional wrapping a Moment structure, representing the
 current instant in time. If the string passed as parameter cannot be
 parsed by the function, the Optional wraps a nil value.

 - parameter stringDate: A string with a date representation.
 - parameter timeZone:   An NSTimeZone object
 - parameter locale:     An NSLocale object

 - returns: <#return value description#>
 */
public func moment(_ stringDate: String,
                   timeZone: TimeZone = TimeZone.default,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment? {

    let formatter = DateFormatter()
    formatter.timeZone = timeZone
    formatter.locale = locale
    let isoFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"

    // The contents of the array below are borrowed
    // and adapted from the source code of Moment.js
    // https://github.com/moment/moment/blob/develop/moment.js
    let formats = [
        isoFormat,
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
        "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
        "yyyy-MM-dd",
        "h:mm:ss A",
        "h:mm A",
        "MM/dd/yyyy",
        "MMMM d, yyyy",
        "MMMM d, yyyy LT",
        "dddd, MMMM D, yyyy LT",
        "yyyyyy-MM-dd",
        "yyyy-MM-dd",
        "GGGG-[W]WW-E",
        "GGGG-[W]WW",
        "yyyy-ddd",
        "HH:mm:ss.SSSS",
        "HH:mm:ss",
        "HH:mm",
        "HH"
    ]

    for format in formats {
        formatter.dateFormat = format

        if let date = formatter.date(from: stringDate) {
            return Moment(date: date, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(_ stringDate: String, dateFormat: String,
                   timeZone: TimeZone = TimeZone.default,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment? {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = timeZone
    formatter.locale = locale
    if let date = formatter.date(from: stringDate) {
        return Moment(date: date, timeZone: timeZone, locale: locale)
    }
    return nil
}

/**
 Builds a new Moment instance using an array with the following components,
 in the following order: [ year, month, day, hour, minute, second ]

 - parameter params:   An array of integer values as date components
 - parameter timeZone: An NSTimeZone object
 - parameter locale:   An NSLocale object

 - returns: An optional wrapping a Moment instance
 */
public func moment(_ params: [Int], timeZone: TimeZone = TimeZone.default,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment? {
    if params.count > 0 {
        let calendar = Calendar.current
        calendar.timeZone = timeZone
        var components = DateComponents()
        components.year = params[0]

        if params.count > 1 {
            components.month = params[1]
            if params.count > 2 {
                components.day = params[2]
                if params.count > 3 {
                    components.hour = params[3]
                    if params.count > 4 {
                        components.minute = params[4]
                        if params.count > 5 {
                            components.second = params[5]
                        }
                    }
                }
            }
        }

        if let date = calendar.date(from: components) {
            return moment(date, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(_ dict: [String: Int], timeZone: TimeZone = TimeZone.default,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment? {
    if dict.count > 0 {
        var params = [Int]()
        if let year = dict["year"] {
            params.append(year)
        }
        if let month = dict["month"] {
            params.append(month)
        }
        if let day = dict["day"] {
            params.append(day)
        }
        if let hour = dict["hour"] {
            params.append(hour)
        }
        if let minute = dict["minute"] {
            params.append(minute)
        }
        if let second = dict["second"] {
            params.append(second)
        }
        return moment(params, timeZone: timeZone, locale: locale)
    }
    return nil
}

public func moment(_ milliseconds: Int) -> Moment {
    return moment(TimeInterval(milliseconds / 1000))
}

public func moment(_ seconds: TimeInterval) -> Moment {
    let interval = TimeInterval(seconds)
    let date = Date(timeIntervalSince1970: interval)
    return Moment(date: date)
}

public func moment(_ date: Date, timeZone: TimeZone = TimeZone.default,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment {
    return Moment(date: date, timeZone: timeZone, locale: locale)
}

public func moment(_ moment: Moment) -> Moment {
    let copy = ((moment.date as NSDate).copy() as? Date)!
    let timeZone = (moment.timeZone.copy() as? TimeZone)!
    let locale = (moment.locale.copy() as? Locale)!
    return Moment(date: copy, timeZone: timeZone, locale: locale)
}

public func past() -> Moment {
    return Moment(date: Date.distantPast )
}

public func future() -> Moment {
    return Moment(date: Date.distantFuture )
}

public func since(_ past: Moment) -> Duration {
    return moment().intervalSince(past)
}

public func maximum(_ moments: Moment...) -> Moment? {
    if moments.count > 0 {
        var max: Moment = moments[0]
        for moment in moments {
            if moment > max {
                max = moment
            }
        }
        return max
    }
    return nil
}

public func minimum(_ moments: Moment...) -> Moment? {
    if moments.count > 0 {
        var min: Moment = moments[0]
        for moment in moments {
            if moment < min {
                min = moment
            }
        }
        return min
    }
    return nil
}

/**
 Internal structure used by the family of moment() functions.
 Instead of modifying the native NSDate class, this is a
 wrapper for the NSDate object. To get this wrapper object, simply
 call moment() with one of the supported input types.
*/
public struct Moment: Comparable {
    public let minuteInSeconds = 60
    public let hourInSeconds = 3600
    public let dayInSeconds = 86400
    public let weekInSeconds = 604800
    public let monthInSeconds = 2592000
    public let yearInSeconds = 31536000

    public let date: Date
    public let timeZone: TimeZone
    public let locale: Locale

    init(date: Date = Date(), timeZone: TimeZone = TimeZone.default,
         locale: Locale = Locale.autoupdatingCurrent) {
        self.date = date
        self.timeZone = timeZone
        self.locale = locale
    }

    /// Returns the year of the current instance.
    public var year: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.year, from: date)
        return components.year!
    }

    /// Returns the month (1-12) of the current instance.
    public var month: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.month, from: date)
        return components.month!
    }

    /// Returns the name of the month of the current instance, in the current locale.
    public var monthName: String {
        let formatter = DateFormatter()
        formatter.locale = locale
        return formatter.monthSymbols[month - 1]
    }

    public var day: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.day, from: date)
        return components.day!
    }

    public var hour: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.hour, from: date)
        return components.hour!
    }

    public var minute: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.minute, from: date)
        return components.minute!
    }

    public var second: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.second, from: date)
        return components.second!
    }

    public var weekday: Int {
        let cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.weekday, from: date)
        return components.weekday!
    }

    public var weekdayName: String {
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "EEEE"
        formatter.timeZone = timeZone
        return formatter.string(from: date)
    }

    public var weekdayOrdinal: Int {
        let cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.weekdayOrdinal, from: date)
        return components.weekdayOrdinal!
    }

    public var weekOfYear: Int {
        let cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.weekOfYear, from: date)
        return components.weekOfYear!
    }

    public var quarter: Int {
        let cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.quarter, from: date)
        return components.quarter!
    }

    // Methods

    public func get(_ unit: TimeUnit) -> Int? {
        switch unit {
        case .Seconds:
            return second
        case .Minutes:
            return minute
        case .Hours:
            return hour
        case .Days:
            return day
        case .Weeks:
            return weekOfYear
        case .Months:
            return month
        case .Quarters:
            return quarter
        case .Years:
            return year
        }
    }

    public func get(_ unitName: String) -> Int? {
        if let unit = TimeUnit(rawValue: unitName) {
            return get(unit)
        }
        return nil
    }

    public func format(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss ZZZZ") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: date)
    }

    public func isEqualTo(_ moment: Moment) -> Bool {
        return (date == moment.date)
    }

    public func intervalSince(_ moment: Moment) -> Duration {
        let interval = date.timeIntervalSince(moment.date)
        return Duration(value: Int(interval))
    }

    public func add(_ value: Int, _ unit: TimeUnit) -> Moment {
        var components = DateComponents()
        switch unit {
        case .Years:
            components.year = value
        case .Quarters:
            components.month = 3 * value
        case .Months:
            components.month = value
        case .Weeks:
            components.day = 7 * value
        case .Days:
            components.day = value
        case .Hours:
            components.hour = value
        case .Minutes:
            components.minute = value
        case .Seconds:
            components.second = value
        }
        let cal = Calendar(calendarIdentifier: Calendar.Identifier.gregorian)!
        cal.timeZone = timeZone
        cal.locale = locale
        if let newDate = cal.date(byAdding: components, to: date,
                                                    options: Calendar.Options.init(rawValue: 0)) {
          return Moment(date: newDate)
        }
        return self
    }

    public func add(_ value: TimeInterval, _ unit: TimeUnit) -> Moment {
        let seconds = convert(value, unit)
        let interval = TimeInterval(seconds)
        let newDate = date.addingTimeInterval(interval)
        return Moment(date: newDate)
    }

    public func add(_ value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return add(value, unit)
        }
        return self
    }

    public func add(_ duration: Duration) -> Moment {
        return add(duration.interval, .Seconds)
    }

    public func subtract(_ value: TimeInterval, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    public func subtract(_ value: Int, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    public func subtract(_ value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return subtract(value, unit)
        }
        return self
    }

    public func subtract(_ duration: Duration) -> Moment {
        return subtract(duration.interval, .Seconds)
    }

    public func isCloseTo(_ moment: Moment, precision: TimeInterval = 300) -> Bool {
        // "Being close" is measured using a precision argument
        // which is initialized a 300 seconds, or 5 minutes.
        let delta = intervalSince(moment)
        return abs(delta.interval) < precision
    }

    public func startOf(_ unit: TimeUnit) -> Moment {
        let cal = Calendar.current
        var newDate: Date?
        var components = cal.components([.year, .month, .weekday, .day, .hour, .minute, .second],
                                        from: date)
        switch unit {
        case .Seconds:
            return self
        case .Years:
            components.month = 1
            fallthrough
        case .Quarters, .Months, .Weeks:
            if unit == .Weeks {
              guard let day = components.day, weekday = components.weekday else {
                fatalError()
              }
              components.day = day - (weekday - 2)
            } else {
                components.day = 1
            }
            fallthrough
        case .Days:
            components.hour = 0
            fallthrough
        case .Hours:
            components.minute = 0
            fallthrough
        case .Minutes:
            components.second = 0
        }
        newDate = cal.date(from: components)
        return newDate == nil ? self : Moment(date: newDate!)
    }

    public func startOf(_ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return startOf(unit)
        }
        return self
    }

    public func endOf(_ unit: TimeUnit) -> Moment {
        return startOf(unit).add(1, unit).subtract(1.seconds)
    }

    public func endOf(_ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return endOf(unit)
        }
        return self
    }

    public func epoch() -> TimeInterval {
        return date.timeIntervalSince1970
    }

    // Private methods

    func convert(_ value: Double, _ unit: TimeUnit) -> Double {
        switch unit {
        case .Seconds:
            return value
        case .Minutes:
            return value * 60
        case .Hours:
            return value * 3600 // 60 minutes
        case .Days:
            return value * 86400 // 24 hours
        case .Weeks:
            return value * 605800 // 7 days
        case .Months:
            return value * 2592000 // 30 days
        case .Quarters:
            return value * 7776000 // 3 months
        case .Years:
            return value * 31536000 // 365 days
        }
    }
}

extension Moment: CustomStringConvertible {
    public var description: String {
        return format()
    }
}

extension Moment: CustomDebugStringConvertible {
    public var debugDescription: String {
        return description
    }
}
