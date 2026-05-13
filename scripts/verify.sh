#!/usr/bin/env bash
# Lightweight checks for this static repo (no npm). Run from repo root: ./scripts/verify.sh
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if grep -q '0 / 22' index.html || grep -q 'step 0 of 22' index.html; then
  echo "verify: FAIL — index.html still has stale 22-step progress copy (expected 17 without ?gate=1)." >&2
  exit 1
fi

if grep -qiE '20[\s-]*question' index.html README.md ROADMAP.md 2>/dev/null; then
  echo "verify: FAIL — found stale '20 question' marketing copy (audit is 15 questions; legacy v1 hash only)." >&2
  exit 1
fi

if ! grep -q 'id="scoreMethodology"' index.html || ! grep -q 'How this score works' index.html; then
  echo "verify: FAIL — results methodology section missing (expected id scoreMethodology + heading)." >&2
  exit 1
fi

python3 <<'PY'
import re
from pathlib import Path
html = Path("index.html").read_text(encoding="utf-8")
m = re.search(r"const questions = \[(.*?)\n\];", html, re.S)
if not m:
    raise SystemExit("verify: FAIL — could not find questions array")
block = m.group(1)
n = block.count("{ cat:")
if n != 15:
    raise SystemExit(f"verify: FAIL — expected 15 audit questions, found {n}")
print("verify: OK (15 questions, no stale 22-step / 20-question UI copy)")
PY
