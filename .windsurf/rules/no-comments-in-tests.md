---
trigger: always_on
---

# No Comments in Tests

Tests must be self-explanatory through names, structure, and helpers—without comments. Comments in tests are prohibited.

## Rationale
- Comments in tests often hide unclear intent; we prefer clarity through code.
- Descriptive names and small helpers communicate behavior better than prose.
- Keeps tests tidy and consistent with TDD and Tidy First principles.

## Scope
- Applies to all test sources (unit, UI, integration) across the repository.
- Applies to line comments and block comments (e.g., `//`, `/* ... */`).

## Guidance: Preferred Alternatives
- Use behavior-driven test names that read as specifications.
- Structure tests into clear Arrange–Act–Assert sections using code, not comments.
- Extract expressive helpers and builders to eliminate the need for explanation.
- Use data-driven cases where appropriate to avoid narrative comments.

## Swift Examples

### ❌ Not allowed (uses comments for structure)
```swift
func test_makesNewRowActiveAfterCheck() {
    // Arrange
    let sut = GameScreenViewModel(rounds: .fixture())
    // Act
    sut.check()
    // Assert
    XCTAssertEqual(sut.activeRowIndex, 1)
}
```

### ✅ Allowed (structure via code; no comments)
```swift
func test_makesNewRowActiveAfterCheck() {
    let sut = GameScreenViewModel(rounds: .fixture())
    sut.check()
    XCTAssertEqual(sut.activeRowIndex, 1)
}
```

### ✅ Allowed (expressive helper conveys intent)
```swift
func test_advancesToNextRow_afterCheck() {
    let sut = makeSUTWithSingleUncheckedRow()
    check(sut)
    assertAdvancesToNextRow(sut)
}
```

## Exceptions
- Temporarily allow comments in disabled or quarantined tests marked `@available(*, deprecated)` or `throw XCTSkip` blocks when explaining why the test is skipped. Remove before re-enabling.

## Enforcement
- Code review should reject tests containing comments.
- Linters or scripts may check for comment tokens within test directories.

## Migration
- When encountering commented tests, replace comments by:
  - Renaming tests to describe behavior.
  - Extracting well-named helpers/builders.
  - Reordering code to make Arrange–Act–Assert obvious.

