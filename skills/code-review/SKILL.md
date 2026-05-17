---
name: code-review
description: Use when reviewing diffs, PRs, or completed work. Produces prioritized findings with exact evidence and fixes.
---

# Code Review Skill

## Purpose
Review code like a senior engineer focused on correctness, maintainability, security, performance, and test coverage.

## Workflow
1. Inspect the diff and relevant surrounding code.
2. Understand the intended behavior before judging the implementation.
3. Look for correctness bugs, edge cases, broken API contracts, security issues, data-loss risk, race conditions, migrations, accessibility, performance, and test gaps.
4. Avoid nitpicks unless they block maintainability or consistency.
5. Provide concrete fixes or patch suggestions for high-confidence issues.

## Severity
- Critical: exploitable security issue, data loss, production outage, secret exposure.
- High: likely user-visible bug, broken auth, broken migration, serious performance regression.
- Medium: maintainability, incomplete validation, missing tests for important behavior.
- Low: style or clarity issue worth fixing but not blocking.

## Output
For each finding:
- Severity
- File/area
- Problem
- Why it matters
- Suggested fix
- Test to prove fix

End with: approve / request changes / needs more context.
