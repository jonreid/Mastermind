import SwiftUI

final class Rounds {
    var guesses: [Guess]
    var currentRound: Int = 0

    init(guesses: [Guess]) {
        self.guesses = guesses
    }
}

@Observable
final class Game {
    private let secretMaker: SecretMaker
    private let secretSize: Int
    let codeChoices: CodeChoices
    var rounds: Rounds

    var guess: [Guess] {
        get { rounds.guesses }
        set { rounds.guesses = newValue }
    }

    var secret = Secret(code: [])

    var isComplete: Bool {
        guess[0].isComplete
    }

    var isWin: Bool {
        secret.matches(guess[0])
    }

    init(numberOfCodeChoices: Int, secretSize: Int, _ secretMaker: SecretMaker) throws {
        self.secretMaker = secretMaker
        self.secretSize = secretSize
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
        rounds = Rounds(guesses: [Guess(secretSize: secretSize)])
    }

    func codeChoice(_ index: Int) -> CodeChoice {
        return codeChoices.options[index]
    }

    func makeNewSecret() {
        secret = secretMaker.makeSecret(from: codeChoices, secretSize: secretSize)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        secret.isGuessCorrect(guess)
    }

    func initialFeedbackPegs() -> [FeedbackPeg] {
        secret.initialFeedback().pegs
    }

    func feedbackPegsForGuess() -> [FeedbackPeg] {
        secret.evaluate(guess[0]).pegs
    }
}
