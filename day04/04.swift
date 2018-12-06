import Foundation

struct GuardInfo {
    let ID:Int
    let start:Date
    let end:Date
}

let path = "input"
var input = [String]()

var Guards = [GuardInfo]()
let times = [Int:Int]()

// Convert file to string and then store every new line in new string in input array
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

input.sort()
for line in input where line != "" {
    var guardData = line.components(separatedBy: "]")
    var time = guardData[0]
    time.remove(at: time.startIndex)
    let date = dateFormatter.date(from: time)
    let action = guardData[1]
    var guardNumber = Int()
    var start = Date()
    var end = Date()
    
    if action.hasPrefix(" Guard") {
        var actionData = action.components(separatedBy: " ")
        var guardString = actionData[2]
        guardString.remove(at: guardString.startIndex)
        guardNumber = Int(guardString)!
    } else if action.hasPrefix(" falls") {
        start = date!
    } else if action.hasPrefix(" wakes up") {
        end = date!
        let thisGuard = GuardInfo(ID: guardNumber, start: start, end: end)
        Guards.append(thisGuard)
        let test = Calendar.current.dateComponents([.minute], from: start, to: end)
        //print(test.minute)
    }
    
}

// [1518-05-04 23:56] Guard #523 begins shift
