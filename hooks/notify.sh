#!/usr/bin/env bash
# Notification hook — runs when Claude wants the user's attention.
# Logs the notification and surfaces it via a desktop notifier if one is
# installed. Best-effort; never fails the hook.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

payload="$(cat || true)"
printf '%s\n' "$payload" >> "${LOG_DIR}/notifications.jsonl"

# Try desktop notifiers in order. Stop after the first one that works.
if command -v terminal-notifier >/dev/null 2>&1; then
  terminal-notifier -title "Claude Code" -message "Claude needs attention" 2>/dev/null || true
elif command -v notify-send >/dev/null 2>&1; then
  notify-send "Claude Code" "Claude needs attention" 2>/dev/null || true
elif command -v osascript >/dev/null 2>&1; then
  # macOS fallback if terminal-notifier isn't installed.
  osascript -e 'display notification "Claude needs attention" with title "Claude Code"' 2>/dev/null || true
fi

exit 0
