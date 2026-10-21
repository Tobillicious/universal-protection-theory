#!/usr/bin/env python3
"""Re-run every v0.17.11 rung-4 checker and compare with its recorded output (author side, Claude, 20 Oct 2026)."""
import os, subprocess, sys, json
from pathlib import Path
HERE = Path(__file__).resolve().parent
CHECKS = ["check_gates.py", "check_0b_k3.py", "check_c2.py", "check_followups.py", "check_floor.py", "check_c2_screen.py", "check_rung5.py", "check_physical.py"]
ok_all = True; rows = []
for c in CHECKS:
    # The exact checkers print integers with more than 4300 digits; CPython 3.11+ (and late 3.9/3.10 patches)
    # refuse that by default, so lift the limit for the child process. Reported by skitter-swarmmemo, 21 Oct 2026.
    p = subprocess.run([sys.executable, "-B", str(HERE / c)], capture_output=True, text=True, cwd=HERE,
                       env=dict(os.environ, PYTHONINTMAXSTRDIGITS="0"))
    if not p.stdout.strip():
        sys.exit(f"FAIL {c}: no output, exit {p.returncode}. stderr:\n{p.stderr[-2000:]}")
    recorded = (HERE / c.replace(".py", ".out")).read_text()
    same = p.stdout == recorded
    summary = json.loads(p.stdout.strip().splitlines()[-1])
    good = p.returncode == 0 and not p.stderr and same and summary["passed"] == summary["total"]
    ok_all &= good
    rows.append((c, summary["passed"], summary["total"], p.returncode, same))
    print(f"{'PASS' if good else 'FAIL'} {c}: {summary['passed']}/{summary['total']}, exit {p.returncode}, matches recorded output: {same}")
print(json.dumps({"checkers": len(CHECKS), "all_pass": ok_all, "checks": sum(r[2] for r in rows)}))
sys.exit(0 if ok_all else 1)
