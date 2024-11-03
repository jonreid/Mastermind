@testable import Mastermind
import XCTest

final class GameTests: XCTestCase {
    func test_isObservable_soThatViewsCanObserveChanges() throws {
        let game = try Game(numberOfCodeChoices: 2, secretSize: 2, SecretMaker.createNull())

        XCTAssertTrue(game is (any Observable))
    }

    func test_gameHasNoSecretInitially() throws {
        let game = try Game(numberOfCodeChoices: 2, secretSize: 2, SecretMaker.createNull())

        XCTAssertEqual(game.secret.code, [])
    }

    func test_makeNewSecret() throws {
        let game = try Game(numberOfCodeChoices: 2, secretSize: 1, SecretMaker.createNull())

        game.makeNewSecret()

        XCTAssertEqual(game.secret.code.first, game.codeChoices.options.first)
    }
}
