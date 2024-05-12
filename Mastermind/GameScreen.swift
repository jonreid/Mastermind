import SwiftUI

struct CodePeg {
    var color: Color
}

let codePeg1 = CodePeg(color: .blue)
let backgroundColor = Color(red: 246/255, green: 248/255, blue: 250/255)

struct GameScreen: View {
    @State private var guess1: CodePeg?
    var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            HStack {
                Button(action: {}, label: {
                    Circle().foregroundColor(guess1?.color ?? .red)
                })
                .id("guess1")
                CodeChoiceView(codePeg: codePeg1, id: "color1", guess: $guess1)
            }
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

private
struct CodeChoiceView: View {
    var codePeg: CodePeg
    var id: String
    @Binding var guess: CodePeg?

    var body: some View {
        Button(action: {
            guess = codePeg
        }, label: {
            Circle().foregroundColor(codePeg.color)
        })
        .id(id)
    }
}

#Preview {
    GameScreen()
}
