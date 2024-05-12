import SwiftUI

struct CodePeg {
    var color: Color
}

let key1 = CodePeg(color: .blue)

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
                guess1 = key1
            }, label: {
                Circle().foregroundColor(key1.color)
            })
            .id("color1")
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

#Preview {
    GameScreen()
}
