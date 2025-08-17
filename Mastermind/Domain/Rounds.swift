final class Rounds {
    var rounds: [Round]

    init(rounds: [Round]) {
        self.rounds = rounds
    }

    func round(_ index: Int) -> Round {
        rounds[index]
    }
}
