import SwiftUI

struct CodePeg {
    var color: Color
}

let codePeg1 = CodePeg(color: .blue)
let backgroundColor = Color(
    red: 227/255,
    green: 231/255,
    blue: 234/255
)
let unselectedColor = Color(
    red: 185/255,
    green: 195/255,
    blue: 198/255
)

struct GameScreen: View {
    @State private var guess1: CodePeg?
    var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            HStack {
                CodeGuessView(guess: $guess1)
                CodeChoiceView(codePeg: codePeg1, id: "color1", guess: $guess1)
            }
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

private struct CodeGuessView: View {
    @Binding var guess: CodePeg?

    var body: some View {
        Button(action: {}, label: {
            Circle()
                .foregroundColor(guess?.color ?? unselectedColor)
                .frame(width: 100, height: 100)
        })
        .id("guess1")
    }
}

private struct CodeChoiceView: View {
    var codePeg: CodePeg
    var id: String
    @Binding var guess: CodePeg?

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
