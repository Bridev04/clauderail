---
description: Review the current diff (or $ARGUMENTS) for correctness, regressions, security, missing tests, and convention drift.
allowed-tools: Read, Grep, Glob, LS, Bash, Task
argument-hint: "[file or area, optional]"
---

# /review

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Diff stat: !`git diff --stat 2>/dev/null || true`
- Diff stat vs main: !`git diff --stat origin/main...HEAD 2>/dev/null || git diff --stat main...HEAD 2>/dev/null || true`
- Recent commits: !`git log --oneline -5 2>/dev/null || true`

## Task

Review **$ARGUMENTS** if provided. Otherwise review the current diff against the base branch (or the working tree if there's no branch divergence).

Delegate the actual review to the `code-reviewer` subagent — that's what it's for. Don't duplicate its work here.

Steps:
1. Determine the review target:
   - If `$ARGUMENTS` is a file or directory, that's the target.
   - Otherwise, use the diff against `origin/main` or `main`.
   - If there's no diff (clean working tree, no branch divergence), tell the user there's nothing to review and stop.
2. Spawn the `code-reviewer` subagent with the target.
3. Pass through its findings. Do not add your own commentary unless the user asked a specific question on top of "review this".
4. After findings are returned, if the user wants fixes applied, that's a separate request — say so and stop.
