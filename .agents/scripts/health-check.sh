#!/usr/bin/env bash
set -euo pipefail
if command -v free >/dev/null; then free -h; fi
for tool in git terraform helm aws; do
  if command -v "$tool" >/dev/null; then
    printf '%s available\n' "$tool"
  else
    printf '%s unavailable\n' "$tool"
  fi
done
