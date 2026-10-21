#!/usr/bin/env python3
"""Secret random pool membership turns P-ISLANDS from a pool-scale premise into a global one (author-side, Claude,
19 Oct 2026). Exact Fractions for the tail; log10 bookkeeping for the cosmic counts.

Defensive design question. A pool can absorb up to 92 disabled islands (JW2.3a; P-ISLANDS). If pool membership is
public, a coalition needs to disable only 93 islands of one pool. If each pool is a secret, uniformly random 400-island
subset (re-drawn periodically, membership unknown to any coalition), a coalition that disables a fraction phi of ALL
islands hits each pool with Binomial(400, phi) disabled islands (hypergeometric over 10^20 islands is Binomial to
excellent accuracy). Over 2.5e17 pools and 10^100 dates (union, no independence needed across pools or dates):
    events * P(Bin(400, phi) >= 93) <= budget.
NOT shown: how membership stays secret (a placement-secrecy premise like MOVE's), re-draw cost, and partial leaks.
"""
import json
import math
import sys
from fractions import Fraction as F
from math import comb

R = []


def check(name, ok, detail=""):
    R.append((name, bool(ok), str(detail)))


def control(name, perturbed_ok, detail=""):
    R.append(("CONTROL " + name, not bool(perturbed_ok), str(detail)))


N, THR = 400, 93
LOG_EVENTS = math.log10(2.5e17) + 100


def log10_tail(phi):
    t = sum(comb(N, j) * phi ** j * (1 - phi) ** (N - j) for j in range(THR, N + 1))
    return math.log10(t.numerator) - math.log10(t.denominator)


def phi_max(log_budget):
    lo, hi = F(0), F(THR, N)
    for _ in range(40):
        mid = (lo + hi) / 2
        if LOG_EVENTS + log10_tail(mid) <= log_budget:
            lo = mid
        else:
            hi = mid
    return lo


p8 = phi_max(-8)
p16 = phi_max(-16)
check("SECRET with secret random pools, a coalition must disable about 0.46% of ALL islands at once to put one pool past 92 (1e-8 budget)",
      F(45, 10000) < p8 < F(47, 10000), f"phi_max = {float(p8):.4f} (~{float(p8) * 1e20:.1e} islands)")
check("SECRET at a stricter 1e-16 budget the global fraction is about 0.37%", F(36, 10000) < p16 < F(38, 10000),
      f"phi_max = {float(p16):.4f}")
control("SECRET public pool membership also forces a coalition to disable a global fraction (it does not: 93 islands suffice)",
        F(THR, 10 ** 20) >= F(1, 100), "public pools: 93 islands total")

ok = sum(1 for _, k, _ in R if k)
for name, k, det in R:
    print(("PASS " if k else "FAIL ") + name + (f"  [{det}]" if det else ""))
print(json.dumps({"passed": ok, "total": len(R), "phi_max_1e-8": float(p8), "phi_max_1e-16": float(p16)}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
