@testable import Mastermind
import XCTest
import ViewInspector
import SwiftUI

@MainActor
final class GameScreenTests: XCTestCase {
    private func load(_ sut: inout GameScreen, using: @escaping ((InspectableView<ViewType.View<GameScreen>>) throws -> Void)) {
        let expectation = sut.on(\.viewInspectorHook, perform: using)
        ViewHosting.host(view: sut)
        wait(for: [expectation], timeout: 0.01)
    }
    
    func test_tappingCircleTurnsItOrange() throws {
        var sut = GameScreen()
        var color = try sut.inspect().button().labelView().shape().foregroundColor()
        XCTAssertNotEqual(color, Color.orange, "Precondition")

        load(&sut) { view in
            try view.button().tap()
            color = try view.button().labelView().shape().foregroundColor()
        }

        XCTAssertEqual(color, Color.orange)
    }
}
