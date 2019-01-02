import Foundation

extension String {
     mutating func removeFirstOccurance(of string: String) {
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

extension String {
    func reducePolymer(skipping: [Character] = [Character]()) -> String {
        var polymer = self
        let str = "abcdefghijklmnopqrstuvwxyz"
        let characterArray = Array(str)
        var chars = [String]()

        for alpha in characterArray {
            if !skipping.contains(alpha) {
                chars.append(String(alpha)+String(alpha).uppercased())
                chars.append(String(alpha).uppercased()+String(alpha))
            }
        }

        var old = polymer

        repeat {
            old = polymer
            for unitType in chars {
                polymer.removeFirstOccurance(of: unitType)
            }
        } while (polymer != old)
        return polymer
    }
}

let reduction = polymer.reducePolymer()

print("Part A: \(reduction.count)")

let str = "abcdefghijklmnopqrstuvwxyz"
let characterArray = Array(str)
var numberOfUnits = Set<Int>()

for unitType in characterArray {
    var reducer = polymer
    reducer = reducer.replacingOccurrences(of: String(unitType), with: "")
    reducer = reducer.replacingOccurrences(of: String(unitType).uppercased(), with: "")
    reducer = reducer.reducePolymer(skipping: [unitType])
    numberOfUnits.insert(reducer.count)
}

print("Part B: \(numberOfUnits.min()!)")
