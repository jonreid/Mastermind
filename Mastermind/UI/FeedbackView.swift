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
                    .foregroundColor(feedbackColor(for: feedbackPegs[0]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback1")
                Circle()
                    .foregroundColor(feedbackColor(for: feedbackPegs[0]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback2")
            }
            GridRow {
                Circle()
                    .foregroundColor(feedbackColor(for: feedbackPegs[0]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback3")
                Circle()
                    .foregroundColor(feedbackColor(for: feedbackPegs[0]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback4")
            }
        }
    }
}
