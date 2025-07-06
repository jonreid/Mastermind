struct Secret: CustomStringConvertible {
    private let code: [CodeChoice]

    static func initialFeedback(size: Int) -> Feedback {
        Feedback(
            totalCount: size,
            inCorrectPosition: 0,
            inWrongPosition: 0
        )
    }

    init(code: [CodeChoice]) {
        self.code = code
    }

    var description: String {
        code.map(\.color.description).joined(separator: ", ")
    }

    var size: Int {
        code.count
    }

    func evaluate(_ guess: Guess) -> Feedback {
        var inCorrectPosition = 0
        var inWrongPosition = 0
        for (index, secret) in code.enumerated() {
            if guess[index] == secret {
                inCorrectPosition += 1
            } else if guess.contains(secret) {
                inWrongPosition += 1
            }
        }
        return Feedback(
            totalCount: size,
            inCorrectPosition: inCorrectPosition,
            inWrongPosition: inWrongPosition
        )
    }


    func matches(_ guess: Guess) -> Bool {
        guard code.count == guess.size else {
            return false
        }
        for (index, secret) in code.enumerated() {
            if guess[index] != secret {
                return false
            }
        }
        return true
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return code == guess
    }
}

#if DEBUG
extension Secret {
    var testHooks: TestHooks { TestHooks(target: self) }

    struct TestHooks {
        private let target: Secret

        fileprivate init(target: Secret) {
            self.target = target
        }

        var code: [CodeChoice] { target.code }
    }
}
#endif
