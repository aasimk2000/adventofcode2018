import Foundation

struct Point {
    var xCoord = 0
    var yCoord = 0
}

extension Point: Hashable {
    public var hashValue: Int {
        return xCoord.hashValue ^ yCoord.hashValue
    }

    public static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.xCoord == rhs.xCoord && lhs.yCoord == rhs.yCoord
    }
}

struct Rectangle {
    var startX = 0
    var startY = 0
    var width = 0
    var height = 0
}

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

func parseInput(_ input: String) -> Rectangle {
    let matched = matches(for: "[0-9]+", in: input)
    return Rectangle(startX: Int(matched[1])!, startY: Int(matched[2])!,
                     width: Int(matched[3])!, height: Int(matched[4])!)
}

let path = "input"
var input = [String]()

// Convert file to string and then store every new line in new string in input array
if let rawInput = try? String(contentsOfFile: path) {
    input = rawInput.components(separatedBy: "\n")
}

var seen = Set<Point>()
var intersecting = Set<Point>()
for index in input where index != "" {
    let temp = getPoints(parseInput(index))
    intersecting = intersecting.union(temp.intersection(seen))
    seen = seen.union(temp)
}
print(intersecting.count)

for index in input where index != "" {
    if intersecting.isDisjoint(with: getPoints(parseInput(index))) {
        print(index)
    }
}
