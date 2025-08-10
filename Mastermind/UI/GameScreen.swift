import SwiftUI

struct GameScreen: TestableView {
    @State private var game: Game

    var viewInspectorHook: ((Self) -> Void)?

    init(game: Game) {
        self.game = game
        game.makeNewSecret()
    }

    var body: some View {
        Color.background.ignoresSafeArea().overlay {
            HStack {
                VStack() {
                    ForEach(0...0, id: \.self) { roundNumber in
                        RoundView(roundNumber: roundNumber, game: game)
                    }
                }
                VStack {
                    CodeChoicesView(game: game)
                    CheckButton(action: { game.score() })
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
    var game: Game

    var body: some View {
        VStack {
            ForEach(game.codeChoices.lastToFirst, id: \.codeValue) { codeChoice in
                CodeChoiceView(codePeg: codeChoice, codeChoiceId: codeChoice.codeValue, guess: game.rounds.round(0))
            }
        }
        .accessibilityIdentifier("codeChoices")
    }
}

private struct CodeChoiceView: View {
    var codePeg: CodeChoice
    var codeChoiceId: Int
    var guess: Round

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
