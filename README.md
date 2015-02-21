Swift Moment
============

This framework is inspired by [Moment.js](http://momentjs.com). Its
objectives are the following:

- Simplify the manipulation and readability of date and interval values.
- Provide help when parsing dates from various string representations.
- Simplifying the formatting of date information into strings.
- Streamlining getting date components (day, month, etc.) from dates and
  time intervals.

This framework targets iOS 8 and later exclusively.

Installation
------------

With [CocoaPods](http://cocoapods.org/), just add this to your Podfile:

```ruby
pod 'SwiftMoment'
```

Examples
--------

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

Architecture
------------

The two most important components of this library are the `Moment` and
`Duration` structures. `Moment` wraps an `NSDate` instance, while
`Duration` wraps an `NSTimeInterval` value.

Both `Moment` and `Duration` comply with the `Comparable` protocols, and
include all the required operators. In addition, `Moment` instances can
be substracted from one another (which yields a `Duration`) and
`Duration` instances can be added to `Moments` to create new moments.

`Moments` and `Durations` are made as immutable as possible.

To create new `Moment` values, use the family of `moment()` functions.
See below for examples.

Documentation
-------------

The documentation of the code is extracted using
[Jazzy](https://github.com/realm/jazzy).

Tests
-----

Swift Moment includes a suite of tests showing how to use the different
functions of the framework.

Contributors
------------

Lots of people are actively helping in the development of this library;
please check the CONTRIBUTORS file for the full list! Thanks to all :)

License
-------

This project is distributed under a BSD license. See the LICENSE file
for details.

