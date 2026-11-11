#!/usr/bin/env python3
"""Exact finite cut-algebra and cyclic-gluing controls, not BCRD world validation."""
from itertools import product, combinations

BIT = (0, 1)
EDGES = list(product(BIT, repeat=2))
RELATIONS = [frozenset(edge for i, edge in enumerate(EDGES) if mask & (1 << i))
             for mask in range(16)]


def powerset(xs):
    return [frozenset(c) for n in range(len(xs) + 1)
            for c in combinations(xs, n)]


def forward(relation, subset):
    """Phi_R: P(X)->P(Y), existential forward image of a finite cut event."""
    return frozenset(y for x, y in relation if x in subset)


def compose(first, second):
    """Second after first, through the admissible shared cut."""
    return frozenset((x, z) for x, y in first
                     for yy, z in second if y == yy)


def recovered_relation(relation):
    return frozenset((x, y) for x in BIT
                     for y in forward(relation, {x}))


def loop_x(relation, sigma=lambda y: y):
    """Initial cut records with an admitted twisted closed witness."""
    return frozenset(x for x in BIT
                     if x in {sigma(y) for y in forward(relation, {x})})


def full_witnesses(first, second):
    return frozenset((x, y) for x, y in first if (y, x) in second)


def run():
    for R in RELATIONS:
        assert recovered_relation(R) == R
        assert forward(R, set()) == frozenset()
        for A in powerset(BIT):
            for C in powerset(BIT):
                assert forward(R, A | C) == forward(R, A) | forward(R, C)
        for sigma in [lambda x: x, lambda x: 1 - x]:
            expected = frozenset(x for x, y in R if sigma(y) == x)
            assert loop_x(R, sigma) == expected

    n2 = 0
    for R, S in product(RELATIONS, repeat=2):
        for A in powerset(BIT):
            assert forward(compose(R, S), A) == forward(S, forward(R, A))
        complete = full_witnesses(R, S)
        assert bool(complete) == bool(loop_x(compose(R, S)))
        assert bool(complete) == bool(loop_x(compose(S, R)))
        assert {(y, x) for x, y in complete} == full_witnesses(S, R)
        n2 += 1

    n3 = 0
    for R, S, U in product(RELATIONS, repeat=3):
        assert compose(compose(R, S), U) == compose(R, compose(S, U))
        full = frozenset(
            (x, y, z) for x, y in R for yy, z in S for zz, xx in U
            if yy == y and zz == z and xx == x
        )
        assert bool(full) == bool(loop_x(compose(compose(R, S), U)))
        assert bool(full) == bool(loop_x(compose(compose(S, U), R)))
        assert bool(full) == bool(loop_x(compose(compose(U, R), S)))
        n3 += 1

    NOT = frozenset({(0, 1), (1, 0)})
    assert not loop_x(NOT)
    assert loop_x(compose(NOT, NOT)) == frozenset({0, 1})

    # Same complete outer cut map, different internal physical witness counts.
    R = frozenset({(0, 0), (0, 1)})
    S = frozenset({(0, 0), (1, 0)})
    D = frozenset({(0, 0)})
    assert compose(R, S) == D
    completions = frozenset((x, y) for x, y in R if (y, x) in S)
    assert completions == frozenset({(0, 0), (0, 1)})
    assert len(completions) == 2 and len(D) == 1

    # Nonconstant internal updates and admissible intervention marker readout.
    def run_intervention(j, x):
        y = 1 - x
        z = 1 - y
        return x, y, z, j

    assert all(run_intervention(j, x)[0] == run_intervention(j, x)[2]
               for j, x in product(BIT, repeat=2))
    assert run_intervention(0, 0)[-1] != run_intervention(1, 0)[-1]

    print("PASS: 16 binary cut relations; join-map and singleton reconstruction")
    print(f"PASS: {n2} two-stage cut-map compositions and seam rotations")
    print(f"PASS: {n3} three-stage reassociations and seam rotations")
    print("PASS: twisted seam, one-flip negative control and double-flip positive")
    print("PASS: same exterior map need not determine complete internal history")
    print("LIMIT: finite operational control; no physical BCRD, X3 or cosmology")


if __name__ == "__main__":
    run()
