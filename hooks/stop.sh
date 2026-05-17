#!/usr/bin/env bash
# Stop hook — runs when Claude finishes a response.
# Captures the final git state for audit / "what did the session do" reviews.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

cd "$PROJECT_DIR" || exit 0

git status --short > "${LOG_DIR}/last-git-status.txt" 2>/dev/null || true
git log --oneline -5 > "${LOG_DIR}/last-recent-commits.txt" 2>/dev/null || true
date -u +"%Y-%m-%dT%H:%M:%SZ" > "${LOG_DIR}/last-stop.txt"

exit 0
