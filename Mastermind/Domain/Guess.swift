import Observation

@Observable
final class Guess {
    private var code: [CodeChoice?]

    init(secretSize: Int, initialFeedbackPegs: [FeedbackPeg] = []) {
        code = Array(repeating: nil, count: secretSize)
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
