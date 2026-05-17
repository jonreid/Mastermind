---
name: discovery-tree
description: Visualizes tasks as a Discovery Tree using Mermaid diagrams. Use when planning or tracking multi-step work with parent and child task relationships.
license: MIT
metadata:
  author: Jon Reid
  version: "1.0"
---

# Discovery Tree

STARTER_CHARACTER = 🌲

## Description

Visualize tasks as a Discovery Tree, where subtasks are child nodes.

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

Mark the chosen story as `in-progress`. Change all parent nodes to `in-progress` as well, except the root `parent-task`.

### Step 7: Complete

When the task is done:
- Mark it as `complete`
- Ask the user: "Any new stories to add next to this one?"
- If not, go up one level in the tree
- Loop back to Step 4

## Optional Features

### Side Notes

A side note is a free-floating box not connected to the tree. Use it for reminders, open questions, or context that isn't a task. Only add when the user requests one.

Trigger phrases (examples):
- "Add a note to the discovery tree"
- "Add a side note to the discovery tree"

To add a side note:
- Declare a node with a unique id, e.g. `note-1["Check API rate limits"]`
- Apply the `notes` class: `class note-1 notes`
- Optionally anchor it near another node with an invisible link: `parent-node ~~~ note-1` (no visible edge is drawn)
- Place side notes after the legend block and before the `classDef` block

#### Layout: max 5 per row

Limit each row of side notes to 5; stack additional notes in new rows below.

- Group every 5 notes into an invisible subgraph with `direction LR` and a blank label, e.g. `subgraph note-row-1[" "]`
- Chain notes inside a row with invisible links: `note-1 ~~~ note-2 ~~~ note-3 ~~~ note-4 ~~~ note-5`
- Chain rows top-to-bottom with invisible links: `note-row-1 ~~~ note-row-2`
- Hide each row's border: `style note-row-1 fill:none,stroke:none`
- Always close each subgraph with `end`

Example (8 notes → row of 5, then row of 3):

```
subgraph note-row-1[" "]
    direction LR
    note-1 ~~~ note-2 ~~~ note-3 ~~~ note-4 ~~~ note-5
end
subgraph note-row-2[" "]
    direction LR
    note-6 ~~~ note-7 ~~~ note-8
end
note-row-1 ~~~ note-row-2
style note-row-1 fill:none,stroke:none
style note-row-2 fill:none,stroke:none
```
