@testable import Mastermind
import Testing

struct FeedbackTests {
    private let red = CodeChoice(color: .red, codeValue: 1)
    private let green = CodeChoice(color: .green, codeValue: 2)
    private let blue = CodeChoice(color: .blue, codeValue: 3)

    @Test
    func noMatches() async throws {
        let evaluator = FeedbackEvaluator(Secret(code: [red, green]))

        let correctColorsFeedback = evaluator.evaluate(makeGuess(code: [blue, blue]))

        #expect(correctColorsFeedback.inCorrectPosition == 0)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    private func makeGuess(code: [CodeChoice]) -> Guess {
        let guess = Guess(secretSize: code.count)
        for choice in code {
            guess.placeChoiceInNextSlot(choice)
        }
        return guess
    }
}
