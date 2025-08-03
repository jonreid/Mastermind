import Observation

@Observable
final class Round {
    private var guess: [CodeChoice?]
    var feedbackPegs: [FeedbackPeg]

    init(secretSize: Int) {
        guess = Array(repeating: nil, count: secretSize)
        feedbackPegs = Feedback.initial(size: secretSize).pegs
    }

    var size: Int {
        guess.count
    }

    var isComplete: Bool {
        !guess.contains { $0 == nil }
    }

    subscript(index: Int) -> CodeChoice? {
        get {
            return guess[index]
        }
        set {
            guess[index] = newValue
        }
    }

    func placeChoiceInNextSlot(_ choice: CodeChoice) {
        guard let index = guess.firstIndex(of: nil) else { return }
        guess[index] = choice
    }

    func contains(_ choice: CodeChoice) -> Bool {
        guess.contains { $0 == choice }
    }

    func updateFeedbackPegs(for secret: Secret) {
        feedbackPegs = secret.evaluate(self).pegs
    }
}
