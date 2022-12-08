import Foundation

extension String {
  public var isNumber: Bool {
    self.range(of: "^[0-9]*$", options: .regularExpression) != nil
  }
}
