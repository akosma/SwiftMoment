//
//  Extensions.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

public extension Int {

    /// Creates a duration value with the current number of seconds.
    var seconds: Duration {
        return Duration(value: self)
    }

    /// Creates a duration value with the current number of minutes.
    var minutes: Duration {
        return Duration(value: self * Int(Moment.minuteInSeconds))
    }

    /// Creates a duration value with the current number of hours.
    var hours: Duration {
        return Duration(value: self * Int(Moment.hourInSeconds))
    }

    /// Creates a duration value with the current number of weeks.
    var weeks: Duration {
        return Duration(value: self * Int(Moment.weekInSeconds))
    }

    /// Creates a duration value with the current number of days.
    var days: Duration {
        return Duration(value: self * Int(Moment.dayInSeconds))
    }

    /// Creates a duration value with the current number of months.
    var months: Duration {
        return Duration(value: self * Int(Moment.monthInSeconds))
    }

    /// Creates a duration value with the current number of quarters.
    var quarters: Duration {
        return Duration(value: self * Int(Moment.quarterInSeconds))
    }

    /// Creates a duration value with the current number of years.
    var years: Duration {
        return Duration(value: self * Int(Moment.yearInSeconds))
    }
}
