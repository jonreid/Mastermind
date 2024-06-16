import SwiftUI

struct CodeChoice {
    var color: Color
}

let codeChoice1 = CodeChoice(color: .blue)

struct GameScreen: View {
    @State private var guess1: CodeChoice?
    var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            HStack {
                CodeGuessView(guess: $guess1)
                CodeChoiceView(codePeg: codeChoice1, id: "color1", guess: $guess1)
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
    var id: String
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
    GameScreen()
}
