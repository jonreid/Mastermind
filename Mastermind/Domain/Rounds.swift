final class Rounds {
    var rounds: [Round]
    var currentRound: Int = 0

    init(rounds: [Round]) {
        self.rounds = rounds
    }

    var currentGuess: Round {
        rounds[currentRound]
    }
}
