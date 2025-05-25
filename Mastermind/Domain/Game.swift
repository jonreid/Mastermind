import SwiftUI

@Observable
final class Game {
    private let secretMaker: SecretMaker
    private let secretSize: Int
    let codeChoices: CodeChoices
    var guess: Guess

    var secret = Secret(code: [])

    var isComplete: Bool {
        guess.isComplete
    }

    var isWin: Bool {
        secret.matches(guess)
    }

    init(numberOfCodeChoices: Int, secretSize: Int, _ secretMaker: SecretMaker) throws {
        self.secretMaker = secretMaker
        self.secretSize = secretSize
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
        guess = Guess(secretSize: secretSize)
    }

    func codeChoice(_ index: Int) -> CodeChoice {
        return codeChoices.options[index]
    }

    func makeNewSecret() {
        secret = secretMaker.makeSecret(from: codeChoices, secretSize: secretSize)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        secret.isGuessCorrect(guess)
    }

    func initialFeedbackPegs() -> [FeedbackPeg] {
        secret.initialFeedback().pegs
    }

    func feedbackPegsForGuess() -> [FeedbackPeg] {
        secret.evaluate(guess).pegs
    }
}
