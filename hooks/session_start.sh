#!/usr/bin/env bash
# SessionStart hook — runs at the beginning of each Claude Code session.
# Writes a session-context file the session can reference if needed.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

cd "$PROJECT_DIR" || exit 0

{
  echo "# Session context"
  echo "- Time UTC: $(date -u +"%Y-%m-%dT%H:%M:%SZ")"
  echo "- Project: $(basename "$PROJECT_DIR")"
  echo "- Branch: $(git branch --show-current 2>/dev/null || echo not-a-git-repo)"
  echo "- HEAD: $(git rev-parse --short HEAD 2>/dev/null || echo none)"
  echo "- Working tree:"
  git status --short 2>/dev/null | head -50 || echo "  (no git state)"
} > "${LOG_DIR}/session-context.md"

exit 0
