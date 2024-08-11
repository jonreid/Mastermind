final class Game {
    let codeChoices: [CodeChoice]
    var secret: [CodeChoice] = []

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return secret == guess
    }
}
