---
name: debugging
description: Use when errors, failing tests, stack traces, broken builds, or unclear runtime behavior need systematic diagnosis.
---

# Debugging Skill

## Purpose
Diagnose issues methodically instead of guessing.

## Workflow
1. Capture the exact error, command, environment, and recent changes.
2. Reproduce with the smallest command or flow.
3. Read the stack trace from the first meaningful error, not only the final cascade.
4. Inspect nearby code, config, imports, versions, env vars, and tests.
5. Form 1-3 hypotheses and test them one at a time.
6. Apply the smallest fix.
7. Add a regression test when the bug represents expected behavior.

## Common checks
- Wrong working directory
- Missing env var
- Port already in use
- Incorrect import path
- Dependency version mismatch
- Database migration not applied
- Client/server route mismatch
- CORS/auth/session issue
- Build artifact cache issue

## Output
- Root cause
- Evidence
- Fix
- Validation command
- Prevention test/check
