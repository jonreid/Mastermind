@testable import Mastermind
import XCTest
import ViewInspector
import SwiftUI

@MainActor
final class GameScreenTests: XCTestCase {
    func test_tappingCircleTurnsItOrange() throws {
        var sut = GameScreen()
        var color = try sut.inspect().button().labelView().shape().foregroundColor()
        XCTAssertNotEqual(color, Color.orange, "Precondition")

        sut.on(\.didAppear) { view in
            try view.button().tap()

            color = try view.button().labelView().shape().foregroundColor()
        }

        ViewHosting.host(view: sut)
        XCTAssertEqual(color, Color.orange)
    }
}
