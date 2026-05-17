# Claude Code starter pack

An opinionated `.claude/` starter pack for Claude Code: CLAUDE.md, settings with sensible permissions, hooks that actually block dangerous commands, eight focused subagents, thirteen slash commands that delegate properly, a curated skills library, MCP config, and CI.

Designed to drop into a real repo, not a demo. Hooks anchor to `$CLAUDE_PROJECT_DIR`, the formatter picks one package manager from the lockfile, and the secret scanner exits 2 on real-looking keys before the write completes.

## What's in the box

```
.claude/
├── settings.json                 # permissions, hooks wiring, status line
├── settings.local.example.json   # template for personal overrides
├── agents/                       # 8 subagents, each with a distinct method
│   ├── code-reviewer.md
│   ├── debugger.md
│   ├── dependency-auditor.md
│   ├── docs-writer.md
│   ├── planner.md
│   ├── refactorer.md
│   ├── security-auditor.md
│   └── test-engineer.md
├── commands/                     # 13 slash commands, real per-command logic
│   ├── commit.md     pr.md       review.md         test.md
│   ├── debug.md      plan.md     refactor.md       deps.md
│   ├── docs.md       explain.md  onboard.md
│   ├── security-audit.md         skills-audit.md
├── hooks/                        # bash, $CLAUDE_PROJECT_DIR-safe, exit-2-blocks
│   ├── pre_tool_use.sh           # blocks dangerous Bash + secret-file reads
│   ├── secret_scan.sh            # blocks writes containing real-looking keys
│   ├── post_tool_use.sh          # auto-formats; picks ONE PM from the lockfile
│   ├── user_prompt_submit.sh     # warns on secret-shaped prompts
│   ├── session_start.sh          # writes session context
│   ├── pre_compact.sh            # snapshots context before compaction
│   ├── stop.sh   subagent_stop.sh   notify.sh   statusline.sh
├── output-styles/
│   └── senior-engineer.md        # concise senior-engineer voice
├── rules/
│   └── security.md               # baseline security rules
└── skills/                       # 23 on-demand playbooks
    └── _references/README.md     # skill design rules

.github/workflows/
├── ci.yml                        # real CI — fails on actual errors
└── claude-review.yml             # official Claude Code Action on PRs

CLAUDE.md                         # team operating instructions
.mcp.json                         # GitHub, Sentry, Context7, Playwright,
                                  # filesystem, Linear MCP servers
```

## Install

```bash
# From your repo root:
cp -R path/to/claude-starter-pack/.claude ./.claude
cp path/to/claude-starter-pack/CLAUDE.md ./CLAUDE.md
cp path/to/claude-starter-pack/.mcp.json ./.mcp.json
mkdir -p .github/workflows
cp path/to/claude-starter-pack/.github/workflows/*.yml .github/workflows/

chmod +x .claude/hooks/*.sh
```

Optional local overrides go in `.claude/settings.local.json` (gitignored). Use the example file as a starting point:

```bash
cp .claude/settings.local.example.json .claude/settings.local.json
```

## First session

Start in your repo with:

```
/onboard
```

That builds a quick mental model — stack, layout, run commands, conventions — citing real files. Use the output to update `CLAUDE.md` with anything project-specific the pack doesn't know.

For a non-trivial change, `/plan` first. For a code review, `/review`. The commands handle pre-flight and delegate to the right subagent.

## Wiring notes

- **Hooks run from `$CLAUDE_PROJECT_DIR`.** This means they work no matter what subdirectory Claude is invoked from. Logs land in `.claude/logs/` at the project root.
- **`exit 2` from a `PreToolUse` hook hard-blocks the tool call.** That's the only reliable hard-stop mechanism in Claude Code. CLAUDE.md and skills are advisory; hooks are deterministic.
- **`permissions.deny` is the primary defense for secret files.** The `.env`-blocking pre-tool hook is belt-and-suspenders. `.claudeignore` is intentionally not included — it's a community convention that Claude Code does not officially honor.
- **`post_tool_use.sh` picks one formatter** by checking which lockfile exists (`pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, etc.). Earlier versions of this pattern double-formatted with both pnpm and npm if both binaries existed; this one doesn't.
- **MCP credentials live in your shell, not the file.** `.mcp.json` references `${GITHUB_TOKEN}`, `${LINEAR_API_KEY}` etc.; export them in your shell or secret manager. A DB MCP server was deliberately left out — passing a live `DATABASE_URL` as an MCP arg violates the secret-handling rules in CLAUDE.md.

## Customize before shipping to your team

The pack is opinionated; some of it will not match your repo. Expect to edit:

1. **CLAUDE.md** — add your stack, your build commands, your project-specific gotchas.
2. **`.mcp.json`** — remove servers you don't use, add ones you do.
3. **`settings.json` permissions** — add the bash commands your team actually runs to the `allow` list so you stop hitting approval prompts.
4. **Skills** — many are general-purpose. Add project-specific ones for your patterns (your auth flow, your migration runner, your deploy procedure).
5. **`.github/workflows/claude-review.yml`** — set `ANTHROPIC_API_KEY` as a repo secret, or delete the file if you don't want auto-review on PRs.

## Updating

Hook schemas and settings keys evolve. Keep Claude Code current, and validate against the official schema (the `$schema` reference in `settings.json` will surface unknown keys in editors that respect it). The `/skills-audit` command checks `.claude/skills/` for the issues that actually break skill discovery.

## Why this exists

The default Claude Code experience is "single CLAUDE.md and approve prompts forever". The full surface — agents, commands, hooks, skills, MCP, output styles — is powerful but easy to misconfigure (vague agent descriptions cause overlapping fires; bare hook paths break in subdirectories; cloned commands provide the illusion of structure without doing different work). This pack is a working baseline that avoids those pitfalls and that you customize from, not a kitchen-sink demo.
