import Foundation

// Set input file path and create empty string array
let path = "input"
var input = [String]()

if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

let numericalInput = input.compactMap {Int(String($0))}

var f = 0
var frequencies = Set<Int>([0])
repeat {
    for num in numericalInput {
        f = f + num
        if frequencies.contains(f) {
            print(f)
            exit(1)
        } else {
            frequencies.insert(f)
        }
    }
} while true
