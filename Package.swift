// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let currentYear = 2022

let package = Package(
    name: "AdventOfCode",
    platforms: [.macOS(.v13)],
    products: [
      .library(name: "Core", targets: ["Core"]),
      .library(name: "Common", targets: ["Common"]),
      .executable(name: "Day01", targets: ["Day01"]),
      .executable(name: "Day02", targets: ["Day02"]),
      .executable(name: "Day03", targets: ["Day03"]),
      .executable(name: "Day04", targets: ["Day04"]),
      .executable(name: "Day05", targets: ["Day05"]),
      .executable(name: "Day06", targets: ["Day06"]),
      .executable(name: "Day07", targets: ["Day07"]),
      .executable(name: "Day08", targets: ["Day08"]),
      .executable(name: "Day09", targets: ["Day09"]),
      .executable(name: "Day10", targets: ["Day10"]),
      .executable(name: "Day11", targets: ["Day11"]),
      .executable(name: "Day12", targets: ["Day12"]),
      .executable(name: "Day13", targets: ["Day13"]),
      .executable(name: "Day14", targets: ["Day14"]),
      .executable(name: "Day15", targets: ["Day15"]),
      .executable(name: "Day16", targets: ["Day16"]),
      .executable(name: "Day17", targets: ["Day17"]),
      .executable(name: "Day18", targets: ["Day18"]),
      .executable(name: "Day19", targets: ["Day19"]),
      .executable(name: "Day20", targets: ["Day20"]),
      .executable(name: "Day21", targets: ["Day21"]),
      .executable(name: "Day22", targets: ["Day22"]),
      .executable(name: "Day23", targets: ["Day23"]),
      .executable(name: "Day24", targets: ["Day24"]),
      .executable(name: "Day25", targets: ["Day25"]),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.0"),
      .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
      .package(url: "https://github.com/apple/swift-collections", from: "1.0.0"),
      .package(url: "https://github.com/apple/swift-crypto.git", from: "2.0.0"),
    ],
    targets: [
      .target(name: "Core"),
      .target(name: "Common", dependencies: [
        .product(name: "Algorithms", package: "swift-algorithms"),
        .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
        .product(name: "Collections", package: "swift-collections"),
        .product(name: "Crypto", package: "swift-crypto"),
      ]),


      .executableTarget(name: "Day01", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day01", resources: [.process("input.txt")]),
      .executableTarget(name: "Day02", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day02", resources: [.process("input.txt")]),
      .executableTarget(name: "Day03", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day03", resources: [.process("input.txt")]),
      .executableTarget(name: "Day04", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day04", resources: [.process("input.txt")]),
      .executableTarget(name: "Day05", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day05", resources: [.process("input.txt")]),
      .executableTarget(name: "Day06", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day06", resources: [.process("input.txt")]),
      .executableTarget(name: "Day07", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day07", resources: [.process("input.txt")]),
      .executableTarget(name: "Day08", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day08", resources: [.process("input.txt")]),
      .executableTarget(name: "Day09", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day09", resources: [.process("input.txt")]),
      .executableTarget(name: "Day10", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day10", resources: [.process("input.txt")]),
      .executableTarget(name: "Day11", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day11", resources: [.process("input.txt")]),
      .executableTarget(name: "Day12", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day12", resources: [.process("input.txt")]),
      .executableTarget(name: "Day13", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day13", resources: [.process("input.txt")]),
      .executableTarget(name: "Day14", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day14", resources: [.process("input.txt")]),
      .executableTarget(name: "Day15", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day15", resources: [.process("input.txt")]),
      .executableTarget(name: "Day16", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day16", resources: [.process("input.txt")]),
      .executableTarget(name: "Day17", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day17", resources: [.process("input.txt")]),
      .executableTarget(name: "Day18", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day18", resources: [.process("input.txt")]),
      .executableTarget(name: "Day19", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day19", resources: [.process("input.txt")]),
      .executableTarget(name: "Day20", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day20", resources: [.process("input.txt")]),
      .executableTarget(name: "Day21", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day21", resources: [.process("input.txt")]),
      .executableTarget(name: "Day22", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day22", resources: [.process("input.txt")]),
      .executableTarget(name: "Day23", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day23", resources: [.process("input.txt")]),
      .executableTarget(name: "Day24", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day24", resources: [.process("input.txt")]),
      .executableTarget(name: "Day25", dependencies: ["Core", "Common"], path: "Sources/\(currentYear)/Day25", resources: [.process("input.txt")]),
    ]
)
