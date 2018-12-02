import Foundation

// Parse input
let path = "input"
var input = [String]()

if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

// Create some objects
var difference: [(Character, Character)]
var answer: String = ""

// Iterate through all possible combinations of keys
for items in input {
    for newItems in input {
        // Pair characters and filter those that differ
        difference = zip(items, newItems).filter { $0 != $1 }
        if difference.count == 1 {
            // Find stuff in common and add to string and print
            difference = zip(items, newItems).filter { $0 == $1 }
            for (char, _) in difference {
                answer += String(char)
            }
            print(answer)
            exit(1)
        }
    }
}
