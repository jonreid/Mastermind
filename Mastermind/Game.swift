final class Game {
    private var _codeChoices: [CodeChoice] = []
    var codeChoices: [CodeChoice] {
        get {
            return _codeChoices
        }
        set {
            _codeChoices = newValue
        }
    }

    var secret: [CodeChoice] = []

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
    }

    func makeNewSecret() {
//        secret = secretMaker.makeSecret(from: codeChoices)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return secret == guess
    }
}
