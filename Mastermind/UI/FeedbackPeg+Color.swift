import SwiftUI

extension FeedbackPeg {
    func feedbackColor() -> Color {
        switch self {
        case .empty:
            return .Pegs.unselected
        case .correct:
            return .Pegs.correct
        case .misplaced:
            return .Pegs.misplaced
        }
    }

    func colorAroundPegToShowThatPegIsFilled() -> Color {
        if self == .empty { return Color.clear }
        return feedbackColor()
    }
}
