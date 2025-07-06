struct Feedback {
    let totalCount: Int
    let inCorrectPosition: Int
    let inWrongPosition: Int

    static func initial(size: Int) -> Feedback {
        Feedback(totalCount: size, inCorrectPosition: 0, inWrongPosition: 0)
    }

    var pegs: [FeedbackPeg] {
       var result: [FeedbackPeg] = []
       result.append(contentsOf: Array.init(repeating: .correct, count: inCorrectPosition))
       result.append(contentsOf: Array.init(repeating: .misplaced, count: inWrongPosition))
       result.append(
           contentsOf: Array.init(
               repeating: .empty,
               count: totalCount - inCorrectPosition - inWrongPosition
           )
       )
       return result
   }
}
