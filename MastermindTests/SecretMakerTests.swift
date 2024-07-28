@testable import Mastermind
import XCTest

final class SecretMakerTests: XCTestCase {
    func test_nullable() throws {
        let sut = SecretMaker.createNull()
        let codeChoices = [CodeChoice(color: .black, codeValue: 1), CodeChoice(color: .blue, codeValue: 2)]

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result, codeChoices)
    }
}
