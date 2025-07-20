import Observation

@Observable
final class Round {
    private var code: [CodeChoice?]
    var feedbackPegs: [FeedbackPeg]

    init(secretSize: Int) {
        code = Array(repeating: nil, count: secretSize)
        feedbackPegs = Feedback.initial(size: secretSize).pegs
    }

    var size: Int {
        code.count
    }

    var isComplete: Bool {
        !code.contains { $0 == nil }
    }

    subscript(index: Int) -> CodeChoice? {
        get {
            return code[index]
        }
        set {
            code[index] = newValue
        }
    }

    func placeChoiceInNextSlot(_ choice: CodeChoice) {
        guard let index = code.firstIndex(of: nil) else { return }
        code[index] = choice
    }

    func contains(_ choice: CodeChoice) -> Bool {
        code.contains { $0 == choice }
    }
}
