---
description: Build a quick mental model of this repo — stack, layout, entrypoints, conventions, how to run it. Run this on a new repo before doing real work.
allowed-tools: Read, Grep, Glob, LS, Bash
---

# /onboard

## Live context
- Root listing: !`ls -1 2>/dev/null | head -40`
- Top-level files: !`ls -1 *.{json,toml,yaml,yml,md,cfg,ini} 2>/dev/null | head -20 || true`
- Git remote: !`git remote -v 2>/dev/null | head -2 || true`
- Recent activity: !`git log --oneline -10 2>/dev/null || true`

## Task

Build an orientation document for this repo. The output is for someone (you, the user, or the next engineer) who needs to do work here without yet knowing the codebase.

### What to discover

1. **Stack & tooling**
   - Languages and major frameworks (read package.json, pyproject.toml, go.mod, Cargo.toml, etc.).
   - Package manager (lockfile presence tells you: pnpm-lock.yaml → pnpm, yarn.lock → yarn, package-lock.json → npm, uv.lock → uv, poetry.lock → poetry).
   - Test runner, linter, formatter, type checker, build tool.
   - Database, cache, queue, deployment target if discoverable from config.

2. **Layout**
   - Top-level directories and what each contains.
   - Where the application entrypoint(s) live.
   - Where routes / handlers / commands are defined.
   - Where the schema/models live.
   - Where tests live and how they're organized.

3. **How to run it**
   - Install command.
   - Dev server / run command.
   - Test command.
   - Lint/format/typecheck commands.
   - Build command.
   - Whether `.env.example` exists and what variables are needed.

4. **Conventions**
   - Naming (camelCase / snake_case / kebab-case for which kinds of things).
   - File organization (feature folders vs. type folders).
   - Import patterns (absolute vs. relative, path aliases).
   - Error handling style.
   - Logging style.

5. **Risks / gotchas**
   - Generated files that shouldn't be edited (check .gitattributes, comments at file tops, codegen configs).
   - Migrations directory.
   - Anything that would surprise a new contributor.

### How to work

- Use `rg`/`grep`/`find` for fast surveys. Don't `cat` whole large files.
- Skip generated/dependency directories: `node_modules`, `.venv`, `dist`, `build`, `.next`, `target`, `coverage`.
- If `README.md` and `CONTRIBUTING.md` exist, read them — but verify their claims against the actual code. READMEs go stale.

### Output

```
## Stack
- <language>: <framework>, <version if discoverable>
- Package manager: <name>
- Test runner: <name>
- Linter / formatter / type checker: <names>

## Layout
- `<dir>/` — <what's here>
- ...

## Entrypoints
- <file> — <what runs first>

## How to run
- Install: `<cmd>`
- Dev: `<cmd>`
- Test: `<cmd>`
- Lint: `<cmd>`
- Typecheck: `<cmd>`
- Build: `<cmd>`

## Conventions observed
- <observation> (evidence: <file>)

## Risks / things to know
- <thing>

## Open questions for the team
- <thing the code didn't tell you>

## Suggested first read for someone new
- <file 1>, <file 2>, <file 3> — in this order
```

### Rules
- Every claim should cite a file. "Uses Jest" is weak; "Uses Jest (package.json:test → jest)" is verifiable.
- If a section has nothing useful, write "none discovered" and move on. Don't pad.
- This command does not modify files.
