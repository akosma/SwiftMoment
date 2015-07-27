import SwiftMoment

let now = moment()
println(now.format())

var obj = moment([2015, 01, 19, 20, 45, 34])!
obj = obj + 4.days
obj.format(dateFormat: "YYYY MMMM dd")
