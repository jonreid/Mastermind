@testable import MastermindCore
import Testing

final class EvaluatorTests: @unchecked Sendable {
    // [TEST] all wrong returns no clues
    // [TEST] one right color wrong position returns 1 misplaced
    // [TEST] two right colors wrong positions returns 2 misplaced
    // [TEST] one right color right position returns 1 correct
    // [TEST] two right colors right positions returns 2 correct
    // [TEST] two misplaced and two correct returns 2 correct, 2 misplaced
    // [TEST] all correct returns 4 correct
}
