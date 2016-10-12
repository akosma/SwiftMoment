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

        let date = Date()
        var cal = Calendar.current
        cal.timeZone = TimeZone.current
        let params : Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .weekday,
                                                .weekdayOrdinal, .weekOfYear, .quarter]
        let components = cal.dateComponents(params, from: date)

        XCTAssertEqual(today.year, components.year, "The moment contains the current year")
        XCTAssertEqual(today.month, components.month, "The moment contains the current month")
        XCTAssertEqual(today.day, components.day, "The moment contains the current day")
        XCTAssertEqual(today.hour, components.hour, "The moment contains the current hour")
        XCTAssertEqual(today.minute, components.minute, "The moment contains the current minute")
        XCTAssertEqual(today.second, components.second, "The moment contains the current second")
        XCTAssertEqual(today.weekday, components.weekday, "The moment contains the current weekday")
        XCTAssertEqual(today.weekOfYear, components.weekOfYear,
                       "The moment contains the current week of year")
        XCTAssertEqual(today.weekdayOrdinal, components.weekdayOrdinal,
                       "The moment contains the current number of the week day")
        XCTAssertEqual(today.quarter, components.quarter, "The moment contains the current quarter")

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        let weekdayName = formatter.string(from: date)

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
        let timeZone = TimeZone(abbreviation: "GMT+01")!
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
        let today2 = moment(Date())
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
        XCTAssertEqual(30.days, exactly_thirty_days - one,
                       "exactly_thirty_days is a difference of 30 days")
        XCTAssertEqual(one, exactly_thirty_days.subtract(1.0, .Months),
                       "Subtracting back to one is okay")

        // adding by a TimeUnit.Month jumps 1 month (not necessarily 30 days)
        let two = moment([2015, 7, 29, 0, 0])!
        let exactly_one_month = moment([2015, 8, 28, 0, 0])!
        XCTAssertEqual(exactly_one_month, two.add(1.0, .Months), "Time unit adds exactly one month")
        XCTAssertEqual(30.days, exactly_one_month - two,
                       "exactly_on_month is a difference of 30 days")
        XCTAssertEqual(two, exactly_one_month.subtract(1, .Months),
                       "Subtracting back to two is okay")

        // use Duration to always add/subtract 365 days for years,
        // otherwise, use TimeUnit.Year
        let all_years_365 = moment().add(5.years)
        let consider_leap_years = moment().add(5, .Years)
        let consider_leap_years2 = moment().add(5.0, .Years)
        XCTAssertTrue(all_years_365 ~= consider_leap_years)
        XCTAssertTrue(consider_leap_years ~= consider_leap_years2)
    }

    func testDurationVSTimeUnitDoesNotMatterForDaysHoursMinutesSeconds() {
        let today = moment()
        let first = moment(today).add(50.days)
        let second = moment(today).add(50, .Days)
        XCTAssertEqual(first, second, "Syntax does not matter when adding days")
        XCTAssertEqual(first.subtract(40, .Days), second.subtract(40.days),
                       "Syntax does not matter when subtracting days")
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
        let max = maximum(ninetyFive, today, birthday)!
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
        let seconds = today.get(.Seconds)
        let minutes = today.get(.Minutes)
        let hours = today.get(.Hours)
        let days = today.get(.Days)
        let months = today.get(.Months)
        let weeks = today.get(.Weeks)
        let years = today.get(.Years)
        let quarters = today.get(.Quarters)
        XCTAssertEqual(seconds, today.second, "Can use an enum to get properties")
        XCTAssertEqual(minutes, today.minute, "Can use an enum to get properties")
        XCTAssertEqual(hours, today.hour, "Can use an enum to get properties")
        XCTAssertEqual(days, today.day, "Can use an enum to get properties")
        XCTAssertEqual(months, today.month, "Can use an enum to get properties")
        XCTAssertEqual(weeks, today.weekOfYear, "Can use an enum to get properties")
        XCTAssertEqual(years, today.year, "Can use an enum to get properties")
        XCTAssertEqual(quarters, today.quarter, "Can use an enum to get properties")

        let second = today.get("s")!
        let minute = today.get("m")!
        let hour = today.get("H")!
        let day = today.get("d")!
        let month = today.get("M")!
        let week = today.get("w")
        let year = today.get("y")
        let quarter = today.get("Q")
        XCTAssertEqual(second, today.second, "Can use an enum to get properties")
        XCTAssertEqual(minute, today.minute, "Can use an enum to get properties")
        XCTAssertEqual(hour, today.hour, "Can use an enum to get properties")
        XCTAssertEqual(day, today.day, "Can use an enum to get properties")
        XCTAssertEqual(month, today.month, "Can use an enum to get properties")
        XCTAssertEqual(week, today.weekOfYear, "Can use an enum to get properties")
        XCTAssertEqual(year, today.year, "Can use an enum to get properties")
        XCTAssertEqual(quarter, today.quarter, "Can use an enum to get properties")
    }

    func testUsingWrongParameterNameYieldsNil() {
        let today = moment()
        let whatever = today.get("whatever")
        XCTAssert(whatever == nil, "There is no 'whatever' property to get")
    }

    func testFormatDates() {
        let timeZone = TimeZone(abbreviation: "GMT+01:00")!
        let birthday = moment("1973-09-04", timeZone: timeZone)!
        let str = birthday.format("EE QQQQ yyyy/dd/MMMM ZZZZ")
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September GMT+01:00", "Complicated string")

        let standard = birthday.format()
        XCTAssertEqual(standard, "1973-09-04 00:00:00 GMT+01:00", "Standard output")
    }

    func testFormatDatesWithLocale() {
        let ad = Locale(identifier: "en_US_POSIX")
        let defaultFormatAd = moment("2015-09-04", locale: ad)!
        let giveFormatAd    = moment("2015", dateFormat: "yyyy", locale: ad)!
        XCTAssertEqual(defaultFormatAd.year, 2015, "AD2015")
        XCTAssertEqual(giveFormatAd.year, 2015, "AD2015")

        let japanese = Locale(identifier: "ja_JP@calendar=japanese")
        let defaultFormatJapanese = moment("0027-09-04", locale: japanese)!
        let giveFormatJapanese    = moment("0027", dateFormat: "yyyy", locale: japanese)!
        XCTAssertEqual(defaultFormatJapanese.year, 2015, "AD2015 == 27 Heisei period")
        XCTAssertEqual(giveFormatJapanese.year, 2015, "AD2015 == 27 Heisei period")
    }

    func testFutureMoment() {
        let duration = future() - moment()
        XCTAssertGreaterThan(duration.years, 1000, "The future is really far away")
    }

    func testPastMoment() {
        let duration = moment() - past()
        XCTAssertLessThan(1000, duration.years, "The past is really far away")
    }

    func testMomentWithTimeZone() {
        let zone = TimeZone(abbreviation: "PST")!
        let birthday = moment("1973-09-04", timeZone: zone)!
        let str = birthday.format("EE QQQQ yyyy/dd/MMMM HH:mm ZZZZ")
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September 00:00 GMT-07:00",
                       "A date in San Francisco")
    }

    func testTimeZoneChangesPreserveMomentInGMT() {
        // Feedback about #75
        let timeZone = TimeZone(secondsFromGMT: -10800)!
        let locale = Locale(identifier: "en_US_POSIX")
        let dateString = "2016-10-12T10:02:50"
        let dateFormat = "yyy-MM-dd'T'HH:mm:ss"
        let birthday = moment(dateString, dateFormat: dateFormat, timeZone: timeZone, locale: locale)!
        let formatted = birthday.format(dateFormat)
        XCTAssertEqual(formatted, dateString)
        XCTAssertEqual(birthday.hour, 10)
        XCTAssertEqual(birthday.minute, 2)

        let displayZone = TimeZone(abbreviation: "PST")!
        let str = birthday.format("EE QQQQ yyyy/dd/MMMM HH:mm ZZZZ", displayZone)
        XCTAssertEqual(str, "Wed 4th quarter 2016/12/October 06:02 GMT-07:00",
                       "A date in San Francisco")

    }

    func testTransformTimeZone() {
        // Fixes #75
        let timeZone = TimeZone(secondsFromGMT: -10800)!
        let locale = Locale(identifier: "en_US_POSIX")
        let dateString = "2016-10-12T10:02:50"
        let dateFormat = "yyy-MM-dd'T'HH:mm:ss"
        let birthday = moment(dateString, dateFormat: dateFormat, timeZone: timeZone, locale: locale)!
        let formatted = birthday.format(dateFormat)
        XCTAssertEqual(formatted, dateString)
        XCTAssertEqual(birthday.hour, 10)
        XCTAssertEqual(birthday.minute, 2)

        let displayZone = TimeZone(abbreviation: "PST")!
        let birthdayInSF = moment(birthday, timeZone: displayZone)
        XCTAssertEqual(birthdayInSF.hour, 6)
        XCTAssertEqual(birthdayInSF.minute, 2)
    }

    func testUTCMomentSupport() {
        let greenwich = utc()
        let str = greenwich.format("ZZZZ")
        XCTAssertEqual(str, "GMT", "The timezone is UTC")
    }

    func testFormatWithTimeZone() {
        let momentZone = TimeZone(abbreviation: "PST")!
        let birthday = moment("1973-09-04", timeZone: momentZone)!
        let displayZone = TimeZone(abbreviation: "CET")!
        let str = birthday.format("EE QQQQ yyyy/dd/MMMM HH:mm ZZZZ", displayZone)
        XCTAssertEqual(str, "Tue 3rd quarter 1973/04/September 08:00 GMT+01:00",
                       "A date in San Francisco")
    }

    func testLocaleSupport() {
        let français = Locale(identifier: "fr_FR")
        let anniversaire = moment("1973-09-04", locale: français)!
        let jour = anniversaire.weekdayName
        let mois = anniversaire.monthName
        XCTAssertEqual(jour, "mardi", "Eh ben bravo!")
        XCTAssertEqual(mois, "septembre", "Eh ben bravo!")

        let deutsch = Locale(identifier: "de_DE")
        let geburtstag = moment("1973-03-04", locale: deutsch)!
        let tag = geburtstag.weekdayName
        let monat = geburtstag.monthName
        XCTAssertEqual(tag, "Sonntag", "Ach so!")
        XCTAssertEqual(monat, "März", "Ach so!")
    }

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

    func testStartOfSecond() {
        let obj = moment([2015, 10, 19, 20, 45, 34])!.startOf(.Seconds)
        XCTAssertEqual(obj.year, 2015, "The year should match")
        XCTAssertEqual(obj.month, 10, "The month should match")
        XCTAssertEqual(obj.day, 19, "The day should match")
        XCTAssertEqual(obj.hour, 20, "The day should match")
        XCTAssertEqual(obj.minute, 45, "The minute should match")
        XCTAssertEqual(obj.second, 34, "The second should match")
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
        XCTAssertEqual(obj.day, 30, "The day should match")
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
        let gmt = moment("2015-05-29T01:40:17", timeZone: TimeZone(identifier: "GMT")!)!
        let jst = moment("2015-05-29T10:40:17", timeZone: TimeZone(identifier: "Asia/Tokyo")!)!
        XCTAssertEqual(moment(0.0).epoch(), 0.0, "The zero epoch should match")
        XCTAssertEqual(moment(1432863617.0).epoch(), 1432863617.0,
                       "The non zero epoch should match")
        XCTAssertEqual(jst.epoch(), gmt.epoch(), "The JST epoch should match GMT epoch")
    }

	func testPublicDate() {
		let date = Date()
		let now = moment(date)
		XCTAssertEqual(now.date, date, "The moment's date should be publicly readable")
    let expectedString = ["The moment's timeZone should be publicly readable",
                          "and default to the current timezone"].joined(separator: " ")
		XCTAssertEqual(now.timeZone, TimeZone.current, expectedString)
	}

	func testPublicTimeZone() {
		let date = Date()
		let now = moment(date)
    let expectedString = ["The moment's timeZone should be publicly readable",
                          "and default to the current timezone"].joined(separator: " ")
		XCTAssertEqual(now.timeZone, TimeZone.current, expectedString)
	}

	func testPublicLocale() {
		let date = Date()
		let now = moment(date)
    let expectedString = ["The moment's locale should be publicly readable",
                          "and default to the current locale"].joined(separator: " ")
        
        // Using autoupdatingCurrent here, because
        // https://github.com/lionheart/openradar-mirror/issues/15493
		XCTAssertEqual(now.locale, Locale.autoupdatingCurrent, expectedString)
	}

    func testAddingInt() {
        // This is to verify that issue #48 is corrected
        // https://github.com/akosma/SwiftMoment/issues/48
        let problem = moment("2016-07-01")!
        let result = problem.add(1, .Months)
        let expected = moment("2016-07-31")!
        XCTAssertEqual(result, expected)
    }

    func testAddSmallTimeSpans() {
        let now1 = moment()
        let now2 = now1.add(1, .Seconds)
        let now3 = now2.add(1, .Minutes)
        let now4 = now3.add(1, .Hours)

        let another1 = moment(now1)
        let another2 = another1.add(1, "s")
        let another3 = another2.add(1, "m")
        let another4 = another3.add(1, "H")

        XCTAssertEqual(now4, another4)
    }
    
    func testSubstractSmallTimeSpans() {
        let now1 = moment()
        let now2 = now1.subtract(1, .Seconds)
        let now3 = now2.subtract(1, .Minutes)
        let now4 = now3.subtract(1, .Hours)

        let another1 = moment(now1)
        let another2 = another1.subtract(1, "s")
        let another3 = another2.subtract(1, "m")
        let another4 = another3.subtract(1, "H")

        XCTAssertEqual(now4, another4)
    }
    
    func testTimeZoneChangeAdd() {
        let now = utc()
        let tomorrow = now.add(1, .Days)
        XCTAssertEqual(now.timeZone, tomorrow.timeZone)
    }

    func testTimeZoneChangeSubtract() {
        let now = utc()
        let yesterday = now.subtract(1, .Quarters)
        XCTAssertEqual(now.timeZone, yesterday.timeZone)
    }

    func testTimeZoneChangeStartOf() {
        let now = utc()
        let startOfDay = now.startOf(.Days)
        XCTAssertEqual(now.timeZone, startOfDay.timeZone)
    }

    func testTimeZoneChangeEndOf() {
        let now = utc()
        let endOfDay = now.endOf(.Days)
        XCTAssertEqual(now.timeZone, endOfDay.timeZone)
    }

    func testTimeZoneStartOfDay() {
        let cet = TimeZone(abbreviation: "CET")!
        let edt = TimeZone(abbreviation: "EDT")!
        let nowCet = moment(cet)
        let nowEdt = moment(edt)
        let startOfDayCet = nowCet.startOf(.Days)
        let startOfDayEdt = nowEdt.startOf(.Days)
        XCTAssertEqual(startOfDayCet.hour, 0)
        XCTAssertEqual(startOfDayEdt.hour, 0)
    }

    func testWrongFormatParametersReturnNil() {
        let mom = moment("sdfg32-435-fdg34-2345", dateFormat: "324265;KJ235-56")
        XCTAssertNil(mom)
    }

    func testWrongArrayReturnsNil() {
        let arr = [Int]()
        let mom1 = moment(arr)
        XCTAssertNil(mom1)

        let mom2 = moment([])
        XCTAssertNil(mom2)

        let dict = [String: Int]()
        let mom3 = moment(dict)
        XCTAssertNil(mom3)

        let mom4 = moment(["savarasasa": 234656])
        XCTAssertNil(mom4)
    }

    func testWrongUnitInAddReturnsSelf() {
        let now = moment()
        let another = now.add(1, "whatever")
        XCTAssertEqual(another, now)
    }

    func testWrongUnitInSubstractReturnsSelf() {
        let now = moment()
        let another = now.subtract(1, "whatever")
        XCTAssertEqual(another, now)
    }

    func testWrongUnitInStartOfReturnsSelf() {
        let now = moment()
        let another = now.startOf("whatever")
        XCTAssertEqual(another, now)
    }

    func testWrongUnitInEndOfReturnsSelf() {
        let now = moment()
        let another = now.endOf("whatever")
        XCTAssertEqual(another, now)
    }

    func testDescriptions() {
        let now = moment()
        let str1 = now.description
        let str2 = now.debugDescription
        XCTAssertEqual(now.format(), str1)
        XCTAssertEqual(now.format(), str2)
    }
}
