@testable import Mastermind
import SnapshotTesting
import SwiftUI
import Testing

@MainActor
final class CheckButtonSnapshotTests: @unchecked Sendable {
    @Test
    func disabledColor() async throws {
        let view = CheckButton().disabled(true)
        assertSnapshot(of: view.toVC(), as: prettyDarnClose())
    }

    @Test
    func enabledColor() async throws {
        let view = CheckButton().disabled(false)
        assertSnapshot(of: view.toVC(), as: prettyDarnClose())
    }

    private func prettyDarnClose() -> Snapshotting<UIViewController, UIImage> {
        .image(precision: 0.99)
    }
}

extension SwiftUI.View {
    func toVC() -> UIViewController {
        let vc = UIHostingController(rootView: self)
        vc.view.frame = UIScreen.main.bounds
        return vc
    }
}
