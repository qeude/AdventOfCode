//
//  Day02.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

enum Shape: Int {
  case rock = 1
  case paper = 2
  case scissors = 3

  static func fromPart1(rawValue: String) -> Shape {
    switch rawValue {
    case "A", "X": return .rock
    case "B", "Y": return .paper
    case "C", "Z": return .scissors
    default: fatalError()
    }
  }

  static func fromPart2(rawValue: String) -> Shape {
    switch rawValue {
    case "A": return .rock
    case "B": return .paper
    case "C": return .scissors
    default: fatalError()
    }
  }
  var winsTo: Shape {
    Shape(rawValue: rawValue == 1 ? 3 : rawValue - 1)!
  }

  var losesTo: Shape {
    Shape(rawValue: rawValue == 3 ? 1 : rawValue + 1)!
  }
}

struct Game {
  enum Variant {
    case players(opponent: Shape, me: Shape)
    case neededOutcome(opponent: Shape, neededOutcome: Outcome)
  }
  enum Outcome: Int {
    case lose = 0
    case draw = 3
    case win = 6

    static func from(rawValue: String) -> Outcome {
      switch rawValue {
      case "X": return .lose
      case "Y": return .draw
      case "Z": return .win
      default: fatalError()
      }
    }
  }

  let variant: Variant


  private var outcome: Outcome {
    switch variant {
    case .players(let opponent, let me):
      if opponent == me { return .draw }
      if me.winsTo == opponent { return .win }
      return .lose
    case .neededOutcome(_, let neededOutcome):
      return neededOutcome
    }

  }

  private var me: Shape {
    switch variant {
    case .players(_, let me):
      return me
    case .neededOutcome(let opponent, let neededOutcome):
      switch neededOutcome {
      case .draw: return opponent
      case .win: return opponent.losesTo
      case .lose: return opponent.winsTo
      }
    }
  }

  var score: Int {
    me.rawValue + outcome.rawValue
  }
}


@main
struct Day02: Day {
  typealias Input = String
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day02 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .components(separatedBy: .newlines)
      .compactMap { line in
        let letters = line.components(separatedBy: .whitespaces)
        return Game(variant: .players(opponent: Shape.fromPart1(rawValue: letters[0]), me: Shape.fromPart1(rawValue: letters[1])))
      }
      .compactMap { $0.score }
      .reduce(0, +)
  }
}

// MARK: - Part 2
extension Day02 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input
      .components(separatedBy: .newlines)
      .compactMap { line in
        let letters = line.components(separatedBy: .whitespaces)
        return Game(variant: .neededOutcome(opponent: Shape.fromPart2(rawValue: letters[0]), neededOutcome: Game.Outcome.from(rawValue: letters[1])))
      }
      .compactMap { $0.score }
      .reduce(0, +)
  }
}
