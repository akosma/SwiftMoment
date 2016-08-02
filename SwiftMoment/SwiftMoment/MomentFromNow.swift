//
//  MomentFromNow.swift
//  SwiftMoment
//
//  Created by Madhava Jay on 07/06/2016.
//  Copyright © 2016 Adrian Kosmaczewski. All rights reserved.
//

import Foundation

extension Moment {
    public func fromNow() -> String {
      let timeDiffDuration = moment(Date()).intervalSince(self)
      let deltaSeconds = Int(timeDiffDuration.seconds)

      var value: Int!

      if deltaSeconds < 5 {
        // Just Now
        return NSDateTimeAgoLocalizedStrings("Just now")

      } else if deltaSeconds < minuteInSeconds {
        // Seconds Ago
        return stringFromFormat("%%d %@seconds ago", withValue: deltaSeconds)

      } else if deltaSeconds < (minuteInSeconds * 2) {
        // A Minute Ago
        return NSDateTimeAgoLocalizedStrings("A minute ago")

      } else if deltaSeconds < hourInSeconds {
        // Minutes Ago
        return stringFromFormat("%%d %@minutes ago", withValue: deltaSeconds / minuteInSeconds)

      } else if deltaSeconds < (hourInSeconds * 2) {
        // An Hour Ago
        return NSDateTimeAgoLocalizedStrings("An hour ago")

      } else if deltaSeconds < dayInSeconds {
        // Hours Ago
        value = Int(floor(Float(deltaSeconds / hourInSeconds)))
        return stringFromFormat("%%d %@hours ago", withValue: value)

      } else if deltaSeconds < (dayInSeconds * 2) {
        // Yesterday
        return NSDateTimeAgoLocalizedStrings("Yesterday")

      } else if deltaSeconds < weekInSeconds {
        // Days Ago
        value = Int(floor(Float(deltaSeconds / dayInSeconds)))
        return stringFromFormat("%%d %@days ago", withValue: value)

      } else if deltaSeconds < (weekInSeconds * 2) {
        // Last Week
        return NSDateTimeAgoLocalizedStrings("Last week")

      } else if deltaSeconds < monthInSeconds {
        // Weeks Ago
        value = Int(floor(Float(deltaSeconds / weekInSeconds)))
        return stringFromFormat("%%d %@weeks ago", withValue: value)

      } else if deltaSeconds < (dayInSeconds * 61) {
        // Last month
        return NSDateTimeAgoLocalizedStrings("Last month")

      } else if deltaSeconds < yearInSeconds {
        // Month Ago
        value = Int(floor(Float(deltaSeconds / monthInSeconds)))
        return stringFromFormat("%%d %@months ago", withValue: value)

      } else if deltaSeconds < (yearInSeconds * 2) {
        // Last Year
        return NSDateTimeAgoLocalizedStrings("Last year")
      }

      // Years Ago
      value = Int(floor(Float(deltaSeconds / yearInSeconds)))
      return stringFromFormat("%%d %@years ago", withValue: value)
    }

    private func stringFromFormat(_ format: String, withValue value: Int) -> String {
      let localeFormat = String(format: format,
                                getLocaleFormatUnderscoresWithValue(Double(value)))
      return String(format: NSDateTimeAgoLocalizedStrings(localeFormat), value)
    }

    private func NSDateTimeAgoLocalizedStrings(_ key: String) -> String {
      // get framework bundle
      let bundleIdentifier = "com.akosma.SwiftMoment"
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

      let localeIdentifer = self.locale.identifier

      // Try to get the Language Bundle based on the localIdentifier, for example "en_US"
      var languageBundle = getLanguageBundle(bundle, localeIdentifier: localeIdentifer)

      // If it doesn't exist then we can try again
      if languageBundle == nil {

        // Get the first 2 letters from the localIdentifier and use them instead, for example "en"
        let languageCode = String(localeIdentifer.characters.prefix(2))
        languageBundle = getLanguageBundle(bundle, localeIdentifier: languageCode)
        if languageBundle == nil {
          // Still nothing
          return ""
        }
      }

      // Get localized string from language look up table
      return languageBundle!.localizedString(forKey: key, value: "", table: "NSDateTimeAgo")
    }

  private func getLanguageBundle(_ bundle: Bundle, localeIdentifier: String) -> Bundle? {
    // swiftlint:disable conditional_binding_cascade
    guard let languagePath = bundle.path(forResource: localeIdentifier, ofType: "lproj"),
          let languageBundle = Bundle(path: languagePath) else {
        return nil
    // swiftlint:enable conditional_binding_cascade
    }

    return languageBundle
  }

    private func getLocaleFormatUnderscoresWithValue(_ value: Double) -> String {
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
