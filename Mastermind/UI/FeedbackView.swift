import SwiftUI

struct FeedbackView: View {
    let feedbackPegs: [FeedbackPeg]

    var body: some View {
        Grid {
            GridRow {
                FeedbackPegView2(feedbackPeg: feedbackPegs[0], accessibilityID: "feedback\(0 + 1)")
                FeedbackPegView(feedbackPegs: feedbackPegs, pegIndex: 1)
            }
            GridRow {
                FeedbackPegView(feedbackPegs: feedbackPegs, pegIndex: 2)
                FeedbackPegView(feedbackPegs: feedbackPegs, pegIndex: 3)
            }
        }
    }
}

private struct FeedbackPegView: View {
    let feedbackPegs: [FeedbackPeg]
    let pegIndex: Int

    var body: some View {
        Circle()
            .foregroundColor(feedbackPegs[pegIndex].feedbackColor())
            .frame(width: 10, height: 10)
            .overlay(
                Circle()
                    .stroke(feedbackPegs[pegIndex].colorAroundPegToShowThatPegIsFilled(), lineWidth: 3)
            )
            .accessibilityIdentifier("feedback\(pegIndex + 1)")
    }
}

private struct FeedbackPegView2: View {
    let feedbackPeg: FeedbackPeg
    let accessibilityID: String

    var body: some View {
        Circle()
            .foregroundColor(feedbackPeg.feedbackColor())
            .frame(width: 10, height: 10)
            .overlay(
                Circle()
                    .stroke(feedbackPeg.colorAroundPegToShowThatPegIsFilled(), lineWidth: 3)
            )
            .accessibilityIdentifier(accessibilityID)
    }
}

#Preview {
    FeedbackView(feedbackPegs: [.correct, .misplaced, .misplaced, .empty])
        .background(Color.blue)
}
