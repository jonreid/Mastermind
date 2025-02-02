struct FeedbackPegs {
    private let feedback: Feedback

    init(_ feedback: Feedback) {
        self.feedback = feedback
    }

    var pegs: [FeedbackPeg] {
        feedback.pegs
    }
}

enum FeedbackPeg {
    case empty
    case correct
    case misplaced
}
