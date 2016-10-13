# SwiftMoment

This framework is inspired by [Moment.js](http://momentjs.com). Its
objectives are the following:

- Simplify the manipulation and readability of date and interval values.
- Provide help when parsing dates from various string representations.
- Simplifying the formatting of date information into strings.
- Streamlining getting date components (day, month, etc.) from dates and
  time intervals.

Important: This framework supports iOS 9+, macOS 10.11+, tvOS 9+, watchOS 2+, Xcode 8 and Swift 3.

Please pay attention to the following API difference with
[Moment.js](http://momentjs.com)

- Format strings `DD` and `dd` do not yield the same results.

---

# Installation

You can include SwiftMoment in your project in three different ways:

1. You can drag and drop the library files, including
   `MomentFromNow.bundle` in your own project. Swift Moment does not
   have any other dependencies than Foundation (actually this is the
   method we have used in this Playground Book!)
2. Use [CocoaPods]:https://cocoapods.org
3. Use [Carthage]:http://github.com/Carthage/Carthage

If you are using CocoaPods, just add this line to your Podfile:

```
pod 'SwiftMoment'
```

It is strongly recommended to add a version number to your podfile:

```
pod 'SwiftMoment', '~> 0.7'
```

(Version 0.7 is the latest version available at the time of this
writing.)

Once you have installed SwiftMoment, we can move to the next chapter and
learn how to use it.

## Mac OS X Notes

- Drag the created .framework file into the Xcode Project, be sure to
  tick 'Copy Files to Directory'
- In the containing applications target, add a new 'Copy File Build
  Phase'
- Set the 'Destination' to 'Frameworks'
- Drag in the created .framework

---

# Using SwiftMoment

The two most important components of SwiftMoment are the `Moment` and
`Duration` structures. `Moment` wraps an `NSDate` instance, while
`Duration` wraps an `NSTimeInterval` value.

Both `Moment` and `Duration` comply with the `Comparable` protocols, and
include all the required operators. In addition, `Moment` instances can
be subtracted from one another (which yields a `Duration`) and
`Duration` instances can be added to `Moments` to create new moments.

`Moments` and `Durations` are both immutable.

## Creating Moments

To use this library, just `import SwiftMoment` in your application, then
call the `moment()` function:

    let now = moment()

This will create a new `Moment` ready to be used, representing the
current date.

### Creating Moments with Strings

You can also create moments based on dates both in the future and the
past:

    let yesterday = moment("2015-01-19")

SwiftMoment supports a wide array of valid string formats off-the-box:

    // Famous battles of the 19th century:
    let meierskappel = moment("November 23, 1847")!
    let gettysburg = moment("Jul/01/1863")!
    let pavon = moment("1861-09-17T10:30:00GMT-4")!

This is the full list of default formats.

- "yyyy-MM-dd'T'HH:mm:ssZZZZZ" (ISO)
- "yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"
- "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
- "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
- "yyyy-MM-dd"
- "h:mm:ss A"
- "h:mm A"
- "MM/dd/yyyy"
- "MMMM d, yyyy"
- "MMMM d, yyyy LT"
- "dddd, MMMM D, yyyy LT"
- "yyyyyy-MM-dd"
- "yyyy-MM-dd"
- "GGGG-[W]WW-E"
- "GGGG-[W]WW"
- "yyyy-ddd"
- "HH:mm:ss.SSSS"
- "HH:mm:ss"
- "HH:mm"
- "HH"

Since SwiftMoment wraps the standard date formatting functionality of
the Foundation framework, the format string uses the format patterns
from the [Unicode Technical Standard #35](http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Format_Patterns).

Of course, if your format does not happen to be supported off-the-box,
you can pass it as parameter when creating your moment; this allows you
to parse and use dates in the most weird formats.

    let data = "Tue 1973/4--September 12:30 GMT-03:00"
    let format = "EE yyyy/dd--MMMM HH:mm ZZZZ"
    let birthday = moment(data, dateFormat: format)!

### Creating Moments with Arrays and Dictionaries

You can also specify the date components manually, in which case the
elements are read in a particular order: year, month, day, hour, minute
and second. Missing parameters are automatically initialized to zero:

    let today = moment([2015, 01, 19, 20, 45, 34])
    let todayAtMidnight = moment([2015, 01, 19])

Or using a dictionary:

    let withDict = moment(["year": 2015,
                           "second": 34,
                           "minute": 45,
                           "month": 01,
                           "hour": 20,
                           "day": 19,
                           "ignored_whatever": 25346436
                          ])

When using a `[String: Int]` dictionary, the order of the keys does not
matter. Moreover, only the keys above are taken into account, and any
other information is ignored.

If you pass an empty array or dictionary, you get an `Optional<Moment>`
value that evaluates to `nil`.

### Creating Moments with Other Parameters

SwiftMoment integrates nicely with any existing Swift code that may
already be using `Date`, `TimeInterval` or even integer representing
milliseconds:

    import Foundation

    let date = Date()
    let withDate = moment(date)
    let systemMilliseconds = moment(25433465)
    let hundredSecondsAfterEpoch = moment(TimeInterval(100))

If you need to copy a Moment into another, just pass it to the
`moment()` function:

    let original = moment()
    let copy = moment(original)

### Convenience Functions

SwiftMoment includes other useful functions to manipulate time and date
information in your applications:

    // Past and future
    let middle = moment()
    let p = past()
    let f = future()

    // Maximum and minimum
    let max = maximum(f, middle, p) // f, of course
    let min = minimum(p, f, middle) // p, of course

### Manipulating Moments

However you create a Moment, you can inspect it and get all the
information you need.

    let obj = moment()

    // returns the wrapped values inside
    obj.date
    obj.timeZone
    obj.locale

    // show the different parts of the moment
    obj.second
    obj.minute
    obj.hour
    obj.day
    obj.weekday
    obj.weekdayName
    obj.monthName
    obj.month
    obj.quarter
    obj.year

    // you can alternatively use the get() methods:
    obj.get(.days)
    obj.get("m") // returns the minutes

The `get()` method uses the `TimeUnit` enumeration or its string value,
which is another component of SwiftMoment. You can use the following
string values instead of the enumeration values, if you prefer:

- `.years` = "y"
- `.quarters` = "Q"
- `.months` = "M"
- `.weeks` = "w"
- `.days` = "d"
- `.hours` = "H"
- `.minutes` = "m"
- `.seconds` = "s"

Of course, the version of `get()` that takes a string will return `nil`
if you provide an invalid value.

## Durations

There is also an extension to the `Int` type in Swift, used to create
`Duration` values directly from an integer value:

    let duration = 5.hours + 56.minutes

---

# Contributor Guidelines

So you want to help us making a better SwiftMoment? Thanks! For the sake
of a productive collaboration, please pay attention to the following
collaboration guidelines:

## Pull Requests > Issues

Whenever possible, try to provide us with [pull
requests](https://help.github.com/articles/creating-a-pull-request/)
instead of simply creating an issue. Pull requests help us move forward
faster, and we will be glad to review and eventually include it in the
master branch.

## Issues

If you open an issue, make sure to include a complete description.
Follow the template that appears on the form, including as much
information as possible. You should include code snippets that helps us
reproduce the error. Saying "it does not work" without further context
does not help anybody.

## Pull Requests

If you create a pull request, please be aware that we only accept pull
requests that include unit tests for your changes. **We do not accept
pull requests without the appropriate unit tests** unless they are just
grammar, cosmetic, documentation or typographical corrections.

Before sending a pull request, make sure that:

1. Your code compiles without warnings of any kind.
2. Your code runs without runtime warnings.
3. You have checked your code with either
   [SwiftLint](https://github.com/realm/SwiftLint) or
   [Tailor](https://tailor.sh) and you have removed any warnings shown
   by either of these tools.
4. You have included unit tests for your feature, if required.
5. All previous unit tests pass.
6. You have included and/or updated API documentation in the public
   methods, structs and classes that are referenced by your pull
   request.

## Behaviour

We want SwiftMoment to be an inclusive project. Please be kind and
helpful in your comments. In case of doubt, ask questions. Be honest and
humble. May SwiftMoment be a better place after you have been here :)

---

# Authors

## Core Committers

- [Adrian Kosmaczewski](https://github.com/akosma)
- [Florent Pillet](https://github.com/fpillet)
- [Madhava Jay](https://github.com/madhavajay)

## Contributors

This is the people that have helped making SwiftMoment with pull
requests, bug submissions, etc since 2015:

- [박현재](https://github.com/hyeonjae)
- [akihiro0228](https://github.com/akihiro0228)
- [Aaron Brager](https://github.com/getaaron)
- [Adriano Goncalves](https://github.com/amg1976)
- [Anders Klenke](https://github.com/andersklenke)
- [Andrew Barba](https://github.com/AndrewBarba)
- [Andrew Branch](https://github.com/andrewbranch)
- [Burak Akkaş](https://github.com/javasch)
- [Chris Sloey](https://github.com/chrissloey)
- [Daniel Cestari](https://github.com/dcestari)
- [David Harris](https://github.com/toadzky)
- [Eric Fang](https://github.com/fjhixiuxiu)
- [Fabio Felici](https://github.com/fabfelici)
- [Hadar Landao](https://github.com/hlandao)
- [Jake Johnson](https://github.com/johnsonjake)
- [karupanenura](https://github.com/karupanerura)
- [Ken Goldfarb](https://github.com/kengoldfarb)
- [Laurin Brandner](https://github.com/larcus94)
- [Masaya Yashiro](https://github.com/yashims)
- [Mihyaeru](https://github.com/mihyaeru21)
- [Narayan Sainaney](https://github.com/nsainaney)
- [Nate Armstrong](https://github.com/n8armstrong)
- [Neil](https://github.com/AsFarA)
- [PG Herveou](https://github.com/pgherveou)
- [Pine Mizune](https://github.com/pine613)
- [Robert La Ferla](https://github.com/rlaferla)
- [Ryan Maxwell](https://github.com/ryanmaxwell)
- [Ryo Yamada](https://github.com/Liooo)
- [Tatiana Magdalena](https://github.com/tatimagdalena)
- [Tomáš Slíž](https://github.com/tomassliz)

## Special Thanks

A big shoutout to [Dave Verwer](https://twitter.com/daveverwer) who
kindly featured SwiftMoment in [iOS Dev Weekly issue
186](http://iosdevweekly.com/issues/186), to [Natasha
Murashev](http://natashatherobot.com) who also featured SwiftMoment in
her newsletter, and to [Swift Sandbox](http://swiftsandbox.io) who
featured SwiftMoment in [issue 36](http://swiftsandbox.io/issues/36?#start)!
Please make sure to subscribe to all of these newsletters!

Also thanks to [Matteo Crippa](https://github.com/matteocrippa) and
[dkhamsing](https://github.com/dkhamsing) for featuring SwiftMoment in
the [awesome swift](https://github.com/matteocrippa/awesome-swift) list!

---

# License

Copyright (c) 2015, Adrian Kosmaczewski
All rights reserved.

Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

---

# Credits

This book has been generated using
[PlaygroundBookGenerator](https://github.com/akosma/PlaygroundBookGenerator)
by Adrian Kosmaczewski.

