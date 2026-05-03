# Discovery Tree

STARTER_CHARACTER = 🌳

## Description

Visualize tasks as a discovery tree, where subtasks are child nodes.

## Steps

### Step 1: Open File

Open `discovery-tree.md`.

If it doesn't exist, create it:
- Ask the user: "What is the parent task?"
- Use the template in `references/template-discovery-tree.md`, replacing `parent-node` and `Parent Task` with the parent task

### Step 2: Constraint

The root `parent-task` node is never modified.

### Step 3: Review

Ask the user to review the current tree. Any new stories to add?

### Step 4: Find Next Task

Find the next `todo` story to work on. Ask the user to confirm.

Keep stories ordered left-to-right in the diagram.

### Step 5: Sync Names

Keep node names and user story labels in sync.

### Step 6: Mark as In-Progress

Mark the chosen story as `todo`. Change all parent nodes to `todo` as well, except the root `parent-task`.

### Step 7: Complete

When the task is done:
- Mark it as `complete`
- Ask the user: "Any new stories to add next to this one?"
- If not, go up one level in the tree
- Loop back to Step 4
