@testable import Mastermind
import XCTest

final class CodeChoiceTests: XCTestCase {
    func test_generateOneCodeChoice() throws {
        let result = try CodeChoiceGenerator.generate(from: [.red, .blue], take: 1)
        let extractedExpr = [
            CodeChoice(color: .red, codeValue: 1),
        ]
        XCTAssertEqual(result, CodeChoices(options: extractedExpr))
    }

    func test_generateTwoCodeChoices() throws {
        let result = try CodeChoiceGenerator.generate(from: [.red, .blue], take: 2)
        let extractedExpr = [
            CodeChoice(color: .red, codeValue: 1),
            CodeChoice(color: .blue, codeValue: 2),
        ]
        XCTAssertEqual(result, CodeChoices(options: extractedExpr))
    }

    func test_notEnoughColorsIsAnError() throws {
        XCTAssertThrowsError(
            try CodeChoiceGenerator.generate(from: [.red, .blue], take: 3)
        )
    }

}
