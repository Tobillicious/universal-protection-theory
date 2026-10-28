#!/usr/bin/env python3
"""Hostile, exact Fraction controls for recovered Gate C-infinity v18Oct.
This does NOT change the source manuscript, certify real funding, or prove X3.
"""
from fractions import Fraction as Q
B=Q(4)
rmin=Q(1,25)
rgood=Q(1,10)
capital=Q(50)
def threshold(r):
    assert r>0
    return B*(1+r)/r
def next_balance(e,r):
    assert e>=B
    return (e-B)*(1+r)
assert threshold(rmin)==Q(104)
assert threshold(rgood)==Q(44)
assert capital<threshold(rmin)
# Countermodel 1: essential infimum over dates =4%, only the first
# epoch earns that; 10% every later epoch. e1=47.84>44, and every
# later iterate remains above its fixed point by exact induction.
initial_after_low=next_balance(capital,rmin)
assert initial_after_low==Q(1196,25)
assert initial_after_low>threshold(rgood)
for first in [rmin,Q(0)]:
    e=next_balance(capital,first)
    assert e>=threshold(rgood)
    for _ in range(120):
        e=next_balance(e,rgood)
        assert e>=threshold(rgood)
assert next_balance(capital,Q(0))==46
# Retain the SUFFICIENT side of the original result.
assert all(next_balance(threshold(rmin),r)>=threshold(rmin)
           for r in [rmin,Q(1,20),rgood])
# Arbitrarily long low-return blocks can still ruin finite capital.
def ruined(e,r,length):
    for _ in range(length):
        if e<B: return True
        e=next_balance(e,r)
    return e<B
assert ruined(capital,Q(0),13)
assert ruined(capital,rmin,100)
# RM exact boundary case, historical check_ns.py stale self-expectation.
T=10**100; eta=Q(1,10**6)
def min_keepers(eps):
    n=1
    while T*eps**n>eta:n+=1
    return n
assert min_keepers(Q(1,10))==106
assert min_keepers(Q(1,100))==53
assert T*Q(1,10)**106 == eta
assert T*Q(1,100)**53 == eta
print("PASS exact C-infinity temporal-support refutations, retained"
      " sufficient endowment, adverse-run controls, and RM boundary 106/53")
print("SCOPE: conditional mathematical countermodels only; no physical X3")
