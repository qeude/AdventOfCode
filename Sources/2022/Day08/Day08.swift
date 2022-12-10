//
//  Day08.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

struct Forest {
  enum Axis {
    case horizontal
    case vertical
  }
  struct Tree {
    struct Position: Equatable{
      let x: Int
      let y: Int
    }
    let position: Position
    let height: Int

    func isVisible(in forest: Forest) -> Bool {
      return position.x == 0 || position.y == 0 ||
      position.x == forest.maxX || position.y == forest.maxY ||
      forest.maxHeightBefore(tree: self, axis: .horizontal) < self.height || forest.maxHeightBefore(tree: self, axis: .vertical) < self.height ||
      forest.maxHeightAfter(tree: self, axis: .horizontal) < self.height || forest.maxHeightAfter(tree: self, axis: .vertical) < self.height
    }

    private func visionScore(for trees: [Tree]) -> Int {
      var visionScore = 0
      for tree in trees {
        visionScore += 1
        if tree.height >= self.height {
          return visionScore
        }
      }
      return visionScore
    }


    func visionScore(in forest: Forest) -> Int {
      if position.x == 0 || position.y == 0 ||
          position.x == forest.maxX || position.y == forest.maxY {
        return 0
      }
      return visionScore(for: forest.treesBefore(tree: self, axis: .horizontal)) *
      visionScore(for: forest.treesBefore(tree: self, axis: .vertical)) *
      visionScore(for: forest.treesAfter(tree: self, axis: .horizontal)) *
      visionScore(for: forest.treesAfter(tree: self, axis: .vertical))
    }
  }

  let trees: [Tree]

  func tree(at position: Forest.Tree.Position) -> Tree? {
    trees.first(where: { $0.position == position })
  }

  var maxX: Int {
    trees
      .map { $0.position.x }
      .max() ?? 0
  }

  var maxY: Int {
    trees
      .map { $0.position.y }
      .max() ?? 0
  }

  func treesBefore(tree: Tree, axis: Axis) -> [Tree] {
    return axis == .horizontal ?
    (0..<tree.position.x)
      .reversed()
      .compactMap { self.tree(at: .init(x: $0, y: tree.position.y))} :
    (0..<tree.position.y)
      .reversed()
      .compactMap { self.tree(at: .init(x: tree.position.x, y: $0))}
  }

  func treesAfter(tree: Tree, axis: Axis) -> [Tree] {
    return axis == .horizontal ?
    (tree.position.x + 1 ... maxX)
      .compactMap { self.tree(at: .init(x: $0, y: tree.position.y))} :
    (tree.position.y + 1 ... maxY)
      .compactMap { self.tree(at: .init(x: tree.position.x, y: $0))}
  }

  func maxHeightBefore(tree: Tree, axis: Axis) -> Int {
    trees
      .filter {
        axis == .horizontal ?
        $0.position.y == tree.position.y && $0.position.x < tree.position.x :
        $0.position.x == tree.position.x && $0.position.y < tree.position.y
      }
      .map { $0.height }
      .max() ?? 0
  }

  func maxHeightAfter(tree: Tree, axis: Axis) -> Int {
    trees
      .filter {
        axis == .horizontal ?
        $0.position.y == tree.position.y && $0.position.x > tree.position.x :
        $0.position.x == tree.position.x && $0.position.y > tree.position.y
      }
      .map { $0.height }
      .max() ?? 0
  }
}


@main
struct Day08: Day {
  static func transform(raw: String) async throws -> Forest {
    let trees = raw
      .split(separator: "\n")
      .enumerated()
      .map { (index, row) in
        row
          .split(separator: "")
          .enumerated()
          .map { Forest.Tree(position: .init(x: $0.0 , y: index), height: Int($0.1)!) }
      }
      .reduce([], +)
    return Forest(trees: trees)
  }

  typealias Input = Forest
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int
}

// MARK: - Part 1
extension Day08 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .trees
      .filter { $0.isVisible(in: input)}
      .count
  }
}

// MARK: - Part 2
extension Day08 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    input
      .trees
      .compactMap { $0.visionScore(in: input) }
      .max()!
  }
}
