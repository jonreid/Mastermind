struct Game {
    var secret: Secret?

    mutating func playNewGame() {
        secret = Secret.create()
    }
}
