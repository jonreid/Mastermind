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

private struct CodeGuessView: View {
    let round: Round

    var body: some View {
        HStack {
            Text("\(round.roundNumber.value)").accessibilityIdentifier("roundNumber")
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
                .id("guess\(round.roundNumber.value)-\(index + 1)")
            }
        }.accessibilityIdentifier("round\(round.roundNumber.value)")
    }
}
