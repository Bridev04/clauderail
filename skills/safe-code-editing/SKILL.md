---
name: safe-code-editing
description: Use when editing production code. Enforces smallest safe diffs, convention matching, secret hygiene, and evidence-based verification.
---

# Safe Code Editing Skill

## Purpose
Make reliable code changes without breaking conventions or leaking secrets.

## Workflow
1. Check `git status --short` before editing.
2. Read the files to be changed and nearby tests.
3. Prefer the smallest diff that solves the request.
4. Match existing patterns, naming, formatting, error handling, and dependency style.
5. Update or add tests when behavior changes.
6. Run the narrowest relevant validation first, then broader checks if risk is high.
7. Report exactly what changed and the evidence.

## Hard rules
- Never hardcode secrets, tokens, keys, private URLs, cookies, auth headers, or credentials.
- Never log private content, full tokens, payment data, or raw auth headers.
- Never rely on client-side validation for server-side business rules.
- Do not silently change public APIs, schemas, migrations, or generated files.
- Do not use `--no-verify`, force push, or destructive commands unless explicitly authorized.

## Output
- Summary of changes
- Tests/checks run
- Remaining risks
- Suggested commit message if appropriate
