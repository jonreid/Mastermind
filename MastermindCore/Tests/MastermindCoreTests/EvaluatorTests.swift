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

    // swiftlint:disable identifier_name
    private func makeSUT(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Evaluator {
        Evaluator(Secret(choices: [CodeChoice(a), CodeChoice(b), CodeChoice(c), CodeChoice(d)]))
    }

    private func makeGuess(_ a: Int, _ b: Int, _ c: Int, _ d: Int) -> Guess {
        Guess(choices: [CodeChoice(a), CodeChoice(b), CodeChoice(c), CodeChoice(d)])
    }
    // swiftlint:enable identifier_name
}
