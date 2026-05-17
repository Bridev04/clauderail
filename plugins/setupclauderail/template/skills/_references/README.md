# Claude Code Skills — Design Reference

Skills are focused, reusable, on-demand playbooks. They are narrower than `CLAUDE.md` (which loads every session) and broader than slash commands (which are user-triggered). Claude loads a skill when its `description` matches the current task.

## Recommended shape

```
.claude/skills/<skill-name>/
├── SKILL.md          # frontmatter + workflow
├── references/       # optional detailed docs, loaded on demand
├── scripts/          # optional helper scripts
└── assets/           # optional templates, schemas, examples
```

Most skills in this pack are single-file SKILL.md — that's fine. The subdirectories are only worth adding when a skill genuinely needs them.

## Frontmatter

Required:

```md
---
name: skill-name
description: Use when ...
---
```

The `name` must match the directory exactly. A mismatch breaks discovery.

The `description` is the most load-bearing field — it's what Claude matches against to decide whether to fire the skill. Specific descriptions fire on the right tasks; vague ones cause every skill to fire on everything, which defeats the point.

Good descriptions (specific, with triggers):
- "Use when editing production code. Enforces smallest safe diffs, convention matching, secret hygiene, and evidence-based verification."
- "Use before deploying or merging changes to auth, file uploads, payments, or any endpoint exposed to untrusted users."

Bad descriptions (vague, will overfire):
- "Helps with code quality."
- "Software engineering best practices."

Keep descriptions under ~300 characters.

## Design rules

1. **One skill = one repeatable workflow.** If a skill covers two unrelated things, split it.
2. **Trigger words go in `description`,** not just in the body.
3. **Keep SKILL.md lean** — under ~150 lines. Push long examples into `references/`.
4. **Don't duplicate CLAUDE.md.** Skills add task-specific procedure on top of the always-loaded baseline.
5. **No hardcoded secrets, personal tokens, internal URLs, or machine-specific paths.** Skills are committed to git.
6. **Prefer concrete artifacts over advice** — checklists, workflows, output formats, decision rules. "Be careful with X" is not a skill; "Before X, run Y, then check Z, then output in this format" is.
7. **Skills complement the other surfaces:**
   - Agents = role/persona/delegation with separate context.
   - Commands = user-triggered, command-name discoverable workflows.
   - Hooks = deterministic automation, no judgment involved.
   - Skills = contextual expertise Claude loads when the task matches.

## Skills included in this pack

Each skill below is one SKILL.md focused on a single workflow. Trigger words are in each skill's `description` field.

**Working in code**
- `codebase-orientation` — building a mental model of an unfamiliar repo
- `implementation-planning` — multi-file changes, decomposition into phases
- `safe-code-editing` — production code edits with convention matching and verification
- `code-review` — reviewing diffs for correctness, regressions, security, missing tests
- `refactoring` is handled by the `refactorer` subagent — no separate skill

**Testing & debugging**
- `test-generation` — writing tests that assert behavior, not implementation
- `smoke-testing` — sanity checks after completing a phase
- `debugging` — hypothesis-driven root-cause investigation

**Quality & safety**
- `security-audit` — threat-surface review before merge/deploy
- `performance-profiling` — measuring before optimizing
- `dependency-upgrades` — safe upgrade procedure with breaking-change review

**Specialist areas**
- `frontend-ux-accessibility` — frontend work with a11y baked in
- `backend-api-design` — endpoint shape, error handling, versioning
- `database-migrations` — safe schema changes, backfill, rollback
- `ai-llm-rag-evals` — LLM features, RAG pipelines, evaluation harnesses
- `webapp-browser-testing` — browser-level test workflows

**Operational**
- `devops-ci-release` — pipeline changes, release procedure
- `documentation-maintenance` — keeping docs aligned with code
- `git-pr-workflow` — branch hygiene, commit shape, PR opening

**Meta**
- `context-management` — when to summarize, what to keep across compactions
- `research-first-development` — investigating before building, especially for ambiguous requirements

## Auditing your skills

Run `/skills-audit` from the project root to check for broken frontmatter, vague descriptions, name/directory mismatches, and overlap. The command produces a structured report with file:line citations.

## Adding a new skill

1. Make a directory: `.claude/skills/<name>/`
2. Create `SKILL.md` with valid frontmatter where `name` matches the directory.
3. Write the workflow as numbered steps. Include an output format.
4. Run `/skills-audit` to check it doesn't conflict with existing skills.
5. Commit. The skill is now discoverable.

## When not to make a skill

If the workflow is more than one step but is **always** triggered by the user explicitly, it's a slash command, not a skill. If the workflow is more like "guard rail that must run every time," it's a hook. If it's "a different mode of working with its own context window," it's a subagent. Skills are the right fit when Claude should load the workflow **based on the task**, mid-conversation, without the user needing to invoke it by name.
