#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="${ENV_FILE:-$REPO_ROOT/scripts/update-awesome-rea.env}"
README_BUILDER="${README_BUILDER:-$REPO_ROOT/scripts/build-readme.py}"
COMMIT_MESSAGE="${COMMIT_MESSAGE:-chore: periodic REA evidence sweep}"
BRANCH="${BRANCH:-}"
SKIP_PUSH="${SKIP_PUSH:-0}"
REBUILD_README="${REBUILD_README:-0}"
REMOTE_URL="${REMOTE_URL:-}"

if [ -f "$ENV_FILE" ]; then
  # shellcheck disable=SC1090
  source "$ENV_FILE"
fi

log() {
  echo "[commit-and-push] $*"
}

fail() {
  log "$*" >&2
  exit 1
}

run_readme_builder() {
  [ -f "$README_BUILDER" ] || fail "README builder not found: $README_BUILDER"

  if command -v python3 >/dev/null 2>&1; then
    python3 "$README_BUILDER"
    return 0
  fi

  if command -v python >/dev/null 2>&1; then
    python "$README_BUILDER"
    return 0
  fi

  fail "python3/python not found for README rebuild"
}

has_changes() {
  ! git diff --quiet -- . \
    || ! git diff --cached --quiet -- . \
    || [ -n "$(git ls-files --others --exclude-standard -- .)" ]
}

cd "$REPO_ROOT"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  fail "not a git repository: $REPO_ROOT"
fi

if [ "$REBUILD_README" = "1" ]; then
  run_readme_builder
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  [ -n "$REMOTE_URL" ] || fail "origin remote is not configured and REMOTE_URL is empty"
  git remote add origin "$REMOTE_URL"
fi

if [ -z "$BRANCH" ]; then
  BRANCH="$(git branch --show-current)"
fi

[ -n "$BRANCH" ] || fail "could not determine current branch; set BRANCH explicitly"

if ! has_changes; then
  log "no repository changes"
  exit 0
fi

git add -A

if git diff --cached --quiet -- .; then
  log "nothing staged after git add"
  exit 0
fi

git commit -m "$COMMIT_MESSAGE"

if [ "$SKIP_PUSH" = "1" ]; then
  log "SKIP_PUSH=1, leaving commit local"
  exit 0
fi

git push -u origin "$BRANCH"
log "pushed to origin/$BRANCH"
