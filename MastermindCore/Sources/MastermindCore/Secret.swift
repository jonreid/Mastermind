struct Secret {
    let choices: [CodeChoice]

    static func createNull(_ choices: [CodeChoice]) -> Self {
        Self(choices: choices)
    }

    static func create() -> Self {
        ShuffleSecretMaker().make()
    }
}
