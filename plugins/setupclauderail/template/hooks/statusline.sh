#!/usr/bin/env bash
# Status line — runs frequently (every refreshInterval seconds).
# Keep it FAST. No git fetches, no network, no heavy commands.
#
# Reads JSON from stdin describing the current session; outputs a single line.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"

input="$(cat || true)"

if command -v jq >/dev/null 2>&1 && [ -n "$input" ]; then
  model=$(printf '%s' "$input" | jq -r '.model.display_name // .model.name // "Claude"' 2>/dev/null || echo Claude)
  ctx=$(printf '%s' "$input" | jq -r '.context_window.used_percentage // .context.usage_percent // 0' 2>/dev/null || echo 0)
else
  model="Claude"
  ctx=0
fi

cd "$PROJECT_DIR" 2>/dev/null || true
branch=$(git branch --show-current 2>/dev/null || echo "no-git")
dirty=$(git status --short 2>/dev/null | wc -l | tr -d ' ' || echo 0)

# Color the context percentage as a quick visual signal.
ctx_int=${ctx%.*}
ctx_int=${ctx_int:-0}
if [ "$ctx_int" -ge 80 ] 2>/dev/null; then
  ctx_color=$'\033[31m'   # red
elif [ "$ctx_int" -ge 50 ] 2>/dev/null; then
  ctx_color=$'\033[33m'   # yellow
else
  ctx_color=$'\033[32m'   # green
fi
reset=$'\033[0m'
dim=$'\033[2m'

if [ "$dirty" = "0" ]; then
  dirty_str="${dim}clean${reset}"
else
  dirty_str="${dirty} changed"
fi

printf "[%s] %s%s%%%s ctx %s|%s %s %s|%s %s" \
  "$model" "$ctx_color" "$ctx_int" "$reset" \
  "$dim" "$reset" "$branch" \
  "$dim" "$reset" "$dirty_str"
