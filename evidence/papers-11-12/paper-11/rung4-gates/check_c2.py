#!/usr/bin/env python3
"""Open problem 7: C2 minds (identity needs an unbroken, never-paused existence) at k = 3.
Author side, Claude, 20 Oct 2026. Exact integers/Fractions.

Construction C2-LOCK: a C2 mind runs as r lockstep replicas on r distinct islands. A step commits when a
majority of replicas agree. Under P-K3 at most K islands are unavailable at any instant, and inside the local
good region an available island serves its replica. So a majority is always present iff r - K >= floor(r/2) + 1.
Residual risk = leaving the good region, which is already in the existing accounts (no new account).
New premise P-LOCK: one lockstep majority round fits the mind's step deadline (not derived here)."""
import json, sys
from fractions import Fraction as F
from math import ceil, floor, comb

R = []
def check(n, ok, d=""): R.append((n, bool(ok), str(d)))
def control(n, bad_ok, d=""): R.append(("CONTROL " + n, not bool(bad_ok), str(d)))

def never_pauses(r, k): return r - k >= r // 2 + 1
def r_min(k): return next(r for r in range(1, 100) if never_pauses(r, k))
check("C2.1 k=3: minimum replica count is 7 (= 2k+1)", r_min(3) == 7)
check("C2.2 twilight k=2: 5 replicas suffice", r_min(2) == 5)
control("C2.1 six replicas at k=3", never_pauses(6, 3))
control("C2.1 seven replicas at k=4 (beyond the premise)", never_pauses(7, 4))
# exhaustive over every set of <= 3 unavailable islands among 7 replica islands
from itertools import combinations
ok = all(7 - len(L) >= 4 for j in range(4) for L in combinations(range(7), j))
check("C2.3 exhaustive: every <=3-island mask leaves a 4-of-7 majority", ok)

# capacity: slots. Each C2 mind adds r-1 = 6 extra execution slots elsewhere in the pool; spread evenly.
M, x, S, SLOTS = 1032, 8, 171, 8
pop = M + x
cmax = (F(SLOTS * S, pop) - 1) / 6
check("C2.4 slot capacity bounds the C2 share at <= ~5.26% (necessary; other resources not re-screened)", F(5, 100) < cmax < F(53, 1000), float(cmax))
control("C2.4 10% of minds choosing C2 within existing slots", pop * (1 + 6 * F(1, 10)) <= SLOTS * S)
# comparison with the probabilistic union bound C(r, ceil(r/2)) p^ceil(r/2) <= eps / N_windows
p, eps = F(1, 500), F(1, 10**8)
N_windows = ceil(F(25, 10) * 10**117 * 400 * M / 32)          # mind-windows over the TW-1 schedule's pool-dates
r_prob = next(r for r in range(1, 400, 2) if comb(r, ceil(F(r, 2))) * p ** ceil(F(r, 2)) <= eps / N_windows)
check("C2.5 without P-K3, independent per-window loss p = 1/500 would need many more replicas", r_prob > 7, r_prob)

ok = sum(1 for _, k, _ in R if k)
for n, k, d in R: print(("PASS " if k else "FAIL ") + n + (f"  [{d}]" if d else ""))
print(json.dumps({"passed": ok, "total": len(R), "r_min_k3": r_min(3), "r_prob": r_prob, "c2_share_max": float(cmax)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
