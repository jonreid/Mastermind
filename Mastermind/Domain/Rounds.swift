final class Rounds {
    private let rounds: [Round]

    init(secretSize: Int, numberOfRounds: Int) {
        self.rounds = (0..<numberOfRounds).map { _ in Round(secretSize: secretSize) }
    }

    func round(_ index: Int) -> Round {
        rounds[index]
    }
}
