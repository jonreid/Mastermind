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
}
