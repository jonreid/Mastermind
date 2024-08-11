import SwiftUI

struct CodeChoice: Equatable {
    let color: Color
let codeValue: Int
}

enum CodeChoiceGeneratorError: Error {
    case notEnoughColors
}

struct CodeChoiceGenerator {
    static func generate(from colors: [Color], take count: Int) throws -> [CodeChoice] {
        guard colors.count >= count else {
            throw CodeChoiceGeneratorError.notEnoughColors
        }
        return colors.prefix(count).enumerated().map { index, color in
            CodeChoice(color: color, codeValue: index + 1)
        }
    }
}

let codeColors: [Color] = [.brown, .black, .blue, .green, .yellow, .orange, .red, .gray]

final class Game {
    let codeChoices: [CodeChoice]
    var secret: [CodeChoice] = []

    init(numberOfCodeChoices: Int, _ secretMaker: SecretMaker) throws {
        try codeChoices = CodeChoiceGenerator.generate(from: codeColors, take: numberOfCodeChoices)
    }

    func isGuessCorrect(_ guess: [CodeChoice]) -> Bool {
        return secret == guess
    }
}
