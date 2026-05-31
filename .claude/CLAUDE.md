# Writing tests

- Prefer Swift Testing
  * Use natural language test name with back ticks
  * Declare each test `async throws`
- Fall back to XCTest
  * For ViewInspector
  * For ApprovalTests
  * Declare each test `throws`

# Running tests

- Core: run ./test_core.sh
- App: Use Xcode MCP
