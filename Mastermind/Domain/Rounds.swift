final class Rounds {
    var rounds: [Round]

    init(secretSize: Int, numberOfRounds: Int = 1) {
        self.rounds = (0..<numberOfRounds).map { _ in Round(secretSize: secretSize) }
    }

    func round(_ index: Int) -> Round {
        rounds[index]
    }
}
