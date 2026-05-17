#!/usr/bin/env bash
# PreCompact hook — runs before Claude compresses the conversation.
# Snapshots the current session context so important state isn't lost in
# compaction, and surfaces a reminder of what to preserve.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
COMPACT_DIR="${LOG_DIR}/compactions"
mkdir -p "$COMPACT_DIR"

# Archive the current session-context if it exists.
if [ -f "${LOG_DIR}/session-context.md" ]; then
  cp "${LOG_DIR}/session-context.md" "${COMPACT_DIR}/session-context-$(date +%s).md" 2>/dev/null || true
fi

# Surface a reminder to stderr — Claude reads this and may use it to bias
# what it keeps across the compaction boundary.
cat >&2 <<'EOF'
Before compaction, preserve:
- The current goal (one sentence).
- Decisions already made and why.
- Files modified this session and what changed in each.
- Commands run and their results.
- Open TODOs and the next concrete step.
EOF

exit 0
