final class Rounds {
    var rounds: [Round]
    var currentRound: Int = 0

    init(guesses: [Round]) {
        self.rounds = guesses
    }

    var currentGuess: Round {
        rounds[currentRound]
    }
}
