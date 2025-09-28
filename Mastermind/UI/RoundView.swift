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
            CodeGuessView(round: game.rounds.round(roundIndex))
            FeedbackView(feedbackPegs: game.rounds.round(roundIndex).feedbackPegs)
        }
    }
}

private struct CodeGuessView: View {
    let round: Round
    private var humanReadableRoundNumber: Int { round.roundNumber }

    var body: some View {
        HStack {
            Text("\(humanReadableRoundNumber)").accessibilityIdentifier("roundNumber")
            ForEach(0 ..< round.size, id: \.self) { index in
                Button(action: {}, label: {
                    Circle()
                        .padding(5)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.unselected, lineWidth: 2)
                        )
                        .foregroundColor(round[index]?.color ?? Color.unselected)
                        .frame(width: 40, height: 40)
                })
                .id("guess\(humanReadableRoundNumber)-\(index + 1)")
            }
        }.accessibilityIdentifier("round\(humanReadableRoundNumber)")
    }
}
