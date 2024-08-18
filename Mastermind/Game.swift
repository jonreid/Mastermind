import SwiftUI

final class Game {
    let codeChoices: CodeChoices

    var secret: [CodeChoice] = []

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
    }

    func codeChoice(_ index: Int) -> CodeChoice {
        return codeChoices.options[index]
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
