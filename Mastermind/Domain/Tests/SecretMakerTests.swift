@testable import Mastermind
import XCTest

final class SecretMakerTests: XCTestCase {
    func test_nullable() throws {
        let codeChoices = try makeCodeChoices()
        let sut = SecretMaker.createNull()

        let result = sut.makeSecret(from: codeChoices, secretSize: 8)

        XCTAssertEqual(result.testHooks.code, codeChoices.options)
    }

    func test_useSecretSize() throws {
        let codeChoices = try makeCodeChoices()
        let sut = SecretMaker.createNull()

        let result = sut.makeSecret(from: codeChoices, secretSize: 2)

        XCTAssertEqual(result.testHooks.code, Array(codeChoices.options.prefix(2)))
    }

    func test_containsAllCodeChoices() throws {
        let codeChoices = try makeCodeChoices()
        let sut = SecretMaker()

        let result = sut.makeSecret(from: codeChoices, secretSize: 8)

        XCTAssertEqual(result.testHooks.code.count, codeChoices.options.count)
        XCTAssertTrue(
            codeChoices.options.allSatisfy({ result.testHooks.code.contains($0) }),
            "Expected \(result.testHooks.code.map(\.color)) to contain all elements of \(codeChoices.options.map(\.color))"
        )
    }

    func test_shufflesCodeChoices() throws {
        let codeChoices = try makeCodeChoices()
        let sut = SecretMaker()

        for _ in 0..<100 {
            let result = sut.makeSecret(from: codeChoices, secretSize: 8)
            if result.testHooks.code != codeChoices.options {
                return
            }
        }
        XCTFail("Failed to shuffle code choices after 100 attempts")
    }

    private func makeCodeChoices() throws -> CodeChoices {
        return try CodeChoiceGenerator.generate(from: codeColors, take: 8)
    }
}
