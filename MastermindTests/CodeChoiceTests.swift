@testable import Mastermind
import XCTest

final class CodeChoiceTests: XCTestCase {
    func test_generateOneCodeChoice() throws {
        let result = try CodeChoiceGenerator.generate(from: [.red, .blue], take: 1)
        XCTAssertEqual(result, [CodeChoice(color: .red, codeValue: 1)])
    }
}
