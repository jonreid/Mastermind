import SwiftUI

struct RoundView: View {
    private let roundNumber: Int
    private var game: Game

    init(roundNumber: Int, game: Game) {
        self.roundNumber = roundNumber
        self.game = game
    }

    var body: some View {
        HStack {
            CodeGuessView(guess: game.currentRound, roundNumber: roundNumber)
            FeedbackView(feedbackPegs: game.currentRound.feedbackPegs)
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
