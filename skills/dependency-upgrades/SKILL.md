---
name: dependency-upgrades
description: Use for package upgrades, vulnerability remediation, framework migrations, lockfile changes, and breaking-change review.
---

# Dependency Upgrades Skill

## Purpose
Upgrade dependencies safely without surprise breakage.

## Workflow
1. Identify package manager and lockfile.
2. Check current versions and why the upgrade is needed.
3. Read release notes/migration guides for major/minor breaking changes.
4. Upgrade the smallest set of packages needed.
5. Run install, tests, typecheck, lint, and build.
6. Inspect lockfile diff for suspicious transitive changes.
7. Document migration notes and rollback path.

## Security remediation
- Prefer direct patch/minor updates before broad upgrades.
- Verify vulnerable package is actually used/reachable when possible.
- Do not suppress audit warnings without written justification.

## Output
- Packages changed
- Breaking changes considered
- Validation commands
- Remaining vulnerabilities
- Rollback notes
