import SwiftUI

struct Key {
    var color: Color
}

let key1 = Key(color: .blue)

struct GameScreen: View {
    @State private var buttonColor = Color.red
    @State private var guess1: Key?
    internal var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        HStack {
            Button(action: {
            }, label: {
                Circle().foregroundColor(buttonColor)
            })
            .id("guess1")
            Button(action: {
                buttonColor = .blue
                guess1 = key1
            }, label: {
                Circle().foregroundColor(guess1?.color ?? .red)
            })
            .id("color1")
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

#Preview {
    GameScreen()
}
