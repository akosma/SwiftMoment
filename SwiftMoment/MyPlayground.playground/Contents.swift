import SwiftMoment

let now = moment()
print(now.format())

var obj = moment([2015, 01, 19, 20, 45, 34])!
obj = obj + 4.days
obj.format("YYYY MMMM dd")

obj.date