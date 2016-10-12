import SwiftMoment

let now = moment()
print(now.format())

var obj = moment([2015, 01, 19, 20, 45, 34])!
obj = obj + 4.days
obj.format("YYYY MMMM dd")

obj.fromNow()

let today = moment()
let first = moment(today).add(50.days)
let second = moment(today).add(50, .days)

let meierskappel = moment("1847-11-23")!
let gettysburg = moment("1863-07-1")!
let pavon = moment("1861-09-17")!
let moments = [pavon, gettysburg, meierskappel]
let sorted = moments.sorted(by: <)
print(sorted)
