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

@Test
func `Secret holds 4 CodeChoices`() async throws {
    let choices = [CodeChoice(1), CodeChoice(2), CodeChoice(3), CodeChoice(4)]

    let secret = Secret(choices: choices)

    #expect(secret.choices.count == 4)
}

@Test
func `createNull returns a Secret built from the given choices`() async throws {
    let choices = [CodeChoice(1), CodeChoice(2), CodeChoice(3), CodeChoice(4)]

    let secret = Secret.createNull(choices)

    #expect(secret.choices == choices)
}

// [TEST] create returns a Secret with 4 distinct values in range 1...6
// [TEST] playNewGame stores a secret on the game
