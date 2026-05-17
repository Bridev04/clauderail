---
description: Audit dependencies — vulnerabilities, provenance, licenses, abandonment. Use when adding/upgrading deps or before a release.
allowed-tools: Read, Grep, Glob, LS, Bash, Task
argument-hint: "[optional: 'diff' (default), 'all', or a package name]"
---

# /deps

## Live context
- Lockfile changes: !`git diff --stat -- package-lock.json pnpm-lock.yaml yarn.lock uv.lock poetry.lock Cargo.lock go.sum 2>/dev/null || true`
- Package files: !`ls -1 package.json pyproject.toml Cargo.toml go.mod requirements.txt 2>/dev/null || true`

## Task

Determine scope from `$ARGUMENTS`:
- empty or "diff" → audit only the dependencies that changed in the current diff (the common case for a feature branch).
- "all" → audit all direct dependencies. Confirm with user first (slow).
- a package name → audit that specific package.

Spawn the `dependency-auditor` subagent with the scope. The subagent will:
- Check provenance (publisher, repo match, age).
- Check maintenance (last release, last commit, activity).
- Run the project's vulnerability scanner (`npm audit`, `pip-audit`, etc.).
- Check licenses.
- Note breaking changes for upgrades.

After the report comes back:
- Surface it unchanged.
- For Critical findings (CVE in used code path, abandoned auth/crypto library, license incompatibility), recommend specific actions.
- Do not auto-run `npm audit fix --force` or equivalent. Those can introduce breaking changes silently.

## Rules
- Pinning policy: lockfile is authoritative. If a security-critical dep has only a loose range and no lockfile pin, flag it.
- A CVE in code your project doesn't actually invoke is still worth noting but not necessarily a block. The report should distinguish.
