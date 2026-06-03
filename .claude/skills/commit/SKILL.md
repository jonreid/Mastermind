---
name: commit
description: Standardized process for creating meaningful git commits using Arlo's notation
---

# Code Commit Workflow

STARTER_CHARACTER = 💾

## Description

Standardized process for creating meaningful Git commits using Arlo's notation.

## Steps

1. **Summarize Changes**

2. **Update Discovery Tree**

If project has discovery-tree.md:
- If changes are refactoring only and there is no refactoring step, skip to step 3 (draft commit message)
- Otherwise use discovery-tree skill to summarize task state
- Ask user what to change in discovery tree, if anything. Wait for response.

3. **Draft Commit Message**
- Read [Arlo's Commit Notation](~/.claude/skills/commit/references/commit-messages-arlo-belshee.md)
- **ALWAYS** ask the programmer to approve the commit message

4. **Commit**
- Stage files if necessary
