---
description: Restructure code in $ARGUMENTS without changing behavior. Delegates to the refactorer subagent.
allowed-tools: Read, Grep, Glob, LS, Bash, Task, Edit, MultiEdit, Write
argument-hint: "<file, function, or area to refactor>"
---

# /refactor

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Working tree: !`git status --short 2>/dev/null || true`

## Task

If the working tree is dirty, ask the user to commit or stash first. A refactor with unrelated uncommitted changes is unreviewable.

`$ARGUMENTS` is the target. If empty, ask which file or area to refactor and stop.

Before spawning the subagent, confirm that tests exist for the target area. Run them and confirm a green baseline. If tests don't exist or don't pass:
- No tests → say so, and recommend using `/test <target>` first to add characterization tests. Stop.
- Tests fail → say so. A refactor on red tests is not a refactor; it's something else. Stop.

When the baseline is green, spawn the `refactorer` subagent with the target. The subagent will work in small steps, running tests between each, and will return a report of moves made and what was confirmed unchanged.

After the refactor:
- Show the diff stat.
- Confirm tests still pass (the subagent should have, but verify).
- The subagent should never have modified tests. If it did, that's a finding — flag it.

## Rules
- Pure refactor only — no new features, no bug fixes mixed in. If the subagent finds a bug, it should surface it separately, not silently fix it.
- Public signatures, error shapes, log output, and side-effect ordering are preserved unless the user explicitly approved otherwise.
