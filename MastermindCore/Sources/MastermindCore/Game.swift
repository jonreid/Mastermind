struct Game {
    var secret: Secret?

    mutating func playNewGame() {
        secret = ShuffleSecretMaker().make()
    }
}
