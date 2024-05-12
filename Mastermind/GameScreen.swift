import SwiftUI

struct CodePeg {
    var color: Color
}

let codePeg1 = CodePeg(color: .blue)

struct GameScreen: View {
    @State private var buttonColor = Color.red
    @State private var guess1: CodePeg?
    internal var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        HStack {
            Button(action: {
            }, label: {
                Circle().foregroundColor(guess1?.color ?? .red)
            })
            .id("guess1")
            Button(action: {
                guess1 = codePeg1
            }, label: {
                Circle().foregroundColor(codePeg1.color)
            })
            .id("color1")
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

#Preview {
    GameScreen()
}
