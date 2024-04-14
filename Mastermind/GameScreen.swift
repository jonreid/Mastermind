import SwiftUI

struct GameScreen: View {
    @State private var buttonColor = Color.red
    internal var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        Button(action: {
            buttonColor = .orange
        }, label: {
            Circle().foregroundColor(buttonColor)
        })
        .onAppear { self.viewInspectorHook?(self) }
    }
}

#Preview {
    GameScreen()
}
