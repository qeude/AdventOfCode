//: [Previous](@previous)

import Foundation

let input = """
5,1,4,1,5,1,1,5,4,4,4,4,5,1,2,2,1,3,4,1,1,5,1,5,2,2,2,2,1,4,2,4,3,3,3,3,1,1,1,4,3,4,3,1,2,1,5,1,1,4,3,3,1,5,3,4,1,1,3,5,2,4,1,5,3,3,5,4,2,2,3,2,1,1,4,1,2,4,4,2,1,4,3,3,4,4,5,3,4,5,1,1,3,2,5,1,5,1,1,5,2,1,1,4,3,2,5,2,1,1,4,1,5,5,3,4,1,5,4,5,3,1,1,1,4,5,3,1,1,1,5,3,3,5,1,4,1,1,3,2,4,1,3,1,4,5,5,1,4,4,4,2,2,5,5,5,5,5,1,2,3,1,1,2,2,2,2,4,4,1,5,4,5,2,1,2,5,4,4,3,2,1,5,1,4,5,1,4,3,4,1,3,1,5,5,3,1,1,5,1,1,1,2,1,2,2,1,4,3,2,4,4,4,3,1,1,1,5,5,5,3,2,5,2,1,1,5,4,1,2,1,1,1,1,1,2,1,1,4,2,1,3,4,2,3,1,2,2,3,3,4,3,5,4,1,3,1,1,1,2,5,2,4,5,2,3,3,2,1,2,1,1,2,5,3,1,5,2,2,5,1,3,3,2,5,1,3,1,1,3,1,1,2,2,2,3,1,1,4,2
"""

let fishes: [Int] = input
  .split(separator: ",")
  .map { Int($0)! }

var childrenForDay: [Int: Int] = [:]

func children(age: Int, in days: Int) -> Int {
  guard days > age else { return 1 }
  guard age == 0 else {
    return children(age: 0, in: days - age)
  }

  if let existing = childrenForDay[days] { return existing }
  let count = children(age: 7, in: days) + children(age: 9, in: days)
  childrenForDay[days] = count
  return count
}

func partOne() -> Int {
  fishes
    .map { children(age: $0, in: 80) }
    .reduce(0, +)
}

func partTwo() -> Int {
  fishes
    .map { children(age: $0, in: 256) }
    .reduce(0, +)
}

print(partOne())
print(partTwo())
//: [Next](@next)
