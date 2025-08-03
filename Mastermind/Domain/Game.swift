import SwiftUI

@Observable
final class Game {
    private let secretMaker: SecretMaker
    let secretSize: Int
    let codeChoices: CodeChoices
    var rounds: Rounds
    var secret = Secret(code: [])

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

    func updateFeedbackPegsForGuess() {
        currentGuess.updateFeedbackPegs(for: secret)
    }
}
