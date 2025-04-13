@testable import Mastermind
import SwiftUI
import Testing

final class FeedbackPeg_ColorTests: @unchecked Sendable {
    @Test
    func overlayColorDependingOnWhetherThePegIsFilledOrNot_empty() async throws {
        let sut = FeedbackPeg.empty
        let color = sut.overlayColorDependingOnWhetherThePegIsFilledOrNot()
        #expect(color == Color.clear)
    }
}
