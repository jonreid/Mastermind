@testable import Mastermind
import XCTest

final class GuessTests: XCTestCase {
    func test_createGuess_setsGuessSize() throws {
        let sut = Guess(secretSize: 2)

        XCTAssertEqual(sut.code, [nil, nil])
    }

    func test_setAndGetAtIndices() throws {
        let sut = Guess(secretSize: 2)
        let choice0 = CodeChoice(color: .red, codeValue: 1)
        let choice1 = CodeChoice(color: .green, codeValue: 2)

        sut[0] = choice0
        sut[1] = choice1

        XCTAssertEqual(sut.code, [choice0, choice1])
        XCTAssertEqual(sut[0], choice0)
        XCTAssertEqual(sut[1], choice1)
    }
}
