@testable import MastermindCore
import Testing

final class EvaluatorTests: @unchecked Sendable {
    @Test
    func `all wrong returns no clues`() async throws {
        let sut = makeSUT(2, 3, 4, 5)

        let clues = sut.evaluate(makeGuess(1, 1, 1, 1))

        #expect(clues.isEmpty)
    }

    @Test
    func `one right peg wrong position answers 1 misplaced`() async throws {
        let sut = makeSUT(2, 3, 4, 5)

        let clues = sut.evaluate(makeGuess(3, 1, 1, 1))

        #expect(clues == [.misplaced])
    }

    @Test
    func `two right pegs wrong positions answers 2 misplaced`() async throws {
        let sut = makeSUT(2, 3, 4, 5)

        let clues = sut.evaluate(makeGuess(3, 2, 1, 1))

        #expect(clues == [.misplaced, .misplaced])
    }

    @Test
    func `one right peg right position answers 1 correct`() async throws {
        let sut = makeSUT(2, 3, 4, 5)

        let clues = sut.evaluate(makeGuess(2, 1, 1, 1))

        #expect(clues == [.correct])
    }

    @Test
    func `two right pegs right positions answers 2 correct`() async throws {
        let sut = makeSUT(2, 3, 4, 5)

        let clues = sut.evaluate(makeGuess(2, 3, 1, 1))

        #expect(clues == [.correct, .correct])
    }

    // [TEST] two misplaced and two correct answers 2 correct, 2 misplaced
    // [TEST] all correct answers 4 correct

    private func makeSUT(_ choices: Int...) -> Evaluator {
        Evaluator(Secret(choices: choices.map(CodeChoice.init)))
    }

    private func makeGuess(_ choices: Int...) -> Guess {
        Guess(choices: choices.map(CodeChoice.init))
    }
}
