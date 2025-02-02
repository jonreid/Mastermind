struct FeedbackPegs {
    private let feedback: Feedback

    init(_ feedback: Feedback) {
        self.feedback = feedback
    }

    var pegs: [FeedbackPeg] {
        Array.init(repeating: .empty, count: feedback.totalCount)
    }
}

enum FeedbackPeg {
    case empty
}
