@testable import Mastermind
import Testing

final class FeedbackPegsTests: @unchecked Sendable {
    private let red = CodeChoice(color: .red, codeValue: 1)
    private let green = CodeChoice(color: .green, codeValue: 2)
    private let blue = CodeChoice(color: .blue, codeValue: 3)

    @Test
    func numberOfPegsIsCodeLength() async throws {
        let secret = Secret(code: [red, green, blue])

        let feedbackPegs = FeedbackPegs(secret: secret)

        #expect(feedbackPegs.count == 3)
    }
}
