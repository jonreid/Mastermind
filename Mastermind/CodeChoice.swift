import SwiftUI

struct CodeChoice: Equatable {
    let color: Color
    let codeValue: Int
}

struct CodeChoices {
    let options: [CodeChoice]
}

enum CodeChoiceGeneratorError: Error {
    case notEnoughColors
}

struct CodeChoiceGenerator {
    static func generate2(from colors: [Color], take count: Int) throws -> CodeChoices {
        guard colors.count >= count else {
            throw CodeChoiceGeneratorError.notEnoughColors
        }
        let result = colors.prefix(count).enumerated().map { index, color in
            CodeChoice(color: color, codeValue: index + 1)
        }
        return CodeChoices(options: result)
    }

}

let codeColors: [Color] = [.brown, .black, .blue, .green, .yellow, .orange, .red, .gray]
