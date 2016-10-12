//
//  MomentFromNow.swift
//  SwiftMoment
//
//  Created by Madhava Jay on 07/06/2016.
//  Copyright © 2016 Adrian Kosmaczewski. All rights reserved.
//

import Foundation

// needed to dynamically select the bundle below
class MomentBundle: NSObject { }

extension Moment {

    /// Returns a localized string specifying the time duration between
    /// the current instance and the present moment.
    ///
    /// - returns: A localized string.
    public func fromNow() -> String {
        let timeDiffDuration = moment().intervalSince(self)
        let deltaSeconds = timeDiffDuration.seconds

        var value: Double!

        if deltaSeconds < 5 {
            // Just Now
            return NSDateTimeAgoLocalizedStrings("Just now")

        }
        else if deltaSeconds < minuteInSeconds {
            // Seconds Ago
            return stringFromFormat("%%1.0f %@seconds ago", withValue: deltaSeconds)

        }
        else if deltaSeconds < (minuteInSeconds * 2) {
            // A Minute Ago
            return NSDateTimeAgoLocalizedStrings("A minute ago")

        }
        else if deltaSeconds < hourInSeconds {
            // Minutes Ago
            return stringFromFormat("%%1.0f %@minutes ago", withValue: deltaSeconds / minuteInSeconds)

        }
        else if deltaSeconds < (hourInSeconds * 2) {
            // An Hour Ago
            return NSDateTimeAgoLocalizedStrings("An hour ago")

        }
        else if deltaSeconds < dayInSeconds {
            // Hours Ago
            value = floor(deltaSeconds / hourInSeconds)
            return stringFromFormat("%%1.0f %@hours ago", withValue: value)

        }
        else if deltaSeconds < (dayInSeconds * 2) {
            // Yesterday
            return NSDateTimeAgoLocalizedStrings("Yesterday")

        }
        else if deltaSeconds < weekInSeconds {
            // Days Ago
            value = floor(deltaSeconds / dayInSeconds)
            return stringFromFormat("%%1.0f %@days ago", withValue: value)

        }
        else if deltaSeconds < (weekInSeconds * 2) {
            // Last Week
            return NSDateTimeAgoLocalizedStrings("Last week")

        }
        else if deltaSeconds < monthInSeconds {
            // Weeks Ago
            value = floor(deltaSeconds / weekInSeconds)
            return stringFromFormat("%%1.0f %@weeks ago", withValue: value)

        }
        else if deltaSeconds < (dayInSeconds * 61) {
            // Last month
            return NSDateTimeAgoLocalizedStrings("Last month")

        }
        else if deltaSeconds < yearInSeconds {
            // Month Ago
            value = floor(deltaSeconds / monthInSeconds)
            return stringFromFormat("%%1.0f %@months ago", withValue: value)

        }
        else if deltaSeconds < (yearInSeconds * 2) {
            // Last Year
            return NSDateTimeAgoLocalizedStrings("Last year")
        }

        // Years Ago
        value = floor(deltaSeconds / yearInSeconds)
        return stringFromFormat("%%1.0f %@years ago", withValue: value)
    }

    fileprivate func stringFromFormat(_ format: String, withValue value: Double) -> String {
        let localeFormat = String(format: format,
                                  getLocaleFormatUnderscoresWithValue(value))
        return String(format: NSDateTimeAgoLocalizedStrings(localeFormat), value)
    }

    fileprivate func NSDateTimeAgoLocalizedStrings(_ key: String) -> String {
        // get framework bundle
        guard let bundleIdentifier = Bundle(for: MomentBundle.self).bundleIdentifier  else {
            return ""
        }

        guard let frameworkBundle = Bundle(identifier: bundleIdentifier) else {
            return ""
        }

        guard let resourcePath = frameworkBundle.resourcePath else {
            return ""
        }

        let bundleName = "MomentFromNow.bundle"
        let path = URL(fileURLWithPath:resourcePath).appendingPathComponent(bundleName)
        guard let bundle = Bundle(url: path) else {
            return ""
        }

        if let languageBundle = getLanguageBundle(bundle) {
            return languageBundle.localizedString(forKey: key, value: "", table: "NSDateTimeAgo")
        }

        return ""
    }

    fileprivate func getLanguageBundle(_ bundle: Bundle) -> Bundle? {
        let localeIdentifer = self.locale.identifier
        if let languagePath = bundle.path(forResource: localeIdentifer, ofType: "lproj") {
            return Bundle(path: languagePath)
        }

        let langDict = Locale.components(fromIdentifier: localeIdentifer)
        let languageCode = langDict["kCFLocaleLanguageCodeKey"]
        if let languagePath = bundle.path(forResource: languageCode, ofType: "lproj") {
            return Bundle(path: languagePath)
        }

        return nil
    }

    fileprivate func getLocaleFormatUnderscoresWithValue(_ value: Double) -> String {
        guard let localeCode = Locale.preferredLanguages.first else {
            return ""
        }

        if localeCode == "ru" {
            let XY = Int(floor(value)) % 100
            let Y = Int(floor(value)) % 10

            if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
                return ""
            }

            if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
                return "_"
            }

            if Y == 1 && XY != 11 {
                return "__"
            }
        }

        return ""
    }
}
