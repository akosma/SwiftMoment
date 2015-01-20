//
//  Operators.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

public func == (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isEqualTo(rhs)
}

public func != (lhs: Moment, rhs: Moment) -> Bool {
    return !lhs.isEqualTo(rhs)
}

public func ~= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isCloseTo(rhs)
}

public func - (lhs: Moment, rhs: Moment) -> Duration {
    return lhs.intervalSince(rhs)
}

public func > (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval > 0
}

public func < (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval < 0
}

public func >= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval >= 0
}

public func <= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval <= 0
}

public func + (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.add(rhs)
}

public func + (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.add(lhs)
}

public func - (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.substract(rhs)
}

public func - (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.substract(lhs)
}

public func == (lhs: Duration, rhs: Duration) -> Bool {
    return lhs.isEqualTo(rhs)
}

public func + (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.add(rhs)
}

public func - (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.substract(rhs)
}
