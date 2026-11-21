#!/usr/bin/env python3
"""Exhaustive source-graph cyclic UPT diagnostic: no physical source oracle assumed."""
from itertools import product
import random


def reachability(n, edges):
    r = [[i == j for j in range(n)] for i in range(n)]
    for i, j, _ in edges:
        r[i][j] = True
    for k in range(n):
        for i in range(n):
            if r[i][k]:
                for j in range(n):
                    r[i][j] |= r[k][j]
    return r


def no_bad_closed_walk(n, edges):
    reach = reachability(n, edges)
    return not any(bad and reach[j][i] for i, j, bad in edges)


def certificate(n, edges):
    """Return V with V(u)>=V(v)+bad for each edge, or None if impossible."""
    reach = reachability(n, edges)
    comp = [-1] * n
    for i in range(n):
        if comp[i] >= 0:
            continue
        c = max(comp) + 1
        for j in range(n):
            if reach[i][j] and reach[j][i]:
                assert comp[j] in (-1, c)
                comp[j] = c
    assert all(z >= 0 for z in comp)
    dag = {k: [] for k in set(comp)}
    for i, j, bad in edges:
        if comp[i] == comp[j]:
            if bad:
                return None
        else:
            dag[comp[i]].append((comp[j], int(bad)))
    memo = {}

    def rank(c):
        if c not in memo:
            memo[c] = max([0] + [w + rank(d) for d, w in dag[c]])
        return memo[c]

    v = tuple(rank(comp[i]) for i in range(n))
    assert all(v[i] >= v[j] + bad for i, j, bad in edges)
    assert max(v, default=0) <= max(0, n - 1)
    return v


def anchored_protection_join(n, edges, protected):
    """IR116-style forward-invariant P and one source-protected SCC anchor."""
    reach = reachability(n, edges)
    forward = all((i not in protected) or (j in protected)
                  for i, j, _ in edges)
    cyclic = {i for i, j, _ in edges if reach[j][i]}
    anchors = all(any(p in protected and reach[i][p] and reach[p][i]
                      for p in range(n)) for i in cyclic)
    if forward:
        # Monotone owed membership cannot change inside a source SCC.
        for i in range(n):
            for j in range(n):
                if reach[i][j] and reach[j][i]:
                    assert (i in protected) == (j in protected)
        assert anchors == (cyclic <= protected)
    return forward, anchors, cyclic <= protected


def tests():
    count = anchor_cases = 0
    for n in (1, 2, 3):
        pairs = list(product(range(n), repeat=2))
        for labels in product((0, 1, 2), repeat=n*n):
            edges = [(i, j, label == 2)
                     for (i, j), label in zip(pairs, labels) if label]
            good = no_bad_closed_walk(n, edges)
            v = certificate(n, edges)
            assert good == (v is not None), (n, edges, good, v)
            for mask in range(1 << n):
                protected = {i for i in range(n) if mask & (1 << i)}
                anchored_protection_join(n, edges, protected)
                anchor_cases += 1
            count += 1
    assert count == 19767 and anchor_cases == 157794

    # Nontrivial protected 0<->1 history; bad 1->2 never returns.
    n, edges = 3, [(0, 1, False), (1, 0, False), (1, 2, True)]
    assert no_bad_closed_walk(n, edges)
    v = certificate(n, edges)
    assert v is not None and v[1] > v[2]

    # One active unprotected cycle disproves unconditional bare cyclic safety.
    unsafe = [(0, 1, False), (1, 0, True)]
    assert not no_bad_closed_walk(2, unsafe)
    assert certificate(2, unsafe) is None

    rng = random.Random(20261102)
    for n in (4, 5):
        for _ in range(1200):
            edges = [(i, j, rng.random() < 0.2)
                     for i in range(n) for j in range(n)
                     if rng.random() < 0.4]
            assert no_bad_closed_walk(n, edges) == (
                certificate(n, edges) is not None)

    print(f"PASS: {count:,} exhaustive labelled graphs, sizes 1–3")
    print(f"PASS: {anchor_cases:,} IR116-style monotone/anchor assignments")
    print("PASS: 2,400 seeded random 4/5-state directed graphs")
    print("PASS: good nontrivial cycle, transient bad edge and bad cycle")
    print("RANK: V(src)>=V(dst)+Bad(edge) iff no bad edge lies on a closed walk")
    print("LIMIT: original-X3 source monitor and physical BCRD cyclic source unverified")


if __name__ == "__main__":
    tests()
