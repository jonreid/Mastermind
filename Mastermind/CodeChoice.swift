import SwiftUI

struct CodeChoice: Equatable {
    let color: Color
    let codeValue: Int
}

enum CodeChoiceGeneratorError: Error {
    case notEnoughColors
}

struct CodeChoices: Equatable {
    let options: [CodeChoice]

    subscript(index: Int) -> CodeChoice {
        options[index]
    }
}

struct CodeChoiceGenerator {
    static func generate(from colors: [Color], take count: Int) throws -> CodeChoices {
        guard colors.count >= count else {
            throw CodeChoiceGeneratorError.notEnoughColors
        }
        let primitive = colors.prefix(count).enumerated().map { index, color in
            CodeChoice(color: color, codeValue: index + 1)
        }
        return CodeChoices(options: primitive)
    }
}

let codeColors: [Color] = [.brown, .black, .blue, .green, .yellow, .orange, .red, .gray]
