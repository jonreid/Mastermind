import SwiftUI

struct GameScreen: TestableView {
    @State private var game: Game
    @State private var guess: Guess
    var viewInspectorHook: ((Self) -> Void)?

    init(game: Game) {
        self.game = game
        game.makeNewSecret()
        guess = Guess(secretSize: game.secretSize)
    }

    var body: some View {
        Color.background.ignoresSafeArea().overlay {
            HStack {
                CodeGuessView(guess: $guess)
                CodeChoicesView(game: $game, guess: $guess)
            }
        }
        .inspectableSheet(isPresented: .constant(guess.isComplete), content: {
            if (game.secret.matches(guess)) {
                Text("You win!")
            } else {
                Text("You lose! The secret was \(game.secret.code[0].color.description)")
            }
        })
        .onAppear { self.viewInspectorHook?(self) }
    }
}

private struct CodeGuessView: View {
    @Binding var guess: Guess

    var body: some View {
        HStack {
            ForEach(0 ..< guess.size, id: \.self) { index in
                Button(action: {}, label: {
                    Circle()
                        .padding(10)
                        .overlay(
                            Circle()
                                .strokeBorder(Color.unselected, lineWidth: 2)
                        )
                        .foregroundColor(guess[index]?.color ?? Color.unselected)
                        .frame(width: 100, height: 100)
                })
                .id("guess\(index + 1)")
            }
        }
    }
}

private struct CodeChoicesView: View {
    @Binding var game: Game
    @Binding var guess: Guess

    var body: some View {
        VStack {
            ForEach(game.codeChoices.lastToFirst, id: \.codeValue) { codeChoice in
                CodeChoiceView(codePeg: codeChoice, codeChoiceId: codeChoice.codeValue, guess: $guess)
            }
        }
        .id("codeChoices")
    }
}

private struct CodeChoiceView: View {
    var codePeg: CodeChoice
    var codeChoiceId: Int
    @Binding var guess: Guess

    var body: some View {
        Button(action: {
            guess.placeChoiceInNextSlot(codePeg)
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: 100, height: 100)
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
    let game = try! Game(numberOfCodeChoices: 2, secretSize: 2, SecretMaker.createNull())
    return GameScreen(game: game)
}
