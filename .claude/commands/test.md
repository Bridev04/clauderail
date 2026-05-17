---
description: Run tests, or write tests for $ARGUMENTS. Picks the narrowest useful test scope first.
allowed-tools: Read, Grep, Glob, LS, Bash, Task, Edit, MultiEdit, Write
argument-hint: "[file, function, or 'all', optional]"
---

# /test

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Changed files: !`git diff --name-only 2>/dev/null; git diff --name-only --cached 2>/dev/null || true`
- Test runner hints: !`grep -E '"test"|"jest"|"vitest"|pytest' package.json pyproject.toml 2>/dev/null | head -20 || true`

## Task

Decide which mode applies and act:

### Mode A — `$ARGUMENTS` is empty or "all"
The user wants to run the existing test suite.
1. Detect the test runner from `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, etc.
2. Prefer the narrowest scope that exercises the recently changed code (`git diff --name-only`). Run targeted tests first.
3. If those pass, offer to run the full suite. Don't auto-run a 20-minute suite without asking.
4. Report: command run, pass/fail count, failures with file:line, and time elapsed.

### Mode B — `$ARGUMENTS` names a file, function, or behavior
The user wants tests **written** for that target.

Delegate to the `test-engineer` subagent. The subagent's contract is in `.claude/agents/test-engineer.md` — it will:
- Read the target code and existing tests.
- Write tests asserting behavior, not implementation.
- Confirm tests fail when the source is mutated.

Pass through its output. If new test files were created, list them.

### Mode C — `$ARGUMENTS` is "watch" or "tdd"
Find the watch mode in the project's test runner (`jest --watch`, `vitest`, `pytest-watch`) and start it for the changed-files scope.

## Rules
- Never use `--no-verify`, `--skip`, or other "make the failure go away" flags.
- Never modify a failing test to make it pass without first confirming the code is correct.
- If the project has no tests at all, surface that as the finding — don't invent a test framework.
