@testable import Mastermind
import Testing

struct FeedbackTests {
    private let red = CodeChoice(color: .red, codeValue: 1)
    private let green = CodeChoice(color: .green, codeValue: 2)
    private let blue = CodeChoice(color: .blue, codeValue: 3)

    @Test
    func noMatches() async throws {
        let evaluator = FeedbackEvaluator(Secret(code: [red, green]))
        let guess = Guess(secretSize: 2)
        guess.placeChoiceInNextSlot(blue)
        guess.placeChoiceInNextSlot(blue)

        let correctColorsFeedback: Feedback = evaluator.evaluate(guess)

        #expect(correctColorsFeedback.inCorrectPosition == 0)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }
}
