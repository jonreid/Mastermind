struct FeedbackEvaluator {
    init(_ secret: Secret) {}

    func evaluate(_ guess: Guess) -> Feedback {
        Feedback(inCorrectPosition: 0, inWrongPosition: 0)
    }
}
