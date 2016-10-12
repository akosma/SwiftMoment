//
//  Duration.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import Foundation

/// Just like Moment wraps a Date, Duration wraps a TimeInterval.
public struct Duration: Equatable {
    internal let interval: TimeInterval

    /// Initializes a new instance.
    ///
    /// - parameter value: A TimeInterval value.
    ///
    /// - returns: A new Duration instance.
    public init(value: TimeInterval) {
        self.interval = value
    }

    /// Initializes a new instance.
    ///
    /// - parameter value: An integer value, representing seconds.
    ///
    /// - returns: A new Duration instance.
    public init(value: Int) {
        self.interval = TimeInterval(value)
    }

    /// The amount of years of the current instance.
    public var years: Double {
        return interval / 31536000 // 365 days
    }

    /// The amount of quarters of the current instance.
    public var quarters: Double {
        return interval / 7776000 // 3 months
    }

    /// The amount of months of the current instance.
    public var months: Double {
        return interval / 2592000 // 30 days
    }

    /// The amount of days of the current instance.
    public var days: Double {
        return interval / 86400 // 24 hours
    }

    /// The amount of hours of the current instance.
    public var hours: Double {
        return interval / 3600 // 60 minutes
    }

    /// The amount of minutes of the current instance.
    public var minutes: Double {
        return interval / 60
    }

    /// The amount of seconds of the current instance.
    public var seconds: Double {
        return interval
    }

    /// Returns a Moment that happened a current Duration ago.
    ///
    /// - returns: A new Moment instance.
    public func ago() -> Moment {
        return moment().subtract(self)
    }

    /// Adds the specified duration to the current instance.
    ///
    /// - parameter duration: A Duration value to add to the current one.
    ///
    /// - returns: A new Duration value.
    public func add(_ duration: Duration) -> Duration {
        return Duration(value: self.interval + duration.interval)
    }

    /// Substracts the specified duration to the current instance.
    ///
    /// - parameter duration: A Duration value to substract to the current one.
    ///
    /// - returns: A new Duration value.
    public func subtract(_ duration: Duration) -> Duration {
        return Duration(value: self.interval - duration.interval)
    }

    /// Specifies whether the current value is equal to the one passed in parameter.
    ///
    /// - parameter duration: The Duration instance to compare to.
    ///
    /// - returns: A boolean; true if the parameter is equal, false otherwise.
    public func isEqualTo(_ duration: Duration) -> Bool {
        return self.interval == duration.interval
    }
}

extension Duration: CustomStringConvertible {

    /// A textual representation of this instance.
    public var description: String {
        let formatter = DateComponentsFormatter()
        formatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        formatter.calendar?.timeZone = TimeZone(abbreviation: "UTC")!
        formatter.allowedUnits = [.year, .month, .weekOfMonth, .day, .hour, .minute, .second]

        let referenceDate = Date(timeIntervalSinceReferenceDate: 0)
        let intervalDate = Date(timeInterval: self.interval, since: referenceDate)
        return formatter.string(from: referenceDate, to: intervalDate)!
    }
}
