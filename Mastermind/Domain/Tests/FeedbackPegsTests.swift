@testable import Mastermind
import Testing

final class FeedbackPegsTests: @unchecked Sendable {
    private let red = CodeChoice(color: .red, codeValue: 1)
    private let green = CodeChoice(color: .green, codeValue: 2)
    private let blue = CodeChoice(color: .blue, codeValue: 3)

    @Test
    func numberOfPegsIsCodeLength() async throws {
        let secretCode = [red, green, blue]
        let expectedCount = 3

        let secret = Secret(code: secretCode)

        let feedbackPegs = FeedbackPegs(secret: secret)

        #expect(feedbackPegs.count == expectedCount)
    }
}
