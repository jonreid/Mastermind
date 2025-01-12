@testable import Mastermind
import Testing

final class FeedbackPegsTests: @unchecked Sendable {
    @Test
    func numberOfPegsIsCodeLength() async throws {
        let red = CodeChoice(color: .red, codeValue: 1)
        let green = CodeChoice(color: .green, codeValue: 2)
        let blue = CodeChoice(color: .blue, codeValue: 3)
        let secret = Secret(code: [red, green, blue])

        let feedbackPegs = FeedbackPegs(secret: secret)

        #expect(feedbackPegs.count == 3)
    }
}
