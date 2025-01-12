@testable import Mastermind
import Testing

struct FeedbackTests {
    private let red = CodeChoice(color: .red, codeValue: 1)
    private let green = CodeChoice(color: .green, codeValue: 2)

    @Test
    func correctPositionInFirstPeg() async throws {
        let evaluator = Secret(code: [red, green])

        let correctColorsFeedback = evaluator.evaluate(makeGuess(code: [red, red]))

        #expect(correctColorsFeedback.inCorrectPosition == 1)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    @Test
    func correctPositionInSecondPeg() async throws {
        let evaluator = Secret(code: [red, green])

        let correctColorsFeedback = evaluator.evaluate(makeGuess(code: [green, green]))

        #expect(correctColorsFeedback.inCorrectPosition == 1)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    @Test
    func wrongPosition() async throws {
        let evaluator = Secret(code: [red, green])

        let correctColorsFeedback = evaluator.evaluate(makeGuess(code: [green, red]))

        #expect(correctColorsFeedback.inCorrectPosition == 0)
        #expect(correctColorsFeedback.inWrongPosition == 2)
    }

    private func makeGuess(code: [CodeChoice]) -> Guess {
        let guess = Guess(secretSize: code.count)
        for choice in code {
            guess.placeChoiceInNextSlot(choice)
        }
        return guess
    }
}
