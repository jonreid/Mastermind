import SwiftUI

struct CodeChoice: Equatable {
    let color: Color
    let codeValue: Int
}

struct CodeChoiceGenerator {
    static func generate(from colors: [Color], take count: Int) throws -> [CodeChoice] {
//        guard colors.count >= count else {
//            throw CodeChoiceGeneratorError.notEnoughColors
//        }
        return colors.prefix(count).enumerated().map { index, color in
            CodeChoice(color: color, codeValue: 1)
        }
    }
}

let codeChoice1 = CodeChoice(color: .brown, codeValue: 1)
//let codeChoice2 = CodeChoice(color: .black, codeValue: 2)
let codeChoices = [codeChoice1]
