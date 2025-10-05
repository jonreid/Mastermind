@testable import Mastermind
import Testing

private let red = CodeChoice(color: .red, codeValue: 1)
private let green = CodeChoice(color: .green, codeValue: 2)
private let blue = CodeChoice(color: .blue, codeValue: 3)

struct FeedbackTests {
    @Test(arguments: [([red, green], 2), ([red, green, blue], 3)])
    func initialCountIsSecretSize(code: [CodeChoice], expectedCount: Int) async throws {
        let feedback = Feedback.initial(size: code.count)

        #expect(feedback.totalCount == expectedCount)
    }

    @Test
    func correctPositionInFirstPeg() async throws {
        let sut = makeSUT(code: [red, green])

        let correctColorsFeedback = sut.evaluate(makeGuess(code: [red, red]))

        #expect(correctColorsFeedback.totalCount == 2)
        #expect(correctColorsFeedback.inCorrectPosition == 1)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    @Test
    func correctPositionInSecondPeg() async throws {
        let sut = makeSUT(code: [red, green])

        let correctColorsFeedback = sut.evaluate(makeGuess(code: [green, green]))

        #expect(correctColorsFeedback.totalCount == 2)
        #expect(correctColorsFeedback.inCorrectPosition == 1)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    @Test
    func wrongPosition() async throws {
        let sut = makeSUT(code: [red, green])

        let correctColorsFeedback = sut.evaluate(makeGuess(code: [green, red]))

        #expect(correctColorsFeedback.totalCount == 2)
        #expect(correctColorsFeedback.inCorrectPosition == 0)
        #expect(correctColorsFeedback.inWrongPosition == 2)
    }

    @Test(arguments: [
        (1, [FeedbackPeg.empty]),
        (2, [FeedbackPeg.empty, FeedbackPeg.empty]),
    ])
    func nothingCorrectYet(totalCount: Int, expected: [FeedbackPeg]) async throws {
        let feedback = Feedback(totalCount: totalCount, inCorrectPosition: 0, inWrongPosition: 0)

        #expect(feedback.pegs == expected)
    }

    @Test
    func pegs_perfectMatch() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 2, inWrongPosition: 0)

        #expect(feedback.pegs == [.correct, .correct])
    }

    @Test
    func pegs_rightColorsInWrongPositions() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 0, inWrongPosition: 2)

        #expect(feedback.pegs == [.misplaced, .misplaced])
    }

    @Test
    func pegs_mixtureOfAll() async throws {
        let feedback = Feedback(totalCount: 4, inCorrectPosition: 1, inWrongPosition: 2)

        #expect(feedback.pegs == [.correct, .misplaced, .misplaced, .empty])
    }

    private func makeSUT(code: [CodeChoice]) -> Secret {
        Secret(code: code)
    }

    private func makeGuess(code: [CodeChoice]) -> Round {
        let guess = Round(secretSize: code.count, roundNumber: RoundNumber(value: 1))
        for choice in code {
            guess.placeChoiceInNextSlot(choice)
        }
        return guess
    }
}
