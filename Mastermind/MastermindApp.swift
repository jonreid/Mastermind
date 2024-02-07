//
//  MastermindApp.swift
//  Mastermind
//
//  Created by Jon Reid on 2/6/24.
//

import SwiftUI

@main
struct ProductionApp: App {
    var body: some Scene {
        WindowGroup {
            if isProduction {
                ContentView()
            }
        }
    }

    private var isProduction: Bool {
        NSClassFromString("XCTestCase") == nil
    }
}
