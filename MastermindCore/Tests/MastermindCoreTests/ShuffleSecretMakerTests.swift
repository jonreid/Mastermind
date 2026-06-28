@testable import MastermindCore
import Testing

final class ShuffleSecretMakerTests: @unchecked Sendable {
    @Test
    func `secret has 4 values each in range 1 to 6`() async throws {
        let secret = ShuffleSecretMaker().make()

        #expect(secret.choices.count == 4)
        #expect(secret.choices.allSatisfy { (1 ... 6).contains($0.value) })
    }

    @Test
    func `secret has no repeated values`() async throws {
        let secret = ShuffleSecretMaker().make()

        let values = secret.choices.map(\.value)
        #expect(Set(values).count == values.count)
    }

    @Test
    func `secret is random`() async throws {
        let first = ShuffleSecretMaker().make()
        var second = ShuffleSecretMaker().make()

        if first.choices == second.choices {
            second = ShuffleSecretMaker().make()
        }

        #expect(first.choices != second.choices)
    }
}
