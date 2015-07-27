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
Returns a moment representing the current instant in time
at the current timezone.

:returns: A Moment instance.
*/
public func moment(timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
    , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment {
    return Moment(timeZone: timeZone, locale: locale)
}

public func utc() -> Moment {
    let zone = NSTimeZone(abbreviation: "UTC")!
    return moment(timeZone: zone)
}

/**
Returns an Optional wrapping a Moment structure, representing the
current instant in time. If the string passed as parameter cannot be
parsed by the function, the Optional wraps a nil value.

:param: stringDate A string with a date representation.
:param: timeZone   An NSTimeZone object

:returns: An optional Moment instance.
*/
public func moment(stringDate: String
    , timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
    , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
    let formatter = NSDateFormatter()
    formatter.timeZone = timeZone
    let isoFormat = "yyyy-MM-ddTHH:mm:ssZ"

    // The contents of the array below are borrowed
    // and adapted from the source code of Moment.js
    // https://github.com/moment/moment/blob/develop/moment.js
    let formats = [
        isoFormat,
        "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'",
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

        if let date = formatter.dateFromString(stringDate) {
            return Moment(date: date, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(stringDate: String
    , dateFormat: String
    , timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
    , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
    let formatter = NSDateFormatter()
    formatter.dateFormat = dateFormat
    formatter.timeZone = timeZone
    if let date = formatter.dateFromString(stringDate) {
        return Moment(date: date, timeZone: timeZone, locale: locale)
    }
    return nil
}

/**
Builds a new Moment instance using an array with the following components,
in the following order: [ year, month, day, hour, minute, second ]

:param: dateComponents An array of integer values
:param: timeZone   An NSTimeZone object

:returns: An optional wrapping a Moment instance
*/
public func moment(params: [Int]
    , timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
    , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
    if params.count > 0 {
        let calendar = NSCalendar.currentCalendar()
        calendar.timeZone = timeZone
        let components = NSDateComponents()
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
        
        if let date = calendar.dateFromComponents(components) {
            return moment(date, timeZone: timeZone, locale: locale)
        }
    }
    return nil
}

public func moment(dict: [String: Int]
    , timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
    , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment? {
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

public func moment(milliseconds: Int) -> Moment {
    return moment(NSTimeInterval(milliseconds / 1000))
}

public func moment(seconds: NSTimeInterval) -> Moment {
    let interval = NSTimeInterval(seconds)
    let date = NSDate(timeIntervalSince1970: interval)
    return Moment(date: date)
}

public func moment(date: NSDate
    , timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
    , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) -> Moment {
    return Moment(date: date, timeZone: timeZone, locale: locale)
}

public func moment(moment: Moment) -> Moment {
    let copy = moment.date.copy() as! NSDate
    let timeZone = moment.timeZone.copy() as! NSTimeZone
    let locale = moment.locale.copy() as! NSLocale
    return Moment(date: copy, timeZone: timeZone, locale: locale)
}

public func past() -> Moment {
    return Moment(date: NSDate.distantPast() as! NSDate)
}

public func future() -> Moment {
    return Moment(date: NSDate.distantFuture() as! NSDate)
}

public func since(past: Moment) -> Duration {
    return moment().intervalSince(past)
}

public func maximum(moments: Moment...) -> Moment? {
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

public func minimum(moments: Moment...) -> Moment? {
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
    let date: NSDate
    let timeZone: NSTimeZone
    let locale: NSLocale

    init(date: NSDate = NSDate()
        , timeZone: NSTimeZone = NSTimeZone.defaultTimeZone()
        , locale: NSLocale = NSLocale.autoupdatingCurrentLocale()) {
        self.date = date
        self.timeZone = timeZone
        self.locale = locale
    }

    /// Returns the year of the current instance.
    public var year: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitYear, fromDate: date)
        return components.year
    }

    /// Returns the month (1-12) of the current instance.
    public var month: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitMonth, fromDate: date)
        return components.month
    }

    /// Returns the name of the month of the current instance, in the current locale.
    public var monthName: String {
        let formatter = NSDateFormatter()
        formatter.locale = locale
        return formatter.monthSymbols[month - 1] as! String
    }

    public var day: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitDay, fromDate: date)
        return components.day
    }

    public var hour: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitHour, fromDate: date)
        return components.hour
    }

    public var minute: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitMinute, fromDate: date)
        return components.minute
    }

    public var second: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitSecond, fromDate: date)
        return components.second
    }

    public var weekday: Int {
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = timeZone
        cal.locale = locale
        let components = cal.components(.CalendarUnitWeekday, fromDate: date)
        return components.weekday
    }

    public var weekdayName: String {
        let formatter = NSDateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "EEEE"
        formatter.timeZone = timeZone
        return formatter.stringFromDate(date)
    }

    public var weekdayOrdinal: Int {
        let cal = NSCalendar.currentCalendar()
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.CalendarUnitWeekdayOrdinal, fromDate: date)
        return components.weekdayOrdinal
    }

    public var weekOfYear: Int {
        let cal = NSCalendar.currentCalendar()
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.CalendarUnitWeekOfYear, fromDate: date)
        return components.weekOfYear
    }

    public var quarter: Int {
        let cal = NSCalendar.currentCalendar()
        cal.locale = locale
        cal.timeZone = timeZone
        let components = cal.components(.CalendarUnitQuarter, fromDate: date)
        return components.quarter
    }

    // Methods

    public func get(unit: TimeUnit) -> Int? {
        switch unit {
        case .Seconds:
            return second
        case .Minutes:
            return minute
        case .Hours:
            return hour
        case .Days:
            return day
        case .Months:
            return month
        case .Quarters:
            return quarter
        case .Years:
            return year
        default:
            return nil
        }
    }

    public func get(unitName: String) -> Int? {
        if let unit = TimeUnit(rawValue: unitName) {
            return get(unit)
        }
        return nil
    }

    public func format(dateFormat: String = "yyyy-MM-dd HH:mm:SS ZZZZ") -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = timeZone
        formatter.locale = locale
        return formatter.stringFromDate(date)
    }

    public func isEqualTo(moment: Moment) -> Bool {
        return date.isEqualToDate(moment.date)
    }

    public func intervalSince(moment: Moment) -> Duration {
        let interval = date.timeIntervalSinceDate(moment.date)
        return Duration(value: interval)
    }

    public func add(value: Int, _ unit: TimeUnit) -> Moment {
        let components = NSDateComponents()
        switch unit {
        case .Years:
            components.year = value
        case .Quarters:
            components.month = 3 * value
        case .Months:
            components.month = value
        case .Days:
            components.day = value
        case .Hours:
            components.hour = value
        case .Minutes:
            components.minute = value
        case .Seconds:
            components.second = value
        }
        let cal = NSCalendar.currentCalendar()
        if let newDate = cal.dateByAddingComponents(components, toDate: date, options: nil) {
          return Moment(date: newDate)
        }
        return self
    }

    public func add(value: NSTimeInterval, _ unit: TimeUnit) -> Moment {
        let seconds = convert(value, unit)
        let interval = NSTimeInterval(seconds)
        let newDate = date.dateByAddingTimeInterval(interval)
        return Moment(date: newDate)
    }

    public func add(value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return add(value, unit)
        }
        return self
    }

    public func add(duration: Duration) -> Moment {
        return add(duration.interval, .Seconds)
    }

    public func substract(value: NSTimeInterval, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    public func substract(value: Int, _ unit: TimeUnit) -> Moment {
        return add(-value, unit)
    }

    public func substract(value: Int, _ unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return substract(value, unit)
        }
        return self
    }

    public func substract(duration: Duration) -> Moment {
        return substract(duration.interval, .Seconds)
    }

    public func isCloseTo(moment: Moment, precision: NSTimeInterval = 300) -> Bool {
        // "Being close" is measured using a precision argument
        // which is initialized a 300 seconds, or 5 minutes.
        let delta = intervalSince(moment)
        return abs(delta.interval) < precision
    }

    public func startOf(unit: TimeUnit) -> Moment {
        let cal = NSCalendar.currentCalendar()
        var newDate: NSDate?
        let components = cal.components(.CalendarUnitYear | .CalendarUnitMonth
            | .CalendarUnitDay | .CalendarUnitHour
            | .CalendarUnitMinute | .CalendarUnitSecond, fromDate: date)
        switch unit {
        case .Seconds:
            return self
        case .Years:
            components.month = 1
            fallthrough
        case .Quarters, .Months:
            components.day = 1
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
        newDate = cal.dateFromComponents(components)
        return newDate == nil ? self : Moment(date: newDate!)
    }

    public func startOf(unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return startOf(unit)
        }
        return self
    }

    public func endOf(unit: TimeUnit) -> Moment {
        return startOf(unit).add(1, unit).substract(1.seconds)
    }

    public func endOf(unitName: String) -> Moment {
        if let unit = TimeUnit(rawValue: unitName) {
            return endOf(unit)
        }
        return self
    }

    public func epoch() -> NSTimeInterval {
        return date.timeIntervalSince1970
    }

    // Private methods

    func convert(value: Double, _ unit: TimeUnit) -> Double {
        switch unit {
        case .Seconds:
            return value
        case .Minutes:
            return value * 60
        case .Hours:
            return value * 3600 // 60 minutes
        case .Days:
            return value * 86400 // 24 hours
        case .Months:
            return value * 2592000 // 30 days
        case .Quarters:
            return value * 7776000 // 3 months
        case .Years:
            return value * 31536000 // 365 days
        default:
            return 0
        }
    }
}

extension Moment: Printable {
    public var description: String {
        return format()
    }
}

extension Moment: DebugPrintable {
    public var debugDescription: String {
        return description
    }
}

