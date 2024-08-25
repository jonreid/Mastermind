@testable import Mastermind
import XCTest

final class SecretMakerTests: XCTestCase {
    private var codeChoices: CodeChoices!

    override func setUpWithError() throws {
        try super.setUpWithError()
        codeChoices = try CodeChoiceGenerator.generate(from: codeColors, take: 8)
    }

    func test_nullable() throws {
        let sut = SecretMaker.createNull()

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result.options, codeChoices.options)
    }

    func test_containsAllCodeChoices() throws {
        let sut = SecretMaker()

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result.options.count, codeChoices.options.count)
        XCTAssertTrue(
            codeChoices.options.allSatisfy({ result.options.contains($0) }),
            "Expected \(result.options.map(\.color)) to contain all elements of \(codeChoices.options.map(\.color))"
        )
    }

    func test_shufflesCodeChoices() throws {
        let sut = SecretMaker()

        for _ in 0..<100 {
            let result = sut.makeSecret(from: codeChoices)
            if result.options != codeChoices.options {
                return
            }
        }
        XCTFail("Failed to shuffle code choices after 100 attempts")
    }
}
