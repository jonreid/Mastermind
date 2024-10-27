import Observation

@Observable
class Guess {
    private var code: [CodeChoice?]

    init(secretSize: Int) {
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
}
