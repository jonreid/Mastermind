import SwiftUI

struct FeedbackView: View {
    let feedbackPegs: [FeedbackPeg]

    var body: some View {
        Grid {
            GridRow {
                Circle()
                    .fill(Color.unselected)
                    .frame(width: 10, height: 10)
                    .accessibilityIdentifier("feedback1")
                Circle().fill(Color.unselected).frame(width: 10, height: 10)
            }
            GridRow {
                Circle().fill(Color.unselected).frame(width: 10, height: 10)
                Circle().fill(Color.unselected).frame(width: 10, height: 10)
            }
        }
    }
}
