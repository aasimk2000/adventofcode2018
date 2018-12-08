import Foundation

let path = "input"
var input = [String]()

// Convert file to string and then store every new line in new string in input array
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

// Stores guard number and array of minutes during which they are sleeping
var guardSleep = [Int: [Int]]()
// Stores guard number and total time asleep
var times = [Int: Int]()

// Some variables that are used later
var start = Int()
var end = Int()
var guardNumber = Int()

// Sorting the input
input.sort()
for line in input where line != "" {
    var guardData = line.components(separatedBy: "]")
    // Seperate time and action
    var time = guardData[0]
    let action = guardData[1]
    time.remove(at: time.startIndex)
    guardData = time.components(separatedBy: ":")
    time = guardData[1]
    let minute = Int(time)!

    if action.hasPrefix(" Guard") {
        var actionData = action.components(separatedBy: " ")
        var guardSleeptring = actionData[2]
        guardSleeptring.remove(at: guardSleeptring.startIndex)
        guardNumber = Int(guardSleeptring)!
        // Initialize array for guard number
        if !guardSleep.keys.contains(guardNumber) {
            guardSleep[guardNumber] = [Int]()
        }
    } else if action.hasPrefix(" falls") {
        start = minute
    } else if action.hasPrefix(" wakes up") {
        let end = minute
        let diff = end - start
        times[guardNumber] = (times[guardNumber] ?? 0) + diff
        let sleepTimes: [Int] = Array(start..<end)
        guardSleep[guardNumber]?.append(contentsOf: sleepTimes)
    }
}

// Find guard with greates time sleeping
let greatestTime = times.max(by: {$0.1 < $1.1})
var counts = [Int: Int]()
guardSleep[(greatestTime?.key)!]?.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
if let (value, _) = counts.max(by: {$0.1 < $1.1}) {
    print("Part A: \(value * (greatestTime?.key ?? -1))")
}

// Store [Guard Number, minute sleeping most]: Count
var maxSleepTimePerGuard = [[Int]: Int]()

for (guardNumber, sleepTimes) in guardSleep {
    var counts = [Int: Int]()
    sleepTimes.forEach {counts[$0] = (counts[$0] ?? 0) + 1}
    if let (value, count) = counts.max(by: {$0.1 < $1.1}) {
        maxSleepTimePerGuard[[guardNumber, value]] = count
    }
}

let greatestMinute = maxSleepTimePerGuard.max(by: {$0.1 < $1.1})
print("Part B: \((greatestMinute?.key[1])! * (greatestMinute?.key[0])!)")
