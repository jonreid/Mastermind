import SwiftUI

@main
struct ProductionApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                GameScreen()
            }
        }
    }

    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
