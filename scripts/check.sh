#!/usr/bin/env bash
# Build the site exactly as CI does, creating .venv/ on first run.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

if [[ ! -x .venv/bin/python || ! -x .venv/bin/zensical ]]; then
  echo "Creating .venv and installing requirements..."
  python3 -m venv .venv
  .venv/bin/pip install -r requirements.txt
fi

.venv/bin/python scripts/gen_llms_txt.py
.venv/bin/zensical build --strict
