import SwiftUI

struct RoundView: View {
    private var game: Game
    private let roundNumber: RoundNumber

    init(game: Game, roundNumber: RoundNumber = RoundNumber(value: 1)) {
        self.game = game
        self.roundNumber = roundNumber
    }

    var body: some View {
        HStack {
            CodeGuessView(round: game.rounds.round(roundNumber))
            FeedbackView(feedbackPegs: game.rounds.round(roundNumber).feedbackPegs)
        }
    }
}
