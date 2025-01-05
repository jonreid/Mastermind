@testable import Mastermind
import SnapshotTesting
import SwiftUI
import Testing

@MainActor
final class CheckButtonSnapshotTests: @unchecked Sendable {
    @Test
    func disabledColor() async throws {
        let view = CheckButton().disabled(true)
        assertSnapshot(of: view.toVC(), as: .image)
    }

    @Test
    func enabledColor() async throws {
        let view = CheckButton().disabled(false)
        assertSnapshot(of: view.toVC(), as: .image)
    }
}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
