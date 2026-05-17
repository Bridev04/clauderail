---
name: devops-ci-release
description: Use for CI/CD, Docker, GitHub Actions, deployment, release, rollback, environment config, and observability.
---

# DevOps, CI, and Release Skill

## Purpose
Make delivery repeatable, observable, and rollback-safe.

## Workflow
1. Identify runtime, package manager, build commands, test commands, container strategy, env vars, and deployment target.
2. Ensure CI runs install, lint, typecheck, tests, build, security checks, and artifact generation where relevant.
3. Keep secrets in CI secret storage, never in workflow files.
4. Add caching carefully using lockfiles and dependency cache keys.
5. Verify deployment health checks and rollback path.
6. Include observability: logs, metrics, traces, error reporting, and release markers when available.

## Release checklist
- Version/changelog updated.
- Migration plan documented.
- Smoke tests pass.
- Rollback command/plan exists.
- Monitoring/alerts checked.
- Known risks communicated.

## Output
- CI/release changes
- Required secrets/env vars
- Validation commands
- Rollback plan
- Monitoring notes
