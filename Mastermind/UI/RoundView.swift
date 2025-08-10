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
            CodeGuessView(guess: game.rounds.round(0), roundNumber: roundNumber)
            FeedbackView(feedbackPegs: game.rounds.round(0).feedbackPegs)
        }
    }
}

private struct CodeGuessView: View {
    let guess: Round
    let roundNumber: Int

    var body: some View {
        HStack {
            Text("\(roundNumber + 1)").accessibilityIdentifier("roundNumber")
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
                .id("guess\(roundNumber + 1)-\(index + 1)")
            }
        }
    }
}
