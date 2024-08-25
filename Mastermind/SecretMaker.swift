struct Secret {
    let code: [CodeChoice]

    init(options: [CodeChoice]) {
        self.code = options
    }
}

struct SecretMaker {
    static func createNull() -> SecretMaker {
        var secretMaker = SecretMaker()
        secretMaker.isNull = true
        return secretMaker
    }

    private var isNull = false

    func makeSecret(from codeChoices: CodeChoices) -> Secret {
        let colors = isNull ? codeChoices.options : codeChoices.options.shuffled()
        return Secret(options: colors)
    }
}
