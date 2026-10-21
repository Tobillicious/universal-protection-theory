#!/usr/bin/env python3
"""Founding safety at island tolerance k = 1 (author-side, Claude, 20 Oct 2026). Exact Fractions.

A founding pool of j islands with k = 1 is overloaded iff at least 2 of its j islands are disabled. Against a global
adversary that has disabled a fraction phi of islands (secret placement: each island hit independently with prob phi),
P(overload) = 1 - (1-phi)^j - j phi (1-phi)^(j-1). Founding phase: union over 10^12 pool-dates (10^6 pools x 10^6
dates, declared), budget 1e-8. Largest tolerable phi by bisection.
"""
import json
import sys
from fractions import Fraction as F

R = []


def check(name, ok, detail=""):
    R.append((name, bool(ok), str(detail)))


def control(name, perturbed_ok, detail=""):
    R.append(("CONTROL " + name, not bool(perturbed_ok), str(detail)))


def overload(j, phi):
    return 1 - (1 - phi) ** j - j * phi * (1 - phi) ** (j - 1)


def phi_max(j):
    lo, hi = F(0), F(1, 10)
    for _ in range(80):
        mid = (lo + hi) / 2
        if overload(j, mid) * 10 ** 12 <= F(1, 10 ** 8):
            lo = mid
        else:
            hi = mid
    return lo


res = {j: phi_max(j) for j in (3, 56, 400)}
check("FOUND k = 1: tolerable global disabled fraction ~5.8e-11 (j = 3), ~2.6e-12 (j = 56), ~3.5e-13 (j = 400)",
      F(5, 10 ** 11) < res[3] < F(6, 10 ** 11) and F(2, 10 ** 12) < res[56] < F(3, 10 ** 12)
      and F(3, 10 ** 13) < res[400] < F(4, 10 ** 13), {j: f"{float(v):.2e}" for j, v in res.items()})
check("FOUND at k = 1 a larger founding pool tolerates a SMALLER global fraction (more islands that can be hit twice)",
      res[3] > res[56] > res[400])
control("FOUND at k = 1 a 56-island pool tolerates a 0.46% global adversary", overload(56, F(46, 10000)) * 10 ** 12 <= F(1, 10 ** 8))

ok = sum(1 for _, k, _ in R if k)
for name, k, det in R:
    print(("PASS " if k else "FAIL ") + name + (f"  [{det}]" if det else ""))
print(json.dumps({"passed": ok, "total": len(R)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
