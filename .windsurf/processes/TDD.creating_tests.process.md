# TDD Creating Tests Process

STARTER_CHARACTER = 🔴

**ALWAYS** ask the user one question at a time and wait for a response.

**ALWAYS** confirm file names and locations if unsure.

**NEVER** make changes to production code in this process.

This process is for creating unit tests for a new feature or bug fix. All production code changes will happen later.

## Steps

1. Ask if we are starting new work or resuming work in progress. If resuming, ask which step to continue from and display the steps.
2. Ask if we are creating a new feature or fixing a bug.
3. Ask for an example scenario (this can be a file or a description).
4. Suggest a list of test scenarios (titles only) to cover. Confirm with the user.
5. Create the test file (or confirm the file in use). Validate the name and location.
6. Write the outer test functions for each scenario (titles only, no implementation), all commented out.
7. Validate the test list with the user.
8. Commit.

**Tip:** When resuming, always clarify which step you are on and offer to show the steps.

---

This process is designed for clarity and speed — focus on writing tests in the way you want to use the feature, even before the implementation exists.
