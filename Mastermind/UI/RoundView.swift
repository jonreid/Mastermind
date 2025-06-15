import SwiftUI

struct RoundView: View {
    private let round: Int
    @State private var game: Game
    @State private var feedbackPegs: [FeedbackPeg]

    init(round: Int, game: Game, feedbackPegs: [FeedbackPeg]) {
        self.round = round
        self.game = game
        self.feedbackPegs = feedbackPegs
    }

    var body: some View {
        CodeGuessView(guess: game.currentGuess, round: round)
        FeedbackView(feedbackPegs: feedbackPegs)
    }
}

private struct CodeGuessView: View {
    let guess: Guess
    let round: Int

    var body: some View {
        HStack {
            Text("\(round)").accessibilityIdentifier("roundNumber")
            ForEach(0 ..< guess.size, id: \.self) { index in
                Button(action: {}, label: {
                    Circle()
                        .padding(5)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.unselected, lineWidth: 2)
                        )
                        .foregroundColor(guess[index]?.color ?? Color.unselected)
                        .frame(width: 40, height: 40)
                })
                .id("guess\(round)-\(index + 1)")
            }
        }
    }
}
