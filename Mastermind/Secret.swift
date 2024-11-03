struct Secret: CustomStringConvertible {
    let code: [CodeChoice]

    var description: String {
        code.map(\.color.description).joined(separator: ", ")
    }

    func matches(_ guess: Guess) -> Bool {
        guard code.count == guess.size else {
            return false
        }
        for (index, secret) in code.enumerated() {
            if guess[index] != secret {
                return false
            }
        }
        return true
    }
}
