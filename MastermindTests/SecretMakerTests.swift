@testable import Mastermind
import XCTest

final class SecretMakerTests: XCTestCase {
    private var codeChoices: [CodeChoice] = []

    override func setUpWithError() throws {
        try super.setUpWithError()
        codeChoices = try CodeChoiceGenerator.generate(from: codeColors, take: 8).options
    }

    func test_nullable() throws {
        let sut = SecretMaker.createNull()

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result, codeChoices)
    }

    func test_containsAllCodeChoices() throws {
        let sut = SecretMaker()

        let result = sut.makeSecret(from: codeChoices)

        XCTAssertEqual(result.count, codeChoices.count)
        XCTAssertTrue(
            codeChoices.allSatisfy({ result.contains($0) }),
            "Expected \(result.map(\.color)) to contain all elements of \(codeChoices.map(\.color))"
        )
    }

    func test_shufflesCodeChoices() throws {
        let sut = SecretMaker()

        for _ in 0..<100 {
            let result = sut.makeSecret(from: codeChoices)
            if result != codeChoices {
                return
            }
        }
        XCTFail("Failed to shuffle code choices after 100 attempts")
    }
}
