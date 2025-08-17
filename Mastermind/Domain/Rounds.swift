final class Rounds {
    private let rounds: [Round]

    init(secretSize: Int, numberOfRounds: Int) {
        self.rounds = (0..<numberOfRounds).map { roundNumber in Round(secretSize: secretSize, roundNumber: roundNumber) }
    }

    func round(_ index: Int) -> Round {
        rounds[index]
    }
}
