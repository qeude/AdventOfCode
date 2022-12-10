//
//  Day10.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

enum Operation: Parsable {
  static func parse(raw: String) throws -> Operation {
    let components = raw
      .components(separatedBy: .whitespaces)
    switch components[0] {
    case "addx": return .addx(value: Int(components[1])!)
    case "noop": return .noop
    default: throw ExecutionError.unsolvable
    }
  }

  case addx(value: Int)
  case noop

  var neededCycles: Int {
    switch self {
    case .addx: return 2
    case .noop: return 1
    }
  }
}

extension [Operation] {
  private var cycleCount: Int {
    self.reduce(0) { partialResult, operation in
        partialResult + operation.neededCycles
      }
  }

  var signal: Int {
    stride(from: 20, through: cycleCount, by: 40).reduce(0) { partialResult, cycle in
      partialResult + signal(at: cycle)
    }
  }

  var display: String {
    var result = ""
    for cycle in 0 ..< cycleCount {
      if cycle % 40 == 0 {
        result.append("\n")
      }
      
      let crt = cycle % 40
      if abs(x(after: cycle) - crt) <= 1 {
        result.append("⬛")
      } else {
        result.append("⬜")
      }
    }
    return result
  }

  private func x(after cycle: Int) -> Int {
    var count = 0
    return self.prefix(while: {
      count += $0.neededCycles
      return count <= cycle
    })
    .reduce(1) { partialResult, operation in
      switch operation {
      case .noop: return partialResult
      case .addx(let value): return partialResult + value
      }
    }
  }

  private func x(at cycle: Int) -> Int {
    var count = 0
    return self.prefix(while: {
      count += $0.neededCycles
      return count < cycle
    })
    .reduce(1) { partialResult, operation in
      switch operation {
      case .noop: return partialResult
      case .addx(let value): return partialResult + value
      }
    }
  }

  private func signal(at cycle: Int) -> Int {
    x(at: cycle) * cycle
  }
}

@main
struct Day10: Day {
  typealias Input = [Operation]
  typealias OutputPartOne = Int
  typealias OutputPartTwo = String
}

// MARK: - Part 1
extension Day10 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input.signal
  }
}

// MARK: - Part 2
extension Day10 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input.display
  }
}
