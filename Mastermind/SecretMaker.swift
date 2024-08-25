struct SecretMaker {
    static func createNull() -> SecretMaker {
        var secretMaker = SecretMaker()
        secretMaker.isNull = true
        return secretMaker
    }

    private var isNull = false

    func makeSecret(from codeChoices: CodeChoices) -> [CodeChoice] {
        return isNull ? codeChoices.options : codeChoices.options.shuffled()
    }
}
