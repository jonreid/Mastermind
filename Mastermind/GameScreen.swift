import SwiftUI

struct GameScreen: View {
    @State private var buttonColor = Color.red
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
            }, label: {
                Circle().foregroundColor(.blue)
            })
            .id("color1")
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

#Preview {
    GameScreen()
}
