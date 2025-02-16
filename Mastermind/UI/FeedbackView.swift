import SwiftUI

struct FeedbackView: View {
    let feedbackPegs: [FeedbackPeg]

    func feedbackColor(for peg: FeedbackPeg) -> Color {
        switch peg {
        case .empty:
            return .unselected
        case .correct:
            return .purple
        case .misplaced:
            return .orange
        }
    }

    var body: some View {
        Grid {
            GridRow {
                Circle()
                    .foregroundColor(Color.unselected)
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback1")
                Circle()
                    .foregroundColor(Color.unselected)
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback2")
            }
            GridRow {
                Circle()
                    .foregroundColor(Color.unselected)
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback3")
                Circle()
                    .foregroundColor(Color.unselected)
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback4")
            }
        }
    }
}
