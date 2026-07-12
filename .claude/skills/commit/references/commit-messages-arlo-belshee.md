# Arlo Belshee's Risk-Aware Commit Notation

## Commit Message Format
```
[risk][space][intention][space][description]
```

## Risk Levels

| Risk Level| Code | Correctness Guarantees |
|-|-|-|
| (Proven) Safe | `.`  | Intended Change, Known Invariants, Unknown Invariants |
| Validated | `^` | Intended Change, Known Invariants |
| Risky | `!` | Intended Change |
| (Probably) Broken | `@` | No guarantees |

## Developer Intentions

| Developer Intention | Code |
|-|-|
| Feature (1 behavior) | `f` |
| Bugfix (1 behavior) | `b` |
| Refactoring (1 code structure) | `r` |
| Documentation | `d` |
| Test-only | `t` |
| Environment (non-code change) | `e` |

## Commit Notation Reference

LoC: count production code only

### Features
| Risk | Description |
|-|-|
| `. f` | Meets all criteria for `^ f` and developers are only users of feature. For example, extends build tooling or adds debug logging. |
| `^ f` | Meets all of: Change is <= 8 LoC AND Feature was fully unit tested prior to this change AND Change includes new or changed unit tests to match intended behavior alteration |
| `! f` | Change includes unit tests for new behavior |
| `@ f` | No automated tests, or unfinished implementation |

### Bug Fixes
| Risk | Description |
|-|-|
| `. b` | Meets all criteria for `^ b` and developers are only users of fix. For example, fixes build tooling or corrects debug logging. |
| `^ b` | Meets all of: Reviewed current and new behavior with customer representative AND Change is <= 8 LoC AND Bug's original (buggy) behavior was captured in a unit test prior to this change AND Change includes 1 changed unit test, matching intended behavior alteration |
| `! b` | Change includes unit tests for new behavior |
| `@ b` | No automated tests, or unfinished implementation

### Refactoring or Remodeling
| Risk | Description |
|-|-|
| `. r` | One of: Provable Refactoring OR Test-supported Procedural Refactoring entirely within test code |
| `^ r` | Test-supported Procedural Refactoring |
| `! r` | Identified single, named refactoring, but executed by editing code or without whole-project test coverage |
| `@ r` | Remodeled by editing code, even in small chunks |

#### Provable Refactorings
Either:
- automated refactoring via tool
- change where compiling is proof enough

#### Test-supported Procedural Refactorings
1. Commit contains only a single refactoring
2. Refactoring is named and published (e.g., in https://refactoring.com/catalog/)
3. Either: Entire product is very highly tested, or you are working on new code that is not yet called
4. You followed the published steps, including running full-suite test runs when indicated

Start commit message with name of refactoring. 

### Documentation
| Risk | Type | Description |
|-|-|-|
| `. d` | Safe documentation | Developer-visible documentation that does not change a process |
| `^ d` | Dev-impacting docs | Dev-impacting only, but changes compilation or process |
| `! d` | Process-altering docs | Alters an important process |
| `@ d` | Unverified docs | Not verified, or trying out process changes |

### Other Types
| Risk | Description |
|-|-|
| `. a` | Automatic formatting/generation |
| `. e` | Environment (non-code) changes |
| `. t` | Test-only changes |
