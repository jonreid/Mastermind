struct FeedbackPegs {
    init(_ feedback: Feedback) {
    }

    var pegs: [FeedbackPeg] {
        [.empty, .empty]
    }
}

enum FeedbackPeg {
    case empty
}
