class Guess {
    private var code: [CodeChoice?]

    init(secretSize: Int) {
        code = Array(repeating: nil, count: secretSize)
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
