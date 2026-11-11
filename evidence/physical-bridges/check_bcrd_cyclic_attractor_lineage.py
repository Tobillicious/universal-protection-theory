#!/usr/bin/env python3
"""Exact finite model checks for BCRD-CYCLE-01.
This does not certify original BCRD B1–B7, X3, or physical cosmology.
"""
from itertools import product


def recurrent_core(T):
    n = len(T)
    result = set()
    for x in range(n):
        y = T[x]
        for _ in range(1, n + 1):
            if y == x:
                result.add(x)
                break
            y = T[y]
    return result


def hitting_time(T, C, x):
    for k in range(len(T)):
        if x in C:
            return k
        x = T[x]
    raise AssertionError("Finite deterministic map failed to enter a periodic orbit")


count = 0
for n in range(1, 5):
    for T in product(range(n), repeat=n):
        C = recurrent_core(T)
        assert C
        for x in range(n):
            h = hitting_time(T, C, x)
            assert h <= n - 1
            if x not in C:
                assert hitting_time(T, C, T[x]) == h - 1
        count += 1
assert count == 288
print(f"PASS: all {count} maps (n=1..4) eventually reach their recurrent core")

# A nontrivial cycle exists but attracts no other states.
T = (1, 0, 2, 3)
C = {0, 1}
assert all(hitting_time(T, C, x) == 0 for x in C)
assert all(T[x] == x for x in (2, 3))
print("PASS: period-two cycle can have no external basin")

# A full basin with strictly descending integer-valued rank V.
T = (1, 0, 0, 2)
C = {0, 1}
V = (0, 0, 1, 2)
assert all(T[x] in C for x in C)
assert all(V[T[x]] < V[x] for x in range(4) if x not in C)
assert all(hitting_time(T, C, x) == V[x] for x in range(4))
# An allowed arbitrary perturbation can create a disjoint cycle.
U = (1, 0, 3, 2)
assert U[U[2]] == 2 and U[2] not in C
assert not all(V[U[x]] < V[x] for x in range(4) if x not in C)
print("PASS: descent theorem is conditional on admitting only rank-decreasing changes")

# Two marked paths, each length two; injective seam may swap them.
paths = {
    "A": ("a_in", "a_mid", "a_out"),
    "B": ("b_in", "b_mid", "b_out"),
}
seam_match = {"a_out": "a_in", "b_out": "b_in"}
seam_swap = {"a_out": "b_in", "b_out": "a_in"}


def cycles(paths, seam):
    next_node = {}
    for path in paths.values():
        for x, y in zip(path, path[1:]):
            next_node[x] = y
        next_node[path[-1]] = seam[path[-1]]
    seen = set()
    lengths = []
    for start in next_node:
        if start in seen:
            continue
        x = start
        visited = set()
        while x not in visited:
            visited.add(x)
            x = next_node[x]
        assert x == start
        seen.update(visited)
        lengths.append(len(visited))
    return sorted(lengths)


assert len(set(seam_match.values())) == 2
assert len(set(seam_swap.values())) == 2  # equally injective
assert cycles(paths, seam_match) == [3, 3]
assert cycles(paths, seam_swap) == [6]
print("PASS: bijective but label-swapping seam combines two marked cycles into one")
print("LIMIT: finite combinatorial diagnostics, not physical/subject continuity")
