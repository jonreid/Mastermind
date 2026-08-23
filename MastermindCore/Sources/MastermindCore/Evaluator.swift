struct Evaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> [Clue] {
        let correctCount = zip(guess.choices, secret.choices).filter { $0 == $1 }.count
        let misplacedCount = guess.choices.filter(secret.choices.contains).count - correctCount
        return Array(repeating: .correct, count: correctCount) + Array(repeating: .misplaced, count: misplacedCount)
    }
}
