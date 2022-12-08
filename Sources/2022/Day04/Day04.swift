//
//  Day04.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

struct Pair: Parsable {
  static func parse(raw: String) throws -> Pair {
    let numbers = raw.split(whereSeparator: { $0.isNumber == false })
      .compactMap { Int($0)! }
    return Pair(firstElf: numbers[0]...numbers[1], secondElf: numbers[2]...numbers[3])
  }

  let firstElf: ClosedRange<Int>
  let secondElf: ClosedRange<Int>

}

@main
struct Day04: Day {
  typealias Input = [Pair]
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day04 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .filter { $0.firstElf.contains($0.secondElf) || $0.secondElf.contains($0.firstElf)}
      .count
  }
}

// MARK: - Part 2
extension Day04 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input
      .filter { $0.firstElf.overlaps($0.secondElf) }
      .count
  }
}
