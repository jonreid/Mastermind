import SwiftUI

@Observable
final class Game {
    private let secretMaker: SecretMaker
    let secretSize: Int
    let codeChoices: CodeChoices
    var rounds: Rounds
    var secret = Secret(code: [])

    var canBeValidated: Bool {
        rounds.round(RoundNumber(value: 1)).isComplete
    }

    var isWin: Bool {
        secret.matches(rounds.round(RoundNumber(value: 1)))
    }

    init(numberOfCodeChoices: Int, secretSize: Int, numberOfRounds: Int, _ secretMaker: SecretMaker) throws {
        self.secretMaker = secretMaker
        self.secretSize = secretSize
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
        rounds = Rounds(secretSize: secretSize, numberOfRounds: numberOfRounds)
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

    func score() {
        rounds.round(RoundNumber(value: 1)).score(for: secret)
    }
}
