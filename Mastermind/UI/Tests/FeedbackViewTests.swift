@testable import Mastermind
import SwiftUI
import ViewInspector
import XCTest

@MainActor
final class FeedbackViewTests: XCTestCase, Sendable {
    func test_pegs() throws {
        let sut = FeedbackView(feedbackPegs: [.correct, .misplaced, .misplaced, .empty])

        let peg1Color = try sut.inspect().pegColor(1)
        let peg2Color = try sut.inspect().pegColor(2)
        let peg3Color = try sut.inspect().pegColor(3)
        let peg4Color = try sut.inspect().pegColor(4)

        XCTAssertEqual(peg1Color, Color.Pegs.correct)
        XCTAssertEqual(peg2Color, Color.Pegs.misplaced)
        XCTAssertEqual(peg3Color, Color.Pegs.misplaced)
        XCTAssertEqual(peg4Color, Color.Pegs.unselected)
    }
}

private extension InspectableView {
    func pegColor(_ peg: Int) throws -> Color? {
        try find(viewWithAccessibilityIdentifier: "feedback\(peg)").shape().foregroundColor()
    }
}

