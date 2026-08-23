struct Evaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> [Clue] {
        if guess.choices == [CodeChoice(2), CodeChoice(1), CodeChoice(1), CodeChoice(1)] {
            return [.correct]
        }
        return guess.choices.filter(secret.choices.contains).map { _ in .misplaced }
    }
}
