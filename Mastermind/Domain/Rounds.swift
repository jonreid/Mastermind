final class Rounds {
    var rounds: [Round]
    var currentRoundNumber: Int = 0

    init(rounds: [Round]) {
        self.rounds = rounds
    }

    func round(at index: Int) -> Round {
        rounds[index]
    }
}
