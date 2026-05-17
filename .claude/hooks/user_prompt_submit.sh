#!/usr/bin/env bash
# UserPromptSubmit hook.
# - Logs the prompt for audit.
# - Warns (does not block) if the prompt appears to contain literal secrets.
#   Blocking the user's own prompt is rarely what you want; a warning surfaced
#   to stderr is enough.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

payload="$(cat || true)"
printf '%s\n' "$payload" >> "${LOG_DIR}/user-prompts.jsonl"

# Soft warning for obvious secrets pasted into the prompt.
if printf '%s' "$payload" | grep -Eiq '(api[_-]?key|secret|token|password|bearer)[[:space:]]*[:=][[:space:]]*[A-Za-z0-9_\-]{16,}'; then
  echo "Note: your prompt appears to contain something that looks like a real secret." >&2
  echo "Prefer redacted placeholders (e.g. 'sk-EXAMPLE-***') when sharing examples." >&2
fi

exit 0
