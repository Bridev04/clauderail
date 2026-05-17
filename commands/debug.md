---
description: Debug a failing test, error, or unexpected behavior. Delegates to the debugger subagent.
allowed-tools: Read, Grep, Glob, LS, Bash, Task, Edit
argument-hint: "<description of the failure, or test name, or error message>"
---

# /debug

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Recent commits: !`git log --oneline -10 2>/dev/null || true`
- Working tree: !`git status --short 2>/dev/null || true`

## Task

`$ARGUMENTS` describes the failure. If it's empty, ask the user for:
1. The exact command they ran.
2. The exact output they got.
3. The output they expected.

Once you have those three things, spawn the `debugger` subagent and pass the failure details. The subagent follows a strict hypothesis-driven loop and returns a structured root-cause report.

When the subagent returns its findings:
- Surface the report unchanged.
- Ask whether the user wants the suggested fix applied (the report includes one). Do not apply it without explicit approval — debugging and fixing are separate decisions.
- If the report identifies a missing test, offer to invoke the `test-engineer` subagent to add it.

## Rules
- Do not suggest "restart / reinstall / clear cache" without evidence pointing there.
- Do not edit code during the debug phase. Reads, logs, and probes only.
- If the failure can't be reproduced, that's the finding — flakiness is the bug, and that's what the debugger should report.
