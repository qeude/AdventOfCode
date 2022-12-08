import Foundation

public enum ExecutionError: Error, CustomStringConvertible {
  case notSolved
  case unsolvable

  public var description: String {
    switch self {
    case .unsolvable:
      return "Day couldn‘t find a solution"
    case .notSolved:
      return "Day implementation is not yet provided"
    }
  }
}

extension Day {
  public static func main() async {
    let start: DispatchTime
    let input: Input
    print("📅 \(self.self)")
    printSeparator()
    do {
      // Input resolution
      let rawInput = try await rawInput()

      // Transformation should be included in the computing time ^^
      start = .now()
      input = try await transform(raw: rawInput)
    } catch {
      print("Input parsing failed: \(error)")
      exit(1)
    }

    do {
      let part1 = try await solvePartOne(input)
      print("Part 1 ✅")
      print(part1)
    } catch {
      print("Part 1 ❌\n\(error)")
    }

    printSeparator()

    do {
      // Part 2
      let part2 = try await solvePartTwo(input)
      print("Part 2 ✅")
      print(part2)
    } catch {
      print("Part 2 ❌\n\(error)")
    }

    printSeparator()
    printElapsedTime(from: start)
  }

  static func printElapsedTime(from start: DispatchTime) {
    let elapsed = Double(DispatchTime.now().uptimeNanoseconds - start.uptimeNanoseconds) / 1_000_000_000
    let formatter = NumberFormatter()
    formatter.minimumIntegerDigits = 1
    formatter.minimumFractionDigits = 4
    formatter.maximumFractionDigits = 4
    print("⏲️ Took \(formatter.string(from: NSNumber(value: elapsed))!)s")
  }

  static func printSeparator() {
    print("\n––––––––––\n")
  }
}
