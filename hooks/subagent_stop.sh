#!/usr/bin/env bash
# SubagentStop hook — runs when a Task subagent finishes.
# Lightweight log; useful for understanding subagent fan-out.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

date -u +"%Y-%m-%dT%H:%M:%SZ subagent complete" >> "${LOG_DIR}/subagents.log"

exit 0
