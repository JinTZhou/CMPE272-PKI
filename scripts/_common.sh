#!/usr/bin/env bash
# Shared setup for scripts in this homework package.
set -euo pipefail
umask 077
HW_PROJECT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$HW_PROJECT_DIR"
require_files() {
  local file
  for file in "$@"; do
    if [[ ! -f "$file" ]]; then
      printf 'Missing %s. Complete the preceding step first.\n' "$file" >&2
      exit 1
    fi
  done
}
refuse_existing() {
  local file
  for file in "$@"; do
    if [[ -e "$file" ]]; then
      printf 'Already exists: %s. Stopping to preserve your existing work.\n' "$file" >&2
      exit 1
    fi
  done
}
