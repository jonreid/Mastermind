@testable import Mastermind
import XCTest

final class SecretMakerTests: XCTestCase {
    private var codeChoices: [CodeChoice] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        codeChoices = try CodeChoiceGenerator.generate(from: codeColors, take: 8)
    }

    func test_nullable() throws {
        let sut = SecretMaker.createNull()

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result, codeChoices)
    }

    func test_notNull() throws {
        let sut = SecretMaker()

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result.count, codeChoices.count)
        XCTAssertTrue(result.contains(codeChoices[0]))
        XCTAssertTrue(result.contains(codeChoices[1]))
    }

    // Test that non-null SecretMaker returns array that is sometimes not equal to codeChoices

}
