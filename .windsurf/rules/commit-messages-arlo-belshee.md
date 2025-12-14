---
trigger: model_decision
description: Commit messages
---

# Commit Message Guidelines

## Arlo Belshee's Commit Notation

### Risk Identifiers
- **.** (Safe) - Proven safe, addresses all known and unknown risks
- **^** (Validated) - Addresses all known risks with validation
- **!** (Risky) - Some known risks remain unverified
- **@** (Probably Broken) - No risk attestation

### Change Types
- **f** feature
- **b** bug fix
- **r** refactoring
- **d** documentation
- **a** automated formatting
- **e** environment
- **t** test-only

## Complete Commit Notation Reference

### Features
| Risk | Type | Description | Criteria |
|------|------|-------------|----------|
| ! f | Feature (> 8 LoC) | Large feature changes |
| ^ f | Feature (<= 8 LoC) | Small feature changes with validation |
| . f | Feature (proven safe) | Automated or tool-generated changes |
| @ f | Feature (no validation) | Unfinished or untested features |

### Bug Fixes
| Risk | Type | Description | Criteria |
|------|------|-------------|----------|
| ! b | Bug fix (> 8 LoC) | Large bug fixes |
| ^ b | Bug fix (<= 8 LoC) | Requires: customer review, <= 8 LoC, unit tests for old and new behavior |
| . b | Bug fix (proven safe) | Developer-only functionality, build tooling, debug logging |
| @ b | Bug fix (no validation) | No automatic tests or unfinished implementation |

### Refactoring
| Risk | Type | Description | Criteria |
|------|------|-------------|----------|
| ! r | Manual refactoring | Identified single, named refactoring, but executed by editing code or without whole-project test coverage |
| ^ r | Test-supported refactoring | Test-supported procedural refactoring with full-suite test runs |
| . r | Proven refactoring | One of: automated refactoring via tool, scripted manual refactoring, formal methods, or entirely within test code |
| @ r | Unverified refactoring | Remodeled by editing code, even in small chunks |

### Documentation
| Risk | Type | Description | Criteria |
|------|------|-------------|----------|
| ! d | Process-altering docs | Alters an important process |
| ^ d | Dev-impacting docs | Dev-impacting only, but changes compilation or process |
| . d | Safe documentation | Developer-visible documentation that does not change a process |
| @ d | Unverified docs | Not verified or trying out process changes |

### Other Types
| Risk | Type | Description |
|------|------|-------------|
| . a | Automatic formatting/generation |
| . e | Environment (non-code) changes, including .windsurf directory changes |
| . t | Test-only changes |

## Key Concepts

### Size Guidelines
- **8 LoC Rule**: Features/bug fixes > 8 lines of code are automatically high risk (!)
- **Small Changes**: Changes <= 8 LoC can be medium risk (^) with proper validation
- **Test Changes**: Include test code in the line count

### Risk Level Definitions
- **Safe (.)**: Addresses all known and unknown risks through proven methods
- **Validated (^)**: Addresses all known risks through testing and validation
- **Risky (!)**: Some known risks remain unverified
- **Probably Broken (@)**: No risk attestation or validation

### Refactoring Types
- **Provable Refactoring**: Automated tools, scripted manual steps, or formal methods
- **Test-Supported Procedural Refactoring**: Named refactoring with full test coverage
- **Manual Refactoring**: Hand-edited code without comprehensive test coverage

## Examples

### Features
```
^ f Add user authentication system (<= 8 LoC with tests)
! f Implement complete payment processing workflow (> 8 LoC)
. f Apply automated code generation for API endpoints
@ f Start implementing user dashboard (unfinished)
```

### Bug Fixes
```
^ b Fix login validation error (<= 8 LoC, customer reviewed, tested)
! b Resolve memory leak in image processing (> 8 LoC)
. b Fix debug logging format (developer-only)
@ b Attempt to fix calculation error (no tests)
```

### Refactoring
```
^ r Extract TDD methodology to dedicated rule file (test-supported)
! r Restructure entire authentication module (manual, large scope)
. r Apply automated code formatting to all Swift files
@ r Start extracting method with no name (unfinished)
```

### Documentation
```
. d Update README with new installation steps
^ d Update code review checklist (process change)
! d Change deployment process documentation
@ d Try new commit message format (experimental)
```

## Guidelines

### When to Use Each Risk Level
- **.** (Safe): Automated, proven, or tool-generated changes
- **^** (Validated): Manual changes with comprehensive test coverage
- **!** (Risky): Large changes or changes without full validation
- **@** (Probably Broken): Unfinished, untested, or experimental changes

### Best Practices
- Keep commit messages concise and descriptive
- Use present tense, imperative mood
- Focus on what the change accomplishes
- Include context when necessary
- Separate risk and type with a space
- Count all lines changed, including tests

### Commit Message Format
```
[risk][space][type][space][description]
```

Follow this notation for all commits to maintain consistency and provide clear risk assessment. The goal is to enable safe, rapid deployment through risk-aware commit history.