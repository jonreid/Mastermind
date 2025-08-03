import SwiftUI

@Observable
final class Game {
    private let secretMaker: SecretMaker
    let secretSize: Int
    let codeChoices: CodeChoices
    var rounds: Rounds
    var secret = Secret(code: [])
    var feedbackPegs: [FeedbackPeg]

    var currentGuess: Round {
        rounds.currentGuess
    }

    var canBeValidated: Bool {
        currentGuess.isComplete
    }

    var isWin: Bool {
        secret.matches(rounds.currentGuess)
    }

    init(numberOfCodeChoices: Int, secretSize: Int, _ secretMaker: SecretMaker) throws {
        self.secretMaker = secretMaker
        self.secretSize = secretSize
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
        rounds = Rounds(rounds: [Round(secretSize: secretSize)])
        self.feedbackPegs = Secret.initialFeedback(size: secretSize).pegs
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

    func feedbackPegsForGuess() -> [FeedbackPeg] {
        feedbackPegs = secret.evaluate(rounds.currentGuess).pegs
        return feedbackPegs
    }
}
