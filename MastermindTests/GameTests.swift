@testable import Mastermind
import XCTest

final class GameTests: XCTestCase {
    func test_gameHasNoSecretInitially() throws {
        let game = try Game(numberOfCodeChoices: 2, SecretMaker.createNull())

        XCTAssertEqual(game.secret, [])
    }

    func test_makeNewSecret() throws {
        try XCTSkipIf(true, "Disabled")
        let game = try Game(numberOfCodeChoices: 2, SecretMaker.createNull())

        game.makeNewSecret()

        XCTAssertEqual(game.secret, game.codeChoices)
    }
}
