@testable import Mastermind
import SwiftUI
@testable import ViewInspector
import XCTest

final class GameScreenTests: XCTestCase {
    @MainActor func test_initialColorGuessIsUnselected() throws {
        let game = try Game(numberOfCodeChoices: 1)
        let sut = GameScreen(game: game)

        let color = try getColorOfGuess(try sut.inspect())

        XCTAssertEqual(color, Color.unselected)
    }

    @MainActor func test_tappingCodeChoiceSetsGuessColor() throws {
        let game = try Game(numberOfCodeChoices: 1)
        var sut = GameScreen(game: game)
        let codeChoice = game.codeChoices[0]
        var color: Color?

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
