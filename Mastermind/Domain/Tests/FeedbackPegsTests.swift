@testable import Mastermind
import Testing

final class FeedbackPegsTests: @unchecked Sendable {
    @Test(arguments: [
        (1, [FeedbackPeg.empty]),
        (2, [FeedbackPeg.empty, FeedbackPeg.empty]),
    ])
    func nothingCorrectYet(totalCount: Int, expected: [FeedbackPeg]) async throws {
        let feedback = Feedback(totalCount: totalCount, inCorrectPosition: 0, inWrongPosition: 0)

        let feedbackPegs = FeedbackPegs(feedback)

        #expect(feedbackPegs.pegs == expected)
    }

    @Test
    func perfectMatch() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 2, inWrongPosition: 0)

        let feedbackPegs = FeedbackPegs(feedback)

        #expect(feedbackPegs.pegs == [.correct, .correct])
    }

    @Test
    func rightColorsInWrongPositions() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 0, inWrongPosition: 2)

        let feedbackPegs = FeedbackPegs(feedback)

        #expect(feedbackPegs.pegs == [.misplaced, .misplaced])
    }
}
