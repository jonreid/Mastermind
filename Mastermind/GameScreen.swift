import SwiftUI

struct GameScreen: View {
    @State private var buttonColor = Color.red
    internal var viewInspectorHook: ((Self) -> Void)?

    var body: some View {
        VStack {
            Button(action: {
                buttonColor = .orange
            }, label: {
                Circle().foregroundColor(buttonColor)
            })
            .id("guess1")
        }
        .onAppear { self.viewInspectorHook?(self) }
    }
}

#Preview {
    GameScreen()
}
