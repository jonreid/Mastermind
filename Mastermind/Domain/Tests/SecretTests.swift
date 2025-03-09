@testable import Mastermind
import XCTest

final class SecretTests: XCTestCase {
    private let red = CodeChoice(color: .red, codeValue: 1)
    private let green = CodeChoice(color: .green, codeValue: 2)
    private let blue = CodeChoice(color: .blue, codeValue: 3)

    func test_secretMatchesGuess() throws {
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 2)
        guess.placeChoiceInNextSlot(red)
        guess.placeChoiceInNextSlot(green)

        XCTAssertTrue(secret.matches(guess))
    }

    func test_secretDoesNotMatchGuess() throws {
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 2)
        guess.placeChoiceInNextSlot(red)
        guess.placeChoiceInNextSlot(blue)

        XCTAssertFalse(secret.matches(guess))
    }

    func test_secretDoesNotMatchGuessOfDifferentSize() throws {
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 4)
        guess.placeChoiceInNextSlot(red)

        XCTAssertFalse(secret.matches(guess))
    }

    func test_describesSecret() throws {
        let secret = Secret(code: [red, green])

        XCTAssertEqual(secret.description, "red, green")
    }
}
