struct FeedbackEvaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> Feedback {
        secret.evaluate(guess)
    }
}
