# TDD Refactoring Process

STARTER_CHARACTER = 🟣

**ALWAYS** ask the user one question at a time and wait for a response.

**ALWAYS** confirm file names and locations if unsure.

**NEVER** make changes to both production code and test code in this process.

This process is for refactoring production code, or for refactoring test code. Never both.


## Running tests when refactoring

- When we are in the refactoring phase, **always** ask the user to run tests in Xcode because it's faster. If it fails, the user will ask you to run them in the terminal.
- Ask the user to do this by getting their attention with your voice, saying "Run the tests in Xcode"

## Steps
Confirm the relevant test file and its location before starting.

For each refactoring:

1. Ask the user if we are refactoring production code or test code.
2. Ask the user to check that tests pass before the change.
3. Choose and perform the simplest possible refactoring (one at a time).
4. Ask the user to confirm that tests pass after the change.
5. Ask if the user is ready to commit, or if they want to make more changes and go back to step 2. 
6. Provide a status update after each refactor.

If a refactoring fails three times or no further refactoring is found, pause and check with the user.

## Code Style
- Prefer self-explanatory, readable code over comments.
- Use functional helper methods for clarity.
- Remove comments and dead code.
- Extract paragraphs into methods.
- Use better variable names.
- Remove unused imports.
- Remove unhelpful local variables.
