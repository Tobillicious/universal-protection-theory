#!/usr/bin/env python3
"""Exact logical model check; not a physical BCRD experiment."""
from itertools import product

def implies(p, q):
    return not p or q

def premises(G, E, H, A, S):
    return (G != E
            and implies(H, E)
            and implies(E, A)
            and implies(S, not S)
            and not S
            and implies(E, not S))

models = [v for v in product((False, True), repeat=5) if premises(*v)]
witness = (False, True, True, True, False)
assert witness in models
assert all(not v[4] for v in models)
assert any(v[2] for v in models)
print("premise-satisfying models:", len(models))
print("countermodel G,E,H,A,S:", witness)
print("PASS: the premises do not entail no first X3 harm")
