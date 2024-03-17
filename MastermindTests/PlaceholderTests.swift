@testable import Mastermind
import XCTest
import ViewInspector
import SwiftUI

@MainActor
final class PlaceholderTests: XCTestCase {
    func test_circleIsRed() throws {
        // make ContentView
        let view = ContentView()
        // find Circle
        let color = try view.inspect().shape().foregroundColor()
        // test that fill color is red
        XCTAssertEqual(color, Color.red)
    }
}
