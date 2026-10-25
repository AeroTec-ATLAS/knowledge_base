#!/usr/bin/env bash
# Local preview, creating .venv/ on first run.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [[ ! -x .venv/bin/python || ! -x .venv/bin/zensical ]]; then
  echo "Creating .venv and installing requirements..."
  python3 -m venv .venv
  .venv/bin/pip install -r requirements.txt
fi

exec .venv/bin/zensical serve "$@"
