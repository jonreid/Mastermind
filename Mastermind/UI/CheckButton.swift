import SwiftUI

struct CheckButton: View {
    @Environment(\.isEnabled)
    private var isEnabled: Bool

    var body: some View {
        Button(action: {
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(isEnabled ? .blue : .unselected)
                .frame(width: 100, height: 200)
                .overlay(
                    Text("Check")
                        .foregroundColor(.white)
                        .font(.title)
                )
        })
        .accessibilityIdentifier("checkButton")
    }
}
