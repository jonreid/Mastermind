import SwiftUI

@main
struct ProductionApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                GameScreen(game: try! Game(numberOfCodeChoices: 2, secretSize: 2, SecretMaker()))
            }
        }
    }

    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
