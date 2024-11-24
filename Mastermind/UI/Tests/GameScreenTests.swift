@testable import Mastermind
import SwiftUI
@testable import ViewInspector
import XCTest

extension InspectableSheet: @retroactive PopupPresenter {}

final class GameScreenTests: XCTestCase {
    @MainActor func test_displaysCodeChoicesBottomUp() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        let sut = GameScreen(game: game)

        let choice1 = try getCodeChoiceColor(sut.inspect(), 0)
        let choice2 = try getCodeChoiceColor(sut.inspect(), 1)

        XCTAssertEqual(choice1, game.codeChoice(1).color)
        XCTAssertEqual(choice2, game.codeChoice(0).color)
    }

    @MainActor func test_showingGameScreen_setsGameSecret() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)

        _ = GameScreen(game: game)

        XCTAssertFalse(game.secret.code.isEmpty)
    }

    @MainActor func test_initialColorGuessIsUnselected() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        let sut = GameScreen(game: game)

        let color = try getColorOfGuess(try sut.inspect(), id: "guess1")

        XCTAssertEqual(color, Color.unselected)
    }

    @MainActor func test_tappingCodeChoicesSetsGuessColors() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 2)
        var sut = GameScreen(game: game)
        let codeChoice1 = game.codeChoice(0)
        let codeChoice2 = game.codeChoice(1)
        var color1: Color?
        var color2: Color?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice1.codeValue).button().tap()
            try view.find(viewWithId: codeChoice2.codeValue).button().tap()
            color1 = try self.getColorOfGuess(view, id: "guess1")
            color2 = try self.getColorOfGuess(view, id: "guess2")
        }

        XCTAssertEqual(color1, codeChoice1.color)
        XCTAssertEqual(color2, codeChoice2.color)
    }

    @MainActor func test_checkButtonIsInitiallyDisabled() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 2)
        let sut = GameScreen(game: game)

        let isEnabled = try sut.inspect().find(viewWithTag: "checkButton").button().isResponsive()

        XCTAssertFalse(isEnabled)
    }

    @MainActor func test_showsGameOverWhenCodeChoiceIsFilled() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        var sut = GameScreen(game: game)
        let codeChoice = game.codeChoice(0)

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            XCTAssertNoThrow(try view.find(ViewType.Sheet.self))
        }
    }

    @MainActor func test_doesNotShowGameOverWhenGuessIsNotFilled() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 2)
        var sut = GameScreen(game: game)
        let firstCodeChoice = game.codeChoice(0)

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: firstCodeChoice.codeValue).button().tap()
            XCTAssertThrowsError(try view.find(ViewType.Sheet.self))
        }
    }

    @MainActor func test_showsYouWinWhenGuessMatchesSecret() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 2)
        var sut = GameScreen(game: game)
        let firstCodeChoice = game.codeChoice(0)
        let secondCodeChoice = game.codeChoice(1)
        var gameOverText: String?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: firstCodeChoice.codeValue).button().tap()
            try view.find(viewWithId: secondCodeChoice.codeValue).button().tap()
            gameOverText = try view.find(ViewType.Sheet.self).text().string()
        }

        XCTAssertEqual(gameOverText, "You win!")
    }

    @MainActor func test_showsYouLoseWhenGuessDoesNotMatchSecret() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 2)
        var sut = GameScreen(game: game)
        let firstCodeChoice = game.codeChoice(0)
        let secondCodeChoice = game.codeChoice(1)
        var gameOverText: String?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: secondCodeChoice.codeValue).button().tap()
            try view.find(viewWithId: firstCodeChoice.codeValue).button().tap()
            gameOverText = try view.find(ViewType.Sheet.self).text().string()
        }

        XCTAssertEqual(gameOverText, "You lose! The secret was brown, black")
    }

    private func makeGame(numberOfCodeChoices: Int, secretSize: Int) throws -> Game {
        try Game(numberOfCodeChoices: numberOfCodeChoices, secretSize: secretSize, SecretMaker.createNull())
    }

    private func getColorOfGuess<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>, id: String) throws -> Color? {
        try view.asInspectableView().find(viewWithId: id).button().labelView().shape().foregroundColor()
    }

    private func getCodeChoiceColor<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>, _ index: Int) throws -> Color? {
        let codeChoice = try view.asInspectableView().find(viewWithId: "codeChoices").vStack(0).forEach(0)[index]
        return try codeChoice.find(ViewType.Button.self).labelView().shape().overlay().shape().foregroundColor()
    }
}
