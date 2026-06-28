struct Evaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_: Guess) -> [Clue] {
        []
    }
}
