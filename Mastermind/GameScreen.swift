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
            CodePegForYourGuess(codePeg1: codePeg1, id: "color1", guess1: $guess1)
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

struct CodePegForYourGuess: View {
    var codePeg1: CodePeg
    var id: String
    @Binding var guess1: CodePeg?
    var body: some View {
        Button(action: {
            guess1 = codePeg1
        }, label: {
            Circle().foregroundColor(codePeg1.color)
        })
        .id(id)
    }
}


#Preview {
    GameScreen()
}
