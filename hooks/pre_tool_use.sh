#!/usr/bin/env bash
# PreToolUse hook.
# - Logs the tool input.
# - Hard-blocks dangerous shell patterns even if permissions are loosened.
# - Hard-blocks reads of secret-bearing files.
#
# Exit 2 = block the tool call. Anything else = allow.

set -euo pipefail

# Anchor everything to the project root so the hook works regardless of cwd.
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

payload="$(cat || true)"
printf '%s\n' "$payload" >> "${LOG_DIR}/tool-events.jsonl"

# Block dangerous shell patterns. Each pattern is conservative — we'd rather
# block a benign command and have the user re-approve than allow a destructive
# one to slip through.
DANGEROUS_PATTERNS='(rm[[:space:]]+-rf[[:space:]]+/|rm[[:space:]]+-rf[[:space:]]+~|sudo[[:space:]]+rm|chmod[[:space:]]+-R[[:space:]]+777|curl[[:space:]][^|]*\|[[:space:]]*sh|wget[[:space:]][^|]*\|[[:space:]]*sh|\beval[[:space:]]|npm[[:space:]]+publish|pnpm[[:space:]]+publish|git[[:space:]]+push[[:space:]]+--force(\b|[[:space:]])|terraform[[:space:]]+destroy|kubectl[[:space:]]+delete)'

if printf '%s' "$payload" | grep -Eiq "$DANGEROUS_PATTERNS"; then
  echo "Blocked by .claude/hooks/pre_tool_use.sh: dangerous command pattern detected." >&2
  echo "If this is intentional, ask the user to approve explicitly or update the hook." >&2
  exit 2
fi

# Block reads of typical secret-bearing files. settings.json permissions.deny
# is the primary defense; this is belt-and-suspenders.
SECRET_PATTERNS='(\.env(\.[a-zA-Z0-9_-]+)?(\b|"|/|$)|/secrets/|id_rsa|\.pem(\b|"|/|$)|\.p12(\b|"|/|$)|\.pfx(\b|"|/|$)|\.key(\b|"|/|$))'

if printf '%s' "$payload" | grep -Eiq "$SECRET_PATTERNS"; then
  echo "Blocked by .claude/hooks/pre_tool_use.sh: possible secret-file access." >&2
  echo "Read .env-style files via your config module, not directly." >&2
  exit 2
fi

exit 0
