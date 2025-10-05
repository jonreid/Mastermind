@testable import Mastermind
import ViewInspector
import XCTest

@MainActor
final class RoundViewTests: XCTestCase, Sendable {
    func test_showsRoundNumber1() throws {
        let sut = try makeSUT(round: 1)

        let roundNumberView = try sut.inspect().round()
        XCTAssertEqual(try roundNumberView.string(), "1")
    }

    func test_showsRoundNumber2() throws {
        let sut = try makeSUT(round: 2)

        let roundNumberView = try sut.inspect().round()
        XCTAssertEqual(try roundNumberView.string(), "2")
    }

    private func makeSUT(round: Int) throws -> RoundView {
        let game = try Game(numberOfCodeChoices: 4, secretSize: 4, numberOfRounds: 2, SecretMaker.createNull())
        game.makeNewSecret()
        return RoundView(game: game, roundNumber: RoundNumber(value: round))
    }
}

private extension InspectableView {
    func round(file: StaticString = #filePath, line: UInt = #line) throws -> InspectableView<ViewType.Text> {
        try findView(accessibilityIdentifier: "roundNumber", file: file, line: line).text()
    }
}
