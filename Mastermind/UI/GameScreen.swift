import SwiftUI

struct GameScreen: TestableView {
    @State private var game: Game
    @State private var feedbackPegs: [FeedbackPeg]

    var viewInspectorHook: ((Self) -> Void)?

    init(game: Game) {
        self.game = game
        game.makeNewSecret()
        self.feedbackPegs = game.initialFeedbackPegs()
    }

    var body: some View {
        Color.background.ignoresSafeArea().overlay {
            HStack {
                ForEach(1...1, id: \.self) { round in
                    RoundView(round: round, game: game, feedbackPegs: feedbackPegs)
                }
                VStack {
                    CodeChoicesView(game: $game)
                    CheckButton(action: { feedbackPegs = game.feedbackPegsForGuess() })
                        .disabled(!game.canBeValidated)
                }
                .frame(width: 50)
            }
        }
        .inspectableSheet(isPresented: .constant(false), content: {
            if (game.isWin) {
                Text("You win!")
            } else {
                Text("You lose! The secret was \(game.secret)")
            }
        })
        .onAppear { self.viewInspectorHook?(self) }
    }
}

private struct CodeChoicesView: View {
    @Binding var game: Game

    var body: some View {
        VStack {
            ForEach(game.codeChoices.lastToFirst, id: \.codeValue) { codeChoice in
                CodeChoiceView(codePeg: codeChoice, codeChoiceId: codeChoice.codeValue, guess: game.rounds.currentGuess)
            }
        }
        .accessibilityIdentifier("codeChoices")
    }
}

private struct CodeChoiceView: View {
    var codePeg: CodeChoice
    var codeChoiceId: Int
    var guess: Guess

    var body: some View {
        Button(action: {
            guess.placeChoiceInNextSlot(codePeg)
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: .infinity)
                .aspectRatio(contentMode: .fit)
                .overlay(
                    Circle()
                        .foregroundColor(codePeg.color)
                        .padding(10)
                )
        })
        .id(codeChoiceId)
    }
}

private extension CodeChoices {
    var lastToFirst: [CodeChoice] {
        return options.reversed()
    }
}

#Preview {
    let game = try! Game(numberOfCodeChoices: 4, secretSize: 4, SecretMaker.createNull())
    return GameScreen(game: game)
}
