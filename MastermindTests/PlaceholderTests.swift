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
        try view.inspect().find(viewWithId: "id").shape()
        // test that fill color is red
//        XCTAssertEqual(color, Color.red)
    }
}
