@testable import Mastermind
import SwiftUI
import ViewInspector
import XCTest

@MainActor
final class FeedbackViewTests: XCTestCase, Sendable {
    func test_pegs() throws {
        let sut = FeedbackView(feedbackPegs: [.empty, .empty, .empty, .empty])

        let peg1Color = try sut.inspect().pegColor(1)
        let peg2Color = try sut.inspect().pegColor(2)

        XCTAssertEqual(peg1Color, Color.unselected)
        XCTAssertEqual(peg2Color, Color.unselected)
    }
}

private extension InspectableView {
    func pegColor(_ peg: Int) throws -> Color? {
        try find(viewWithAccessibilityIdentifier: "feedback\(peg)").shape().foregroundColor()
    }
}

