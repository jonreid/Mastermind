import SwiftUI

final class Rounds {
    var guesses: [Guess]
    var currentRound: Int = 0

    init(guesses: [Guess]) {
        self.guesses = guesses
    }

    var currentGuess: Guess {
        guesses[currentRound]
    }

    var currentGuessIsComplete: Bool {
        currentGuess.isComplete
    }
}

@Observable
final class Game {
    private let secretMaker: SecretMaker
    private let secretSize: Int
    let codeChoices: CodeChoices
    var rounds: Rounds
    var secret = Secret(code: [])

    var currentGuess: Guess {
        rounds.currentGuess
    }

    var enableCheckButton: Bool {
        currentGuess.isComplete
    }

    var isWin: Bool {
        secret.matches(rounds.currentGuess)
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
        secret.evaluate(rounds.currentGuess).pegs
    }
}
