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
        for guess in code {
            if guess == nil {
                return false
            }
        }
        return true
    }

    subscript(index: Int) -> CodeChoice? {
        get {
            return code[index]
        }
        set {
            code[index] = newValue
        }
    }
}
