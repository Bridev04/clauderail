---
description: Run a security audit on the current diff or $ARGUMENTS area. Delegates to the security-auditor subagent.
allowed-tools: Read, Grep, Glob, LS, Bash, Task
argument-hint: "[file, directory, or 'diff', default 'diff']"
---

# /security-audit

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Diff scope: !`git diff --stat origin/main...HEAD 2>/dev/null || git diff --stat main...HEAD 2>/dev/null || git diff --stat 2>/dev/null || true`

## Task

Determine the audit scope:
- `$ARGUMENTS` empty or "diff" → the current diff vs. the base branch.
- `$ARGUMENTS` is a file/directory → audit that scope.
- `$ARGUMENTS` is "full" → audit the whole repo. Confirm with the user first — this is slow.

Spawn the `security-auditor` subagent with the scope. The subagent walks the threat surface (input handling, authn/authz, injection, secrets, rate limits, crypto, cookies/headers, dependencies) and returns findings grouped by severity.

After findings return:
- Surface them unchanged.
- For each Critical finding, ask whether the user wants the security-auditor to also propose a fix patch (a separate call), or whether the user wants to address them.
- Do not apply fixes during the audit phase.

## Rules
- This command is read-only. The auditor does not write code.
- If the audit surfaces a real exposed secret (key found in source), recommend rotation immediately — discovery alone is exposure.
- For "Needs verification" findings that depend on runtime config, the report should say so explicitly rather than guessing.
