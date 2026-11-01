#!/usr/bin/env python3
"""Exact M5/M7 cyclic seam controls; finite examples, not physical BCRD/UPT proof."""
from itertools import product

BIT = (0, 1)
EDGES = tuple(product(BIT, repeat=2))
RELATIONS = [
    frozenset(edge for i, edge in enumerate(EDGES) if mask & (1 << i))
    for mask in range(16)
]


def compose(first, second):
    """Relational second-after-first through the shared cut."""
    return frozenset((x, z) for x, y in first for y2, z in second if y == y2)


def loop_starts(open_relation, closing_relation):
    """Closed starts with matching intermediate witness."""
    return frozenset(
        x for x, y in open_relation if (y, x) in closing_relation
    )


def verify_m5():
    tested = 0
    for R, S in product(RELATIONS, repeat=2):
        all_contexts_equal = True
        for C in RELATIONS:
            left, right = loop_starts(R, C), loop_starts(S, C)
            assert left == frozenset(x for x in BIT if (x, x) in compose(R, C))
            assert right == frozenset(x for x in BIT if (x, x) in compose(S, C))
            all_contexts_equal &= (left == right)
            tested += 1
        assert all_contexts_equal == (R == S)

    ID = frozenset({(0, 0), (1, 1)})
    FLIP = frozenset({(0, 1), (1, 0)})
    # Constant coarse terminal readout sees no difference:
    projection = {(0, "*"), (1, "*")}
    projected_R = frozenset((x, z) for x, y in ID for yy, z in projection if y == yy)
    projected_S = frozenset((x, z) for x, y in FLIP for yy, z in projection if y == yy)
    assert projected_R == projected_S
    assert loop_starts(ID, ID) == frozenset(BIT)
    assert loop_starts(FLIP, ID) == frozenset()
    print(f"PASS M5: {tested} full-context tests across 256 open-process pairs")
    print("PASS M5: weak/coarse agreement fails under an exposing closed context")


def S(v):
    u, w = v
    return (w, -u)


def a(b, v):
    u, w = v
    return w if b == 0 else u


def sigma(b):
    return 1 - b


def tau(b, z):
    return z if b == 0 else -z


def verify_m7():
    tested = 0
    for b in BIT:
        for v in product(range(-3, 4), repeat=2):
            assert a(sigma(b), S(v)) == tau(b, a(b, v))
            tested += 1

    # Kernels are distinct; S exchanges them, not by state-dependent calibration.
    assert all(a(1, S((u, 0))) == 0 for u in range(-3, 4))
    assert all(a(0, S((0, w))) == 0 for w in range(-3, 4))
    for v in product(range(-3, 4), repeat=2):
        s2 = S(S(v))
        s4 = S(S(s2))
        assert s2 == (-v[0], -v[1])
        assert s4 == v
        assert a(0, s2) == -a(0, v)
        assert a(1, s2) == -a(1, v)
    witness = (0, 1)
    assert sigma(sigma(0)) == 0
    assert a(0, witness) == 1
    assert a(0, S(S(witness))) == -1
    assert a(0, S(S(S(S(witness))))) == 1
    print(f"PASS M7: {tested} state/covariance checks on integer test vectors")
    print("PASS M7: base-cut period 2, nontrivial period-2 response monodromy, period-4 recovery")
    print("LIMIT: calibrated finite linear toy, no physical seam, gravity or X3 proof")


if __name__ == "__main__":
    verify_m5()
    verify_m7()
