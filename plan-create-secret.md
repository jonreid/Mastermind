# Plan: Play New Game — Creates Secret

## Context

Implementing the first use case in Mastermind. When a new game starts, the game generates a `Secret`: an ordered sequence of 4 distinct `CodeChoice` values (integers 1–6). The `SecretMaker` infrastructure wrapper follows the Nullables pattern — `create()` uses randomness, `createNull()` takes hard-coded choices for tests. The `Game` coordinates between them per A-Frame Architecture.

## Types

- `CodeChoice` — value type wrapping `Int` in 1...6
- `Secret` — value type holding exactly 4 distinct `CodeChoice` values
- `SecretMaker` — infrastructure wrapper (Nullable)
- `Game` — application layer, takes `SecretMaker`, exposes `playNewGame()`

## TDD Order

1. `CodeChoice` — pure value, test equality and range
2. `Secret` — pure value, test it holds 4 CodeChoices
3. `SecretMaker.createNull()` — returns fixed `Secret` from hard-coded input
4. `SecretMaker.create()` — narrow integration test: valid `Secret` (4 values, no repeats, in 1...6)
5. `Game.playNewGame()` — test using `SecretMaker.createNull()`

## Key Design

```swift
// Infrastructure wrapper (SecretMaker.swift)
struct SecretMaker {
    private let makeSecret: () -> Secret

    static func create() -> SecretMaker {
        SecretMaker { Secret(randomChoices()) }
    }

    static func createNull(_ values: [Int] = [1, 2, 3, 4]) -> SecretMaker {
        SecretMaker { Secret(values.map(CodeChoice.init)) }
    }

    private init(_ makeSecret: @escaping () -> Secret) {
        self.makeSecret = makeSecret
    }

    func makeNewSecret() -> Secret { makeSecret() }

    private static func randomChoices() -> [CodeChoice] {
        var pool = Array(1...6)
        return (0..<4).map { _ in
            CodeChoice(pool.remove(at: Int.random(in: 0..<pool.count)))
        }
    }
}

// Application layer (Game.swift)
struct Game {
    private let secretMaker: SecretMaker
    private(set) var secret: Secret?

    init(secretMaker: SecretMaker) {
        self.secretMaker = secretMaker
    }

    mutating func playNewGame() {
        secret = secretMaker.makeNewSecret()
    }
}
```

## Files

- `MastermindCore/Sources/MastermindCore/CodeChoice.swift` — new
- `MastermindCore/Sources/MastermindCore/Secret.swift` — new
- `MastermindCore/Sources/MastermindCore/SecretMaker.swift` — new
- `MastermindCore/Sources/MastermindCore/Game.swift` — new
- `MastermindCore/Tests/MastermindCoreTests/GameTests.swift` — new (primary test file)
- `MastermindCore/Sources/MastermindCore/Dummy.swift` — delete (replace with real code)
- `MastermindCore/Tests/MastermindCoreTests/DummyTests.swift` — delete

## Test Example

```swift
// GameTests.swift
@Test func playNewGame_createsSecret() async throws {
    var game = makeGame()
    game.playNewGame()
    #expect(game.secret == Secret([1, 2, 3, 4].map(CodeChoice.init)))
}

func makeGame() -> Game {
    Game(secretMaker: .createNull([1, 2, 3, 4]))
}
```

## Verification

Run `./test_core.sh` after each TDD step — all tests must pass before moving to next type.
