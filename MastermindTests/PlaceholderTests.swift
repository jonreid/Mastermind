@testable import Mastermind
import XCTest
import ViewInspector
import SwiftUI

@MainActor
final class PlaceholderTests: XCTestCase {
    func test_circleIsRed() throws {
        let view = ContentView()
        let color = try view.inspect().shape().foregroundColor()
        XCTAssertEqual(color, Color.red)
    }
}
