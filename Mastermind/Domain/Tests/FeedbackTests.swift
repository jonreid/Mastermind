@testable import Mastermind
import Testing

private let red = CodeChoice(color: .red, codeValue: 1)
private let green = CodeChoice(color: .green, codeValue: 2)
private let blue = CodeChoice(color: .blue, codeValue: 3)

struct FeedbackTests {
    @Test(arguments: [([red, green], 2), ([red, green, blue], 3)])
    func totalCountIsSecretSize(code: [CodeChoice], expectedCount: Int) async throws {
        let sut = makeSUT(code: code)

        let feedback = sut.initialFeedback()

        #expect(feedback.totalCount == expectedCount)
    }

    @Test
    func correctPositionInFirstPeg() async throws {
        let sut = makeSUT(code: [red, green])

        let correctColorsFeedback = sut.evaluate(makeGuess(code: [red, red]))

        #expect(correctColorsFeedback.inCorrectPosition == 1)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    @Test
    func correctPositionInSecondPeg() async throws {
        let sut = makeSUT(code: [red, green])

        let correctColorsFeedback = sut.evaluate(makeGuess(code: [green, green]))

        #expect(correctColorsFeedback.inCorrectPosition == 1)
        #expect(correctColorsFeedback.inWrongPosition == 0)
    }

    @Test
    func wrongPosition() async throws {
        let sut = makeSUT(code: [red, green])

        let correctColorsFeedback = sut.evaluate(makeGuess(code: [green, red]))

        #expect(correctColorsFeedback.inCorrectPosition == 0)
        #expect(correctColorsFeedback.inWrongPosition == 2)
    }

    private func makeSUT(code: [CodeChoice]) -> Secret {
        Secret(code: code)
    }

    private func makeGuess(code: [CodeChoice]) -> Guess {
        let guess = Guess(secretSize: code.count)
        for choice in code {
            guess.placeChoiceInNextSlot(choice)
        }
        return guess
    }
}
