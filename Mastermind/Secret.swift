struct Secret {
    let code: [CodeChoice]

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
