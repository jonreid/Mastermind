@testable import Mastermind
import XCTest

final class GameTests: XCTestCase {
    func test_isObservable_soThatViewsCanObserveChanges() throws {
        let sut = try makeSUT()

        XCTAssertTrue(sut is (any Observable))
    }

    func test_gameHasNoSecretInitially() throws {
        let sut = try makeSUT()

        XCTAssertEqual(sut.secret.code, [])
    }

    func test_makeNewSecret() throws {
        let sut = try makeSUT()

        sut.makeNewSecret()

        XCTAssertEqual(sut.secret.code.first, sut.codeChoices.options.first)
    }

    private func makeSUT() throws -> Game {
        try Game(numberOfCodeChoices: 2, secretSize: 2, SecretMaker.createNull())
    }
}
