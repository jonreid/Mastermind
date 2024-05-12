import SwiftUI

struct CodePeg {
    var color: Color
}

let codePeg1 = CodePeg(color: .blue)

struct GameScreen: View {
    @State private var guess1: CodePeg?
    internal var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        HStack {
            Button(action: {
            }, label: {
                Circle().foregroundColor(guess1?.color ?? .red)
            })
            .id("guess1")
            CodeChoiceView(codePeg: codePeg1, id: "color1", guess: $guess1)
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

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
