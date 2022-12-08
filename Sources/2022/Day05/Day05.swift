//
//  Day05.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

struct State {
  let stacks: [Int: [Character]]
  let instructions: [Instruction]
}

struct Instruction {
  let from: Int
  let to: Int
  let count: Int
}

@main
struct Day05: Day {
  typealias Input = State
  typealias OutputPartOne = String
  typealias OutputPartTwo = String

  static func transform(raw: String) async throws -> State {
    let components = raw.components(separatedBy: "\n\n")
    let inputStacks = components[0]
    let inputInstructions = components[1]
    let stacks = inputStacks
      .components(separatedBy: .newlines)
      .reduce(into: [Int: [Character]](), { stacks, line in
        line.enumerated().forEach { (index, character) in
          guard character.isLetter else { return }
          stacks[(index / 4) + 1, default: []].insert(character, at: 0)
        }
      })

    let instructions = inputInstructions
      .components(separatedBy: .newlines)
      .compactMap { line in
        let numbers = line
          .components(separatedBy: .whitespaces)
          .filter { $0.isNumber }
          .compactMap { Int($0)! }
        return Instruction(from: numbers[1], to: numbers[2], count: numbers[0])
      }

    return State(stacks: stacks, instructions: instructions)
  }
}

// MARK: - Part 1
extension Day05 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    var stacks = input.stacks
    input.instructions
      .forEach { instruction in
        for _ in 1...instruction.count {
          guard let itemToMove = stacks[instruction.from]?.popLast() else { continue }
          stacks[instruction.to]?.append(itemToMove)
        }
      }
   return stacks
      .keys
      .sorted()
      .compactMap { String(stacks[$0]!.last!) }
      .joined()
  }
}

// MARK: - Part 2
extension Day05 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    var stacks = input.stacks
    input.instructions
      .forEach { instruction in
        var itemsToMove = [Character]()
        for _ in 1...instruction.count {
          guard let itemToMove = stacks[instruction.from]?.popLast() else { continue }
          itemsToMove.insert(itemToMove, at: 0)
        }
        stacks[instruction.to]?.append(contentsOf: itemsToMove)
      }
    return stacks
      .keys
      .sorted()
      .compactMap { String(stacks[$0]!.last!) }
      .joined()
  }
}
