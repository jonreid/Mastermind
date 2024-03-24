@testable import Mastermind
import XCTest
import ViewInspector
import SwiftUI

@MainActor
final class GameScreenTests: XCTestCase {
    func test_circleIsRed() throws {
        let view = GameScreen()

        let color = try view.inspect().shape().foregroundColor()

        XCTAssertEqual(color, Color.red)
    }
}
