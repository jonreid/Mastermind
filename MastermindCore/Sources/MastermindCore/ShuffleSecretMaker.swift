struct ShuffleSecretMaker: SecretMaking {
    func make() -> Secret {
        let values = (1 ... 6).shuffled().prefix(4).map(CodeChoice.init)
        return Secret(choices: values)
    }
}
