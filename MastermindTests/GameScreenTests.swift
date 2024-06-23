@testable import Mastermind
import SwiftUI
@testable import ViewInspector
import XCTest

final class GameScreenTests: XCTestCase {
    @MainActor func test_tappingCodeChoiceSetsGuessColor() throws {
        var sut = GameScreen()
        var color = try getColorOfGuess(try sut.inspect())
        let codeChoice = codeChoices[0]
        XCTAssertNotEqual(color, codeChoice.color, "Precondition")

        update(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            color = try self.getColorOfGuess(view)
        }

        XCTAssertEqual(color, codeChoice.color)
    }

    private func getColorOfGuess<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>) throws -> Color? {
        try view.asInspectableView().find(viewWithId: "guess1").button().labelView().shape().foregroundColor()
    }
}
