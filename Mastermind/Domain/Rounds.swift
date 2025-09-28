final class Rounds {
    private let rounds: [Round]

    init(secretSize: Int, numberOfRounds: Int) {
        self.rounds = (1...numberOfRounds).map {
            round in Round(secretSize: secretSize, roundNumber: round)
        }
    }

    var count: Int { rounds.count }

    func round(_ index: Int) -> Round {
        rounds[index]
    }
}
