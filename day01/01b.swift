import Foundation

// Set input file path and create empty string array
let path = "input"
var input = [String]()

// Store input data in string. Then split string into string array based on new line
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

// Convert to integer array
let numericalInput = input.compactMap {Int(String($0))}

var total = 0

// Create integer set
var frequencies = Set<Int>([0])
// Infinite loop
repeat {
    for num in numericalInput {
        total += num
        // If number in frequncies print and quit
        if frequencies.contains(total) {
            print(total)
            exit(1)
        } else {
            frequencies.insert(total)
        }
    }
} while true
