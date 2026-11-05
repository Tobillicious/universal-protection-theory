#!/usr/bin/env python3
"""Finite controls for the four-stage canonical UPT proof obligation.

Counts ALL nonempty feasible families over four Boolean stage
coordinates (existing life, existing freedom, new life, new freedom),
and tests original lexicographic maximality, stagewise union closure
and total-outcome greatestness.

This is an EXACT FINITE mathematical diagnostic. It is NOT a BCRD
physics, physical selection, conscious continuation or X3 deployment
certificate. Canonical Lean source theorems are NOT replaced.
"""
from collections import Counter

N = 4
STAGES = range(1 << N)
TOP = (1 << N) - 1

def subset(a, b):
    return a & b == a

def lex_better(a, b):
    """b is strictly better at the first differing UPT stage."""
    for i in range(N):
        x, y = (a >> i) & 1, (b >> i) & 1
        if x != y:
            return x < y
    return False

def aligned(family, actual):
    return all(not lex_better(actual, feasible) for feasible in family)

def union_closed(family):
    return all((a | b) in family for a in family for b in family)

def greatest(family, actual):
    return all(subset(feasible, actual) for feasible in family)

counts = Counter()
for mask in range(1, 1 << len(STAGES)):
    family = [s for s in STAGES if (mask >> s) & 1]
    closed = union_closed(family)
    has_top = TOP in family
    counts["families"] += 1
    counts["union_closed_families"] += int(closed)
    for actual in family:
        counts["feasible_selected_pairs"] += 1
        # Original canon: alignment means no stage has a feasible
        # strictly better outcome at the first differing stage.
        no_needless = all(not lex_better(actual, q) for q in family)
        assert aligned(family, actual) == no_needless
        if aligned(family, actual):
            counts["aligned_selected_pairs"] += 1
            # Top feasible? Any canonical selected outcome must be top.
            assert not has_top or actual == TOP
            # Source G2 union-closure lemma: selected canonical
            # outcome contains all feasible profiles at every stage.
            assert not closed or greatest(family, actual)
            counts["aligned_union_closed_pairs"] += int(closed)

# Three logically independent source-obligation failures:
# (i) no top feasible, even with perfect selection/union closure;
# (ii) no source locality/union closure, canonical selected may
#      sacrifice some other feasible stages;
# (iii) top feasible and union closed, actual implementation may
#       still select a mathematically valid but noncanonical outcome.
no_top = {0}
assert union_closed(no_top) and aligned(no_top, 0) and TOP not in no_top

no_union = {1, 14}
assert aligned(no_union, 1)
assert not greatest(no_union, 1) and not union_closed(no_union)

bad_selected = {0, 15}
assert union_closed(bad_selected) and TOP in bad_selected
assert not aligned(bad_selected, 0)

expected = {
    "families": 65535,
    "union_closed_families": 4959,
    "feasible_selected_pairs": 524288,
    "aligned_selected_pairs": 65535,
    "aligned_union_closed_pairs": 4959,
}
assert dict(counts) == expected, counts
print("PASS", dict(counts))
print("PASS three source-obligation independence controls")
print("LIMIT: finite UPT order, not BCRD physical selection or cosmic UPT")
