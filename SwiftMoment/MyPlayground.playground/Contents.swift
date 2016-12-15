import SwiftMoment

let now = moment()
print(now.format())

now.second

var obj = moment([2015, 01, 19, 20, 45, 34])!
obj = obj + 4.days
obj.format("YYYY MMMM dd")

obj.fromNow()

obj.daysInMonth()
obj.isLeapYear()
obj.daysTillEndOfMonth()
obj.daysInYear()

var yesterday = moment(locale: Locale(identifier: "ES")) - 2.days
yesterday.fromNow()

let today = moment()
let first = moment(today).add(50.days)
let second = moment(today).add(50, .days)

let meierskappel = moment("November 23, 1847")!
let gettysburg = moment("Jul/01/1863")!
let pavon = moment("1861-09-17T10:30:00GMT-4")!

let moments = [pavon, gettysburg, meierskappel]
let sorted = moments.sorted(by: <)
print(sorted)

let p = past()
let f = future()

// Maximum and minimum
let max = maximum(f, now, p) // f, of course
let min = minimum(p, f, now) // p, of course
