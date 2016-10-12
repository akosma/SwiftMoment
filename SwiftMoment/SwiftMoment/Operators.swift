//
//  Operators.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//


/// Compares both Moments for equality.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if equal, false otherwise.
public func == (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isEqualTo(rhs)
}

/// Compares both Moments for inequality.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if inequal, false otherwise.
public func != (lhs: Moment, rhs: Moment) -> Bool {
    return !lhs.isEqualTo(rhs)
}

/// Compares both Moments for similarity.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if close by, false otherwise.
public func ~= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.isCloseTo(rhs)
}

/// Compares both Moments.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if lhs is later than rhs, false otherwise.
public func > (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval > 0
}

/// Compares both Moments.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if lhs is earlier than rhs, false otherwise.
public func < (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval < 0
}

/// Compares both Moments.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if lhs is later or equal than rhs, false otherwise.
public func >= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval >= 0
}

/// Compares both Moments.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: A boolean; true if lhs is earlier or equal than rhs, false otherwise.
public func <= (lhs: Moment, rhs: Moment) -> Bool {
    return lhs.intervalSince(rhs).interval <= 0
}

/// Substracts two Moment instance and returns the Duration between both.
///
/// - parameter lhs: The Moment at the left hand side.
/// - parameter rhs: The Moment at the right hand side.
///
/// - returns: The Duration between two moments.
public func - (lhs: Moment, rhs: Moment) -> Duration {
    return lhs.intervalSince(rhs)
}

/// Adds the Duration to the Moment.
///
/// - parameter lhs: A Moment value.
/// - parameter rhs: A Duration to add to the Moment.
///
/// - returns: A new Moment instance.
public func + (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.add(rhs)
}

/// Adds the Duration to the Moment.
///
/// - parameter lhs: A Duration to substract to the Moment.
/// - parameter rhs: A Moment value.
///
/// - returns: A new Moment instance.
public func + (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.add(lhs)
}

/// Substracts the Duration to the Moment.
///
/// - parameter lhs: A Moment value.
/// - parameter rhs: A Duration to substract to the Moment.
///
/// - returns: A new Moment instance.
public func - (lhs: Moment, rhs: Duration) -> Moment {
    return lhs.subtract(rhs)
}

/// Substract the Duration to the Moment.
///
/// - parameter lhs: A Duration to substract to the Moment.
/// - parameter rhs: A Moment value.
///
/// - returns: A new Moment instance.
public func - (lhs: Duration, rhs: Moment) -> Moment {
    return rhs.subtract(lhs)
}

/// Compares two Durations for equality.
///
/// - parameter lhs: The Duration at the left hand side.
/// - parameter rhs: The Duration at the right hand side.
///
/// - returns: A boolean; true if the Durations are the same, false otherwise.
public func == (lhs: Duration, rhs: Duration) -> Bool {
    return lhs.isEqualTo(rhs)
}

/// Adds the durations.
///
/// - parameter lhs: The Duration at the left hand side.
/// - parameter rhs: The Duration at the right hand side.
///
/// - returns: A new Duration value.
public func + (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.add(rhs)
}

/// Substracts the durations.
///
/// - parameter lhs: The Duration at the left hand side.
/// - parameter rhs: The Duration at the right hand side.
///
/// - returns: A new Duration value.
public func - (lhs: Duration, rhs: Duration) -> Duration {
    return lhs.subtract(rhs)
}
