import Foundation

// Declare a new struct
struct Point {
    var xCoord = 0
    var yCoord = 0
}

// Make struct hashable to allow it to be inserted into Sets
extension Point: Hashable {
    public var hashValue: Int {
        return xCoord.hashValue ^ yCoord.hashValue
    }

    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.xCoord == rhs.xCoord && lhs.yCoord == rhs.yCoord
    }
}

// Rectangle struct used to keep code organized
struct Rectangle {
    var startX = 0
    var startY = 0
    var width = 0
    var height = 0
}

// Takes in regex and string outputs matching string array
func matches(for regex: String, in text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

// Uses the regex function above to parse Input and output a rectangle
func parseInput(_ input: String) -> Rectangle {
    let matched = matches(for: "[0-9]+", in: input)
    return Rectangle(startX: Int(matched[1])!, startY: Int(matched[2])!,
                     width: Int(matched[3])!, height: Int(matched[4])!)
}

// Outputs a set of points which contains the claim of cloth
func getPoints(_ rect: Rectangle) -> Set<Point> {
    let size = rect.width * rect.height
    var coordinates = Set<Point>(minimumCapacity: size)
    for xCoord in rect.startX..<(rect.startX+rect.width) {
        for yCoord in rect.startY..<(rect.startY+rect.height) {
            coordinates.insert(Point(xCoord: xCoord, yCoord: yCoord))
        }
    }
    return coordinates
}

let path = "input"
var input = [String]()

// Convert file to string and then store every new line in new string in input array
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

// Sets to store coodinates seen, and those that have duplicates
var seen = Set<Point>()
var intersecting = Set<Point>()

// Iterates through all non empty inputs
// Gets points into a set, Appends intersection between points and seen to intersecting
// Adds rest to seen
for index in input where index != "" {
    let temp = getPoints(parseInput(index))
    intersecting = intersecting.union(temp.intersection(seen))
    seen = seen.union(temp)
}

// Prints number of intersecting points
print("Part A:\(intersecting.count)")

// Iterates through all non empty inputs and finds line that is disjoint with intersecting prints ID
for index in input where index != "" {
    if intersecting.isDisjoint(with: getPoints(parseInput(index))) {
        print("Part B:\(matches(for: "[0-9]+", in: index)[0])")
    }
}
