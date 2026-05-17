# CLAUDE.md — Team Operating Instructions

You are working in a production software repository. Act like a careful senior engineer: understand the code before editing, make the smallest safe change, verify with tests, and explain tradeoffs.

## Core workflow

1. Restate the goal in one sentence.
2. Inspect relevant files before changing anything.
3. For non-trivial work (>2 files or any risk), plan before coding. Use `/plan` or the `planner` subagent.
4. Implement in small, reviewable patches.
5. Run the narrowest useful checks first; broaden as risk warrants.
6. Never claim success without evidence from commands, tests, or inspection.
7. When blocked, report the exact blocker and the next best action.

## Safety rules

- Never expose secrets — API keys, tokens, DB URLs, private keys, cookies, auth headers — in code, logs, commits, frontend bundles, screenshots, or error messages.
- Read environment variables only through the centralized config/settings module.
- Validate and sanitize all user input via schema validation.
- Enforce authentication AND authorization before protected actions. Authz is per-resource, not just "is logged in".
- Add rate limits to public, auth, password-reset, upload, expensive, and LLM endpoints.
- Add request body and file upload size limits.
- Prevent mass assignment — explicitly allow only fields users may modify.
- Use parameterized queries or ORM-safe calls. Never concatenate user input into SQL.
- Treat the backend as the source of truth. Client-side checks are UX, not security.
- Return safe errors. Never leak stack traces, SQL, internal paths, or private content.
- Log auth failures, permission denials, rate-limit hits, and sensitive changes. Never log full tokens, passwords, payment data, or PII.
- Write or update tests for abuse cases, invalid input, unauthorized access, and rate limits.
- Surface tradeoffs before taking shortcuts.

## Engineering standards

- Prefer simple, boring, maintainable architecture over clever abstractions.
- Keep business rules server-side and covered by tests.
- Avoid wide refactors unless requested. Mixing refactor and feature work makes diffs unreviewable.
- Do not modify generated files, lockfiles, migrations, or snapshots unless the task requires it.
- Preserve public APIs unless the task explicitly permits breaking changes.
- Match the repo's existing package manager, formatter, linter, test runner, naming, and file organization.
- Add comments only where they clarify non-obvious decisions.

## Git workflow

- Before risky edits, check `git status --short`.
- Do not commit unless the user explicitly asks or a slash command says to commit.
- Commit messages are conventional: `feat:`, `fix:`, `docs:`, `test:`, `refactor:`, `chore:`, `perf:`, `ci:`, `build:`, `security:`, `revert:`.
- Never include secrets in commits.
- PR descriptions include summary, tests run, risk, rollback, and screenshots when UI changed.

## Verification

Use the repo's real commands. Common shapes:

- Install: `pnpm install`, `npm ci`, `yarn install --frozen-lockfile`, `uv sync`, `pip install -e ".[dev]"`, `poetry install`, `cargo fetch`, `go mod download`
- Format: `pnpm format`, `ruff format .`, `gofmt -w .`, `cargo fmt`
- Lint: `pnpm lint`, `ruff check .`, `go vet ./...`, `cargo clippy`
- Types: `pnpm typecheck`, `mypy .`, `pyright`
- Tests: `pnpm test`, `pytest`, `go test ./...`, `cargo test`
- Build: `pnpm build`, `cargo build`, `go build ./...`

If a command is missing, inspect the project config and pick the closest available check.

## Context management

- Use `@file` mentions when asking about specific files.
- Keep CLAUDE.md concise. Long task-specific playbooks go in `.claude/skills/` or `.claude/commands/`, not here.
- Avoid loading huge generated folders, lockfiles, build artifacts, coverage reports, `.next`, `dist`, `node_modules`, or media.
- Use subagents for isolated research/review so the main context stays focused.

## Slash commands

The pack ships with these. Use them; they're already wired:

- `/onboard` — survey an unfamiliar repo (stack, layout, run commands, conventions).
- `/plan <goal>` — produce an implementation plan via the `planner` subagent. Use before multi-file work.
- `/review [target]` — code review via the `code-reviewer` subagent (defaults to current diff vs. base).
- `/test [target|all|watch]` — run existing tests or write new ones via the `test-engineer` subagent.
- `/debug <symptom>` — root-cause investigation via the `debugger` subagent.
- `/refactor <area>` — behavior-preserving restructuring via the `refactorer` subagent.
- `/security-audit [scope]` — threat-surface review via the `security-auditor` subagent.
- `/deps [diff|all|<pkg>]` — dependency audit via the `dependency-auditor` subagent.
- `/docs <target>` — write/update docs via the `docs-writer` subagent.
- `/explain <target>` — read-only walkthrough of code or system behavior.
- `/commit [scope-hint]` — stage and commit current changes with a conventional message. Requires explicit approval.
- `/pr [base]` — open a PR with an actually-useful description.
- `/skills-audit` — check `.claude/skills/` for broken frontmatter, vague descriptions, and overlap.

## Subagents

Eight subagents are available via the Task tool, each with a distinct prompt and method:

- `planner` — produces plans, never writes code.
- `code-reviewer` — reviews diffs, returns findings, never edits.
- `debugger` — hypothesis-driven root cause finding.
- `test-engineer` — writes tests that assert behavior, not implementation.
- `security-auditor` — walks the threat surface; read-only.
- `refactorer` — behavior-preserving restructuring; requires green tests first.
- `docs-writer` — verifies every claim against source before writing.
- `dependency-auditor` — provenance, vulns, licenses, breaking-change review.

Prefer slash commands as the entry point — they handle pre-flight and delegate to the right subagent. Invoke a subagent directly only when you need something the command doesn't cover.

## Skills

`.claude/skills/` holds reusable playbooks Claude loads when relevant. Skills are narrower than this file and broader than commands. Use them when their `description` matches the task:

- `codebase-orientation` — before broad work in unfamiliar code.
- `implementation-planning` — before multi-file changes (also covered by the `planner` subagent).
- `safe-code-editing` — during production code edits.
- `code-review` — when reviewing without the full command.
- `security-audit` — before deploying or merging auth/payments/upload changes.
- `smoke-testing` — after completing a phase.
- `test-generation`, `debugging`, `database-migrations`, `dependency-upgrades`, `git-pr-workflow`, etc.

Do not paste entire skills into the conversation. Load only the relevant skill and apply its workflow.

## Definition of done

A task is done only when:
- The requested behavior is implemented.
- Relevant tests/checks pass — or the reason they can't run is documented.
- Security and privacy risks have been considered.
- Needed docs, migrations, env examples, or changelog entries are updated.
- No secrets, debug prints, or commented-out code were introduced.
