final class Rounds {
    var rounds: [Round]
    var currentRoundNumber: Int = 0

    init(rounds: [Round]) {
        self.rounds = rounds
    }

    var currentRound: Round {
        rounds[currentRoundNumber]
    }
}
