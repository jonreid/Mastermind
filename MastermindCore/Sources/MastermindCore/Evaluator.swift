struct Evaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> [Clue] {
        guess.choices.filter(secret.choices.contains).map { _ in .misplaced }
    }
}
