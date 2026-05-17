# clauderail

An opinionated `.claude/` starter pack for Claude Code: CLAUDE.md, settings with sensible permissions, hooks that actually block dangerous commands, eight focused subagents, thirteen slash commands, a curated skills library, and MCP config.

## Install via marketplace (recommended)

Add clauderail as a marketplace source once, then install the all-in-one setup plugin:

```
/plugin marketplace add Bridev04/clauderail
/plugin install setupclauderail@clauderail
```

Open your project in Claude Code and run:

```
/setupclauderail
```

That bootstraps the full clauderail template into your project's `.claude/` and `CLAUDE.md`. Restart Claude Code so the new agents, commands, and skills load.

To install individual agents instead of the full kit:

```
/plugin install code-reviewer@clauderail
/plugin install security-auditor@clauderail
/plugin install debugger@clauderail
```

Full plugin list: `setupclauderail`, `code-reviewer`, `debugger`, `dependency-auditor`, `docs-writer`, `planner`, `refactorer`, `security-auditor`, `test-engineer`.

## Install via clone

```bash
git clone https://github.com/Bridev04/clauderail.git /tmp/clauderail

cd your-project
mkdir -p .claude

cp /tmp/clauderail/settings.json           .claude/
cp -r /tmp/clauderail/agents               .claude/
cp -r /tmp/clauderail/commands             .claude/
cp -r /tmp/clauderail/skills               .claude/
cp -r /tmp/clauderail/hooks                .claude/
cp -r /tmp/clauderail/rules                .claude/
cp -r /tmp/clauderail/output-styles        .claude/
cp /tmp/clauderail/CLAUDE.md               ./
cp /tmp/clauderail/.mcp.json               ./

chmod +x .claude/hooks/*.sh
rm -rf /tmp/clauderail
```

## What's in the box

```
.claude/
├── settings.json                 # permissions, hooks wiring, status line
├── agents/                       # 8 subagents, each with a distinct method
│   ├── code-reviewer.md
│   ├── debugger.md
│   ├── dependency-auditor.md
│   ├── docs-writer.md
│   ├── planner.md
│   ├── refactorer.md
│   ├── security-auditor.md
│   └── test-engineer.md
├── commands/                     # 13 slash commands
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
│   └── stop.sh  subagent_stop.sh  notify.sh  statusline.sh
├── output-styles/
│   └── senior-engineer.md        # concise senior-engineer voice
├── rules/
│   └── security.md               # baseline security rules
└── skills/                       # 20 on-demand playbooks

.github/workflows/
├── ci.yml                        # real CI — fails on actual errors
└── claude-review.yml             # official Claude Code Action on PRs

CLAUDE.md                         # team operating instructions
.mcp.json                         # GitHub, Sentry, Context7, Playwright,
                                  # filesystem, Linear MCP servers
```

## Wiring notes

- **Hooks run from `$CLAUDE_PROJECT_DIR`.** Logs land in `.claude/logs/` at the project root.
- **`exit 2` from a `PreToolUse` hook hard-blocks the tool call.** Hooks are deterministic; CLAUDE.md and skills are advisory.
- **`post_tool_use.sh` picks one formatter** by checking which lockfile exists (`pnpm-lock.yaml` → pnpm, `yarn.lock` → yarn, etc.).
- **MCP credentials live in your shell, not the file.** `.mcp.json` references `${GITHUB_TOKEN}`, `${LINEAR_API_KEY}` etc.

## Customize before shipping to your team

1. **CLAUDE.md** — add your stack, build commands, project-specific gotchas.
2. **`.mcp.json`** — remove servers you don't use, add ones you do.
3. **`settings.json` permissions** — add the bash commands your team actually runs to the `allow` list.
4. **Skills** — add project-specific ones for your auth flow, migration runner, deploy procedure.
5. **`.github/workflows/claude-review.yml`** — set `ANTHROPIC_API_KEY` as a repo secret, or delete if unused.

## License

MIT
