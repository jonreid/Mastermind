@testable import MastermindCore
import Testing

final class GameTests: @unchecked Sendable {
    @Test
    func `new game has no secret`() async throws {
        let game = Game()

        #expect(game.secret == nil)
    }

    @Test
    func `starting a new game creates a secret code`() async throws {
        var game = Game()

        game.playNewGame()

        #expect(game.secret != nil)
    }
}
