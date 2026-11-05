#!/usr/bin/env python3
"""BCRD-native finite relational graph/cut controls; no spacetime or Hilbert model.
This is an exact finite diagnostic, not a physical UPT/X3 or cosmic theorem.
"""
from itertools import permutations, product
from collections import Counter

def equivariant(j, old, new):
    return all(j[old[x]] == new[j[x]] for x in range(len(old)))

def compose(f, g):
    return tuple(g[f[x]] for x in range(len(f)))

def iterate(f, x, n):
    for _ in range(n):
        x = f[x]
    return x

def certified_composition():
    count = Counter()
    for f in permutations(range(3), 2):
        for old in product(range(2), repeat=2):
            for mid in product(range(3), repeat=3):
                count['first_candidates'] += 1
                if not equivariant(f, old, mid):
                    continue
                count['first_valid'] += 1
                for g in permutations(range(4), 3):
                    higher = [None] * 4
                    for v in range(3):
                        higher[g[v]] = g[mid[v]]
                    outside = [v for v in range(4) if higher[v] is None]
                    for options in product(range(4), repeat=len(outside)):
                        new = higher[:]
                        for v, o in zip(outside, options):
                            new[v] = o
                        new = tuple(new)
                        e = compose(f, g)
                        assert len(set(e)) == 2
                        assert equivariant(g, mid, new)
                        assert equivariant(e, old, new)
                        assert e[0] != e[1]
                        for x in range(2):
                            for n in range(9):
                                assert e[iterate(old, x, n)] == iterate(new, e[x], n)
                                count['orbit_checks'] += 1
                        count['two_seam_valid'] += 1
    assert count == {'first_candidates': 648, 'first_valid': 72,
                     'two_seam_valid': 6912, 'orbit_checks': 124416}
    # Without injection even equivariance does not protect distinct nodes.
    collapse = (0, 0)
    assert collapse[0] == collapse[1]
    return count

def readout_fibres():
    cases = recoverable = 0
    for cut in product(range(4), repeat=3):
        for history in product(range(2), repeat=3):
            constant = all(cut[i] != cut[j] or history[i] == history[j]
                           for i in range(3) for j in range(3))
            decoder = any(all(d[cut[i]] == history[i] for i in range(3))
                          for d in product(range(2), repeat=4))
            assert constant == decoder
            cases += 1
            recoverable += constant
    assert (cases, recoverable) == (512, 344)
    # Erase a mutable record: historical occurrence remains different.
    states = ((True, False), (False, False))  # (occurred, record_bit)
    assert states[0][1] == states[1][1]
    assert states[0][0] != states[1][0]
    return cases, recoverable

def compose_relations(left, right, n):
    return frozenset((x, z) for x in range(n) for z in range(n)
                     if any((x, y) in left and (y, z) in right
                            for y in range(n)))

def exact_cut_associativity():
    n = 2
    pairs = list(product(range(n), repeat=2))
    relations = tuple(frozenset(p for k, p in enumerate(pairs)
                                if mask & (1 << k)) for mask in range(1 << 4))
    checked = 0
    for r in relations:
        for s in relations:
            for t in relations:
                assert compose_relations(compose_relations(r, s, n), t, n) == \
                       compose_relations(r, compose_relations(s, t, n), n)
                checked += 1
    assert checked == 4096
    # Consistent source history: a halt occurred, but there is no successor.
    terminal = frozenset({(0, 1)})
    assert (0, 1) in terminal
    assert not any(a == 1 for a, _ in terminal)
    complete_history = ('initial', 'halt')
    assert 'halt' in complete_history
    return checked

if __name__ == '__main__':
    c = certified_composition()
    f = readout_fibres()
    a = exact_cut_associativity()
    print(f"PASS: {c['first_candidates']} first-seam candidates, {c['first_valid']} equivariant")
    print(f"PASS: {c['two_seam_valid']:,} 2-to-3-to-4 injective composite seams")
    print(f"PASS: {c['orbit_checks']:,} original finite-generator orbit checks")
    print(f"PASS: {f[0]} exact cut-fibre/decoder cases ({f[1]} reconstructible)")
    print(f"PASS: {a:,} cut relation-composition associativity triples")
    print("PASS: collapsed injection, erased record and consistent halt hostiles")
    print("LIMIT: no physical source completeness, cosmic cyclicity or UPT/X3 asserted")
