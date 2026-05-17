---
description: Produce an implementation plan for a non-trivial change. Use before touching multiple files.
allowed-tools: Read, Grep, Glob, LS, Bash, Task
argument-hint: "<what you want to build or change>"
---

# /plan

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Top-level layout: !`ls -1 2>/dev/null | head -30 || true`

## Task

`$ARGUMENTS` is the goal. If it's empty, ask the user what they want to plan and stop.

Delegate to the `planner` subagent. The planner will:
1. Restate the goal.
2. Inspect the relevant code.
3. Identify every file that changes, gets created, or is deliberately left alone.
4. Decompose into phases with verification and rollback per phase.
5. Call out risks and open questions.

Pass through the plan unchanged. After the plan is returned:
- Ask the user to review and adjust before any execution.
- Do not auto-execute the plan. Plans get reviewed first.
- If the plan has open questions, surface them at the top so the user notices.

## Rules
- A "trivial" plan is allowed — if the change is 1-2 files and low risk, the planner should produce a 3-line plan, not the full template.
- The planner does not write code. If the user wants execution, they'll say so as a separate step.
