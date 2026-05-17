---
name: context-management
description: Use when a task is large, the codebase is big, context is getting noisy, or multiple subagents/parallel reviews are needed.
---

# Context Management Skill

## Purpose
Keep Claude Code effective in large repositories and long sessions.

## Workflow
1. Keep the active context focused on the current task.
2. Use targeted file reads and searches instead of loading broad directories.
3. Summarize discoveries before switching areas.
4. Use subagents for isolated research/review tasks, then merge only conclusions into the main context.
5. For very large tasks, create a working plan with checkpoints.
6. Before compaction or session end, write a concise state summary: goal, decisions, files changed, commands run, remaining work.

## File scoping
Prefer reading:
- Entrypoints
- Config
- Direct dependencies of changed files
- Tests near changed behavior
- Documentation relevant to the task

Avoid unless necessary:
- `node_modules`, `.next`, `dist`, `build`, `coverage`, vendored code, generated files, binary/media files, large lockfiles.

## Output
- Context map
- Files that matter
- Files intentionally ignored
- Next checkpoint
