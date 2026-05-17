---
description: Write or update docs for $ARGUMENTS — README, API, ADR, runbook, changelog, or inline comments. Delegates to the docs-writer subagent.
allowed-tools: Read, Grep, Glob, LS, Bash, Task, Edit, MultiEdit, Write
argument-hint: "<doc target, e.g. 'README', 'API for /users', 'ADR for caching choice'>"
---

# /docs

## Task

`$ARGUMENTS` describes what to document. If empty, ask the user what they want documented and stop.

Spawn the `docs-writer` subagent. The subagent's contract:
- Answers four questions in order: what is this, what problem does it solve, how to use it, what are the edges.
- Verifies every claim against the source.
- Runs any command it puts in the docs.
- Matches the project's existing doc style.

Pass through what the subagent produces. If it surfaces "still unclear / TBD" items, present those to the user before publishing the doc.

## Rules
- Doc changes are still code changes. They should go through `/commit` and `/pr` like anything else.
- If the subagent reports that the code itself is unclear (not just the docs), surface that — sometimes the right fix is to clarify the code, not to document around it.
