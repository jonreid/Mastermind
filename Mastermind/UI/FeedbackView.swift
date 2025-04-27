import SwiftUI

struct FeedbackView: View {
    let feedbackPegs: [FeedbackPeg]

    var body: some View {
        Grid {
            GridRow {
                pegView(0)
                pegView(1)
            }
            GridRow {
                pegView(2)
                pegView(3)
            }
        }
    }

    private func pegView(_ index: Int) -> some View {
        FeedbackPegView2(feedbackPeg: feedbackPegs[index])
            .accessibilityIdentifier("feedback\(index + 1)")
    }
}

private struct FeedbackPegView2: View {
    let feedbackPeg: FeedbackPeg

    var body: some View {
        Circle()
            .foregroundColor(feedbackPeg.feedbackColor())
            .frame(width: 10, height: 10)
            .overlay(
                Circle()
                    .stroke(feedbackPeg.colorAroundPegToShowThatPegIsFilled(), lineWidth: 3)
            )
    }
}

#Preview {
    FeedbackView(feedbackPegs: [.correct, .misplaced, .misplaced, .empty])
        .background(Color.blue)
}
