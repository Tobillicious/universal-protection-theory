#!/usr/bin/env python3
"""Founding safety at rung 3 (author-side, Claude, 19 Oct 2026). Exact Fractions.

A founding pool of j islands absorbs k_j = floor(j * 312 / (312 + 1032)) disabled islands (each intact island has 312
spare care slots and each disabled island has 1032 minds; check_jw23a_failover). Against a global adversary that has
disabled a fraction phi of all islands (secret random pools, so each member is hit independently with probability phi),
a founding pool is overloaded with probability P(Bin(j, phi) > k_j). Founding is a bounded phase: union over a declared
10^6 founding pools x 10^6 dates, budget 1e-8. Also at the cosmic event count, for comparison.
NOT shown: the founding capital, failover timing at small j, the other per-island accounts at small j.
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


PHI = F(46, 10000)


def k_of(j):
    return (j * 312) // (312 + 1032)


def tail(j, phi):
    k = k_of(j)
    return sum(comb(j, i) * phi ** i * (1 - phi) ** (j - i) for i in range(k + 1, j + 1))


def jmin(log_events, budget=F(1, 10 ** 8)):
    for j in range(1, 401):
        t = tail(j, PHI)
        if t == 0 or math.log10(t.numerator) - math.log10(t.denominator) + log_events <= math.log10(budget):
            return j
    return None


j_found = jmin(12)
j_cosmic = jmin(math.log10(2.5e17) + 100)
check("FOUND at 0.46% global capture, a founding pool is safe (1e6 pools x 1e6 dates, 1e-8) from 56 islands",
      j_found == 56, f"j_min = {j_found} (absorbs k = {k_of(j_found)})")
check("FOUND at the cosmic event count, the argument needs 397 islands, consistent with the 400-island pool that set phi",
      j_cosmic == 397, f"j_min = {j_cosmic}")
control("FOUND a single-island pool is safe against 0.46% global capture", tail(1, PHI) * 10 ** 12 <= F(1, 10 ** 8),
        f"P = {float(tail(1, PHI)):.4f} per pool-date")

ok = sum(1 for _, kk, _ in R if kk)
for name, kk, det in R:
    print(("PASS " if kk else "FAIL ") + name + (f"  [{det}]" if det else ""))
print(json.dumps({"passed": ok, "total": len(R), "j_min_founding": j_found, "j_min_cosmic": j_cosmic}, sort_keys=True))
sys.exit(0 if ok == len(R) else 1)
