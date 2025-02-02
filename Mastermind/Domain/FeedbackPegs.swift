struct FeedbackPegs {
    private let feedback: Feedback

    init(_ feedback: Feedback) {
        self.feedback = feedback
    }

    var pegs: [FeedbackPeg] {
        applesauce(feedback: feedback)
    }
}

 func applesauce(feedback: Feedback) ->  [FeedbackPeg] {
    var result: [FeedbackPeg] = []
    result.append(contentsOf: Array.init(repeating: .correct, count: feedback.inCorrectPosition))
    result.append(contentsOf: Array.init(repeating: .misplaced, count: feedback.inWrongPosition))
    result.append(
        contentsOf: Array.init(
            repeating: .empty,
            count: feedback.totalCount - feedback.inCorrectPosition - feedback.inWrongPosition
        )
    )
    return result
}


enum FeedbackPeg {
    case empty
    case correct
    case misplaced
}
