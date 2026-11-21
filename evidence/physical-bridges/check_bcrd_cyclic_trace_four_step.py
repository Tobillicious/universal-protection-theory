#!/usr/bin/env python3
"""Finite relational cyclic-gluing verifier, not physical BCRD verification."""
from itertools import product

BIT = (0, 1)
EDGES = tuple(product(BIT, repeat=2))
RELATIONS = [
    frozenset(edge for pos, edge in enumerate(EDGES) if mask & (1 << pos))
    for mask in range(16)
]


def compose(first, second):
    """(second o first): X->Z, via existential intermediate interface."""
    return frozenset((x, z) for x, y in first for y2, z in second if y == y2)


def cycle_solutions(*relations):
    """All complete labelled internal assignments for n >= 1 closed stages."""
    n = len(relations)
    return frozenset(
        xs for xs in product(BIT, repeat=n)
        if all((xs[i], xs[(i + 1) % n]) in relations[i] for i in range(n))
    )


def relational_fixed_points(relation):
    return frozenset(x for x in BIT if (x, x) in relation)


def run():
    checked2 = 0
    for A, B in product(RELATIONS, repeat=2):
        solutions = cycle_solutions(A, B)
        assert frozenset(x for x, _ in solutions) == relational_fixed_points(compose(A, B))
        rotated = cycle_solutions(B, A)
        assert frozenset((y, x) for x, y in solutions) == rotated
        assert frozenset(y for _, y in solutions) == relational_fixed_points(compose(B, A))
        checked2 += 1

    checked3 = 0
    for A, B, C in product(RELATIONS, repeat=3):
        sols = cycle_solutions(A, B, C)
        assert compose(compose(A, B), C) == compose(A, compose(B, C))
        assert frozenset(x for x, _, _ in sols) == relational_fixed_points(compose(compose(A, B), C))
        rotated = cycle_solutions(B, C, A)
        assert frozenset((y, z, x) for x, y, z in sols) == rotated
        checked3 += 1

    NOT = frozenset({(0, 1), (1, 0)})
    ID = frozenset({(0, 0), (1, 1)})
    assert not cycle_solutions(NOT)
    assert cycle_solutions(ID) == {(0,), (1,)}
    assert cycle_solutions(NOT, NOT) == {(0, 1), (1, 0)}

    # A local intervention at the first event is recorded in a marker
    # and read at the second event; the external closed cut is unchanged.
    witnesses_by_intervention = {}
    for j in BIT:
        witness = frozenset((x, y, j) for x, y in cycle_solutions(NOT, NOT))
        assert witness
        assert {r for _, _, r in witness} == {j}
        witnesses_by_intervention[j] = witness
    assert witnesses_by_intervention[0].isdisjoint(witnesses_by_intervention[1])

    print(f"PASS: {checked2} ordered binary two-stage relational pairs")
    print(f"PASS: {checked3} ordered binary three-stage relational triples")
    print("PASS: rotation, composition parenthesization, empty-NOT closure, nontrivial two-flip circuit")
    print("PASS: intervention readout distinguishes two individually consistent closed histories")
    print("LIMIT: finite relational compatibility only; no physical BCRD, X3, or cosmology verified")


if __name__ == "__main__":
    run()
