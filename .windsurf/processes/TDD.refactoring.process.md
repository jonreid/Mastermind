# TDD Production Code Refactoring Process

STARTER_CHARACTER = 🟣

**ALWAYS** ask the user one question at a time and wait for a response.

**ALWAYS** confirm file names and locations if unsure.

**NEVER** make changes to Test code in this process.

This process is for refactoring production code.


## Running tests when refactoring

- When we are in the refactoring phase, **always** ask me to run tests in Xcode because it's faster. If it fails, I will ask you to run them in the terminal.
- Ask me to do this by getting my attention with your voice, saying "Run the tests in Xcode"

## Steps
Confirm the relevant test file and its location before starting.

For each refactoring:

1. Ask me to check that tests pass before the change.
2. Choose and perform the simplest possible refactoring (one at a time).
3. Ask me to confirm that tests pass after the change.
4. Ask if I am ready to commit, or if I want to make more changes and go back to step 2. 
5. Provide a status update after each refactor.
˙
If a refactoring fails three times or no further refactoring is found, pause and check with the user.

## Code Style
- Prefer self-explanatory, readable code over comments.
- Use functional helper methods for clarity.
- Remove comments and dead code.
- Extract paragraphs into methods.
- Use better variable names.
- Remove unused imports.
- Remove unhelpful local variables.
