@testable import Mastermind
import XCTest

final class SecretTests: XCTestCase {
    func test_secretMatchesGuess() throws {
        let red = CodeChoice(color: .red, codeValue: 1)
        let green = CodeChoice(color: .green, codeValue: 2)
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 2)
        guess[0] = red
        guess[1] = green
        XCTAssertTrue(secret.matches(guess))
    }

    func test_secretDoesNotMatchGuess() throws {
        let red = CodeChoice(color: .red, codeValue: 1)
        let green = CodeChoice(color: .green, codeValue: 2)
        let blue = CodeChoice(color: .blue, codeValue: 3)
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 2)
        guess[0] = red
        guess[1] = blue
        XCTAssertFalse(secret.matches(guess))
    }
}
