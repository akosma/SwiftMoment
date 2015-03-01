//
//  Extensions.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

public extension Int {
    var seconds: Duration {
        return Duration(value: self)
    }

    var minutes: Duration {
        return Duration(value: self * 60)
    }

    var hours: Duration {
        return Duration(value: self * 3600)
    }

    var days: Duration {
        return Duration(value: self * 86400)
    }

    var months: Duration {
        return Duration(value: self * 2592000)
    }

    var quarters: Duration {
        return Duration(value: self * 7776000)
    }

    var years: Duration {
        return Duration(value: self * 31536000)
    }
}
