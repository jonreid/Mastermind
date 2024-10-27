@testable import Mastermind
import XCTest

final class GuessTests: XCTestCase {
    private var choice0: CodeChoice!
    private var choice1: CodeChoice!

    override func setUpWithError() throws {
        try super.setUpWithError()
        choice0 = CodeChoice(color: .red, codeValue: 1)
        choice1 = CodeChoice(color: .green, codeValue: 2)
    }

    override func tearDownWithError() throws {
        choice0 = nil
        choice1 = nil
        try super.tearDownWithError()
    }

    func test_createGuess_setsGuessSize() throws {
        let sut = makeGuess(secretSize: 2)

        XCTAssertNil(sut[0])
        XCTAssertNil(sut[1])
    }

    func test_size() throws {
        let sut = makeGuess(secretSize: 4)

        XCTAssertEqual(sut.size, 4)
    }

    func test_setAndGetAtIndices() throws {
        let sut = makeGuess(secretSize: 2)

        sut[0] = choice0
        sut[1] = choice1

        XCTAssertEqual(sut[0], choice0)
        XCTAssertEqual(sut[1], choice1)
    }

    func test_placeCodeChoiceInFirstEmptySlot() throws {
        let sut = makeGuess(secretSize: 2)

        sut.placeCodeChoiceInFirstEmptySlot(choice0)
        sut.placeCodeChoiceInFirstEmptySlot(choice1)

        XCTAssertEqual(sut[0], choice0)
        XCTAssertEqual(sut[1], choice1)
    }

    func test_isObservable_soThatViewsCanObserveChanges() throws {
        let sut = makeGuess(secretSize: 2)

        XCTAssertTrue(sut is (any Observable))
    }

    func test_isNotComplete_withSecondSlotEmpty() throws {
        let sut = makeGuess(secretSize: 2)

        sut[0] = choice0

        XCTAssertFalse(sut.isComplete)
    }

    func test_isNotComplete_withFirstSlotEmpty() throws {
        let sut = makeGuess(secretSize: 2)

        sut[1] = choice1

        XCTAssertFalse(sut.isComplete)
    }

    func test_isComplete_withAllSlotsFilled() throws {
        let sut = makeGuess(secretSize: 2)

        sut[0] = choice0
        sut[1] = choice1

        XCTAssertTrue(sut.isComplete)
    }

    private func makeGuess(secretSize: Int) -> Guess {
        Guess(secretSize: secretSize)
    }
}
