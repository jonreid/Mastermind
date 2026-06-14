struct Secret {
    let choices: [CodeChoice]

    static func createNull(_ choices: [CodeChoice]) -> Self {
        Self(choices: choices)
    }

    static func create() -> Self {
        let values = (1 ... 6).shuffled().prefix(4).map(CodeChoice.init)
        return Self(choices: values)
    }
}
