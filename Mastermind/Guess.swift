struct Guess {
    let code: [CodeChoice?]

    init(secretSize: Int) {
        code = Array(repeating: nil, count: secretSize)
    }
}
