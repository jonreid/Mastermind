import SwiftUI

struct RoundView: View {
    @State private var game: Game
    @State private var feedbackPegs: [FeedbackPeg]

    init(round: Int, game: Game, feedbackPegs: [FeedbackPeg]) {
        self.game = game
        self.feedbackPegs = feedbackPegs
    }

    var body: some View {
        CodeGuessView(guess: game.currentGuess)
        FeedbackView(feedbackPegs: feedbackPegs)
    }
}

private struct CodeGuessView: View {
    var guess: Guess

    var body: some View {
        HStack {
            Text("1").accessibilityIdentifier("roundNumber")
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
                .id("guess\(index + 1)")
            }
        }
    }
}
