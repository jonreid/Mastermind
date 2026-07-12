@testable import MastermindCore
import Testing

final class EvaluatorTests: @unchecked Sendable {
    @Test
    func `all wrong returns no clues`() async throws {
        let sut = Evaluator(Secret(choices: [CodeChoice(2), CodeChoice(3), CodeChoice(4), CodeChoice(5)]))

        let clues = sut.evaluate(Guess(choices: [CodeChoice(1), CodeChoice(1), CodeChoice(1), CodeChoice(1)]))

        #expect(clues.isEmpty)
    }

    // [TEST] one right color wrong position answers 1 misplaced
    // [TEST] two right colors wrong positions answers 2 misplaced
    // [TEST] one right color right position answers 1 correct
    // [TEST] two right colors right positions answers 2 correct
    // [TEST] two misplaced and two correct answers 2 correct, 2 misplaced
    // [TEST] all correct answers 4 correct
}
