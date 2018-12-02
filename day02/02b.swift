import Foundation

let path = "input"
var input = [String]()

if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

var difference: [(Character, Character)]
var answer: String = ""

for items in input {
    for newItems in input {
        difference = zip(items, newItems).filter { $0 != $1 }
        if difference.count == 1 {
            difference = zip(items, newItems).filter { $0 == $1 }
            for (char, _) in difference {
                answer += String(char)
            }
            print(answer)
            exit(1)
        }
    }
}
