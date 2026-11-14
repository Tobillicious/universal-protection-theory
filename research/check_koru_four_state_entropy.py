#!/usr/bin/env python3
"""Executable finite entropy witness; independent of Lean verification."""
from fractions import Fraction as F
from math import log, isclose

p0 = (F(1,2), F(1,2), F(0), F(0))

def step(p):
    """Pushforward under the cyclic permutation i -> i+1 (mod 4)."""
    return (p[3], p[0], p[1], p[2])

def coarse(p):
    """Uniformize within the fixed macro cells {0,1} and {2,3}."""
    return ((p[0]+p[1])/2,)*2 + ((p[2]+p[3])/2,)*2

def H(p):
    """Dimensionless Gibbs/Shannon entropy, with 0 log 0 = 0."""
    return -sum(float(x)*log(float(x)) for x in p if x)

p1 = step(p0)
assert p1 == (0,F(1,2),F(1,2),0)
assert coarse(p0) == p0
assert coarse(p1) == (F(1,4),)*4
assert sum(p0) == sum(p1) == sum(coarse(p1)) == 1
assert isclose(H(p0),log(2),abs_tol=1e-12)
assert isclose(H(p1),log(2),abs_tol=1e-12)
assert isclose(H(coarse(p1)),log(4),abs_tol=1e-12)
assert isclose(H(coarse(p1))-H(coarse(p0)),log(2),abs_tol=1e-12)

# A reversible return disproves unconditional coarse entropy monotonicity.
p2 = step(p1)
assert isclose(H(coarse(p2)),log(2),abs_tol=1e-12)
print("PASS: rational state evolution, entropy gap, and coarse recurrence")
