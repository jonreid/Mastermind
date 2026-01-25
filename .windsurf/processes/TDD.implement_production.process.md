# TDD Production Code Implementation Process

STARTER_CHARACTER = 🟢

**ALWAYS** ask the user one question at a time and wait for a response.

**ALWAYS** confirm file names and locations if unsure.

**NEVER** make changes to Test code in this process.

This process is for implementing production code for a new feature or bug fix.


## Steps
1. If needed, confirm the relevant test file and its location.
2. Repeat the following until all tests pass:
   - Uncomment one test and implement it.
   - Run the tests.
   - Identify the first failing test.
   - Show test results and ask to inspect the failure.
   - Implement only the production code necessary to make that test pass.
   - Run the tests again.
   - After each successful run, ask me if I would like to commit.
3. When all tests pass, recommend a final commit or review.

## Code Style
- Prefer code that is self-explanatory and easy to read over comments.
- Use functional helper methods instead of long methods.

## SwiftUI Testing Approach

For SwiftUI tests, work in two phases:
1. **Phase 1:** Focus on finding the target element/subview - getting this to pass is sufficient work
2. **Phase 2:** Once the element is found, write the remaining test code to query and verify it
