@testable import MastermindCore
import Testing

final class EvaluatorTests: @unchecked Sendable {
    @Test
    func `all wrong returns no clues`() async throws {
        let sut = makeSUT(2, 3, 4, 5)

        let clues = sut.evaluate(makeGuess(1, 1, 1, 1))

        #expect(clues.isEmpty)
    }

    // [TEST] one right color wrong position answers 1 misplaced
    // [TEST] two right colors wrong positions answers 2 misplaced
    // [TEST] one right color right position answers 1 correct
    // [TEST] two right colors right positions answers 2 correct
    // [TEST] two misplaced and two correct answers 2 correct, 2 misplaced
    // [TEST] all correct answers 4 correct

    private func makeSUT(_ choices: Int...) -> Evaluator {
        Evaluator(Secret(choices: choices.map(CodeChoice.init)))
    }

    private func makeGuess(_ choices: Int...) -> Guess {
        Guess(choices: choices.map(CodeChoice.init))
    }
}
