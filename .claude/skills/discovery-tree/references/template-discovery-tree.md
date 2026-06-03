```mermaid
---
title: Project Title
---
graph TD
    subgraph legend["Legend"]
        direction LR
        legend-parent-task["Parent task"] ~~~ legend-todo["To do"] ~~~ legend-in-progress["In progress"] ~~~ legend-completed["Completed"] ~~~ legend-blocked["Blocked"] ~~~ legend-punt["Punt"] ~~~ legend-notes["Notes"]
    end

    parent-node["Parent Task"]

    legend ~~~ parent-node

    classDef parent-task fill:#f4f6f8
    classDef todo fill:#fef7aa
    classDef in-progress fill:#f4b87f
    classDef completed fill:#8add95
    classDef blocked fill:#f1a2a0
    classDef punt fill:#b5abf4
    classDef notes fill:#b8cffa

    style legend color:#000000,font-size:18px,font-weight:bold

    class legend-parent-task parent-task
    class legend-todo todo
    class legend-in-progress in-progress
    class legend-completed completed
    class legend-blocked blocked
    class legend-punt punt
    class legend-notes notes

    class parent-node parent-task
```
