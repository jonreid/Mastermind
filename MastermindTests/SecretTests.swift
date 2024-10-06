@testable import Mastermind
import XCTest

final class SecretTests: XCTestCase {
    func test_secretMatchesGuess() throws {
        let secret = Secret(code: [CodeChoice(color: .red, codeValue: 1), CodeChoice(color: .green, codeValue: 2)])
        let guess = Guess(secretSize: 2)
        guess[0] = CodeChoice(color: .red, codeValue: 1)
        guess[1] = CodeChoice(color: .green, codeValue: 2)
        XCTAssertTrue(secret.matches(guess))
    }
}
