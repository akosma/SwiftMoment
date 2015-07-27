//
//  DurationTests.swift
//  SwiftMoment
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import UIKit
import XCTest
import SwiftMoment

class DurationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCanCreateDurationsFromIntegers() {
        let duration = Duration(value: 10000000)
        XCTAssertEqual(duration.seconds, 10000000, "The Duration instance wraps an NSTimeInterval in seconds")
    }
    
    func testCanCreateDurationsFromDoubles() {
        let duration = Duration(value: 10000000.1000)
        XCTAssertEqual(duration.seconds, 10000000.1000, "The Duration instance wraps an NSTimeInterval in seconds")
    }
    
    func testCanGenerateMomentAgo() {
        let date = 2.months.ago()
        XCTAssert(date ~= (moment() - 2.months), "'ago()' returns a moment in the past")
    }

    func testSinceReturnsDuration() {
        let date = 2.months.ago() + 3.hours + 5.minutes
        let duration = since(date)
        let seconds = Int(duration.seconds)
        XCTAssertEqual(seconds, 5172900, "That date happened 5172900 seconds ago")
    }

    func testCanAddAndSubstractDurations() {
        let birthday = moment("09/04/1973")!
        let duration = Duration(value: 107567580)
        let substracted = birthday - (3.years + 5.months - 7.minutes)
        let substracted2 = birthday - duration
        XCTAssertEqual(substracted, substracted2, "Both operations yield the same result")
    }
    
    func testDurationDescription() {
        let duration = 4.months + 53.days + 6.hours + 4.minutes
        let str = duration.description
        XCTAssertEqual(str, "5m 3w 1d 6:04:00", "The description of a duration provides quite a bit of info")
    }
}
