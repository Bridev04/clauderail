---
description: Stage and commit the current changes with a conventional-commits message. Only commits when the user explicitly approves.
allowed-tools: Read, Grep, Glob, LS, Bash
argument-hint: "[optional: scope or focus hint]"
---

# /commit

## Live context
- Branch: !`git branch --show-current 2>/dev/null || echo unknown`
- Status: !`git status --short 2>/dev/null || true`
- Staged diff stat: !`git diff --cached --stat 2>/dev/null || true`
- Unstaged diff stat: !`git diff --stat 2>/dev/null || true`
- Recent commits (for style): !`git log --oneline -10 2>/dev/null || true`

## Task

Prepare **one** good commit. Do not push.

### 1. Decide what's in scope
- If files are already staged, that's the commit scope. Don't add more unless asked.
- If nothing is staged but there are unstaged changes, list them grouped by likely commit boundary (related changes together). Ask the user which group to commit. Do not auto-stage everything.
- If there's nothing to commit, say so and stop.

### 2. Read the actual diff
Run `git diff --cached` (or the diff of the proposed staged set). Read it. Your message must describe what the diff actually does, not what the user said they were doing.

### 3. Write the message
Conventional commits format. Type prefix from this list only:
`feat`, `fix`, `docs`, `test`, `refactor`, `chore`, `perf`, `ci`, `build`, `security`, `revert`.

Shape:
```
<type>(<optional scope>): <imperative summary, <=72 chars>

<optional body: what + why, wrapped at 72 chars>

<optional footer: BREAKING CHANGE: ..., Refs: #123, Co-authored-by: ...>
```

Rules for the message:
- Imperative mood: "add", not "added" or "adds".
- Summary describes the *outcome*, not the activity. "fix: prevent double-charge on retry" not "fix: change retry logic".
- Body is only needed when the *why* isn't obvious from the diff.
- `BREAKING CHANGE:` in the footer only if there's an actual API or behavior break callers can detect.

### 4. Pre-commit checks
Before committing:
- `git diff --cached | grep -E '(AKIA|sk-[A-Za-z0-9]{20,}|BEGIN.*PRIVATE KEY|password\s*=\s*["\047])'` — if anything matches, **stop**, surface it, and do not commit.
- If the repo has a husky/lefthook/pre-commit hook, do not bypass it with `--no-verify`.

### 5. Confirm and commit
Show the user the final message and the file list. Wait for explicit approval ("yes", "go", "commit"). On approval, run `git commit`. On disapproval, revise and ask again.

### 6. After commit
- Show `git log -1 --stat` so the user sees what landed.
- Do **not** push. Pushing is a separate decision.

## $ARGUMENTS
If `$ARGUMENTS` is provided, treat it as a scope hint (e.g. "auth refactor") to bias the message wording — not as the full message.
