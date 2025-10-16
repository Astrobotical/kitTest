#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
TEMPLATES=("$ROOT_DIR/.specify/templates/plan-template.md" "$ROOT_DIR/.specify/templates/tasks-template.md")
MISSING=0

for t in "${TEMPLATES[@]}"; do
  if [ ! -f "$t" ]; then
    echo "Missing template: $t" >&2
    MISSING=1
    continue
  fi
  if ! grep -qi "Constitution Check" "$t"; then
    echo "Template $t is missing 'Constitution Check' section" >&2
    MISSING=1
  fi
done

if [ "$MISSING" -ne 0 ]; then
  echo "Constitution validation failed" >&2
  exit 2
fi

echo "Constitution validation passed"
exit 0
