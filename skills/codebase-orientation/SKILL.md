---
name: codebase-orientation
description: Use when starting work in an unfamiliar repository, onboarding to a codebase, or before making broad changes. Builds a fast mental model without over-reading.
---

# Codebase Orientation Skill

## Purpose
Build a practical mental model of the repository before editing.

## Use this when
- The user asks to inspect, understand, onboard, or continue a project.
- A task touches multiple areas and the relevant files are unclear.
- You need to avoid guessing architecture or conventions.

## Workflow
1. Start with repository landmarks: `README*`, package files, project config, `.env.example`, `CLAUDE.md`, `docs/`, and top-level directories.
2. Identify the stack: languages, framework, package manager, test runner, formatter, linter, build tool, database, deployment target, and AI/LLM providers if present.
3. Find app entrypoints, route definitions, service layers, schema/model definitions, config modules, and tests.
4. Map the likely change surface: files that must be read before editing and files that should probably stay untouched.
5. Summarize the architecture in 5-10 bullets.
6. Before edits, state assumptions and the exact files you plan to inspect/change.

## Guardrails
- Do not scan generated artifacts, dependency directories, coverage, build output, media dumps, or lockfiles unless necessary.
- Prefer targeted `grep`, `find`, `rg`, and file reads over opening huge files.
- Never start broad refactors during orientation.

## Output
Return:
- Stack summary
- Key directories
- Entry points
- Data flow
- Test/build commands discovered
- Risks/unknowns
- Recommended next step
