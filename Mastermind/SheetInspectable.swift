import SwiftUI

extension View {
    func sheetInspectable<Sheet>(isPresented: Binding<Bool>, onDismiss: (() -> Void)? = nil, @ViewBuilder content: @escaping () -> Sheet
    ) -> some View where Sheet: View {
        return self.modifier(InspectableSheet(isPresented: isPresented, onDismiss: onDismiss, popupBuilder: content))
    }
}

struct InspectableSheet<Sheet>: ViewModifier where Sheet: View {

    let isPresented: Binding<Bool>
    let onDismiss: (() -> Void)?
    let popupBuilder: () -> Sheet

    func body(content: Self.Content) -> some View {
        content.sheet(isPresented: isPresented, onDismiss: onDismiss, content: popupBuilder)
    }
}
