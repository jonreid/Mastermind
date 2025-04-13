@testable import Mastermind
import SwiftUI
import Testing

final class FeedbackPeg_ColorTests: @unchecked Sendable {
    @Test
    func overlayColorDependingOnWhetherThePegIsFilledOrNot_empty() async throws {
        let sut = FeedbackPeg.empty
        let color = sut.colorAroundPegToShowThatPegIsFilled()
        #expect(color == Color.clear)
    }

    @Test
    func overlayColorDependingOnWhetherThePegIsFilledOrNot_correct() async throws {
        let sut = FeedbackPeg.correct
        let color = sut.colorAroundPegToShowThatPegIsFilled()
        #expect(color == Color.Pegs.correct)
    }
}
