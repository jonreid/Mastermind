# Context Markers

Start every reply with STARTER_CHARACTER: 🍀 by default, or a skill's own STARTER_CHARACTER while that skill is active.
Situational prefixes always stack right after it — ❗️ error/miss, ⭐ recommended option, ❌ rejected option (e.g. "🍀 ⭐", "💾❗️").

# Coding Principles

- Code like Kent Beck
- Be proactive and flag issues before they become a problem
- When reporting information to user, be extremely concise and sacrifice grammar for the sake of concision
- Write readable and expressive code that does not need redundant comments or reasoning why something changed
- Follow Single Responsibility Principle
- Methods should be no longer than 25 lines

## Tests

- Prefer Swift Testing
  - Use natural language test name with back ticks
  - Declare `@Test` functions as `async throws`
  - Avoid `== true` or `== false` when comparing non-optional `Bool`. Use direct value or negated value.

- Fall back to XCTest for ViewInspector and ApprovalTests
  * Declare each test `throws`, starting name with prefix `test_`

- ViewInspector:
- When reviewing `TestableView`-conforming views, skip the data.md rule "State should be marked private." The non-private access is required so tests can read it.

### Names

- Use domain-centric test names, not programmer-centric
- Remove articles from test names

## Decisions

When you need user input on decision:

- First, pick option you think is best and propose it. Start that message with ⭐
- Also list alternatives you rejected, each with brief reason why. Start each with ❌
