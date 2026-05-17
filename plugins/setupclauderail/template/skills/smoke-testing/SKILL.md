---
name: smoke-testing
description: Use after implementing a phase or before deployment to prove the app starts and core flows work end-to-end.
---

# Smoke Testing Skill

## Purpose
Verify the project actually runs and the main user flows work.

## Workflow
1. Discover start/build/test commands from package files, README, compose files, Makefile, pyproject, or CI config.
2. Confirm required env vars via `.env.example`; do not invent secrets.
3. Run install only if dependencies are missing.
4. Run format/lint/type/test/build commands where available.
5. Start required services in the safest local mode.
6. Hit health endpoints and main pages.
7. Exercise the core user flow with curl, browser automation, or existing e2e tests.
8. Inspect terminal output for import errors, console errors, hydration errors, failing API calls, and auth leaks.

## Minimum checks
- Backend starts.
- Frontend starts or builds.
- Main page loads.
- API health check passes if present.
- Protected routes reject unauthenticated access.
- No obvious secrets in logs.

## Output
- Pass/fail summary
- Commands run
- Evidence
- Failures found
- Fixes applied or recommended
- Suggested commit message
