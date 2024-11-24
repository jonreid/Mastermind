struct FeedbackEvaluator {
    private let secret: Secret

    init(_ secret: Secret) {
        self.secret = secret
    }

    func evaluate(_ guess: Guess) -> Feedback {
        var inCorrectPosition = 0
        var inWrongPosition = 0
        for (index, secret) in secret.code.enumerated() {
            if guess[index] == secret {
                inCorrectPosition += 1
            } else if guess.contains(secret) {
                inWrongPosition += 1
            }
        }
        return Feedback(inCorrectPosition: inCorrectPosition, inWrongPosition: inWrongPosition)
    }
}
