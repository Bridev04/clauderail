---
name: research-first-development
description: Use when integrating unfamiliar libraries, APIs, frameworks, platform rules, or fast-changing tools where stale knowledge is risky.
---

# Research-First Development Skill

## Purpose
Avoid stale assumptions when working with changing APIs, frameworks, or libraries.

## Workflow
1. Identify which facts are stable and which may have changed.
2. Prefer official docs, changelogs, release notes, migration guides, and source repositories.
3. Verify package versions used by the project before applying guidance.
4. Compare current docs to the project's installed version.
5. Extract only the details needed for the task.
6. Record source links in the implementation notes or PR body when relevant.

## Use for
- Claude Code and AI tooling
- Framework upgrades
- SDK integrations
- Cloud provider APIs
- Payment/auth providers
- Security or compliance rules
- Browser/mobile platform behavior

## Output
- Current version/context
- Sources checked
- Relevant facts
- Outdated or uncertain guidance
- Implementation recommendation
