---
description: Audit the .claude/skills/ directory — broken frontmatter, vague descriptions, duplicate triggers, missing references.
allowed-tools: Read, Grep, Glob, LS, Bash
---

# /skills-audit

## Task

Walk `.claude/skills/` and check each `SKILL.md` for the issues that actually cause skills to misfire or fail to fire. Report findings.

### What to check

1. **Frontmatter exists and is valid YAML.** Each SKILL.md must open with `---`, contain `name:` and `description:`, and close with `---`.

2. **`name` matches the directory.** A skill in `.claude/skills/foo/SKILL.md` must have `name: foo`. Mismatches break discovery.

3. **`description` is specific, not vague.** Bad descriptions cause overlapping auto-invocation (every skill firing on every prompt). Specifically check:
   - Does it start with a trigger word like "Use when..."?
   - Does it name the file types, directories, or actions that activate it?
   - Is it under ~300 characters? (Long descriptions cost context and dilute matching.)
   - Does it overlap heavily with another skill's description? (Run a quick diff of phrasing across all skills.)

4. **Body is lean.** Long SKILL.md files cost context every time the skill is considered. Anything over ~150 lines should probably push detail into a `references/` subdirectory and link to it.

5. **No hardcoded paths, secrets, or machine-specific commands.** Skills are committed to git and used across machines.

6. **Workflow / output format is concrete.** A skill that says "do good work" provides no value. Look for explicit steps, decision rules, and an output template.

### Output

```
## Summary
<N skills audited, M issues found>

## Skills with issues

### <skill-name>
- **Issue:** <one line>
- **Evidence:** <file:line or quote>
- **Suggested fix:** <one line>

## Description overlap
- <skill-a> and <skill-b> both fire on <pattern>. Likely cause: <reason>. Suggested fix: <which one to narrow>.

## Skills that are healthy
- <skill-name> — <one line on what's good about it>
```

## Rules
- This command is read-only. It produces a report; the user decides what to change.
- Be specific. "Description is vague" without quoting it isn't actionable.
- If `.claude/skills/` doesn't exist or is empty, say so and stop.
