//
//  Duration.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import Foundation

public struct Duration: Equatable {
    let interval: NSTimeInterval

    public init(value: NSTimeInterval) {
        self.interval = value
    }

    public init(value: Int) {
        self.interval = NSTimeInterval(value)
    }

    public var years: Double {
        return interval / 31536000 // 365 days
    }

    public var quarters: Double {
        return interval / 7776000 // 3 months
    }

    public var months: Double {
        return interval / 2592000 // 30 days
    }

    public var days: Double {
        return interval / 86400 // 24 hours
    }

    public var hours: Double {
        return interval / 3600 // 60 minutes
    }

    public var minutes: Double {
        return interval / 60
    }

    public var seconds: Double {
        return interval
    }

    public func ago() -> Moment {
        return moment().subtract(self)
    }

    public func add(duration: Duration) -> Duration {
        return Duration(value: self.interval + duration.interval)
    }

    public func subtract(duration: Duration) -> Duration {
        return Duration(value: self.interval - duration.interval)
    }

    public func isEqualTo(duration: Duration) -> Bool {
        return self.interval == duration.interval
    }
}

extension Duration: CustomStringConvertible {
    public var description: String {
        let formatter = NSDateComponentsFormatter()
        formatter.calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        formatter.calendar?.timeZone = NSTimeZone(abbreviation: "UTC")!
        formatter.allowedUnits = [.Year, .Month, .WeekOfMonth, .Day, .Hour, .Minute, .Second]

        let referenceDate = NSDate(timeIntervalSinceReferenceDate: 0)
        let intervalDate = NSDate(timeInterval: self.interval, sinceDate: referenceDate)
        return formatter.stringFromDate(referenceDate, toDate: intervalDate)!
    }
}
