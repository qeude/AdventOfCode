//
//  Day09.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Algorithms
import Common
import Core
import Foundation

enum Direction: String {
  case up = "U"
  case down = "D"
  case left = "L"
  case right = "R"
}

struct Point: Hashable {
  var x: Int
  var y: Int

  static let zero = Point(x: 0, y: 0)

  func move(in direction: Direction) -> Point {
    switch direction {
    case .up: return Point(x: x, y: y - 1)
    case .down: return Point(x: x, y: y + 1)
    case .left: return Point(x: x - 1, y: y)
    case .right: return Point(x: x + 1, y: y)
    }
  }

  mutating func move(dependingOn head: Point) {
    if self.isCloseTo(point: head) { return }
    
    let xMove = x < head.x ? 1 : -1
    let yMove = y < head.y ? 1 : -1
    
    if x == head.x {
      y += yMove
    } else if y == head.y {
      x += xMove
    } else {
      x += xMove
      y += yMove
    }
  }

  func isCloseTo(point: Point) -> Bool {
    if self == point { return true }
    return abs(x - point.x) <= 1 && abs(y - point.y) <= 1
  }
}

struct Instruction: Parsable {
  let direction: Direction
  let value: Int

  static func parse(raw: String) throws -> Instruction {
    let components = raw
      .components(separatedBy: .whitespaces)
    return Instruction(direction: Direction(rawValue: components[0])!, value: Int(components[1])!)
  }
}


extension [Instruction] {
  func countVisitedByTail(ropeLength: Int) -> Int {
    var knots = Array<Point>(repeating: .zero, count: ropeLength)
    var visitedPoints: Set<Point> = [.zero]

    for instruction in self {
      for _ in 1 ... instruction.value {
        knots[0] = knots[0].move(in: instruction.direction)
        for (previousIndex, index) in knots.indices.adjacentPairs() {
          knots[index].move(dependingOn: knots[previousIndex])
        }

        visitedPoints.insert(knots.last!)
      }
    }
    return visitedPoints.count
  }
}

@main
struct Day09: Day {
  typealias Input = [Instruction]
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day09 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .countVisitedByTail(ropeLength: 2)
  }
}

// MARK: - Part 2
extension Day09 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input
      .countVisitedByTail(ropeLength: 10)
  }
}
