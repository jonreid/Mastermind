import SwiftUI

struct GameScreen: TestableView {
    @State private var game: Game
    @State private var guess1: CodeChoice?
    var viewInspectorHook: ((Self) -> Void)?

    init(game: Game) {
        self.game = game
    }

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            HStack {
                CodeGuessView(guess: $guess1)
                VStack {
                    ForEach(game.codeChoices.reversed(), id: \.codeValue) { codeChoice in
                        CodeChoiceView(codePeg: codeChoice, id: codeChoice.codeValue, guess: $guess1)
                    }
                }
                .id("codeChoices")
            }
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

private struct CodeGuessView: View {
    @Binding var guess: CodeChoice?

    var body: some View {
        Button(action: {}, label: {
            Circle()
                .padding(10)
                .overlay(
                    Circle()
                        .strokeBorder(Color.unselected, lineWidth: 2)
                )
                .foregroundColor(guess?.color ?? Color.unselected)
                .frame(width: 100, height: 100)
        })
        .id("guess1")
    }
}

private struct CodeChoiceView: View {
    var codePeg: CodeChoice
    var id: Int
    @Binding var guess: CodeChoice?

    var body: some View {
        Button(action: {
            guess = codePeg
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
        .id(id)
    }
}

#Preview {
    return GameScreen(game: try! Game(numberOfCodeChoices: 1))
}
