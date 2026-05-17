---
name: setupclauderail
description: Set up clauderail in any project. Bootstraps `.claude/` from the bundled template if missing, installs agents, commands, skills, hooks, rules, and CLAUDE.md.
argument-hint: "[optional: focus area]"
disable-model-invocation: true
---

Set up clauderail in this project. If `.claude/` doesn't exist yet, bootstrap it from the template bundled inside this plugin.

`CLAUDE.md` must be at the project root (`./CLAUDE.md`), NOT inside `.claude/`. All other config files live inside `.claude/`.

## Phase Init: Bootstrap .claude/ if missing

Check for `.claude/settings.json`:

- If it exists: `.claude/` is already set up. Tell the user and stop.
- If it does NOT exist: bootstrap from the bundled template.

When bootstrapping:

1. Use AskUserQuestion: "This project has no `.claude/` set up yet. Bootstrap it from the clauderail template?" Options: `yes` / `no`.

2. If the user says **no**, stop.

3. If the user says **yes**, run these commands (`$CLAUDE_PLUGIN_ROOT` is set by Claude Code to this plugin's installation directory):

   ```bash
   mkdir -p .claude/agents .claude/commands .claude/skills .claude/hooks .claude/rules .claude/output-styles
   cp    "$CLAUDE_PLUGIN_ROOT/template/settings.json"        .claude/
   cp -r "$CLAUDE_PLUGIN_ROOT/template/agents/."             .claude/agents/
   cp -r "$CLAUDE_PLUGIN_ROOT/template/commands/."           .claude/commands/
   cp -r "$CLAUDE_PLUGIN_ROOT/template/skills/."             .claude/skills/
   cp -r "$CLAUDE_PLUGIN_ROOT/template/hooks/."              .claude/hooks/
   cp -r "$CLAUDE_PLUGIN_ROOT/template/rules/."              .claude/rules/
   cp -r "$CLAUDE_PLUGIN_ROOT/template/output-styles/."      .claude/output-styles/
   chmod +x .claude/hooks/*.sh
   ```

   Then handle root files (don't overwrite existing ones):

   ```bash
   [ -f ./CLAUDE.md ]  || cp "$CLAUDE_PLUGIN_ROOT/template/CLAUDE.md"  ./
   [ -f ./.mcp.json ]  || cp "$CLAUDE_PLUGIN_ROOT/template/.mcp.json"  ./
   ```

4. Tell the user what was installed, then tell them to **restart Claude Code** so the new agents, commands, and skills load.

If `$CLAUDE_PLUGIN_ROOT` is unset, tell the user to re-install via the marketplace or follow the manual clone path at https://github.com/Bridev04/clauderail.

## Rules

- NEVER apply changes without user confirmation
- NEVER overwrite an existing `CLAUDE.md` or `.mcp.json`
