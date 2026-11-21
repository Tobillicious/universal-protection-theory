#!/usr/bin/env python3
"""Finite controls for interventional boundary sufficiency (source-level only).
NOT physical evidence for BCRD, X3, or real actuation. Models explicitly
separate action availability from possible harmful successors.
"""
from itertools import product
from collections import Counter
from fractions import Fraction

S = (0, 1, 2)
A = (0, 1, 2)
O = (0, 1)
FULL = (1 << (len(S) * len(A))) - 1
CUTS = tuple(product(O, repeat=len(S)))
POLICIES = tuple(product(A, repeat=len(O)))

def bit(mask, s, a):
    return bool(mask & (1 << (len(A) * s + a)))

def criterion(cut, protected, mask):
    return all(any(all(
        not (protected & (1 << s)) or cut[s] != o or bit(mask, s, a)
        for s in S) for a in A) for o in O)

def policy_exists(cut, protected, mask):
    return any(all(
        not (protected & (1 << s)) or bit(mask, s, policy[cut[s]])
        for s in S) for policy in POLICIES)

def pointwise_viable(protected, mask):
    return all(
        not (protected & (1 << s)) or any(bit(mask, s, a) for a in A)
        for s in S)

def response_congruent(cut, protected, allowed, bad):
    return all(
        bit(allowed, s, a) == bit(allowed, t, a) and
        bit(bad, s, a) == bit(bad, t, a)
        for s in S for t in S for a in A
        if cut[s] == cut[t] and
        protected & (1 << s) and protected & (1 << t))

count = Counter()
for cut in CUTS:
    for protected in range(1 << len(S)):
        for mask in range(FULL + 1):
            iff = criterion(cut, protected, mask)
            assert iff == policy_exists(cut, protected, mask)
            count["iff_cases"] += 1
            count["guardable"] += bool(iff)

# All pairs share an action, yet the full protected fibre does not.
tri_sets = ({0, 1}, {1, 2}, {0, 2})
assert all(tri_sets[i] & tri_sets[j] for i in S for j in S if i < j)
assert not set.intersection(*tri_sets)
tri_mask = sum(1 << (len(A) * s + a)
               for s in S for a in tri_sets[s])
assert pointwise_viable(0b111, tri_mask)
assert not criterion((0, 0, 0), 0b111, tri_mask)
assert criterion((0, 1, 0), 0b111, tri_mask)

# The allowed and bad responses are independent source tables.
# Guard(s,a) = Allowed(s,a) and NOT BadSuccessor(s,a).
for allowed in range(FULL + 1):
    for bad in range(FULL + 1):
        safe = allowed & (~bad & FULL)
        if not pointwise_viable(0b111, safe):
            continue
        count["pointwise_viable_response_tables"] += 1
        for cut in CUTS:
            if response_congruent(cut, 0b111, allowed, bad):
                assert criterion(cut, 0b111, safe)
                count["intervention_complete_viable_cases"] += 1

# Compact connected continuous 1D action space, closed convex nonempty
# individual safe sets, but no global safe action.
radius = Fraction(1, 4)
def safe_interval(s):
    return max(Fraction(0), s-radius), min(Fraction(1), s+radius)
for s in map(Fraction, range(2)):
    lo, hi = safe_interval(s)
    assert lo <= hi
assert safe_interval(Fraction(0))[1] < safe_interval(Fraction(1))[0]

# Compact convex 2D: pairwise nonempty, triple empty.
x0 = Fraction(4, 5)
y0 = Fraction(4, 5)
r = Fraction(13, 10)
assert x0 + y0 > r
assert x0 + Fraction(1, 2) <= r
assert Fraction(1, 2) + y0 <= r

assert count == {
    "iff_cases": 32768,
    "guardable": 24996,
    "pointwise_viable_response_tables": 50653,
    "intervention_complete_viable_cases": 8288,
}, count
print("PASS", dict(count))
print("PASS triple obstruction and compact/convex countercontrols")
print("LIMIT source response factorization and physical X3 OPEN")
