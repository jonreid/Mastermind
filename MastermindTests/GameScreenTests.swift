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

        let color = try getColorOfGuess(try sut.inspect())

        XCTAssertEqual(color, Color.unselected)
    }

    @MainActor func test_tappingCodeChoiceSetsGuessColor() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        var sut = GameScreen(game: game)
        let codeChoice = game.codeChoice(0)
        var color: Color?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            color = try self.getColorOfGuess(view)
        }

        XCTAssertEqual(color, codeChoice.color)
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

    @MainActor func test_doesNotShowGameOverWhenCodeChoiceIsEmpty() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        let sut = GameScreen(game: game)
        XCTAssertThrowsError(try sut.inspect().find(ViewType.Sheet.self))
    }

    @MainActor func test_gameOverShowsYouLoseWhenGuessDoesNotMatchSecret_secretSize1() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        var sut = GameScreen(game: game)
        let codeChoiceToTap = game.codeChoice(1)
        var gameOverText: String?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoiceToTap.codeValue).button().tap()
            gameOverText = try view.find(ViewType.Sheet.self).text().string()
        }

        XCTAssertEqual(gameOverText, "You lose! The secret was brown")
    }

    @MainActor func test_gameOverShowsYouWinWhenGuessMatchesSecret_secretSize1() throws {
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        var sut = GameScreen(game: game)
        let codeChoiceToTap = game.codeChoice(0)
        var gameOverText: String?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoiceToTap.codeValue).button().tap()
            gameOverText = try view.find(ViewType.Sheet.self).text().string()
        }

        XCTAssertEqual(gameOverText, "You win!")
    }

    @MainActor func test_gameOverShowsYouWinWhenGuessMatchesSecret_secretSize2() throws {
        try XCTSkipIf(true, "Disabled")
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

    private func makeGame(numberOfCodeChoices: Int, secretSize: Int) throws -> Game {
        try Game(numberOfCodeChoices: numberOfCodeChoices, secretSize: secretSize, SecretMaker.createNull())
    }

    private func getColorOfGuess<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>) throws -> Color? {
        try view.asInspectableView().find(viewWithId: "guess1").button().labelView().shape().foregroundColor()
    }

    private func getCodeChoiceColor<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>, _ index: Int) throws -> Color? {
        let codeChoice = try view.asInspectableView().find(viewWithId: "codeChoices").vStack(0).forEach(0)[index]
        return try codeChoice.find(ViewType.Button.self).labelView().shape().overlay().shape().foregroundColor()
    }
}
