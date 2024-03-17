import SwiftUI

struct ContentView: View {
    var body: some View {
        Circle().fill(.red).id("id")
    }
}

#Preview {
    ContentView()
}
