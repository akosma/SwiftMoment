//
//  FromNowTests.swift
//  SwiftMoment
//
//  Created by Madhava Jay on 07/06/2016.
//  Copyright © 2016 Adrian Kosmaczewski. All rights reserved.
//

import Foundation
import XCTest
import SwiftMoment

class FromNowTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testFromNowEnglish() {
        let now = NSDate()
        let nowMoment = getLocalEnglishMoment(now)
        XCTAssertEqual(nowMoment.fromNow(), "Just now")

        let nowSeconds = now.dateByAddingTimeInterval(NSTimeInterval(-50))
        let secondsMoment = getLocalEnglishMoment(nowSeconds)
        XCTAssertEqual(secondsMoment.fromNow(), "50 seconds ago")

        let nowSeconds2 = now.dateByAddingTimeInterval(NSTimeInterval(-90))
        let secondsMoment2 = getLocalEnglishMoment(nowSeconds2)
        XCTAssertEqual(secondsMoment2.fromNow(), "A minute ago")

        let nowMinutes = now.dateByAddingTimeInterval(NSTimeInterval(-500))
        let minutesMoment = getLocalEnglishMoment(nowMinutes)
        XCTAssertEqual(minutesMoment.fromNow(), "8 minutes ago")

        let hourSecs: Double = 3600

        let nowMinutes2 = now.dateByAddingTimeInterval(NSTimeInterval(-(hourSecs * 1.5)))
        let minutesMoment2 = getLocalEnglishMoment(nowMinutes2)
        XCTAssertEqual(minutesMoment2.fromNow(), "An hour ago")

        let nowMinutes3 = now.dateByAddingTimeInterval(NSTimeInterval(-(hourSecs * 6)))
        let minutesMoment3 = getLocalEnglishMoment(nowMinutes3)
        XCTAssertEqual(minutesMoment3.fromNow(), "6 hours ago")

        let nowHours = now.dateByAddingTimeInterval(NSTimeInterval(-(hourSecs * 25)))
        let hoursMoment = getLocalEnglishMoment(nowHours)
        XCTAssertEqual(hoursMoment.fromNow(), "Yesterday")

        let nowHours2 = now.dateByAddingTimeInterval(NSTimeInterval(-(hourSecs * 48)))
        let hoursMoment2 = getLocalEnglishMoment(nowHours2)
        XCTAssertEqual(hoursMoment2.fromNow(), "2 days ago")

        let daySecs = hourSecs * 24

        let nowDays = now.dateByAddingTimeInterval(NSTimeInterval(-(daySecs * 7)))
        let daysMoment = getLocalEnglishMoment(nowDays)
        XCTAssertEqual(daysMoment.fromNow(), "Last week")

        let nowWeeks = now.dateByAddingTimeInterval(NSTimeInterval(-(daySecs * 14)))
        let weeksMoment = getLocalEnglishMoment(nowWeeks)
        XCTAssertEqual(weeksMoment.fromNow(), "2 weeks ago")

        let nowWeeks2 = now.dateByAddingTimeInterval(NSTimeInterval(-(daySecs * 50)))
        let weeksMoment2 = getLocalEnglishMoment(nowWeeks2)
        XCTAssertEqual(weeksMoment2.fromNow(), "Last month")

        let weekSecs = daySecs * 7

        let nowMonths = now.dateByAddingTimeInterval(NSTimeInterval(-(weekSecs * 10)))
        let monthsMoment = getLocalEnglishMoment(nowMonths)
        XCTAssertEqual(monthsMoment.fromNow(), "2 months ago")

        let nowMonths2 = now.dateByAddingTimeInterval(NSTimeInterval(-(weekSecs * 60)))
        let monthsMoment2 = getLocalEnglishMoment(nowMonths2)
        XCTAssertEqual(monthsMoment2.fromNow(), "Last year")

        let nowMonths3 = now.dateByAddingTimeInterval(NSTimeInterval(-(weekSecs * 160)))
        let monthsMoment3 = getLocalEnglishMoment(nowMonths3)
        XCTAssertEqual(monthsMoment3.fromNow(), "3 years ago")
    }

    func getLocalEnglishMoment(date: NSDate) -> Moment {
        return moment(date, timeZone: NSTimeZone.defaultTimeZone(),
                      locale: NSLocale(localeIdentifier: "en"))
    }

    func testFromNowHebrew() {
        let mom = moment(NSDate(), timeZone: NSTimeZone.defaultTimeZone(),
                         locale: NSLocale(localeIdentifier: "he"))
    XCTAssertEqual(mom.fromNow(), "ממש עכשיו")
    }
}
