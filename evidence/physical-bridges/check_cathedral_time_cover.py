#!/usr/bin/env python3
"""Exact finite diagnostics for observer cyclic phase vs source history.
No physical time/cosmology or actual UPT universal protection inference.
"""
from fractions import Fraction
from itertools import product


def reachability(n, edges):
    r = [[i == j for j in range(n)] for i in range(n)]
    for u, v in edges:
        r[u][v] = True
    for k in range(n):
        for i in range(n):
            for j in range(n):
                r[i][j] |= r[i][k] and r[k][j]
    return r


def productive(n, edges, backwards=False):
    """After n steps the set equals states admitting one infinite direction."""
    can = set(range(n))
    for _ in range(n):
        can = ({v for u, v in edges if u in can} if backwards
               else {u for u, v in edges if v in can})
    return can


def graph_checks():
    graphs = states = two_sided = nonrecurrent = 0
    for n in (1, 2, 3, 4):
        pairs = tuple(product(range(n), repeat=2))
        for mask in range(1 << (n*n)):
            edges = tuple((u, v) for i, (u, v) in enumerate(pairs)
                          if mask & (1 << i))
            r = reachability(n, edges)
            cyclic = {u for u, v in edges if r[v][u]}
            past = {s for s in range(n) if any(r[c][s] for c in cyclic)}
            future = {s for s in range(n) if any(r[s][c] for c in cyclic)}
            assert past == productive(n, edges, backwards=True)
            assert future == productive(n, edges)
            for s in range(n):
                states += 1
                if s in past and s in future:
                    two_sided += 1
                    if s not in cyclic:
                        nonrecurrent += 1
            graphs += 1
    assert (graphs, states, nonrecurrent) == (66066, 263714, 2988)
    bridge = ((0, 0), (0, 1), (1, 2), (2, 2))
    assert 1 not in {u for u, v in bridge if reachability(3, bridge)[v][u]}
    assert 1 in productive(3, bridge)
    assert 1 in productive(3, bridge, backwards=True)
    return graphs, states, two_sided, nonrecurrent


def deterministic_checks():
    maps = states = 0
    for n in range(1, 7):
        for f in product(range(n), repeat=n):
            edges = tuple((x, f[x]) for x in range(n))
            past = productive(n, edges, backwards=True)
            r = reachability(n, edges)
            on_cycle = {u for u, v in edges if r[v][u]}
            assert past == on_cycle
            for x in range(n):
                states += 1
                assert (x in past) == (x in on_cycle)
            maps += 1
    assert (maps, states) == (50069, 296675)
    return maps, states


def phase_cover_checks():
    checked = 0
    for m in range(2, 8):
        for n in range(-100, 101):
            state = (n, n % m)
            after = (n + m, (n + m) % m)
            assert state[1] == after[1] and state != after
            previous = (n-1, (n-1) % m)
            assert (previous[0]+1, (previous[1]+1) % m) == state
            checked += 1
    assert checked == 1206
    return checked


def owed_ledger_checks():
    checked = monotone = 0
    for n in range(1, 6):
        for ledger in product(range(8), repeat=n):
            checked += 1
            is_monotone = all(ledger[i] & ~ledger[(i+1) % n] == 0
                              for i in range(n))
            if is_monotone:
                monotone += 1
                assert all(x == ledger[0] for x in ledger)
    assert (checked, monotone) == (37448, 40)
    for n in range(-50, 50):
        old = frozenset() if n < 0 else frozenset({'a'})
        new = frozenset() if n+1 < 0 else frozenset({'a'})
        assert old <= new
    return checked, monotone


def projection_checks():
    def px(v):
        return (v[0], Fraction(0))
    def pd(v):
        return ((v[0]+v[1])/2, (v[0]+v[1])/2)
    def step(v):
        return pd(px(v))
    checked = periodic = 0
    for x, y, p in product(range(-4, 5), range(-4, 5), range(1, 8)):
        v = (Fraction(x), Fraction(y))
        out = v
        for _ in range(p):
            out = step(out)
        if out == v:
            periodic += 1
            assert v == (0, 0)
        checked += 1
    assert (checked, periodic) == (567, 7)
    return checked, periodic


if __name__ == '__main__':
    a = graph_checks()
    b = deterministic_checks()
    c = phase_cover_checks()
    d = owed_ledger_checks()
    e = projection_checks()
    print(f'PASS: {a[0]:,} graph cases, {a[1]:,} states, {a[3]:,} bi-infinite nonrecurrent states')
    print(f'PASS: {b[0]:,} deterministic total maps, {b[1]:,} state checks')
    print(f'PASS: {c:,} lifted-history / repeated-phase checks')
    print(f'PASS: {d[0]:,} cyclic IR116-style ledgers ({d[1]} monotone, all constant)')
    print(f'PASS: {e[0]} exact rational projection cases, {e[1]} periodic (zero only)')
    print('LIMIT: these finite mathematical checks are not physical cosmology or new Lean certification')
