@testable import Mastermind
import XCTest

final class GuessTests: XCTestCase {
    func test_createGuess_setsGuessSize() throws {
        let sut = Guess(secretSize: 2)

        XCTAssertEqual(sut.code, [nil, nil])
    }
}
