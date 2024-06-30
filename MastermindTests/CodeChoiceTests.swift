@testable import Mastermind
import XCTest

final class CodeChoiceTests: XCTestCase {
    func test_generateOneCodeChoice() throws {
        let result = try CodeChoiceGenerator.generate(from: [.red, .blue], take: 1)
        XCTAssertEqual(result, [
            CodeChoice(color: .red, codeValue: 1),
        ])
    }

    func test_generateTwoCodeChoices() throws {
        let result = try CodeChoiceGenerator.generate(from: [.red, .blue], take: 2)
        XCTAssertEqual(result, [
            CodeChoice(color: .red, codeValue: 1),
            CodeChoice(color: .blue, codeValue: 2),
        ])
    }

    func test_notEnoughColorsIsAnError() throws {
        XCTAssertThrowsError(
            try CodeChoiceGenerator.generate(from: [.red, .blue], take: 3)
        )
    }
}
