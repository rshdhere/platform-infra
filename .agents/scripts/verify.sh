#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
for project in cms devin metaverse; do
  for dir in environments modules; do
    [[ -d "$project/$dir" ]] || { echo "Missing $project/$dir" >&2; exit 1; }
  done
done
for file in cms/AGENTS.md cms/README.md .agents/context/architecture.md .agents/workflows/feature-development.md; do
  [[ -s "$file" ]] || { echo "Missing or empty: $file" >&2; exit 1; }
done
for script in .agents/scripts/*.sh; do bash -n "$script"; done
echo "Infrastructure layout and shell syntax verified."
