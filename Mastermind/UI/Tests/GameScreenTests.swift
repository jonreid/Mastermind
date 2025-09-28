@testable import Mastermind
import SwiftUI
import ViewInspector
import XCTest

extension InspectableSheet: @retroactive PopupPresenter {}

@MainActor
final class GameScreenTests: XCTestCase, Sendable {
    private var game: Game!

    override func setUp() async throws {
        try await super.setUp()
        game = try makeGame()
    }

    override func tearDown() async throws {
        game = nil
        try await super.tearDown()
    }

    func test_displaysCodeChoicesBottomUp() throws {
        let sut = makeSUT(game)

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
        _ = makeSUT(game)

        XCTAssertFalse(game.secret.testHooks.code.isEmpty)
    }

    func test_initialColorGuessIsUnselected() throws {
        let sut = makeSUT(game)

        let color1 = try sut.inspect().colorOfGuess(id: "guess1-1")
        let color2 = try sut.inspect().colorOfGuess(id: "guess1-2")
        let color3 = try sut.inspect().colorOfGuess(id: "guess1-3")
        let color4 = try sut.inspect().colorOfGuess(id: "guess1-4")

        XCTAssertEqual(color1, Color.unselected)
        XCTAssertEqual(color2, Color.unselected)
        XCTAssertEqual(color3, Color.unselected)
        XCTAssertEqual(color4, Color.unselected)
    }

    func test_tappingCodeChoicesSetsGuessColors() throws {
        var sut = makeSUT(game)
        let codeChoice1 = game.codeChoice(0)
        let codeChoice2 = game.codeChoice(1)
        let codeChoice3 = game.codeChoice(2)
        let codeChoice4 = game.codeChoice(3)
        var color1: Color?
        var color2: Color?
        var color3: Color?
        var color4: Color?

        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: codeChoice1.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice2.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice3.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice4.codeValue).button().tap()
            color1 = try inspectableView.colorOfGuess(id: "guess1-1")
            color2 = try inspectableView.colorOfGuess(id: "guess1-2")
            color3 = try inspectableView.colorOfGuess(id: "guess1-3")
            color4 = try inspectableView.colorOfGuess(id: "guess1-4")
        }

        XCTAssertEqual(color1, codeChoice1.color)
        XCTAssertEqual(color2, codeChoice2.color)
        XCTAssertEqual(color3, codeChoice3.color)
        XCTAssertEqual(color4, codeChoice4.color)
    }

    func test_checkButtonIsInitiallyDisabled() throws {
        let sut = makeSUT(game)

        let isEnabled = try sut.inspect().findView(accessibilityIdentifier: "checkButton").button().isResponsive()

        XCTAssertFalse(isEnabled)
    }

    func test_enablesCheckButtonWhenGuessIsFilled() throws {
        var sut = makeSUT(game)
        let codeChoice1 = game.codeChoice(0)
        let codeChoice2 = game.codeChoice(1)
        let codeChoice3 = game.codeChoice(2)
        let codeChoice4 = game.codeChoice(3)

        var isEnabled = false
        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: codeChoice1.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice2.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice3.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice4.codeValue).button().tap()

            isEnabled = try inspectableView.checkButton().isResponsive()
        }

        XCTAssertTrue(isEnabled)
    }

    func test_initialFeedbackPegsAreEmpty() throws {
        let sut = makeSUT(game)

        let feedbackPegColor = try sut.inspect().feedbackPegColor(1)

        XCTAssertEqual(feedbackPegColor, Color.Pegs.unselected)
    }

    func test_tappingCheckButtonUpdatesFeedback() throws {
        var sut = makeSUT(game)
        let codeChoice1 = game.codeChoice(0)
        let codeChoice2 = game.codeChoice(1)
        let codeChoice3 = game.codeChoice(2)
        let codeChoice4 = game.codeChoice(3)
        var feedbackPegColor: Color?

        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: codeChoice1.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice2.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice3.codeValue).button().tap()
            try inspectableView.findView(id: codeChoice4.codeValue).button().tap()
            try inspectableView.checkButton().tap()
            feedbackPegColor = try inspectableView.feedbackPegColor(1)
        }

        XCTAssertEqual(feedbackPegColor, Color.Pegs.correct)
    }

    func test_showsGameOverWhenCodeChoiceIsFilled() throws {
        try XCTSkipIf(true, "Disabled")
        var sut = makeSUT(game)
        let codeChoice = game.codeChoice(0)

        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: codeChoice.codeValue).button().tap()
            XCTAssertNoThrow(try inspectableView.find(ViewType.Sheet.self))
        }
    }

    func test_doesNotShowGameOverWhenGuessIsNotFilled() throws {
        var sut = makeSUT(game)
        let firstCodeChoice = game.codeChoice(0)
        let secondCodeChoice = game.codeChoice(1)
        let thirdCodeChoice = game.codeChoice(2)

        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: firstCodeChoice.codeValue).button().tap()
            try inspectableView.findView(id: secondCodeChoice.codeValue).button().tap()
            try inspectableView.findView(id: thirdCodeChoice.codeValue).button().tap()
            XCTAssertThrowsError(try inspectableView.find(ViewType.Sheet.self))
        }
    }

    func test_showsYouWinWhenGuessMatchesSecret() throws {
        try XCTSkipIf(true, "Disabled")
        var sut = makeSUT(game)
        let firstCodeChoice = game.codeChoice(0)
        let secondCodeChoice = game.codeChoice(1)
        var gameOverText: String?

        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: firstCodeChoice.codeValue).button().tap()
            try inspectableView.findView(id: secondCodeChoice.codeValue).button().tap()
            gameOverText = try inspectableView.find(ViewType.Sheet.self).text().string()
        }

        XCTAssertEqual(gameOverText, "You win!")
    }

    func test_showsYouLoseWhenGuessDoesNotMatchSecret() throws {
        try XCTSkipIf(true, "Disabled")
        let game = try makeGame(numberOfCodeChoices: 2, secretSize: 2)
        var sut = makeSUT(game)
        let firstCodeChoice = game.codeChoice(0)
        let secondCodeChoice = game.codeChoice(1)
        var gameOverText: String?

        inspectChangingView(&sut) { inspectableView in
            try inspectableView.findView(id: secondCodeChoice.codeValue).button().tap()
            try inspectableView.findView(id: firstCodeChoice.codeValue).button().tap()
            gameOverText = try inspectableView.find(ViewType.Sheet.self).text().string()
        }

        XCTAssertEqual(gameOverText, "You lose! The secret was brown, black")
    }

    func test_displaysTwoRounds() throws {
        let game = try makeGame(numberOfRounds: 2)
        let sut = makeSUT(game)
        let inspectable = try sut.inspect()

        _ = try inspectable.findView(accessibilityIdentifier: "round1")
        _ = try inspectable.findView(accessibilityIdentifier: "round2")
        XCTAssertThrowsError(try inspectable.find(viewWithAccessibilityLabel: "round3"))
        _ = try inspectable.findView(id: "guess1-1")
        _ = try inspectable.findView(id: "guess2-1")
        XCTAssertThrowsError(try inspectable.find(viewWithId: "guess3-1"))
    }
    
    func test_displaysThreeRounds() throws {
        let game = try makeGame(numberOfRounds: 3)
        let sut = makeSUT(game)
        let inspectable = try sut.inspect()

        _ = try inspectable.findView(id: "guess1-1")
        _ = try inspectable.findView(id: "guess2-1")
        _ = try inspectable.findView(id: "guess3-1")
        XCTAssertThrowsError(try inspectable.find(viewWithId: "guess4-1"))
    }

    private func makeGame(numberOfCodeChoices: Int = 4, secretSize: Int = 4, numberOfRounds: Int = 2) throws -> Game {
        try Game(numberOfCodeChoices: numberOfCodeChoices, secretSize: secretSize, numberOfRounds: numberOfRounds, SecretMaker.createNull())
    }

    private func makeSUT(_ game: Game) -> GameScreen {
        GameScreen(game: game)
    }
}

private extension InspectableView {
    func checkButton(file: StaticString = #filePath, line: UInt = #line) throws -> InspectableView<ViewType.Button> {
        try findView(accessibilityIdentifier: "checkButton", file: file, line: line).button()
    }

    func colorOfGuess(id: String, file: StaticString = #filePath, line: UInt = #line) throws -> Color? {
        try findView(id: id, file: file, line: line).button().labelView().shape().foregroundColor()
    }

    func codeChoiceColor(_ index: Int, file: StaticString = #filePath, line: UInt = #line) throws -> Color? {
        let codeChoice = try findView(accessibilityIdentifier: "codeChoices", file: file, line: line).vStack(0).forEach(0)[index]
        return try codeChoice.find(ViewType.Button.self).labelView().shape().overlay().shape().foregroundColor()
    }

    func feedbackPegColor(_ peg: Int, file: StaticString = #filePath, line: UInt = #line) throws -> Color? {
        try findView(accessibilityIdentifier: "feedback\(peg)", file: file, line: line).shape().foregroundColor()
    }
}

extension InspectableView {
    func findView(
        accessibilityIdentifier: String,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> InspectableView<ViewType.ClassifiedView> {
        do {
            return try find(viewWithAccessibilityIdentifier: accessibilityIdentifier)
        } catch {
            XCTFail(
                "view with accessibility identifier \"\(accessibilityIdentifier)\" not found: \(error)",
                file: file,
                line: line
            )
            throw error
        }
    }

    func findView(
        id: AnyHashable,
        file: StaticString = #filePath,
        line: UInt = #line
    ) throws -> InspectableView<ViewType.ClassifiedView> {
        do {
            return try find(viewWithId: id)
        } catch {
            XCTFail(
                "view with id \"\(id)\" not found: \(error)",
                file: file,
                line: line
            )
            throw error
        }
    }
}
