#!/usr/bin/env bash
# PostToolUse hook for Edit/Write/MultiEdit.
# - Logs the event.
# - Runs the project's formatter if one is configured. Picks ONE — never
#   double-formats with pnpm and npm.
# - All formatter calls are best-effort: failures are logged but don't block.

set -euo pipefail

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(pwd)}"
LOG_DIR="${PROJECT_DIR}/.claude/logs"
mkdir -p "$LOG_DIR"

payload="$(cat || true)"
printf '%s\n' "$payload" >> "${LOG_DIR}/post-tool-events.jsonl"

cd "$PROJECT_DIR" || exit 0

# Format JS/TS via the project's package manager. Choose exactly one:
# lockfile presence is the authoritative signal for which PM the repo uses.
if [ -f package.json ] && grep -q '"format"' package.json; then
  if [ -f pnpm-lock.yaml ] && command -v pnpm >/dev/null 2>&1; then
    pnpm -s format >"${LOG_DIR}/format.log" 2>&1 || true
  elif [ -f yarn.lock ] && command -v yarn >/dev/null 2>&1; then
    yarn -s format >"${LOG_DIR}/format.log" 2>&1 || true
  elif [ -f package-lock.json ] && command -v npm >/dev/null 2>&1; then
    npm run -s format >"${LOG_DIR}/format.log" 2>&1 || true
  elif command -v npm >/dev/null 2>&1; then
    # No lockfile but a format script exists. Fall back to npm.
    npm run -s format >"${LOG_DIR}/format.log" 2>&1 || true
  fi
fi

# Format Python via ruff if pyproject.toml is present.
if [ -f pyproject.toml ] && command -v ruff >/dev/null 2>&1; then
  ruff format . >"${LOG_DIR}/ruff-format.log" 2>&1 || true
fi

# Format Go.
if [ -f go.mod ] && command -v gofmt >/dev/null 2>&1; then
  gofmt -w . >"${LOG_DIR}/gofmt.log" 2>&1 || true
fi

# Format Rust.
if [ -f Cargo.toml ] && command -v cargo >/dev/null 2>&1; then
  cargo fmt --quiet >"${LOG_DIR}/cargo-fmt.log" 2>&1 || true
fi

exit 0
