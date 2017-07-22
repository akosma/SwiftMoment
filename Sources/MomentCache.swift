//
//  MomentCache.swift
//  SwiftMoment
//
//  Created by Florent Pillet on 08/12/16.
//  Copyright © 2016 Adrian Kosmaczewski. All rights reserved.
//

import Foundation

internal class MomentCache {
	// the key we use to cache calendars for a common TimeZone / Locale pair
	private struct Key : Hashable, Equatable {
		let tz: TimeZone
		let locale: Locale
		
		var hashValue: Int {
			return tz.hashValue ^ locale.hashValue
		}
		static func ==(lhs: Key, rhs: Key) -> Bool {
			return lhs.tz == rhs.tz && lhs.locale == rhs.locale
		}
	}
	
	// our cache and the lock to access it
	private static var calendarCache = [Key:Calendar]()
	private static var lock = NSLock()
	
	// create calendars on demand; in most cases, will return the same calendar
	static func calendar(timeZone: TimeZone = defaultTimezone, locale: Locale = defaultLocale) -> Calendar {
		lock.lock()
		defer { lock.unlock() }
		let key = Key(tz: timeZone, locale: locale)
		if let calendar = calendarCache[key] {
			return calendar
		}
		var calendar = Calendar.autoupdatingCurrent
		calendar.timeZone = timeZone
		calendar.locale = locale
		calendarCache[key] = calendar
		return calendar
	}
	
	static var defaultCalendar : Calendar = { Calendar.autoupdatingCurrent }()
	static var defaultLocale : Locale = { Locale.autoupdatingCurrent }()
	static var defaultTimezone : TimeZone = { TimeZone.autoupdatingCurrent }()
}
