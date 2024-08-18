final class Game {
    private var _codeChoices: CodeChoices = CodeChoices(options: [])
    var codeChoices: [CodeChoice] {
        get {
            return _codeChoices.options
        }
        set {
            _codeChoices = CodeChoices(options: newValue)
        }
    }

    var secret: [CodeChoice] = []

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices).options
    }

    func makeNewSecret() {
//        secret = secretMaker.makeSecret(from: codeChoices)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return secret == guess
    }
}
