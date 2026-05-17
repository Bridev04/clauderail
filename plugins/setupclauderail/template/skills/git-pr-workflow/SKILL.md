---
name: git-pr-workflow
description: Use for commits, branch hygiene, PR descriptions, changelogs, release notes, and review-ready summaries.
---

# Git and PR Workflow Skill

## Purpose
Prepare clean commits and PRs with strong reviewer context.

## Workflow
1. Run `git status --short` and inspect the diff.
2. Group related changes logically.
3. Confirm no secrets, generated junk, debug logs, or accidental files are included.
4. Run relevant checks before commit/PR when possible.
5. Write conventional commit messages.
6. Draft PR description with summary, why, test evidence, risks, rollback, screenshots/videos for UI, and migration notes if needed.

## Commit message format
Use: `type(scope): summary`

Types: `feat`, `fix`, `docs`, `test`, `refactor`, `perf`, `security`, `ci`, `build`, `chore`, `release`.

## PR template
- Summary
- Motivation
- Changes
- Tests run
- Screenshots/video
- Risk
- Rollback plan
- Checklist

## Output
- Files changed summary
- Suggested commit(s)
- PR body
- Reviewer notes
