import XCTest

// swift test --generate-linuxmain

extension DurationTests {
    static let __allTests = [
        ("testCanAddAndSubstractDurations", testCanAddAndSubstractDurations),
        ("testCanCreateDurationsFromDoubles", testCanCreateDurationsFromDoubles),
        ("testCanCreateDurationsFromIntegers", testCanCreateDurationsFromIntegers),
        ("testCanGenerateMomentAgo", testCanGenerateMomentAgo),
        ("testDurationDescription", testDurationDescription),
        ("testDurationProperties", testDurationProperties),
        ("testSinceReturnsDuration", testSinceReturnsDuration),
    ]
}

extension ExtensionsTests {
    static let __allTests = [
        ("testCanReturnDaysDuration", testCanReturnDaysDuration),
        ("testCanReturnDaysDurationAsDouble", testCanReturnDaysDurationAsDouble),
        ("testCanReturnHoursDuration", testCanReturnHoursDuration),
        ("testCanReturnHoursDurationAsDouble", testCanReturnHoursDurationAsDouble),
        ("testCanReturnMinutesDuration", testCanReturnMinutesDuration),
        ("testCanReturnMinutesDurationAsDouble", testCanReturnMinutesDurationAsDouble),
        ("testCanReturnMonthsDuration", testCanReturnMonthsDuration),
        ("testCanReturnMonthsDurationAsDouble", testCanReturnMonthsDurationAsDouble),
        ("testCanReturnQuartersDuration", testCanReturnQuartersDuration),
        ("testCanReturnQuartersDurationAsDouble", testCanReturnQuartersDurationAsDouble),
        ("testCanReturnSecondsDuration", testCanReturnSecondsDuration),
        ("testCanReturnSecondsDurationAsDouble", testCanReturnSecondsDurationAsDouble),
        ("testCanReturnWeeksDuration", testCanReturnWeeksDuration),
        ("testCanReturnWeeksDurationAsDouble", testCanReturnWeeksDurationAsDouble),
        ("testCanReturnYearsDuration", testCanReturnYearsDuration),
        ("testCanReturnYearsDurationAsDouble", testCanReturnYearsDurationAsDouble),
    ]
}

extension FromNowTests {
    static let __allTests = [
        ("testFromNowEnglish", testFromNowEnglish),
        ("testFromNowHebrew", testFromNowHebrew),
    ]
}

extension MomentTests {
    static let __allTests = [
        ("testAddingInt", testAddingInt),
        ("testAddingOtherValues", testAddingOtherValues),
        ("testAdditionAndSubstractionAreInverse", testAdditionAndSubstractionAreInverse),
        ("testAddSmallTimeSpans", testAddSmallTimeSpans),
        ("testCanCompareMoments", testCanCompareMoments),
        ("testCanCreateMomentsWithFiveComponents", testCanCreateMomentsWithFiveComponents),
        ("testCanCreateMomentsWithFourComponents", testCanCreateMomentsWithFourComponents),
        ("testCanCreateMomentsWithOneComponent", testCanCreateMomentsWithOneComponent),
        ("testCanCreateMomentsWithSixComponents", testCanCreateMomentsWithSixComponents),
        ("testCanCreateMomentsWithThreeComponents", testCanCreateMomentsWithThreeComponents),
        ("testCanCreateMomentsWithTwoComponents", testCanCreateMomentsWithTwoComponents),
        ("testCanCreateWeirdDateFromComponents", testCanCreateWeirdDateFromComponents),
        ("testCanGetParametersByGetter", testCanGetParametersByGetter),
        ("testCreateDateWithDictionary", testCreateDateWithDictionary),
        ("testDescriptions", testDescriptions),
        ("testDifferentSyntaxesToAddAndSubstract", testDifferentSyntaxesToAddAndSubstract),
        ("testDurationVSTimeUnitDoesNotMatterForDaysHoursMinutesSeconds", testDurationVSTimeUnitDoesNotMatterForDaysHoursMinutesSeconds),
        ("testEmptyArrayOfComponentsYieldsNilMoment", testEmptyArrayOfComponentsYieldsNilMoment),
        ("testEmptyDictionaryOfComponentsYieldsNilMoment", testEmptyDictionaryOfComponentsYieldsNilMoment),
        ("testEndOfDay", testEndOfDay),
        ("testEndOfMonth", testEndOfMonth),
        ("testEndOfWeek", testEndOfWeek),
        ("testEndOfYear", testEndOfYear),
        ("testEpoch", testEpoch),
        ("testEqualityIsCommutative", testEqualityIsCommutative),
        ("testFindMaximumMoment", testFindMaximumMoment),
        ("testFindMinimumMoment", testFindMinimumMoment),
        ("testFormatDates", testFormatDates),
        ("testFormatDatesWithLocale", testFormatDatesWithLocale),
        ("testFormatWithTimeZone", testFormatWithTimeZone),
        ("testFutureMoment", testFutureMoment),
        ("testGibberishIsInvalid", testGibberishIsInvalid),
        ("testLocaleSupport", testLocaleSupport),
        ("testMaximumWithoutParametersReturnsNil", testMaximumWithoutParametersReturnsNil),
        ("testMinimumWithoutParametersReturnsNil", testMinimumWithoutParametersReturnsNil),
        ("testMomentWithTimeZone", testMomentWithTimeZone),
        ("testPastMoment", testPastMoment),
        ("testPublicDate", testPublicDate),
        ("testPublicLocale", testPublicLocale),
        ("testPublicTimeZone", testPublicTimeZone),
        ("testStartOfDay", testStartOfDay),
        ("testStartOfHour", testStartOfHour),
        ("testStartOfMinute", testStartOfMinute),
        ("testStartOfMonth", testStartOfMonth),
        ("testStartOfSecond", testStartOfSecond),
        ("testStartOfWeek", testStartOfWeek),
        ("testStartOfYear", testStartOfYear),
        ("testSubstractSmallTimeSpans", testSubstractSmallTimeSpans),
        ("testTheMomentIsNow", testTheMomentIsNow),
        ("testTimeZoneChangeAdd", testTimeZoneChangeAdd),
        ("testTimeZoneChangeEndOf", testTimeZoneChangeEndOf),
        ("testTimeZoneChangesPreserveMomentInGMT", testTimeZoneChangesPreserveMomentInGMT),
        ("testTimeZoneChangeStartOf", testTimeZoneChangeStartOf),
        ("testTimeZoneChangeSubtract", testTimeZoneChangeSubtract),
        ("testTimeZoneStartOfDay", testTimeZoneStartOfDay),
        ("testTransformTimeZone", testTransformTimeZone),
        ("testUsingWrongParameterNameYieldsNil", testUsingWrongParameterNameYieldsNil),
        ("testUTCMomentSupport", testUTCMomentSupport),
        ("testWrongArrayReturnsNil", testWrongArrayReturnsNil),
        ("testWrongFormatParametersReturnNil", testWrongFormatParametersReturnNil),
        ("testWrongUnitInAddReturnsSelf", testWrongUnitInAddReturnsSelf),
        ("testWrongUnitInEndOfReturnsSelf", testWrongUnitInEndOfReturnsSelf),
        ("testWrongUnitInStartOfReturnsSelf", testWrongUnitInStartOfReturnsSelf),
        ("testWrongUnitInSubstractReturnsSelf", testWrongUnitInSubstractReturnsSelf),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(DurationTests.__allTests),
        testCase(ExtensionsTests.__allTests),
        testCase(FromNowTests.__allTests),
        testCase(MomentTests.__allTests),
    ]
}
#endif
