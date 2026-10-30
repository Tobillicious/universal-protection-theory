#!/usr/bin/env python3
"""Independent exact dependency *controls* for 18 Oct UPT-P funding/keepers.
Not a replay of inaccessible historical source checker, not a proof of
NS/DS/AI/P-Sigma, not a physical model of every original particular.
"""
from fractions import Fraction as Q
from itertools import product
# C-infinity simple endowment arithmetic, conditional on a positive
# guaranteed return floor (not a source-derived real investment model).
c = Q(4)
p = lambda r: c * (1+r) / r
assert p(Q(1,25)) == Q(104)
assert [p(Q(1,n)) for n in (25,100,1000)] == [104,404,4004]
# Under stated common upkeep factor d, held zero-inflow ender/saboteur,
# keeper inflow nonnegative: ratio keeper/(ender+adversary) cannot fall.
d=Q(3,4); kk,ke,ad=Q(9),Q(3),Q(1)
ratios=[]
for t in range(10):
    ratios.append(kk/(ke+ad))
    kk,ke,ad=d*kk+1,d*ke,d*ad
assert all(x<=y for x,y in zip(ratios,ratios[1:]))
# Countermodel: an unheld saboteur can acquire new resources and defeat
# that ratio. This source condition cannot be silently omitted.
assert (d*Q(9)+1)/(d*Q(3)+Q(20)) < Q(9)/(Q(3)+Q(1))
# Pairwise independence does not imply a three-way probability product.
worlds=list(product((0,1),repeat=2))
failure=lambda a,b:(a==0,b==0,(a^b)==0)
assert sum(all(failure(a,b)) for a,b in worlds)==1
for i in range(3):
    assert sum(failure(a,b)[i] for a,b in worlds)==2
    for j in range(i+1,3):
        assert sum(failure(a,b)[i] and failure(a,b)[j] for a,b in worlds)==1
assert Q(1,4)>Q(1,8)
# D2 finite-trade-off game: winning coalition and no-pooling equilibria.
# Existence does NOT entail equilibrium selection. The strict-lexicographic
# NS dominance condition is stronger and NOT certified by this example.
def payoff(a,i):
    return (Q(3) if all(a) else Q(0))-(Q(2) if a[i] else Q(0))
def is_nash(a):
    for i in range(2):
        b=list(a);b[i]=1-b[i]
        if payoff(tuple(b),i)>payoff(a,i):return False
    return True
assert {a for a in product((0,1),repeat=2) if is_nash(a)}=={(0,0),(1,1)}
# A fixed positive per-date fault bound isn't summable over infinite time.
assert sum([Q(1,100)]*1000,Q(0))==Q(10)
print('PASS: exact funding 104 and zero-return-floor control; held capacity'
      ' persistence and unheld-saboteur control; XOR dependence;'
      ' joint-coalition nonselection; fixed fault horizon.')
print('CAVEAT: auxiliary controls only; no validation of source NS/AI/DS/P-Sigma'
      ' as real physics or original maximal X3.')
