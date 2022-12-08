//
//  Day07.swift
//
//  Created by Quentin Eude on 12/8/22.
//

import Common
import Core
import Foundation

enum Line {
  case cd(param: String)
  case ls
  case file(name: String, size: Int)
  case dir(name: String)

  init(_ str: String) {
    let parts = str.components(separatedBy: " ")
    switch (parts[0], parts[1]) {
    case ("$", "cd"): self = .cd(param: parts[2])
    case ("$", "ls"): self = .ls
    case ("dir", let name): self = .dir(name: name)
    case (let size, let name) where size.isNumber : self = .file(name: name, size: Int(size)!)
    default: fatalError()
    }
  }
}

protocol FilesystemElement {
  var name: String { get set }
  var size: Int { get }
  func humanReadable(iteration: Int) -> String
}


extension [FilesystemElement] {
  var size: Int {
    self.reduce(0) { lastResult, element in
      return lastResult + element.size
    }
  }
}

class Directory: FilesystemElement, Parsable {
  static func parse(raw: String) throws -> Self {
    let lines = raw
      .components(separatedBy: .newlines)
      .map { Line($0) }

    var currentDirectory = Directory.root
    for line in lines {
      switch line {
      case .ls:
        continue
      case .dir(let name):
        if currentDirectory.children.contains(where: { $0 is Directory && $0.name == name }) == false {
          currentDirectory.children.append(Directory(name: name, parent: currentDirectory))
        }
      case .file(let name, let size):
        if currentDirectory.children.contains(where: { $0 is File && $0.name == name }) == false {
          currentDirectory.children.append(File(name: name, size: size))
        }
      case .cd(let param):
        switch param {
        case "..":
          currentDirectory = currentDirectory.parent!
        case "/":
          currentDirectory = .root
        default:
          if let directory = currentDirectory.children.first(where: { $0 is Directory && $0.name == param }) as? Directory {
            currentDirectory = directory
          }
        }
      }
    }
    return Directory.root as! Self
  }

  weak var parent: Directory?
  var name: String
  var children: [any FilesystemElement]

  static var root: Directory = Directory(name: "/")

  var size: Int {
    children.size
  }

  func filter(where condition: (any FilesystemElement) -> Bool) -> [Directory] {
    var result: [Directory] = []
    if condition(self) == true {
      result.append(self)
    }
    for child in self.children.compactMap({ $0 as? Directory }) {
      result = result + child.filter(where: condition)
    }
    return result
  }

  func humanReadable(iteration: Int = 1) -> String {
    let childrenStrings = self
      .children
      .compactMap {
        let spaces = Array(repeating: " ", count: iteration * 2).joined()
        return "\(spaces)\($0.humanReadable(iteration: iteration + 1))"
      }
      .joined(separator: "\n")
    let children = childrenStrings.isEmpty ? "" : "\n\(childrenStrings)"
    return "📁 \(self.name) (size=\(self.size))\(children)"
  }

  init(name: String, parent: Directory? = nil) {
    self.name = name
    self.parent = parent
    self.children = []
  }
}

struct File: FilesystemElement {
  var name: String
  var size: Int

  func humanReadable(iteration: Int = 1) -> String {
    "📄 \(self.name) (file, size=\(self.size))"
  }
}

@main
struct Day07: Day {
  typealias Input = Directory
  typealias OutputPartOne = Int
  typealias OutputPartTwo = Int

  static let totalDiskSpace = 70_000_000
  static let updateSize = 30_000_000
}

// MARK: - Part 1
extension Day07 {
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne {
    input
      .filter { $0.size < 100_000 }
      .map { $0.size }
      .reduce(0, +)
  }
}

// MARK: - Part 2
extension Day07 {
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo {
    let neededSpace = updateSize - (totalDiskSpace - input.size)
    return input
      .filter(where: { $0.size > neededSpace} )
      .compactMap { $0.size }
      .sorted()
      .first!
  }
}
