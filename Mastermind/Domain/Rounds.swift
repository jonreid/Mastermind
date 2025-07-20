final class Rounds {
    var guesses: [Round]
    var currentRound: Int = 0

    init(guesses: [Round]) {
        self.guesses = guesses
    }

    var currentGuess: Round {
        guesses[currentRound]
    }
}
