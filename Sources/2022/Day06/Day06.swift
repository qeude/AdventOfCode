//
//  Day06.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Algorithms
import Common
import Core
import Foundation

extension String {
  func firstMarkerIndex(with size: Int) -> Int? {
    guard let index = self.windows(ofCount: size).compactMap({ Set($0) }).firstIndex(where: { $0.count == size }) else { return nil }
    return index + size
  }
}

@main
struct Day06: Day {
  typealias Input = String
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day06 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input.firstMarkerIndex(with: 4)!
  }
}

// MARK: - Part 2
extension Day06 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input.firstMarkerIndex(with: 14)!
  }
}
