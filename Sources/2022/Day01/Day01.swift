//
//  Day01.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

struct Backpack: Parsable {
  let snacks: [Int]

  var calories: Int {
    snacks.reduce(0, +)
  }

  static func parse(raw: String) throws -> Backpack {
    let snacks = raw
      .components(separatedBy: .newlines)
      .compactMap { Int($0)! }
    return Backpack(snacks: snacks)
  }
}

@main
struct Day01: Day {
  typealias Input = [Backpack]
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day01 {
  static var componentsSeparator: InputSeparator {
    .string(string: "\n\n")
  }

  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .compactMap { $0.calories }
      .max()!
  }
}

// MARK: - Part 2
extension Day01 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input
      .compactMap { $0.calories }
      .sorted(by: >)
      .prefix(3)
      .reduce(0, +)
  }
}
