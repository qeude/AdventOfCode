//
//  Day03.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Algorithms
import Common
import Core
import Foundation

extension Character {
  var priority: Int {
    Int(asciiValue! - (isUppercase ? 38 : 96))
  }
}

extension String {
  func split() -> (String, String) {
    let length = self.count / 2
    return (String(self.prefix(length)), String(self.suffix(length)))
  }
}

struct Rucksack: Parsable {
  static func parse(raw: String) throws -> Rucksack {
    return Rucksack(content: raw)
  }

  let content: String

  var firstContainer: String {
    content.split().0
  }
  var secondContainer: String {
    content.split().1
  }

  init(content: String) {
    self.content = content
  }

  var priority: Int {
    Set(self.firstContainer)
      .intersection(self.secondContainer)
      .compactMap { $0.priority }
      .reduce(0, +)
  }
}

extension [Rucksack] {
  var badgePriority: Int {
    self.reduce(Set(self.first!.content)) { partialResult, rucksack in
      partialResult.intersection(rucksack.content)
    }
    .compactMap { $0.priority }
    .reduce(0, +)
  }
}

@main
struct Day03: Day {
  typealias Input = [Rucksack]
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day03 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .compactMap { $0.priority }
      .reduce(0, +)
  }
}

// MARK: - Part 2
extension Day03 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input
      .chunks(ofCount: 3)
      .compactMap { Array($0).badgePriority }
      .reduce(0, +)
  }
}
