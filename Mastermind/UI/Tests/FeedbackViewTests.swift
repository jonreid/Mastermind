@testable import Mastermind
import SwiftUI
import ViewInspector
import XCTest

@MainActor
final class FeedbackViewTests: XCTestCase, Sendable {
    func test_zero() throws {
        let sut = FeedbackView(feedbackPegs: [.empty, .empty, .empty, .empty])

        let peg1Color = try sut.inspect().peg1Color()

        XCTAssertEqual(peg1Color, Color.unselected)
    }
}

private extension InspectableView {
    func peg1Color() throws -> Color? {
        try find(viewWithAccessibilityIdentifier: "feedback1").shape().foregroundColor()
    }

    func pegColor(_ peg: Int) throws -> Color? {
        try find(viewWithAccessibilityIdentifier: "feedback\(peg)").shape().foregroundColor()
    }
}

