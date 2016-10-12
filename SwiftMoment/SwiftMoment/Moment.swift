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


/// Returns a moment representing the current instant in time at the current timezone.
/// This is the most common way to create a new Moment value:
///
///     let today = moment()
///
/// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
/// - parameter locale:   An optional Locale value, defaulting to the current locale
///
/// - returns: A Moment value.
public func moment(_ timeZone: TimeZone = TimeZone.current,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment {
    return Moment(timeZone: timeZone, locale: locale)
}


/// Returns a moment representing the current instant in the GMT / UTC timezone:
///
///     let greenwich = utc()
///     let str = greenwich.format("ZZZZ")
///     // str is "GMT"
///
/// - returns: A Moment value with the GMT / UTC timezone.
public func utc() -> Moment {
    let zone = TimeZone(abbreviation: "UTC")!
    return moment(zone)
}


/// Returns an Optional wrapping a Moment structure, representing the 
/// current instant in time. If the string passed as parameter is invalid, 
/// the Optional wraps a nil value.
///
/// Valid date format strings:
///
/// - "yyyy-MM-dd'T'HH:mm:ssZZZZZ" (ISO)
/// - "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
/// - "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'",
/// - "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
/// - "yyyy-MM-dd",
/// - "h:mm:ss A",
/// - "h:mm A",
/// - "MM/dd/yyyy",
/// - "MMMM d, yyyy",
/// - "MMMM d, yyyy LT",
/// - "dddd, MMMM D, yyyy LT",
/// - "yyyyyy-MM-dd",
/// - "yyyy-MM-dd",
/// - "GGGG-[W]WW-E",
/// - "GGGG-[W]WW",
/// - "yyyy-ddd",
/// - "HH:mm:ss.SSSS",
/// - "HH:mm:ss",
/// - "HH:mm",
/// - "HH"
///
/// Usage:
///
///     let dateString = "2016-10-12T10:02:50"
///     let birthday = moment(dateString)
///     // birthday is not nil
///
/// - parameter stringDate: A string with a valid date format, as required by NSDateFormatter
/// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
/// - parameter locale:   An optional Locale value, defaulting to the current locale
///
/// - returns: An optional Moment value.
public func moment(_ stringDate: String,
                   timeZone: TimeZone = TimeZone.current,
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


/// Builds a Moment value using a date in string format, using the second
/// parameter to know how to parse the values. If any of the parameters is
/// invalid, the function returns nil.
///
///     let date = "2016-10-12T10:02:50"
///     let format = "yyy-MM-dd'T'HH:mm:ss"
///     let birthday = moment(date, dateFormat: format)
///     // birthday is not nil
///
/// - parameter stringDate: A string with the date to parse.
/// - parameter dateFormat: A string with the specification of the format.
/// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
/// - parameter locale:   An optional Locale value, defaulting to the current locale
///
/// - returns: An optional Moment value.
public func moment(_ stringDate: String,
                   dateFormat: String,
                   timeZone: TimeZone = TimeZone.current,
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


/// Builds a new Moment instance using an array with the following components, 
/// in the following order: [ year, month, day, hour, minute, second ]. This means
/// that the first element of the array will always be taken as the year, the second
/// as the month, and so on. If any of the parameters is invalid, the function will
/// return nil.
///
///     let obj = moment([2015, 01, 19, 20, 45, 34])
///     // obj is not only not nil, it points to January 19th 2015 at 20:45:34
///     // in the current timezone.
///
/// When the array is incomplete, the function will fill the missing parameters with
/// the first logical value, for example midnight or the first of January.
///
/// - parameter params:   An array of integer values as date components
/// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
/// - parameter locale:   An optional Locale value, defaulting to the current locale
///
/// - returns: An optional wrapping a Moment instance.
public func moment(_ params: [Int],
                   timeZone: TimeZone = TimeZone.current,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment? {
    if params.count > 0 {
        var calendar = Calendar.current
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


/// Builds a Moment value using the dictionary of values passed as first parameter:
/// If all keys in the dictionary are invalid, the function returns nil.
///
/// Valid keys:
///
/// - "year"
/// - "month"
/// - "day"
/// - "hour"
/// - "minute"
/// - "second"
///
/// Example:
///
///     let obj = moment(["year": 2015,
///                       "second": 34,
///                       "month": 01,
///                       "minute": 45,
///                       "day": 19,
///                       "hour": 20,
///                       "ignoredKey": 2342432])!
///
/// - parameter dict:     A Dictionary of string keys and integer values.
/// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
/// - parameter locale:   An optional Locale value, defaulting to the current locale
///
/// - returns: An optional Moment value.
public func moment(_ dict: [String: Int],
                   timeZone: TimeZone = TimeZone.current,
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


/// Builds a Moment value corresponding to the number of milliseconds since the Unix Epoch.
///
///     let epoch = moment(0)
///     // Represents the origin of Unix time
///
/// - parameter milliseconds: An integer value with milliseconds.
///
/// - returns: A non-optional Moment value.
public func moment(_ milliseconds: Int) -> Moment {
    return moment(TimeInterval(milliseconds / 1000))
}


/// Builds a Moment value corresponding to the number of seconds since the Unix Epoch.
///
///     let epoch = moment(0.0)
///     // Represents the origin of Unix time
///
/// - parameter milliseconds: A TimeInterval value with seconds.
///
/// - returns: A non-optional Moment value.
public func moment(_ seconds: TimeInterval) -> Moment {
    let interval = TimeInterval(seconds)
    let date = Date(timeIntervalSince1970: interval)
    return Moment(date: date)
}


/// Builds a Moment value using the Date value passed as parameter.
/// This is another very common way to create new Moment values.
///
///     let date = Date()
///     let now = moment(date)
///
/// - parameter date:     A Foundation Date object.
/// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
/// - parameter locale:   An optional Locale value, defaulting to the current locale
///
/// - returns: A non-optional Moment value.
public func moment(_ date: Date,
                   timeZone: TimeZone = TimeZone.current,
                   locale: Locale = Locale.autoupdatingCurrent) -> Moment {
    return Moment(date: date, timeZone: timeZone, locale: locale)
}


/// Copies a Moment value and returns a new one.
///
///     let epoch = moment(0)
///     let copy = moment(epoch)
///
/// - parameter moment: The Moment value to copy.
///
/// - returns: A new Moment value, with the same date, timezone and locale as the original.
public func moment(_ moment: Moment) -> Moment {
    let date = moment.date
    let timeZone = moment.timeZone
    let locale = moment.locale
    return Moment(date: date, timeZone: timeZone, locale: locale)
}

/// Copies a Moment value and returns a new one, with a new timezone.
///
///     let timeZone = TimeZone(secondsFromGMT: -10800)!
///     let locale = Locale(identifier: "en_US_POSIX")
///     let dateString = "2016-10-12T10:02:50"
///     let dateFormat = "yyy-MM-dd'T'HH:mm:ss"
///     let birthday = moment(dateString, dateFormat: dateFormat, timeZone: timeZone, locale: locale)!
///     let formatted = birthday.format(dateFormat)
///
///     let pacific = TimeZone(abbreviation: "PST")!
///     let birthdayInSF = moment(birthday, timeZone: pacific)
///
///     XCTAssertEqual(birthday.hour, 10)
///     XCTAssertEqual(birthday.minute, 2)
///     XCTAssertEqual(birthdayInSF.hour, 6)
///     XCTAssertEqual(birthdayInSF.minute, 2)
///
/// - parameter moment: The Moment value to copy.
///
/// - returns: A new Moment value, with the same date, timezone and locale as the original.
public func moment(_ moment: Moment, timeZone: TimeZone) -> Moment {
    let date = moment.date
    let locale = moment.locale
    return Moment(date: date, timeZone: timeZone, locale: locale)
}


/// Returns a Moment value set in the distant past.
///
/// - returns: A Moment value set in the distant past.
public func past() -> Moment {
    return Moment(date: Date.distantPast)
}


/// Returns a Moment value set in the distant future.
///
/// - returns: A Moment value set in the distant future.
public func future() -> Moment {
    return Moment(date: Date.distantFuture)
}

/// Returns the Duration that separates the current moment from another one.
///
/// - parameter past: The moment to compare to the current moment.
///
/// - returns: A Duration value.
public func since(_ past: Moment) -> Duration {
    return moment().intervalSince(past)
}

/// Returns the maximum, that is, the latest of all values passed in parameter.
///
/// - parameter moments: A sequence of Moment values.
///
/// - returns: The latest Moment value in the sequence.
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

/// Returns the minimum, that is, the earliest of all values passed in parameter.
///
/// - parameter moments: A sequence of Moment values.
///
/// - returns: The earliest Moment value in the sequence.
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


/// Internal structure used by the `moment()` family of functions.
/// It wraps a Foundation `Date`, a `TimeZone` and a `Locale` value.
/// To create one of these values, call one of the `moment()` family of functions.
public struct Moment: Comparable {
    public let minuteInSeconds : Double = 60
    public let hourInSeconds : Double = 3600
    public let dayInSeconds : Double = 86400
    public let weekInSeconds : Double = 604800
    public let monthInSeconds : Double = 2592000
    public let yearInSeconds : Double = 31536000

    public let date: Date
    public let timeZone: TimeZone
    public let locale: Locale

    private let _formatter = LazyBox<DateFormatter> {
        return DateFormatter()
    }

    private var formatter: DateFormatter {
        return _formatter.value
    }

    /// Initializes a new Moment value.
    ///
    /// - parameter date:     The date wrapped by the Moment value.
    /// - parameter timeZone: A TimeZone value.
    /// - parameter locale:   A Locale value.
    ///
    /// - returns: A new Moment value.
    init(date: Date = Date(), timeZone: TimeZone = TimeZone.current,
         locale: Locale = Locale.autoupdatingCurrent) {
        self.date = date
        self.timeZone = timeZone
        self.locale = locale
    }

    /// Year of the current instance.
    public var year: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.year]
        let components = cal.dateComponents(param, from: date)
        return components.year!
    }

    /// Month (1-12) of the current instance.
    public var month: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.month]
        let components = cal.dateComponents(param, from: date)
        return components.month!
    }

    /// Name of the month of the current instance, in the current locale.
    public var monthName: String {
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.monthSymbols[month - 1]
    }

    /// Day of the month (1-31) of the current instance.
    public var day: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.day]
        let components = cal.dateComponents(param, from: date)
        return components.day!
    }

    /// Hour (0-23) of the current instance.
    public var hour: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.hour]
        let components = cal.dateComponents(param, from: date)
        return components.hour!
    }

    /// Minutes (0-59) of the current instance.
    public var minute: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.minute]
        let components = cal.dateComponents(param, from: date)
        return components.minute!
    }

    /// Seconds (0-59) of the current instance.
    public var second: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.second]
        let components = cal.dateComponents(param, from: date)
        return components.second!
    }

    /// Weekday (1-7, Sunday is 1) of the current instance.
    public var weekday: Int {
        var cal = Calendar.current
        cal.timeZone = timeZone
        cal.locale = locale
        let param : Set<Calendar.Component> = [.weekday]
        let components = cal.dateComponents(param, from: date)
        return components.weekday!
    }

    /// Localized name of the day of the current instance.
    public var weekdayName: String {
        formatter.locale = locale
        formatter.dateFormat = "EEEE"
        formatter.timeZone = timeZone
        return formatter.string(from: date)
    }

    /// Weekday ordinal of the current instance. Taken from the `Calendar` documentation:
    /// "Weekday ordinal units represent the position of the weekday
    /// within the next larger calendar unit, such as the month.
    /// For example, 2 is the weekday ordinal unit for the second Friday of the month."
    public var weekdayOrdinal: Int {
        var cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        let param : Set<Calendar.Component> = [.weekdayOrdinal]
        let components = cal.dateComponents(param, from: date)
        return components.weekdayOrdinal!
    }

    /// Number of the week in the current year of the current instance.
    public var weekOfYear: Int {
        var cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        let param : Set<Calendar.Component> = [.weekOfYear]
        let components = cal.dateComponents(param, from: date)
        return components.weekOfYear!
    }

    /// Quarter of the year of the current instance.
    public var quarter: Int {
        var cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        let param : Set<Calendar.Component> = [.quarter]
        let components = cal.dateComponents(param, from: date)
        return components.quarter!
    }

    /// Gets the specified value of the current instance.
    ///
    ///     let today = moment()
    ///     let hours = today.get(.Hours)
    ///
    /// - parameter unit: A TimeUnit value, specifying the element to retrieve.
    ///
    /// - returns: A non-optional integer value.
    public func get(_ unit: TimeUnit) -> Int {
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

    /// Gets the specified value of the current instance. If the string
    /// passed as parameter does not evaluate to a `TimeUnit` instance,
    /// this method returns nil.
    ///
    /// Valid values:
    ///
    /// - Years = "y"
    /// - Quarters = "Q"
    /// - Months = "M"
    /// - Weeks = "w"
    /// - Days = "d"
    /// - Hours = "H"
    /// - Minutes = "m"
    /// - Seconds = "s"
    ///
    /// Example:
    ///
    ///     let today = moment()
    ///     let hours = today.get("H")!
    ///
    /// - parameter unit: A TimeUnit value, specifying the element to retrieve.
    ///
    /// - returns: An optional integer value.
    public func get(_ unitName: String) -> Int? {
        if let unit = TimeUnit(rawValue: unitName) {
            return get(unit)
        }
        return nil
    }

    /// Formats the current moment using the string passed as parameter.
    /// If no format is specified, the default format is `"yyyy-MM-dd HH:mm:ss ZZZZ"`
    ///
    ///     let birthday = moment("1973-09-04")
    ///     let standard = birthday.format()
    ///     // standard is now "1973-09-04 00:00:00 GMT+01:00"
    ///
    /// - parameter dateFormat: A valid format string.
    ///
    /// - returns: A string representing the current moment.
    public func format(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss ZZZZ") -> String {
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: date)
    }

    /// Formats the current moment using the string and timezone passed as parameter.
    /// If no format is specified, the default format is `"yyyy-MM-dd HH:mm:ss ZZZZ"`
    ///
    ///     let cet = TimeZone(abbreviation: "CET")!
    ///     let birthday = moment("1973-09-04", timeZone: cet)!
    ///     let pst = TimeZone(abbreviation: "PST")!
    ///     let str = birthday.format("EE QQQQ yyyy/dd/MMMM HH:mm ZZZZ", pst)
    ///     // str shows the time in the Pacific time zone for that event
    ///
    /// - parameter dateFormat: A valid format string.
    /// - parameter timeZone: An optional TimeZone value, defaulting to the current timezone
    ///
    /// - returns: A string representing the current moment in the specified timezone.
    public func format(_ dateFormat: String = "yyyy-MM-dd HH:mm:ss ZZZZ",
                       _ timeZone: TimeZone = TimeZone.current) -> String {
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.string(from: date)
    }

    /// Verifies whether the current Moment is equal to the one passed in parameter.
    ///
    /// - parameter moment: The Moment value to compare to.
    ///
    /// - returns: A boolean value; true if equal, false otherwise.
    public func isEqualTo(_ moment: Moment) -> Bool {
        return (date == moment.date)
    }

    /// Returns the `Duration` value that represents the time interval between
    /// the current instance and the one passed in parameter.
    ///
    /// - parameter moment: The Moment value to compare to.
    ///
    /// - returns: A Duration value.
    public func intervalSince(_ moment: Moment) -> Duration {
        let interval = date.timeIntervalSince(moment.date)
        return Duration(value: Int(interval))
    }

    /// Adds the specified value in the specified time unit to the current
    /// instance and returns a new Moment instance.
    ///
    ///     let old = moment("2016-07-01")!
    ///     let new = problem.add(1, .Months)
    ///     let expected = moment("2016-07-31")!
    ///     // and "new" is equal to "expected"
    ///
    /// - parameter value: The amount to add.
    /// - parameter unit:  The unit of the amount to add.
    ///
    /// - returns: A new Moment instance.
    public func add(_ value: Int, _ unit: TimeUnit) -> Moment {
        var interval = Double(value)
        switch unit {
        case .Years:
            interval = value.years.interval
        case .Quarters:
            interval = value.quarters.interval
        case .Months:
            interval = value.months.interval
        case .Weeks:
            interval = value.weeks.interval
        case .Days:
            interval = value.days.interval
        case .Hours:
            interval = value.hours.interval
        case .Minutes:
            interval = value.minutes.interval
        case .Seconds:
            interval = Double(value)
        }
        return add(TimeInterval(interval), .Seconds)
    }

    /// Adds the specified value in the specified TimeInterval to the current
    /// instance and returns a new Moment instance.
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom2 = mom1.add(1.0, .Months)
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     // mom2 is equal to mom3, because duration adds exactly 30 days
    ///
    /// - parameter value: The amount to add.
    /// - parameter unit:  The unit of the amount to add.
    ///
    /// - returns: A new Moment instance.
    public func add(_ value: TimeInterval, _ unit: TimeUnit) -> Moment {
        let seconds = convert(value, unit)
        let interval = TimeInterval(seconds)
        let newDate = date.addingTimeInterval(interval)
        return Moment(date: newDate, timeZone: timeZone)
    }

    /// Adds the specified value in the specified TimeInterval to the current
    /// instance and returns a new Moment instance.
    ///
    /// Valid unit values:
    ///
    /// - Years = "y"
    /// - Quarters = "Q"
    /// - Months = "M"
    /// - Weeks = "w"
    /// - Days = "d"
    /// - Hours = "H"
    /// - Minutes = "m"
    /// - Seconds = "s"
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom2 = mom1.add(1, "M")
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     // mom2 is equal to mom3, because duration adds exactly 30 days
    ///
    /// - parameter value: The amount to add.
    /// - parameter unit:  The name of the unit of the amount to add.
    ///
    /// - returns: A new Moment instance.
    public func add(_ value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return add(value, unit)
        }
        return self
    }

    /// Adds the specified duration to the current instance and returns a new Moment.
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom2 = mom1.add(1.months)
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     // mom2 is equal to mom3, because duration adds exactly 30 days
    ///
    /// - parameter duration: The duration to add.
    ///
    /// - returns: A new Moment instance.
    public func add(_ duration: Duration) -> Moment {
        return add(duration.interval, .Seconds)
    }

    /// Substracts the specified value in the specified TimeInterval to the current
    /// instance and returns a new Moment instance.
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     let mom2 = mom3.substract(1.0, .Months)
    ///     // mom2 is equal to mom1, because duration equals exactly 30 days
    ///
    /// - parameter value: The amount to substract.
    /// - parameter unit:  The unit of the amount to substract.
    ///
    /// - returns: A new Moment instance.
    public func subtract(_ value: Int, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    /// Substracts the specified value in the specified TimeInterval to the current
    /// instance and returns a new Moment instance.
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     let mom2 = mom3.substract(1.0, .Months)
    ///     // mom2 is equal to mom1, because duration equals exactly 30 days
    ///
    /// - parameter value: The amount to substract.
    /// - parameter unit:  The unit of the amount to substract.
    ///
    /// - returns: A new Moment instance.
    public func subtract(_ value: TimeInterval, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    /// Substracts the specified value in the specified TimeInterval to the current
    /// instance and returns a new Moment instance.
    ///
    /// Valid unit values:
    ///
    /// - Years = "y"
    /// - Quarters = "Q"
    /// - Months = "M"
    /// - Weeks = "w"
    /// - Days = "d"
    /// - Hours = "H"
    /// - Minutes = "m"
    /// - Seconds = "s"
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     let mom2 = mom3.substract(1, "M")
    ///     // mom2 is equal to mom1, because duration equals exactly 30 days
    ///
    /// - parameter value: The amount to substract.
    /// - parameter unit:  The name of the unit of the amount to substract.
    ///
    /// - returns: A new Moment instance.
    public func subtract(_ value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return subtract(value, unit)
        }
        return self
    }

    /// Substracts the specified duration to the current instance and returns a new Moment.
    ///
    ///     let mom1 = moment([2015, 7, 29, 0, 0])!
    ///     let mom3 = moment([2015, 8, 28, 0, 0])!
    ///     let mom2 = mom3.substract(1.months)
    ///     // mom2 is equal to mom1, because duration equals exactly 30 days
    ///
    /// - parameter duration: The duration to substract.
    ///
    /// - returns: A new Moment instance.
    public func subtract(_ duration: Duration) -> Moment {
        return subtract(duration.interval, .Seconds)
    }

    /// Decides whether a moment is "close by" another one passed in parameter,
    /// where "Being close" is measured using a precision argument
    /// which is initialized a 300 seconds, or 5 minutes.
    ///
    /// - parameter moment:    The moment used for the comparison.
    /// - parameter precision: The precision of the comparison, initialized at 300 seconds
    ///
    /// - returns: A boolean; true if close by, false otherwise.
    public func isCloseTo(_ moment: Moment, precision: TimeInterval = 300) -> Bool {
        let delta = intervalSince(moment)
        return abs(delta.interval) < precision
    }

    /// Returns a new Moment that is initialized at the start of a specified unit of time.
    ///
    /// - parameter unit: A TimeUnit value.
    ///
    /// - returns: A new Moment instance.
    public func startOf(_ unit: TimeUnit) -> Moment {
        var cal = Calendar.current
        cal.locale = locale
        cal.timeZone = timeZone
        var newDate: Date?
        let param : Set<Calendar.Component> = [.year, .month, .weekday, .day, .hour, .minute, .second]
        var components = cal.dateComponents(param, from: date)
        switch unit {
        case .Seconds:
            return self
        case .Years:
            components.month = 1
            fallthrough
        case .Quarters, .Months, .Weeks:
            if unit == .Weeks {
                components.day = components.day! - (components.weekday! - 2)
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
        return newDate == nil ? self : Moment(date: newDate!, timeZone: timeZone)
    }

    /// Returns a new Moment that is initialized at the start of a specified unit of time.
    ///
    /// Valid unit values:
    ///
    /// - Years = "y"
    /// - Quarters = "Q"
    /// - Months = "M"
    /// - Weeks = "w"
    /// - Days = "d"
    /// - Hours = "H"
    /// - Minutes = "m"
    /// - Seconds = "s"
    ///
    /// - parameter unit: The name of a TimeUnit value.
    ///
    /// - returns: A new Moment instance.
    public func startOf(_ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return startOf(unit)
        }
        return self
    }

    /// Returns a new Moment that is initialized at the end of a specified unit of time.
    ///
    /// - parameter unit: A TimeUnit value.
    ///
    /// - returns: A new Moment instance.
    public func endOf(_ unit: TimeUnit) -> Moment {
        return startOf(unit).add(1, unit).subtract(1.seconds)
    }

    /// Returns a new Moment that is initialized at the end of a specified unit of time.
    ///
    /// Valid unit values:
    ///
    /// - Years = "y"
    /// - Quarters = "Q"
    /// - Months = "M"
    /// - Weeks = "w"
    /// - Days = "d"
    /// - Hours = "H"
    /// - Minutes = "m"
    /// - Seconds = "s"
    ///
    /// - parameter unit: The name of a TimeUnit value.
    ///
    /// - returns: A new Moment instance.
    public func endOf(_ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return endOf(unit)
        }
        return self
    }

    /// Returns the TimeInterval since the Unix epoch to the current instance.
    ///
    /// - returns: A TimeInterval value.
    public func epoch() -> TimeInterval {
        return date.timeIntervalSince1970
    }

    fileprivate func convert(_ value: Double, _ unit: TimeUnit) -> Double {
        switch unit {
        case .Seconds:
            return value
        case .Minutes:
            return value * minuteInSeconds
        case .Hours:
            return value * hourInSeconds // 60 minutes
        case .Days:
            return value * dayInSeconds // 24 hours
        case .Weeks:
            return value * 605800 // 7 days
        case .Months:
            return value * monthInSeconds // 30 days
        case .Quarters:
            return value * 7776000 // 3 months
        case .Years:
            return value * yearInSeconds // 365 days
        }
    }
}

extension Moment: CustomStringConvertible {

    /// A textual representation of this instance.
    public var description: String {
        return format()
    }
}

extension Moment: CustomDebugStringConvertible {

    /// A textual representation of this instance, suitable for debugging.
    public var debugDescription: String {
        return description
    }
}
