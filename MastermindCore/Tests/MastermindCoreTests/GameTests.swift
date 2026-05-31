@testable import MastermindCore
import Testing

@Test
func `CodeChoice with same value are equal`() async throws {
    let first = CodeChoice(1)
    let second = CodeChoice(1)

    #expect(first == second)
}

@Test
func `CodeChoices with different values are not equal`() async throws {
    let first = CodeChoice(1)
    let second = CodeChoice(2)

    #expect(first != second)
}

// [TEST] Secret holds 4 CodeChoices
// [TEST] createNull returns a Secret built from the given choices
// [TEST] create returns a Secret with 4 distinct values in range 1...6
// [TEST] playNewGame stores a secret on the game
