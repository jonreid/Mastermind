struct Evaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> [Clue] {
        guess.choices.contains(where: secret.choices.contains) ? [.misplaced] : []
    }
}
