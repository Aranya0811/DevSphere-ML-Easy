#!/usr/bin/env bash
# =============================================================
#  DevSphere ML-Easy — Test Runner
#
#  Called by:
#    - pre-commit hook (local)
#    - fork-ci.yml     (fork push, participant's CI minutes)
#    - pr-checks.yml   (PR to main, authoritative)
#
#  Platform support:
#    Linux / macOS / Windows (Git Bash or WSL)
#    Requires only python3 — no pip install needed (stdlib only).
#
#  Exit 0 = all checks passed
#  Exit 1 = one or more checks failed
# =============================================================
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ── Run the static notebook checker ───────────────────────────
#
#  checker.py inspects devsphere_easy_challenge.ipynb for all
#  required fixes.  It prints the first failing check and exits
#  with 1, or prints "PASS" and exits with 0.

echo "── Check notebook ───────────────────────────────────────"
python3 "$ROOT/tests/checker.py"
RESULT=$?

echo ""
echo "────────────────────────────────────────────────────────"
if [[ $RESULT -eq 0 ]]; then
  echo "  Result: PASS"
else
  echo "  Result: FAIL"
fi
echo "────────────────────────────────────────────────────────"

exit $RESULT
