@testable import Mastermind
import XCTest

final class RoundTests: XCTestCase {
    private let choice0 = CodeChoice(color: .red, codeValue: 1)
    private let choice1 = CodeChoice(color: .green, codeValue: 2)

    func test_createRound_setsGuessSize() throws {
        let sut = makeSUT(secretSize: 4)

        XCTAssertNil(sut[0])
        XCTAssertNil(sut[1])
        XCTAssertNil(sut[2])
        XCTAssertNil(sut[3])
    }

    func test_size() throws {
        let sut = makeSUT(secretSize: 4)

        XCTAssertEqual(sut.pegCount, 4)
    }

    func test_placeChoiceInNextSlot() throws {
        let sut = makeSUT(secretSize: 2)

        sut.placeChoiceInNextSlot(choice0)
        sut.placeChoiceInNextSlot(choice1)

        XCTAssertEqual(sut[0], choice0)
        XCTAssertEqual(sut[1], choice1)
    }

    func test_isObservable_soThatViewsCanObserveChanges() throws {
        let sut = makeSUT(secretSize: 2)

        XCTAssertTrue(sut is (any Observable))
    }

    func test_isNotComplete_withSecondSlotEmpty() throws {
        let sut = makeSUT(secretSize: 2)

        sut.placeChoiceInNextSlot(choice0)

        XCTAssertFalse(sut.isComplete)
    }

    func test_isNotComplete_withFirstSlotEmpty() throws {
        let sut = makeSUT(secretSize: 2)

        sut[1] = choice1

        XCTAssertFalse(sut.isComplete)
    }

    func test_isComplete_withAllSlotsFilled() throws {
        let sut = makeSUT(secretSize: 2)

        sut.placeChoiceInNextSlot(choice0)
        sut.placeChoiceInNextSlot(choice1)

        XCTAssertTrue(sut.isComplete)
    }

    private func makeSUT(secretSize: Int) -> Round {
        Round(secretSize: secretSize, roundNumber: RoundNumber(value: 1))
    }
}
