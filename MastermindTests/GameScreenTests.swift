@testable import Mastermind
import XCTest
import ViewInspector
import SwiftUI

@MainActor
final class GameScreenTests: XCTestCase {
    private func display(_ sut: inout GameScreen, using: @escaping ((InspectableView<ViewType.View<GameScreen>>) throws -> Void)) {
        let expectation = sut.on(\.viewInspectorHook, perform: using)
        ViewHosting.host(view: sut)
        wait(for: [expectation], timeout: 0.01)
    }
    
    private func getColorOfGuess(_ view: InspectableView<ViewType.View<GameScreen>>) throws -> Color? {
        return try view.button().labelView().shape().foregroundColor()
    }
    
    func test_tappingCircleTurnsItOrange() throws {
        var sut = GameScreen()
        let inspectedView = try sut.inspect()
        var color = try inspectedView.button().labelView().shape().foregroundColor()
        XCTAssertNotEqual(color, Color.orange, "Precondition")

        display(&sut) { view in
            try view.button().tap()
            color = try self.getColorOfGuess(view)
        }

        XCTAssertEqual(color, Color.orange)
    }
}
