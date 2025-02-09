import SwiftUI

@main
struct ProductionApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                GameScreen(game: try! Game(numberOfCodeChoices: 4, secretSize: 4, SecretMaker()))
            }
        }
    }

    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
