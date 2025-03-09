@testable import Mastermind
import SwiftUI
import ViewInspector
import XCTest

extension InspectableSheet: @retroactive PopupPresenter {}

@MainActor
final class GameScreenTests: XCTestCase {
    func test_displaysCodeChoicesBottomUp() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)
        let sut = GameScreen(game: game)

        let choice1 = try sut.inspect().codeChoiceColor(0)
        let choice2 = try sut.inspect().codeChoiceColor(1)
        let choice3 = try sut.inspect().codeChoiceColor(2)
        let choice4 = try sut.inspect().codeChoiceColor(3)

        XCTAssertEqual(choice1, game.codeChoice(3).color)
        XCTAssertEqual(choice2, game.codeChoice(2).color)
        XCTAssertEqual(choice3, game.codeChoice(1).color)
        XCTAssertEqual(choice4, game.codeChoice(0).color)
    }

    func test_showingGameScreen_setsGameSecret() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)

        _ = GameScreen(game: game)

        XCTAssertFalse(game.secret.testHooks.code.isEmpty)
    }

    func test_initialColorGuessIsUnselected() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)
        let sut = GameScreen(game: game)

        let color1 = try sut.inspect().colorOfGuess(id: "guess1")
        let color2 = try sut.inspect().colorOfGuess(id: "guess2")
        let color3 = try sut.inspect().colorOfGuess(id: "guess3")
        let color4 = try sut.inspect().colorOfGuess(id: "guess4")

        XCTAssertEqual(color1, Color.unselected)
        XCTAssertEqual(color2, Color.unselected)
        XCTAssertEqual(color3, Color.unselected)
        XCTAssertEqual(color4, Color.unselected)
    }

    func test_tappingCodeChoicesSetsGuessColors() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)
        var sut = GameScreen(game: game)
        let codeChoice1 = game.codeChoice(0)
        let codeChoice2 = game.codeChoice(1)
        let codeChoice3 = game.codeChoice(2)
        let codeChoice4 = game.codeChoice(3)
        var color1: Color?
        var color2: Color?
        var color3: Color?
        var color4: Color?

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice1.codeValue).button().tap()
            try view.find(viewWithId: codeChoice2.codeValue).button().tap()
            try view.find(viewWithId: codeChoice3.codeValue).button().tap()
            try view.find(viewWithId: codeChoice4.codeValue).button().tap()
            color1 = try view.colorOfGuess(id: "guess1")
            color2 = try view.colorOfGuess(id: "guess2")
            color3 = try view.colorOfGuess(id: "guess3")
            color4 = try view.colorOfGuess(id: "guess4")
        }

        XCTAssertEqual(color1, codeChoice1.color)
        XCTAssertEqual(color2, codeChoice2.color)
        XCTAssertEqual(color3, codeChoice3.color)
        XCTAssertEqual(color4, codeChoice4.color)
    }

    func test_checkButtonIsInitiallyDisabled() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)
        let sut = GameScreen(game: game)

        let isEnabled = try sut.inspect().find(viewWithAccessibilityIdentifier: "checkButton").button().isResponsive()

        XCTAssertFalse(isEnabled)
    }

    func test_enablesCheckButtonWhenGuessIsFilled() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)
        var sut = GameScreen(game: game)
        let codeChoice1 = game.codeChoice(0)
        let codeChoice2 = game.codeChoice(1)
        let codeChoice3 = game.codeChoice(2)
        let codeChoice4 = game.codeChoice(3)

        var isEnabled = false
        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice1.codeValue).button().tap()
            try view.find(viewWithId: codeChoice2.codeValue).button().tap()
            try view.find(viewWithId: codeChoice3.codeValue).button().tap()
            try view.find(viewWithId: codeChoice4.codeValue).button().tap()

            isEnabled = try view.checkButton().isResponsive()
        }

        XCTAssertTrue(isEnabled)
    }

    func test_showsGameOverWhenCodeChoiceIsFilled() throws {
        try XCTSkipIf(true, "Disabled")
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 1)
        var sut = GameScreen(game: game)
        let codeChoice = game.codeChoice(0)

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            XCTAssertNoThrow(try view.find(ViewType.Sheet.self))
        }
    }

    func test_doesNotShowGameOverWhenGuessIsNotFilled() throws {
        let game = try makeGame(numberOfCodeChoices: 4, secretSize: 4)
        var sut = GameScreen(game: game)
        let firstCodeChoice = game.codeChoice(0)
        let secondCodeChoice = game.codeChoice(1)
        let thirdCodeChoice = game.codeChoice(2)

        inspectChangingView(&sut) { view in
            try view.find(viewWithId: firstCodeChoice.codeValue).button().tap()
            try view.find(viewWithId: secondCodeChoice.codeValue).button().tap()
            try view.find(viewWithId: thirdCodeChoice.codeValue).button().tap()
            XCTAssertThrowsError(try view.find(ViewType.Sheet.self))
        }
    }

    func test_showsYouWinWhenGuessMatchesSecret() throws {
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

    func test_showsYouLoseWhenGuessDoesNotMatchSecret() throws {
        try XCTSkipIf(true, "Disabled")
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

    private func makeGame(numberOfCodeChoices: Int = 4, secretSize: Int = 4) throws -> Game {
        try Game(numberOfCodeChoices: numberOfCodeChoices, secretSize: secretSize, SecretMaker.createNull())
    }
}

private extension InspectableView {
    func checkButton() throws -> InspectableView<ViewType.Button> {
        try find(viewWithAccessibilityIdentifier: "checkButton").button()
    }

    func colorOfGuess(id: String) throws -> Color? {
        try find(viewWithId: id).button().labelView().shape().foregroundColor()
    }

    func codeChoiceColor(_ index: Int) throws -> Color? {
        let codeChoice = try find(viewWithAccessibilityIdentifier: "codeChoices").vStack(0).forEach(0)[index]
        return try codeChoice.find(ViewType.Button.self).labelView().shape().overlay().shape().foregroundColor()
    }
}
