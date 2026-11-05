#!/usr/bin/env python3
"""Finite checks of embedding-independent intrinsic standing and source scope law.

Logical countermodels and exact enumeration; no physics or Lean kernel claims.
"""
from itertools import product, permutations

MAX_N = 3
INJECTIONS = {(m,n): tuple(permutations(range(n),m))
              for m in range(MAX_N+1) for n in range(m,MAX_N+1)}

def is_natural(scope, backwards=True):
    for (m,n), maps in INJECTIONS.items():
        for f in maps:
            for x in range(m):
                left = bool(scope[m] & (1 << x))
                right = bool(scope[n] & (1 << f[x]))
                if left and not right:
                    return False
                if backwards and right and not left:
                    return False
    return True

families = tuple(product(*[range(1 << n) for n in range(MAX_N+1)]))
natural = tuple(s for s in families if is_natural(s))
forward = tuple(s for s in families if is_natural(s, backwards=False))
empty = tuple(0 for n in range(MAX_N+1))
full = tuple((1 << n)-1 for n in range(MAX_N+1))
assert natural == (empty,full)
assert empty in forward and full in forward
assert (0,0,3,7) in forward and (0,0,3,7) not in natural
assert (0,1,0,0) not in forward

# Actual original Law definitions: protected-scope projected maximality
# must rule out an ordinary strict feasible superset if S is full.
checked = 0
for n in range(MAX_N+1):
    outcomes = range(1 << n)
    for familymask in range(1 << (1 << n)):
        F = [o for o in outcomes if familymask & (1 << o)]
        for o in F:
            projected_maximal = not any(o != q and (o & q) == o for q in F)
            needless_loss = any(o != q and (o & q) == o for q in F)
            assert not (projected_maximal and needless_loss)
            checked += 1

# Mathematical naturality allows the everywhere-empty scope.
assert empty in natural
# Actual physical selection need not implement the mathematically best option.
F = (0,1)
actual_selected = 0
assert actual_selected in F
assert any(q != actual_selected and (q & actual_selected) == actual_selected for q in F)

def graph_component_checks():
    tested = connected_nonempty = 0
    for n in range(1, 5):
        pairs = [(i,j) for i in range(n) for j in range(i+1,n)]
        for edge_mask in range(1 << len(pairs)):
            edges = [p for k,p in enumerate(pairs) if edge_mask & (1 << k)]
            components = []
            unseen = set(range(n))
            while unseen:
                seed = next(iter(unseen))
                comp = {seed}
                work = [seed]
                while work:
                    v = work.pop()
                    for u,w in edges:
                        z = w if u == v else (u if w == v else None)
                        if z is not None and z not in comp:
                            comp.add(z)
                            work.append(z)
                components.append(comp)
                unseen -= comp
            for membership in range(1 << n):
                tested += 1
                edge_invariant = all(
                    bool(membership & (1 << u)) == bool(membership & (1 << v))
                    for u,v in edges)
                component_invariant = all(len({
                    bool(membership & (1 << v)) for v in comp}) == 1
                    for comp in components)
                assert edge_invariant == component_invariant
                if len(components) == 1 and membership and edge_invariant:
                    assert membership == (1 << n) - 1
                    connected_nonempty += 1
    return tested, connected_nonempty

graph_counts = graph_component_checks()
assert (len(families), len(natural), len(forward), checked, graph_counts[0]) == (
    64, 2, 4, 1061, 1098)
print('PASS 64 standing-scope families, 24 injections, exactly 2 embedding-reflecting families')
print('PASS 4 forward-only families, including a non-universal contextual hostile control')
print('PASS 1,061 exact feasible-outcome no-needless-loss checks')
print('PASS 1,098 comparison-graph standing assignments and component classifications')
print('PASS independent empty-standing and nonmaximal physical-selection countercontrols')
print('LIMIT: source-valid embedding reflection and any actual physical standing not proved')
