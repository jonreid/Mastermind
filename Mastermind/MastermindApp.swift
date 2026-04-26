import SwiftUI

@main
struct MastermindApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                Placeholder()
            }
        }
    }

    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
