//
//  Duration.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import Foundation

public struct Duration: Equatable {
    let interval: TimeInterval

    public init(value: TimeInterval) {
        self.interval = value
    }

    public init(value: Int) {
        self.interval = TimeInterval(value)
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

    public func add(_ duration: Duration) -> Duration {
        return Duration(value: self.interval + duration.interval)
    }

    public func subtract(_ duration: Duration) -> Duration {
        return Duration(value: self.interval - duration.interval)
    }

    public func isEqualTo(_ duration: Duration) -> Bool {
        return self.interval == duration.interval
    }
}

extension Duration: CustomStringConvertible {
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
