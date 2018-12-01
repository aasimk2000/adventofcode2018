import Foundation

// Set input file path and create empty string array
let path = "input"
var input = [String]()

// Convert file to string and then store every new line in new string in input array
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

// Compact map converts all numeric elements of string array to int array (every input in this case)
// reduce sums them up
let total = input.compactMap {Int(String($0))}.reduce(0, +)

print(total)
