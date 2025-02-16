@testable import Mastermind
import ViewInspector
import XCTest

@MainActor
final class FeedbackViewTests: XCTestCase, Sendable {
    func test_zero() throws {
        let sut = FeedbackView(feedbackPegs: [.empty, .empty, .empty, .empty])

        try sut.inspect().peg1()
    }
}

private extension InspectableView {
    func peg1() throws -> InspectableView<ViewType.Shape> {
        try find(viewWithAccessibilityIdentifier: "feedback1").shape()
    }
}

