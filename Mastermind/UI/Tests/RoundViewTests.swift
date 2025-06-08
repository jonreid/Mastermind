@testable import Mastermind
import XCTest

@MainActor
final class RoundViewTests: XCTestCase, Sendable {
    func test_showsRoundNumber() throws {
        let game = try Game(numberOfCodeChoices: 4, secretSize: 4, SecretMaker.createNull())
        let feedbackPegs = game.initialFeedbackPegs()
        let sut = RoundView(game: game, feedbackPegs: feedbackPegs)
    }
}
