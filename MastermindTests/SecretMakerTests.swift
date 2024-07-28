@testable import Mastermind
import XCTest

final class SecretMakerTests: XCTestCase {
    func test_nullable() throws {
        let sut = SecretMaker.createNull()
        let codeChoices = [CodeChoice(color: .black, codeValue: 1), CodeChoice(color: .blue, codeValue: 2)]

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result, codeChoices)
    }

    func test_notNull() throws {
        let sut = SecretMaker()
        let codeChoices = [CodeChoice(color: .black, codeValue: 1), CodeChoice(color: .blue, codeValue: 2)]

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result.count, codeChoices.count)
        XCTAssertTrue(result.contains(codeChoices[0]))
        XCTAssertTrue(result.contains(codeChoices[1]))
    }

    // Test that non-null SecretMaker returns array that is sometimes not equal to codeChoices
}
