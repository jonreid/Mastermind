@testable import Mastermind
import ViewInspector
import XCTest

@MainActor
final class FeedbackViewTests: XCTestCase, Sendable {
    func test_zero() throws {
//        XCTFail("Tests not yet implemented in FeedbackViewTests")
    }
}

private extension InspectableView {
    func peg1() throws -> InspectableView<ViewType.Shape> {
        try find(viewWithAccessibilityIdentifier: "feedback1").shape()
    }
}

