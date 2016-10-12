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
        return Duration(value: self * 60)
    }

    /// Creates a duration value with the current number of hours.
    var hours: Duration {
        return Duration(value: self * 3600)
    }

    /// Creates a duration value with the current number of weeks.
    var weeks: Duration {
        return Duration(value: self * 604800)
    }

    /// Creates a duration value with the current number of days.
    var days: Duration {
        return Duration(value: self * 86400)
    }

    /// Creates a duration value with the current number of months.
    var months: Duration {
        return Duration(value: self * 2592000)
    }

    /// Creates a duration value with the current number of quarters.
    var quarters: Duration {
        return Duration(value: self * 7776000)
    }

    /// Creates a duration value with the current number of years.
    var years: Duration {
        return Duration(value: self * 31536000)
    }
}
