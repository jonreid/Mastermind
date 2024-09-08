import SwiftUI

final class Game {
    private let secretMaker: SecretMaker
    let codeChoices: CodeChoices

    var secret = Secret(code: [])

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        self.secretMaker = secretMaker
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
    }

    func codeChoice(_ index: Int) -> CodeChoice {
        return codeChoices.options[index]
    }

    func makeNewSecret() {
        secret = secretMaker.makeSecret(from: codeChoices, secretSize: 2)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return secret.code == guess
    }
}
