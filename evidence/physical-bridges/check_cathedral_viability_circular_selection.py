#!/usr/bin/env python3
"""IR-72 viability/selection and cyclic BCRD source controls.
Only mathematical Boolean/finite-limit cases; no real cosmic physics claim.
"""
from itertools import product
from fractions import Fraction

def next_state(state,action):
    return False if action else state

def policy_action(policy,state):
    return policy[int(state)]

def run(policy,n):
    state=True
    history=[state]
    for _ in range(n):
        state=next_state(state,policy_action(policy,state))
        history.append(state)
    return history

policies=list(product((False,True),repeat=2))
safe=[p for p in policies if all(run(p,n)[-1] for n in range(30))]
unsafe=[p for p in policies if p not in safe]
assert len(safe)==2 and len(unsafe)==2
assert all(run(p,31)[-1] for p in safe)
assert all(not run(p,1)[-1] for p in unsafe)

# Circular time: transitive two-phase cycle, both phases objectively exist,
# but a predicate describing current activity need not hold in both phases.
cycle=lambda x:not x
assert all(cycle(cycle(x))==x for x in (False,True))
assert not cycle(True)

# Separately derived source invariance WOULD propagate a witnessed P
# around the entire transitive cycle.
invariant_count=0
invariant_with_anchor=0
for m in range(4):
    P=lambda s:bool((m>>int(s))&1)
    invariant=all(not P(s) or P(cycle(s)) for s in (False,True))
    if invariant: invariant_count+=1
    if invariant and P(True):
        invariant_with_anchor+=1
        assert P(False) and P(True)
assert (invariant_count,invariant_with_anchor)==(2,1)

# Genuine physical omega-limit would require topological closure of P.
for n in range(1,5001):
    assert Fraction(1,n)>0
assert not (Fraction(0)>0)

print("PASS 4 deterministic policies: 2 safe for every checked time, 2 unsafe at step one")
print("PASS cyclic two-phase return with phasewise liveness violation")
print("PASS four predicates exhaustively: two cycle-invariant, one anchored")
print("PASS 5000 positive finite approximants with unprotected zero limit")
print("LIMIT: IR72 real physical applicability, original X3 and cosmic circularity OPEN")
