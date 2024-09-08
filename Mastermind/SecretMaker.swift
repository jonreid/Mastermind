struct Secret {
    let code: [CodeChoice]
}

struct SecretMaker {
    static func createNull() -> SecretMaker {
        var secretMaker = SecretMaker()
        secretMaker.isNull = true
        return secretMaker
    }

    private var isNull = false

    func makeSecret(from codeChoices: CodeChoices, secretSize: Int) -> Secret {
        let colors = isNull ? codeChoices.options : codeChoices.options.shuffled()
        return Secret(code: colors)
    }
}
