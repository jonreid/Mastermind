final class Rounds {
    var rounds: [Round]
    var roundNumber: Int = 0

    init(rounds: [Round]) {
        self.rounds = rounds
    }

    var currentGuess: Round {
        rounds[roundNumber]
    }
}
