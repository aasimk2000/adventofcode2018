import Foundation

func count(_ input: String) -> [Int: Bool] {
    let characters = Array(input)
    var myDictionary = [Character: Int]()
    for word in characters {
        if myDictionary.keys.contains(word) {
            myDictionary[word] = myDictionary[word]! + 1
        } else {
            myDictionary[word] = 1
        }
    }
    var output = [2: false, 3: false]
    for (_, number) in myDictionary {
        if number == 2 {
            output[2] = true
        }
        if number == 3 {
            output[3] = true
        }
    }

    return output
}

let path = "input"
var input = [String]()

if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

var count3 = 0
var count2 = 0
var output = [Int: Bool]()

for word in input {
    output = count(word)
    if output[2]! {
        count2 += 1
    }
    if output[3]! {
        count3 += 1
    }
}

print(count3 * count2)
