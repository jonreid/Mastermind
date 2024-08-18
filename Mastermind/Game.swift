import SwiftUI

final class Game {
    let _codeChoices: CodeChoices

    var secret: [CodeChoice] = []

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        try _codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
    }

    func codeChoice(_ index: Int) -> CodeChoice {
        return _codeChoices.options[index]
    }

    func codeChoiceColor(_ index: Int) -> Color {
        return codeChoice(index).color
    }

    func makeNewSecret() {
//        secret = secretMaker.makeSecret(from: codeChoices)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return secret == guess
    }
}
