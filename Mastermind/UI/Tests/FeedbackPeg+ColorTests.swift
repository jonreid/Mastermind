@testable import Mastermind
import SwiftUI
import Testing

final class FeedbackPeg_ColorTests: @unchecked Sendable {
    @Test
    func colorAroundPegToShowThatPegIsFilled_forEmptyPeg() async throws {
        let sut = FeedbackPeg.empty
        let color = sut.colorAroundPegToShowThatPegIsFilled()
        #expect(color == Color.clear)
    }

    @Test(arguments: [FeedbackPeg.correct, FeedbackPeg.misplaced])
    func colorAroundPegToShowThatPegIsFilled_forFilledPeg(sut: FeedbackPeg) async throws {
        let color = sut.colorAroundPegToShowThatPegIsFilled()
        #expect(color == sut.feedbackColor())
    }
}
