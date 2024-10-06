struct SecretMaker {
    static func createNull() -> SecretMaker {
        var secretMaker = SecretMaker()
        secretMaker.isNull = true
        return secretMaker
    }

    private var isNull = false

    func makeSecret(from codeChoices: CodeChoices, secretSize: Int) -> Secret {
        assert(0 < secretSize)
        assert(secretSize <= codeChoices.options.count)

        let colors = isNull ? codeChoices.options : codeChoices.options.shuffled()
        return Secret(code: Array(colors.prefix(secretSize)))
    }
}
