@testable import Mastermind
import SwiftUI
import ViewInspector
import XCTest

@MainActor
final class FeedbackViewTests: XCTestCase, Sendable {
    func test_pegs() throws {
        let sut = makeSUT(.correct, .misplaced, .misplaced, .empty)

        let peg1Color = try sut.inspect().pegColor(1)
        let peg2Color = try sut.inspect().pegColor(2)
        let peg3Color = try sut.inspect().pegColor(3)
        let peg4Color = try sut.inspect().pegColor(4)

        XCTAssertEqual(peg1Color, Color.Pegs.correct)
        XCTAssertEqual(peg2Color, Color.Pegs.misplaced)
        XCTAssertEqual(peg3Color, Color.Pegs.misplaced)
        XCTAssertEqual(peg4Color, Color.Pegs.unselected)
    }

    private func makeSUT(_ feedbackPegs: FeedbackPeg...) -> FeedbackView {
        FeedbackView(feedbackPegs: feedbackPegs)
    }
}

private extension InspectableView {
    func pegColor(_ peg: Int) throws -> Color? {
        try pegShape(peg).foregroundColor()
    }

    func pegStrokeColor(_ peg: Int) throws -> Color? {
        try pegShape(peg).overlay().shape().fillShapeStyle(Color.self)
    }

    private func pegShape(_ peg: Int) throws -> InspectableView<ViewType.Shape> {
        try find(viewWithAccessibilityIdentifier: "feedback\(peg)").shape()
    }
}

