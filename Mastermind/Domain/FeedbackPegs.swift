struct FeedbackPegs {
    private let feedback: Feedback

    init(_ feedback: Feedback) {
        self.feedback = feedback
    }

    var pegs: [FeedbackPeg] {
        var result: [FeedbackPeg] = []

        // Fill in correct pegs
        for _ in 0 ..< feedback.inCorrectPosition {
            result.append(.correct)
        }
        // Fill in misplaced pegs

        // Fill in empty
        for _ in 0 ..< feedback.totalCount - feedback.inCorrectPosition {
            result.append(.empty)
        }

        return result
    }
}

enum FeedbackPeg {
    case empty
    case correct
}
