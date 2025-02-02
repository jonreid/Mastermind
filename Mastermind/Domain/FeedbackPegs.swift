struct FeedbackPegs {
    private let feedback: Feedback

    init(_ feedback: Feedback) {
        self.feedback = feedback
    }

    var pegs: [FeedbackPeg] {
        var result: [FeedbackPeg] = []

        // Fill in correct pegs
        result.append(contentsOf: Array.init(repeating: .correct, count: feedback.inCorrectPosition))

        // Fill in misplaced pegs

        // Fill in empty
        result.append(contentsOf: Array.init(repeating: .empty, count: feedback.totalCount - feedback.inCorrectPosition))

        return result
    }
}

enum FeedbackPeg {
    case empty
    case correct
}
