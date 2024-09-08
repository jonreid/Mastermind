struct Guess {
    let code: [Int?]

    init(secretSize: Int) {
        code = Array(repeating: nil, count: secretSize)
    }
}
