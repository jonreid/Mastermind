import SwiftUI

struct CheckButton: View {
    @Environment(\.isEnabled)
    private var isEnabled: Bool

    var body: some View {
        Button(action: {
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(isEnabled ? .blue : .unselected)
                .frame(width: .infinity, height: 100)
                .overlay(
                    Text("Check")
                        .foregroundColor(.white)
                        .font(.subheadline)
                )
        })
        .accessibilityIdentifier("checkButton")
    }
}
