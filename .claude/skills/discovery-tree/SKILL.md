# Discovery Tree

STARTER_CHARACTER = 🌳

## Description

Visualize tasks as a discovery tree, where subtasks are child nodes.

## Steps

### Step 1: Open File

Open `discovery-tree.md`.

If it doesn't exist, create it:
- Start with `graph TD`
- Ask the user: "What is the parent task?"
- Add the parent node with class `parent-task`
- Add classDefs:

```
classDef parent-task fill:#f4f6f8
classDef todo fill:#fef7aa
classDef in-progress fill:#f4b87f
classDef completed fill:#8add95
classDef blocked fill:#f1a2a0
classDef punt fill:#b5abf4
classDef notes fill:#b8cffa
```

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
