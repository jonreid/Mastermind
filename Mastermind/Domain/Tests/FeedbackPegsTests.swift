@testable import Mastermind
import Testing

private let red = CodeChoice(color: .red, codeValue: 1)
private let green = CodeChoice(color: .green, codeValue: 2)
private let blue = CodeChoice(color: .blue, codeValue: 3)

final class FeedbackPegsTests: @unchecked Sendable {
    @Test(arguments: [([red, green], 2), ([red, green, blue], 3)])
    func numberOfPegsIsCodeLength(secretCode: [CodeChoice], expectedCount: Int) async throws {
        let secret = Secret(code: secretCode)

        let feedbackPegs = FeedbackPegs(secret: secret)

        #expect(feedbackPegs.count == expectedCount)
    }
}
