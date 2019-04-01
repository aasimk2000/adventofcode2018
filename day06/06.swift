import Foundation
let path = "input"

guard let input: String = try? String(contentsOfFile: path) else {
    print("Input file not found")
    exit(1)
}

struct Point {
    let x: Int
    let y: Int
}

extension Point {
    func manhattanDistance(from other: Point) -> Int {
        let xDistance = abs(x - other.x)
        let yDistance = abs(y - other.y)
        return xDistance + yDistance
    }
}

let points = input.components(separatedBy: .newlines).map {line -> Point in
    let numbers = line.components(separatedBy: ", ")
    let x = Int(numbers[0])
    let y = Int(numbers[1])
    return Point(x: x!, y: y!)
}

guard let maxY = points.max(by: { $0.y < $1.y })?.y else { exit(-1) }
guard let maxX = points.max(by: { $0.x < $1.x })?.x else { exit(-1) }
var thisArray = Array(repeating: 0, count: points.count)
var infiniteSet = Set<Int>()
let maxSum = 10000
var regions = 0

for y in (0..<maxY) {
    for x in (0..<maxX) {
        let thisPoint = Point(x: x, y: y)
        let distanceMap: [(index: Int, distance: Int)] = points.enumerated().map {
            ($0, $1.manhattanDistance(from: thisPoint))
        }
        let totalDistance = distanceMap.reduce((-1, 0), { (lhs: (Int, Int), rhs: (Int, Int)) -> (Int, Int) in
            return (-1, lhs.1+rhs.1)
        })
        if totalDistance.1 < maxSum {
            regions += 1
        }
        let closest = distanceMap.min { $0.distance < $1.distance }
        let hasOthers = distanceMap.lazy.filter { $0.distance == closest?.distance }.count > 1
        if hasOthers {
            continue
        }
        if let index = closest?.index {
            thisArray[index] += 1
            if thisPoint.x == 0 || thisPoint.y == 0 || thisPoint.x == maxX || thisPoint.y == maxY {
                infiniteSet.insert(index)
            }
        }
    }
}

let max = thisArray.enumerated().filter { !infiniteSet.contains($0.offset) }.max { $0.element < $1.element }

if let maxArea = max?.element {
    print("Part A: \(maxArea)")
}
print("Part B: \(regions)")
