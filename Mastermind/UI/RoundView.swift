import SwiftUI

struct RoundView: View {
    private let roundNumber: Int
    private var game: Game
    private let feedbackPegs: [FeedbackPeg]

    init(roundNumber: Int, game: Game, feedbackPegs: [FeedbackPeg]) {
        self.roundNumber = roundNumber
        self.game = game
        self.feedbackPegs = feedbackPegs
    }

    var body: some View {
        HStack {
            CodeGuessView(guess: game.currentGuess, roundNumber: roundNumber)
            FeedbackView(feedbackPegs: feedbackPegs)
        }
    }
}

private struct CodeGuessView: View {
    let guess: Round
    let roundNumber: Int

    var body: some View {
        HStack {
            Text("\(roundNumber)").accessibilityIdentifier("roundNumber")
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
                .id("guess\(roundNumber)-\(index + 1)")
            }
        }
    }
}
