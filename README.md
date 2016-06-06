# SwiftMoment

[![Build Status](https://travis-ci.org/akosma/SwiftMoment.svg?branch=master)](https://travis-ci.org/akosma/SwiftMoment)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/SwiftMoment.svg)](https://img.shields.io/cocoapods/v/SwiftMoment)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform](https://img.shields.io/cocoapods/p/SwiftMoment.svg?style=flat)](http://cocoadocs.org/docsets/SwiftMoment)
[![swiftyness](https://img.shields.io/badge/pure-swift-ff3f26.svg?style=flat)](https://swift.org/)

This framework is inspired by [Moment.js](http://momentjs.com). Its
objectives are the following:

- Simplify the manipulation and readability of date and interval values.
- Provide help when parsing dates from various string representations.
- Simplifying the formatting of date information into strings.
- Streamlining getting date components (day, month, etc.) from dates and
  time intervals.

Important: This framework supports iOS 8+, macOS 10.10+, tvOS 9+, watchOS 2+, Xcode 7 and Swift 2.2.

## Installation

SwiftMoment is compatible with
[Carthage](http://github.com/Carthage/Carthage) and
[CocoaPods](http://cocoapods.org/). With CocoaPods, just add this to
your Podfile:

```ruby
pod 'SwiftMoment'
```

## Mac OS X Notes

- Drag the created .framework file into the Xcode Project, be sure to tick 'Copy Files to Directory'
- In the containing applications target, add a new 'Copy File Build Phase'
- Set the 'Destination' to 'Frameworks'
- Drag in the created .framework

## Examples

To use this library, just `import SwiftMoment` in your application.

To create new moment instances:

```Swift
let now = moment()
let yesterday = moment("2015-01-19")
```

By default, moments are initialized with the current date and time. You
can create moments for any... moment in the future or the past; you can
do that by passing strings in different formats:

```Swift
let yesterday = moment("2015-01-19")
```

You can also do it by directly specifying the components manually:

```Swift
let today = moment([2015, 01, 19, 20, 45, 34])
```

You can also use a dictionary with the following keys:

```Swift
let obj = moment(["year": 2015,
                    "second": 34,
                    "month": 01,
                    "minute": 45,
                    "hour": 20,
                    "day": 19
                ])
```

When using a `[String: Int]` dictionary, the order of the keys does not
matter. Moreover, only the keys above are taken into account, and any
other information is ignored.

There is also an extension to the `Int` type in Swift, used to create
`Duration` values directly from an integer value:

```Swift
let duration = 5.hours + 56.minutes
```

## Architecture

The two most important components of this library are the `Moment` and
`Duration` structures. `Moment` wraps an `NSDate` instance, while
`Duration` wraps an `NSTimeInterval` value.

Both `Moment` and `Duration` comply with the `Comparable` protocols, and
include all the required operators. In addition, `Moment` instances can
be subtracted from one another (which yields a `Duration`) and
`Duration` instances can be added to `Moments` to create new moments.

`Moments` and `Durations` are made as immutable as possible.

## Tests

Swift Moment includes a suite of tests showing how to use the different
functions of the framework.

## Playground

A playground is included in the project to learn how to use the library.

## Differences with [Moment.js](http://momentjs.com)

- Format strings `DD` and `dd` do not yield the same results.

## Contributors

Lots of people are actively helping in the development of this library;
please check the
[CONTRIBUTORS](https://github.com/akosma/SwiftMoment/blob/master/CONTRIBUTORS.md)
file for the full list! Thanks to all :)

## License

This project is distributed under a BSD license. See the LICENSE file
for details.

