@testable import Mastermind
import Testing

final class FeedbackPegsTests: @unchecked Sendable {
    @Test(arguments: [
        (1, [FeedbackPeg.empty]),
        (2, [FeedbackPeg.empty, FeedbackPeg.empty]),
    ])
    func nothingCorrectYet(totalCount: Int, expected: [FeedbackPeg]) async throws {
        let feedback = Feedback(totalCount: totalCount, inCorrectPosition: 0, inWrongPosition: 0)

        #expect(feedback.pegs == expected)
    }

    @Test
    func perfectMatch() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 2, inWrongPosition: 0)

        #expect(feedback.pegs == [.correct, .correct])
    }

    @Test
    func rightColorsInWrongPositions() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 0, inWrongPosition: 2)

        #expect(feedback.pegs == [.misplaced, .misplaced])
    }

    @Test
    func mixtureOfAll() async throws {
        let feedback = Feedback(totalCount: 4, inCorrectPosition: 1, inWrongPosition: 2)

        #expect(feedback.pegs == [.correct, .misplaced, .misplaced, .empty])
    }
}
