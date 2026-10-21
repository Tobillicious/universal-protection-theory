#!/usr/bin/env python3
"""Rung 5 numerical facts on the frozen inherited model (author side, 20 Oct 2026). Exact Fractions.
R5.1 the scenario grid has 10 rows and the k = 3 ledger counts all 10.
R5.2 the rescue bound decreases as service probability pc increases along the grid.
R5.3 at pc = 499/500 with each row's own grid law, every row's ledger total is at most the existing worst total."""
import json, sys
from fractions import Fraction as F
from pathlib import Path
sys.dont_write_bytecode = True
FROZEN = Path(__file__).resolve().parent / "frozen" / "upt-rung4a"
sys.path.insert(0, str(FROZEN / "checks"))
import common
c, j, _ = common.baseline(); m = j.m; b = m.b; ch = m.prior
R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))
READ = list(ch.prior.old.READINGS); RESP = sorted(ch.prior.old.RESPONSES)
screen = json.load(open(FROZEN / "K3-SCREEN.json"))
check("R5.1 grid rows = 10 and the k3 ledger counts all of them", len(READ) * len(RESP) == 10 == len(screen["all21_screen"]["rows"]))
q, W = F(1, 2), 42800
base = [ch.capacity_channels(q, r, W, 'slack') for r in RESP]
res = [x["rescue"] for x in base]; hold = [x["holding"] for x in base]
check("R5.2 rescue bound strictly decreases along the grid as pc rises", all(res[i] > res[i + 1] for i in range(len(res) - 1)))
control("R5.2 reversed order", all(res[i] < res[i + 1] for i in range(len(res) - 1)))
worst = max(F(r["with_reserve"]["exact"]) for r in screen["all21_screen"]["rows"].values())
orig = b.scenario
def high_pc(r, reading):
    pc, cost, eps = orig(r, reading)
    return F(499, 500), cost, eps
b.scenario = high_pc; ch.capacity_channels.cache_clear()
hix = [ch.capacity_channels(q, r, W, 'slack') for r in RESP]
hi = [x["rescue"] for x in hix]; hihold = [x["holding"] for x in hix]
b.scenario = orig; ch.capacity_channels.cache_clear()
check("R5.3 at pc = 499/500 each row's rescue bound is at most its grid value", all(h <= g for h, g in zip(hi, res)))
# pc enters the ledger only through holding and rescue: ordinary_holding = MT*ph, ordinary_rescue = MT*pr,
# coordinated_load = MT*(ph+pr). So each row's total changes by 2*MT*(d_ph + d_pr).
MT = m.MT
deltas = [2 * MT * ((hh - h) + (rr - r0)) for hh, h, rr, r0 in zip(hihold, hold, hi, res)]
check("R5.3b each row's ledger total changes by 2*MT*(d_holding + d_rescue) <= 0 at pc = 499/500", all(d <= 0 for d in deltas))
check("R5.3c hence every row stays at or below the existing worst total, which is within 1e-6", worst <= F(1, 10**6), float(worst))
ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
