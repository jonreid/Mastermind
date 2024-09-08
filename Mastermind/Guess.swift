class Guess {
    var code: [CodeChoice?]

    init(secretSize: Int) {
        code = Array(repeating: nil, count: secretSize)
    }

    func setGuessAt(_ index: Int, _ choice: CodeChoice) {
        code[index] = choice
    }
}
