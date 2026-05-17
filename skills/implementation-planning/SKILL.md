---
name: implementation-planning
description: Use before non-trivial coding tasks to create a small, reviewable implementation plan with risks, tests, and rollback strategy.
---

# Implementation Planning Skill

## Purpose
Turn a vague coding request into a safe, reviewable plan.

## Workflow
1. Restate the user goal in one sentence.
2. Identify constraints from `CLAUDE.md`, existing architecture, package manager, deployment target, and security rules.
3. Split work into phases no larger than one reviewable patch each.
4. For each phase, define files likely to change, validation commands, and rollback notes.
5. Call out hidden risks: data migrations, auth/authorization, rate limits, API compatibility, env vars, secrets, performance, observability, and UI regressions.
6. Ask for clarification only if an ambiguity can cause rework or security risk; otherwise choose the safest default and say so.

## Output format
- Goal
- Current facts from repo inspection
- Plan
- Files likely affected
- Validation commands
- Risks and rollback

## Rule
Do not write code until the plan is grounded in files already inspected.
