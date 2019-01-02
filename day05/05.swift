import Foundation

extension String {
     mutating func removeFirstOccurance(of string: String){
        guard let range = self.range(of: string) else {return}
        self.removeSubrange(range)
    }
}

let path = "input"
var input = [String]()

// Convert file to string and then store every new line in new string in input array
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}
var polymer = input[0]

let str = "abcdefghijklmnopqrstuvwxyz"
let characterArray = Array(str)
let uppercaseArray = Array(str.uppercased())
var chars = [String]()

for (i, j) in zip(characterArray, uppercaseArray) {
    chars.append(String(i)+String(j))
    chars.append(String(j)+String(i))
}

var old = polymer
repeat {
    old = polymer
    for i in chars {
        polymer.removeFirstOccurance(of: i)
    }
} while (polymer != old)

print(polymer.count)



