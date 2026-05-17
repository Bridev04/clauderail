#!/usr/bin/env bash
# Secret scanner for Edit/Write/MultiEdit payloads.
# Blocks (exit 2) if recognizable secret patterns appear in the content being written.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

payload="$(cat || true)"

# Patterns chosen to have very low false-positive rates. Each is either a
# documented prefix (sk-, xox-, ghp_, AKIA, github_pat_) or a structural marker
# (PEM headers, DB URLs with credentials).
PATTERNS='(sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{10,}|ghp_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,}|AKIA[0-9A-Z]{16}|ASIA[0-9A-Z]{16}|-----BEGIN[[:space:]]+(RSA[[:space:]]+|EC[[:space:]]+|OPENSSH[[:space:]]+|DSA[[:space:]]+|PGP[[:space:]]+)?PRIVATE[[:space:]]+KEY-----|(postgres|postgresql|mysql|mongodb(\+srv)?|redis|rediss|amqp|amqps)://[^:[:space:]]+:[^@[:space:]]+@)'

if printf '%s' "$payload" | grep -Eq "$PATTERNS"; then
  {
    echo "Blocked by .claude/hooks/secret_scan.sh: potential secret in write payload."
    echo "Remove the literal value and load it from environment variables or a secret manager."
    echo "If this is a placeholder for documentation, use an obviously-fake value like 'sk-EXAMPLE-not-a-real-key'."
  } >&2
  # Log the block (without the payload itself) for audit.
  date -u +"%Y-%m-%dT%H:%M:%SZ secret_scan blocked write" >> "${LOG_DIR}/blocks.log"
  exit 2
fi

exit 0
