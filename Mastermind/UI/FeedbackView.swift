import SwiftUI

struct FeedbackView: View {
    let feedbackPegs: [FeedbackPeg]

    func feedbackColor(for peg: FeedbackPeg) -> Color {
        switch peg {
        case .empty:
            return .Pegs.unselected
        case .correct:
            return .Pegs.correct
        case .misplaced:
            return .Pegs.misplaced
        }
    }

    var body: some View {
        Grid {
            GridRow
            {
                FeedbackPegView(feedbackPegs: feedbackPegs, pegIndex: 0)
                Circle()
                    .foregroundColor(feedbackColor(for: feedbackPegs[1]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback2")
            }
            GridRow {
                Circle()
                    .foregroundColor(feedbackColor(for: feedbackPegs[2]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback3")
                Circle()
                    .foregroundColor(feedbackColor(for: feedbackPegs[3]))
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback4")
            }
        }
    }
}

private struct FeedbackPegView: View {
    let feedbackPegs: [FeedbackPeg]
    let pegIndex: Int

    var body: some View {
        Circle()
            .foregroundColor(feedbackColor(for: feedbackPegs[pegIndex]))
            .frame(width: 10, height: 10)
            .accessibilityIdentifier("feedback\(pegIndex + 1)")
    }

    private func feedbackColor(for peg: FeedbackPeg) -> Color {
        switch peg {
        case .empty:
            return .Pegs.unselected
        case .correct:
            return .Pegs.correct
        case .misplaced:
            return .Pegs.misplaced
        }
    }
}

#Preview {
    FeedbackView(feedbackPegs: [.correct, .misplaced, .misplaced, .empty])
        .background(Color.blue)
}
