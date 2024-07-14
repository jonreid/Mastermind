@testable import Mastermind
import SwiftUI
@testable import ViewInspector
import XCTest

extension InspectableSheet: PopupPresenter {}

final class GameScreenTests: XCTestCase {
    @MainActor func test_displaysCodeChoicesBottomUp() throws {
        let game = try Game(numberOfCodeChoices: 2)
        let sut = GameScreen(game: game)

        let choice1 = try getCodeChoiceColor(sut.inspect(), 0)
        let choice2 = try getCodeChoiceColor(sut.inspect(), 1)

        XCTAssertEqual(choice1, game.codeChoices[1].color)
        XCTAssertEqual(choice2, game.codeChoices[0].color)
    }

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

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            color = try self.getColorOfGuess(view)
        }

        XCTAssertEqual(color, codeChoice.color)
    }

    @MainActor func test_showsGameOverWhenCodeChoiceIsFilled() throws {
        let game = try Game(numberOfCodeChoices: 2)
        var sut = GameScreen(game: game)
        let codeChoice = game.codeChoices[0]

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            XCTAssertNoThrow(try view.find(ViewType.Sheet.self))
        }
    }

    @MainActor func test_doesNotShowGameOverWhenCodeChoiceIsEmpty() throws {
        let game = try Game(numberOfCodeChoices: 2)
        let sut = GameScreen(game: game)
        XCTAssertThrowsError(try sut.inspect().find(ViewType.Sheet.self))
    }

    private func getColorOfGuess<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>) throws -> Color? {
        try view.asInspectableView().find(viewWithId: "guess1").button().labelView().shape().foregroundColor()
    }

    private func getCodeChoiceColor<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>, _ index: Int) throws -> Color? {
        try view.asInspectableView().find(viewWithId: "codeChoices").vStack(0).forEach(0)[index].button().labelView().shape().overlay().shape().foregroundColor()
    }
}
