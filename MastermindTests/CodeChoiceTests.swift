@testable import Mastermind
import XCTest

final class CodeChoiceTests: XCTestCase {
    func test_generateOneCodeChoiceFromOneColor() throws {
        let result = try CodeChoiceGenerator.generate(from: [.red], take: 1)
        XCTAssertEqual(result, [CodeChoice(color: .red, codeValue: 1)])
    }
}
