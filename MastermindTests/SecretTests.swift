@testable import Mastermind
import XCTest

final class SecretTests: XCTestCase {
    private var red: CodeChoice!
    private var green: CodeChoice!
    private var blue: CodeChoice!

    override func setUpWithError() throws {
        try super.setUpWithError()
        red = CodeChoice(color: .red, codeValue: 1)
        green = CodeChoice(color: .green, codeValue: 2)
        blue = CodeChoice(color: .blue, codeValue: 3)
    }

    override func tearDownWithError() throws {
        red = nil
        green = nil
        blue = nil
        try super.tearDownWithError()
    }

    func test_secretMatchesGuess() throws {
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 2)
        guess[0] = red
        guess[1] = green

        XCTAssertTrue(secret.matches(guess))
    }

    func test_secretDoesNotMatchGuess() throws {
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 2)
        guess[0] = red
        guess[1] = blue

        XCTAssertFalse(secret.matches(guess))
    }

    func test_secretDoesNotMatchGuessOfDifferentSize() throws {
        let secret = Secret(code: [red, green])
        let guess = Guess(secretSize: 1)
        guess[0] = red

        XCTAssertFalse(secret.matches(guess))
    }
}
