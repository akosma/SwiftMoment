//
//  SwiftMomentTests.swift
//  SwiftMomentTests
//
//  Created by Adrian on 19/01/15.
//  Copyright (c) 2015 Adrian Kosmaczewski. All rights reserved.
//

import Foundation
import XCTest
import SwiftMoment

class MomentTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testTheMomentIsNow() {
        let today = moment()

        let date = NSDate()
        let cal = NSCalendar.currentCalendar()
        cal.timeZone = NSTimeZone.defaultTimeZone()
        let components = cal.components([.Year, .Month, .Day, .Hour, .Minute, .Second, .Weekday, .WeekdayOrdinal, .WeekOfYear, .Quarter],
            fromDate: date)

        XCTAssertEqual(today.year, components.year, "The moment contains the current year")
        XCTAssertEqual(today.month, components.month, "The moment contains the current month")
        XCTAssertEqual(today.day, components.day, "The moment contains the current day")
        XCTAssertEqual(today.hour, components.hour, "The moment contains the current hour")
        XCTAssertEqual(today.minute, components.minute, "The moment contains the current minute")
        XCTAssertEqual(today.second, components.second, "The moment contains the current second")
        XCTAssertEqual(today.weekday, components.weekday, "The moment contains the current weekday")
        XCTAssertEqual(today.weekOfYear, components.weekOfYear, "The moment contains the current week of year")
        XCTAssertEqual(today.weekdayOrdinal, components.weekdayOrdinal, "The moment contains the current number of the week day")
        XCTAssertEqual(today.quarter, components.quarter, "The moment contains the current quarter")

        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        let weekdayName = formatter.stringFromDate(date)

        XCTAssertEqual(today.weekdayName, weekdayName, "The moment contains the current week day")
    }
    
    func testCanCreateMomentsWithSixComponents() {
        let obj = moment([2015, 01, 19, 20, 45, 34])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 34, "The second should match")
    }
    
    func testCanCreateMomentsWithFiveComponents() {
        let obj = moment([2015, 01, 19, 20, 45])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithFourComponents() {
        let obj = moment([2015, 01, 19, 20])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithThreeComponents() {
        let obj = moment([2015, 01, 19])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 0, "The hour should be zero")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithTwoComponents() {
        let obj = moment([2015, 01])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 1, "The day should be one")
        XCTAssertEqual(obj.hour, 0, "The hour should be zero")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateMomentsWithOneComponent() {
        let obj = moment([2015])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 1, "The month should be January")
        XCTAssertEqual(obj.day, 1, "The day should be the first")
        XCTAssertEqual(obj.hour, 0, "The hour should be zero")
        XCTAssertEqual(obj.minute, 0, "The minute should be zero")
        XCTAssertEqual(obj.second, 0, "The second should be zero")
    }
    
    func testCanCreateWeirdDateFromComponents() {
        let timeZone = NSTimeZone(abbreviation: "GMT+01")!
        let obj = moment([-2015445, 76, -46, 876, 234565, -999], timeZone: timeZone)!
        XCTAssertEqual(obj.format(), "2015440-02-13 12:57:11 GMT+01:00", "The date is weird...!")
    }
    
    func testEmptyArrayOfComponentsYieldsNilMoment() {
        let obj = moment([])
        XCTAssert(obj == nil, "This should yield a nil moment object")
    }
    
    func testCreateDateWithDictionary() {
        let obj = moment(["year": 2015,
            "second": 34,
            "month": 01,
            "minute": 45,
            "day": 19,
            "hour": 20,
            "ignoredKey": 2342432])!
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 34, "The second should match")
    }

    func testEmptyDictionaryOfComponentsYieldsNilMoment() {
        let obj = moment(["whatever": 453])
        XCTAssert(obj == nil, "This should yield a nil moment object")
    }

    func testGibberishIsInvalid() {
        let gibberish = moment("whatever")
        XCTAssert(gibberish == nil, "Gibberish is invalid")
    }

    func testCanCompareMoments() {
        let today = moment()
        let today2 = moment(NSDate())
        let epoch = moment(0)

        let copy = moment(epoch)
        let ninetyFive = moment("1995-12-25")!
        XCTAssertNotEqual(ninetyFive, epoch, "The epoch did not happen in 1995")
        XCTAssertGreaterThan(today, ninetyFive, "Today happens after 1995")
        XCTAssertLessThan(ninetyFive, today, "Today does not happen before 1995")
        XCTAssert(today ~= today2, "Separated by some milliseconds")
        XCTAssertEqual(epoch, copy, "Copies are exactly equal")

        let similar = ninetyFive + 30.seconds
        XCTAssert(ninetyFive ~= similar, "Separated by 30 seconds")
    }

    func testEqualityIsCommutative() {
        let today = moment()
        let copy = moment(today)
        XCTAssertEqual(today, copy, "Equality is commutative")
        XCTAssertEqual(copy, today, "Equality is commutative")
    }

    func testDifferentSyntaxesToAddAndSubstract() {
        // month durations always add 30 days
        let one = moment([2015, 7, 29, 0, 0])!
        let exactly_thirty_days = moment([2015, 8, 28, 0, 0])!
        XCTAssertEqual(exactly_thirty_days, one.add(1.months), "Duration adds exactly 30 days")
        XCTAssertEqual(30.days, exactly_thirty_days - one, "exactly_thirty_days is a difference of 30 days")
        XCTAssertEqual(one, exactly_thirty_days.subtract(1.months), "Subtracting back to one is okay")

        // adding by a TimeUnit.Month jumps 1 month (not necessarily 30 days)
        let two = moment([2015, 7, 29, 0, 0])!
        let exactly_one_month = moment([2015, 8, 29, 0, 0])!
        XCTAssertEqual(exactly_one_month, two.add(1, .Months), "Time unit adds exactly one month")
        XCTAssertEqual(31.days, exactly_one_month - two, "exactly_on_month is a difference of 31 days")
        XCTAssertEqual(two, exactly_one_month.subtract(1, .Months), "Subtracting back to two is okay")


        // use Duration to always add/subtract 365 days for years,
        // otherwise, use TimeUnit.Year
        let all_years_365 = moment().add(5.years)
        let consider_leap_years = moment().add(5, .Years)
        XCTAssertNotEqual(all_years_365, consider_leap_years, "5.years is not equal to 5, .Years")

        // Duration vs TimeUnit does not matter for days, hours, minutes, seconds
        let today = moment()
        let first = moment(today).add(50.days)
        let second = moment(today).add(50, .Days)
        XCTAssertEqual(first, second, "Syntax does not matter when adding days")
        XCTAssertEqual(first.subtract(40, .Days), second.subtract(40.days), "Syntax does not matter when subtracting days")
    }

    func testAdditionAndSubstractionAreInverse() {
        let today = moment()
        let soon = today + 1.hours
        let now = soon - 1.hours
        XCTAssertEqual(now, today, "Addition and subtraction are inverse operations")
    }

    func testFindMaximumMoment() {
        let today = moment()
        let format = "EE yyyy/dd--MMMM HH:mm ZZZZ"
        let birthday = moment("Tue 1973/4--September 12:30 GMT-03:00", dateFormat: format)!
        let ninetyFive = moment("1995-12-25")!
        let max = maximum(today, ninetyFive, birthday)!
        XCTAssertEqual(max, today, "Today is the maximum")
    }

    func testFindMinimumMoment() {
        let today = moment()
        let epoch = moment(0)
        let format = "EE yyyy/dd--MMMM HH:mm ZZZZ"
        let birthday = moment("Tue 1973/4--September 12:30 GMT-03:00", dateFormat: format)!
        let ninetyFive = moment("1995-12-25")!
        let min = minimum(today, epoch, ninetyFive, birthday)!
        XCTAssertEqual(min, epoch, "The minimum is the epoch")
    }

    func testMinimumWithoutParametersReturnsNil() {
        let min = minimum()
        XCTAssert(min == nil, "Without parameters, minimum() == nil")
    }

    func testMaximumWithoutParametersReturnsNil() {
        let max = maximum()
        XCTAssert(max == nil, "Without parameters, maximum() == nil")
    }

    func testCanGetParametersByGetter() {
        let today = moment()
        let hours = today.get(.Hours)!
        XCTAssertEqual(hours, today.hour, "Can use an enum to get properties")

        let minute = today.get("m")!
        XCTAssertEqual(minute, today.minute, "Can use a string to get properties")
    }

    func testUsingWrongParameterNameYieldsNil() {
        let today = moment()
        let whatever = today.get("whatever")
        XCTAssert(whatever == nil, "There is no 'whatever' property to get")
    }

    func testFormatDates() {
        let timeZone = NSTimeZone(abbreviation: "GMT+01:00")!
        let birthday = moment("1973-09-04", timeZone: timeZone)!
        let str = birthday.format("EE QQQQ yyyy/dd/MMMM ZZZZ")
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September GMT+01:00", "Complicated string")

        let standard = birthday.format()
        XCTAssertEqual(standard, "1973-09-04 00:00:00 GMT+01:00", "Standard output")
    }

    func testFormatDatesWithLocale() {
        let ad = NSLocale(localeIdentifier: "en_US_POSIX")
        let defaultFormatAd = moment("2015-09-04", locale: ad)!
        let giveFormatAd    = moment("2015", dateFormat: "yyyy", locale: ad)!
        XCTAssertEqual(defaultFormatAd.year, 2015, "AD2015")
        XCTAssertEqual(giveFormatAd.year,    2015, "AD2015")

        let japanese = NSLocale(localeIdentifier: "ja_JP@calendar=japanese")
        let defaultFormatJapanese = moment("0027-09-04", locale: japanese)!
        let giveFormatJapanese    = moment("0027", dateFormat: "yyyy", locale: japanese)!
        XCTAssertEqual(defaultFormatJapanese.year, 2015, "AD2015 == 27 Heisei period")
        XCTAssertEqual(giveFormatJapanese.year,    2015, "AD2015 == 27 Heisei period")
    }

    func testFutureMoment() {
        let duration = future() - moment()
        XCTAssertGreaterThan(duration.years, 1000, "The future is really far away")
    }

    func testPastMoment() {
        let duration = moment() - past()
        XCTAssertLessThan(1000, duration.years, "The past is really far away")
    }
    /*
    func testTimeZoneSupport() {
        let zone = NSTimeZone(abbreviation: "PST")!
        let birthday = moment("1973-09-04 12:30:00", timeZone: zone)!
        let str = birthday.format("EE QQQQ yyyy/dd/MMMM HH:mm ZZZZ")
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September 12:30 GMT-07:00", "A date in San Francisco")
    }
    */
    func testUTCMomentSupport() {
        let greenwich = utc()
        let str = greenwich.format("ZZZZ")
        XCTAssertEqual(str, "GMT", "The timezone is UTC")
    }
   
   /*
    func testLocaleSupport() {
        let français = NSLocale(localeIdentifier: "fr_FR")
        let anniversaire = moment("1973-09-04 12:30:00", locale: français)!
        let jour = anniversaire.weekdayName
        let mois = anniversaire.monthName
        XCTAssertEqual(jour, "mardi", "Eh ben bravo!")
        XCTAssertEqual(mois, "septembre", "Eh ben bravo!")

        let deutsch = NSLocale(localeIdentifier: "de_DE")
        let geburtstag = moment("1973-03-04 12:30:00", locale: deutsch)!
        let tag = geburtstag.weekdayName
        let monat = geburtstag.monthName
        XCTAssertEqual(tag, "Sonntag", "Ach so!")
        X
*/

    func testStartOfYear() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.startOf("y")
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 1, "The month should match")
        XCTAssertEqual(obj.day, 1, "The day should match")
        XCTAssertEqual(obj.hour, 0, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should match")
    }

    func testStartOfMonth() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.startOf("M")
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 10, "The month should match")
        XCTAssertEqual(obj.day, 1, "The day should match")
        XCTAssertEqual(obj.hour, 0, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should match")
    }

    func testStartOfWeek() {
        let obj = moment([2016, 01, 02, 20, 45, 34])!.startOf(.Weeks)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 12, "The month should match")
        XCTAssertEqual(obj.day, 28, "The day should match")
        XCTAssertEqual(obj.hour, 0, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should match")
    }

    func testStartOfDay() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.startOf(.Days)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 10, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 0, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should match")
    }

    func testStartOfHour() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.startOf(.Hours)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 10, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The hour should match")
        XCTAssertEqual(obj.minute, 0, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should match")
    }

    func testStartOfMinute() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.startOf(.Minutes)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 10, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The day should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 0, "The second should match")
    }

    func testEndOfYear() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.endOf(.Years)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 12, "The month should match")
        XCTAssertEqual(obj.day, 31, "The day should match")
        XCTAssertEqual(obj.hour, 23, "The hour should match")
        XCTAssertEqual(obj.minute, 59, "The minute should match")
        XCTAssertEqual(obj.second, 59, "The second should match")
    }

    func testEndOfMonth() {
        let obj = moment([2015, 01, 19, 20, 45, 34])!.endOf(.Months)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 31, "The day should match")
        XCTAssertEqual(obj.hour, 23, "The hour should match")
        XCTAssertEqual(obj.minute, 59, "The minute should match")
        XCTAssertEqual(obj.second, 59, "The second should match")
    }

    func testEndOfWeek() {
        let obj = moment([2015, 12, 29, 20, 45, 34])!.endOf(.Weeks)
        XCTAssertEqual(obj.year, 2016, "The year should match")
        XCTAssertEqual(obj.month, 01, "The month should match")
        XCTAssertEqual(obj.day, 03, "The day should match")
        XCTAssertEqual(obj.hour, 23, "The hour should match")
        XCTAssertEqual(obj.minute, 59, "The minute should match")
        XCTAssertEqual(obj.second, 59, "The second should match")
    }

    func testEndOfDay() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.endOf("d")
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 10, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 23, "The day should match")
        XCTAssertEqual(obj.minute, 59, "The minute should match")
        XCTAssertEqual(obj.second, 59, "The second should match")
    }

    func testEpoch() {
        let gmt = moment("2015-05-29T01:40:17", timeZone: NSTimeZone(name: "GMT")!)!
        let jst = moment("2015-05-29T10:40:17", timeZone: NSTimeZone(name: "Asia/Tokyo")!)!
        XCTAssertEqual(moment(0.0).epoch(), 0.0, "The zero epoch should match")
        XCTAssertEqual(moment(1432863617.0).epoch(), 1432863617.0, "The non zero epoch should match")
        XCTAssertEqual(jst.epoch(), gmt.epoch(), "The JST epoch should match GMT epoch")
    }

	func testPublicDate() {
		let date = NSDate()
		let now = moment(date)
		XCTAssertEqual(now.date, date, "The moment's date should be publicly readable")
		XCTAssertEqual(now.timeZone, NSTimeZone.defaultTimeZone(), "The moment's timeZone should be publicly readable and default to the current timezone")
	}
	
	func testPublicTimeZone() {
		let date = NSDate()
		let now = moment(date)
		XCTAssertEqual(now.timeZone, NSTimeZone.defaultTimeZone(), "The moment's timeZone should be publicly readable and default to the current timezone")
	}

	func testPublicLocale() {
		let date = NSDate()
		let now = moment(date)
		XCTAssertEqual(now.locale, NSLocale.currentLocale(), "The moment's locale should be publicly readable and default to the current locale")
	}
    
  func testAddingInt() {
    // This is to verify that issue #48 is corrected
    // https://github.com/akosma/SwiftMoment/issues/48
    let problem = moment("2016-07-01")!
    let result = problem.add(1, .Months)
    let expected = moment("2016-08-01")!
    XCTAssertEqual(result, expected)
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
    return moment(date, timeZone: NSTimeZone.defaultTimeZone(), locale: NSLocale(localeIdentifier: "en"))
  }

  func testFromNowHebrew() {
    let mom = moment(NSDate(), timeZone: NSTimeZone.defaultTimeZone(), locale: NSLocale(localeIdentifier: "he"))
    XCTAssertEqual(mom.fromNow(), "ממש עכשיו")
  }
}
