@testable import Mastermind
import SwiftUI
@testable import ViewInspector
import XCTest

final class GameScreenTests: XCTestCase {
    @MainActor func test_tappingCodeChoiceSetsGuessColor() throws {
        var sut = GameScreen()
        var color = try getColorOfGuess(try sut.inspect())
        let codeChoice = codeChoices[0]
        XCTAssertNotEqual(color, codeChoice.color, "Precondition")

        display(&sut) { view in
            try view.find(viewWithId: codeChoice.codeValue).button().tap()
            color = try self.getColorOfGuess(view)
        }

        XCTAssertEqual(color, codeChoice.color)
    }

    @MainActor private func display(
        _ sut: inout GameScreen,
        using: @escaping ((InspectableView<ViewType.View<GameScreen>>) throws -> Void),
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let expectation = sut.on(\.viewInspectorHook, file: file, line: line, perform: using)
        ViewHosting.host(view: sut)
        wait(for: [expectation], timeout: 0.01)
    }

    private func getColorOfGuess<V: ViewInspector.KnownViewType>(_ view: InspectableView<V>) throws -> Color? {
        try view.asInspectableView().find(viewWithId: "guess1").button().labelView().shape().foregroundColor()
    }
}
