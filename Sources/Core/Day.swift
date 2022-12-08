import Foundation

public protocol Day<Input, OutputPartOne, OutputPartTwo> {
  associatedtype Input
  associatedtype OutputPartOne
  associatedtype OutputPartTwo
  
  /// Should provide raw input for the given day
  /// A default implementation are provided for when the file input.txt exists
  static func rawInput() async throws -> String
  
  /// Should transform the raw string input into the required Input
  static func transform(raw: String) async throws -> Input
  
  /// The separator to use for the component separation
  static var componentsSeparator: InputSeparator { get }

  /// Should solve the first part of the day
  static func solvePartOne(_ input: Input) async throws -> OutputPartOne
  
  /// Should solve the second part of the day
  static func solvePartTwo(_ input: Input) async throws -> OutputPartTwo
}
