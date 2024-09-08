class Guess {
    var code: [CodeChoice?]

    init(secretSize: Int) {
        code = Array(repeating: nil, count: secretSize)
    }

    func setGuessAt(_ index: Int, _ choice: CodeChoice) {
        code[index] = choice
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
