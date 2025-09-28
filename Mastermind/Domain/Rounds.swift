final class Rounds {
    private let rounds: [Round]

    init(secretSize: Int, numberOfRounds: Int) {
        self.rounds = (0..<numberOfRounds).map {
            round in Round(secretSize: secretSize, roundNumber: round + 1)
        }
    }

    var count: Int { rounds.count }

    func round(_ index: Int) -> Round {
        rounds[index]
    }
}
