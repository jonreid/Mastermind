import SwiftUI

struct RoundView: View {
    private var game: Game
    private let roundIndex: Int

    init(game: Game, roundIndex: Int = 0) {
        self.game = game
        self.roundIndex = roundIndex
    }

    var body: some View {
        HStack {
            CodeGuessView(guess: game.rounds.round(roundIndex))
            FeedbackView(feedbackPegs: game.rounds.round(roundIndex).feedbackPegs)
        }
    }
}

private struct CodeGuessView: View {
    let guess: Round

    var body: some View {
        HStack {
            Text("\(guess.roundNumber + 1)").accessibilityIdentifier("roundNumber")
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
                .id("guess\(guess.roundNumber + 1)-\(index + 1)")
            }
        }
    }
}
