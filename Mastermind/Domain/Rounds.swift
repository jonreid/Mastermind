final class Rounds {
    var guesses: [Guess]
    var currentRound: Int = 0

    init(guesses: [Guess]) {
        self.guesses = guesses
    }

    var currentGuess: Guess {
        guesses[currentRound]
    }
}
