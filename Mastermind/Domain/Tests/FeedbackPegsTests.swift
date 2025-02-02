@testable import Mastermind
import Testing

final class FeedbackPegsTests: @unchecked Sendable {
    @Test func feedbackCount() async throws {
        let feedback = Feedback(totalCount: 2, inCorrectPosition: 0, inWrongPosition: 0)

        let feedbackPegs = FeedbackPegs(feedback)

        #expect(feedbackPegs.pegs == [.empty, .empty])
    }
}
