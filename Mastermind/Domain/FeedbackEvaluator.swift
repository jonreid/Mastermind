struct FeedbackEvaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> Feedback {
        var inCorrectPosition = 0
        for (index, secret) in secret.code.enumerated() {
            if guess[index] == secret {
                inCorrectPosition += 1
            }
        }
        return Feedback(inCorrectPosition: inCorrectPosition, inWrongPosition: 0)
    }
}
