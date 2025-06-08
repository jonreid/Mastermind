@testable import Mastermind
import ViewInspector
import XCTest

@MainActor
final class RoundViewTests: XCTestCase, Sendable {
    func test_showsRoundNumber() throws {
        let round = 1
        let game = try Game(numberOfCodeChoices: 4, secretSize: 4, SecretMaker.createNull())
        game.makeNewSecret()
        let feedbackPegs = game.initialFeedbackPegs()

        let sut = RoundView(round: round, game: game, feedbackPegs: feedbackPegs)

        let roundNumberView = try sut.inspect().round()
        XCTAssertEqual(try roundNumberView.string(), "1")
    }
}

private extension InspectableView {
    func round() throws -> InspectableView<ViewType.Text> {
        try find(viewWithAccessibilityIdentifier: "roundNumber").text()
    }
}
