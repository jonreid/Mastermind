final class Rounds {
    private let rounds: [Round]

    init(secretSize: Int, numberOfRounds: Int) {
        self.rounds = (1...numberOfRounds).map {
            roundNumber in Round(secretSize: secretSize, roundNumber: RoundNumber(value: roundNumber))
        }
    }

    var count: Int { rounds.count }

    func round(_ roundNumber: RoundNumber) -> Round {
        rounds[roundNumber.index]
    }
}
