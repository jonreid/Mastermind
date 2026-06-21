@testable import MastermindCore
import Testing

final class SecretTests: @unchecked Sendable {
    @Test
    func `secret code contains 4 choices`() async throws {
        let choices = [CodeChoice(1), CodeChoice(2), CodeChoice(3), CodeChoice(4)]

        let secret = Secret(choices: choices)

        #expect(secret.choices.count == 4)
    }

    @Test
    func `createNull uses the choices it was given`() async throws {
        let choices = [CodeChoice(1), CodeChoice(2), CodeChoice(3), CodeChoice(4)]

        let secret = Secret.createNull(choices)

        #expect(secret.choices == choices)
    }

    @Test
    func `secret has 4 values each in range 1 to 6`() async throws {
        let secret = Secret.create()

        #expect(secret.choices.count == 4)
        #expect(secret.choices.allSatisfy { (1 ... 6).contains($0.value) })
    }

    @Test
    func `secret has no repeated values`() async throws {
        let secret = Secret.create()

        let values = secret.choices.map(\.value)
        #expect(Set(values).count == values.count)
    }
}
