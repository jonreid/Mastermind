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

        let expectation = sut.on(\.didAppear) { view in
            try view.button().tap()

            color = try view.button().labelView().shape().foregroundColor()
        }
        ViewHosting.host(view: sut)
        wait(for: [expectation], timeout: 0.01)

        XCTAssertEqual(color, Color.orange)
    }
}
