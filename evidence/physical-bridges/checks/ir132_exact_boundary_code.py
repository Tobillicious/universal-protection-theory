#!/usr/bin/env python3
"""IR-132: independent exact rational bulk/boundary reconstruction controls.

Finite matrices over Q are sufficient to demonstrate that Gauss
constraints alone don't imply boundary reconstruction, while a
specified fixed-ancilla isometric code DOES reconstruct a logical
matrix algebra. Also exhibits the H5 entropy-sign obstruction
using an actual trace-preserving reset Kraus map.

The printed entropy values are symbolic ln(2), not an empirical
claim about a BCRD physical substrate or conscious subjects.
"""
from fractions import Fraction as Q


def zeros(m, n):
    return [[Q(0) for _ in range(n)] for _ in range(m)]


def eye(n):
    a = zeros(n, n)
    for i in range(n):
        a[i][i] = Q(1)
    return a


def mm(a, b):
    assert len(a[0]) == len(b), (len(a[0]), len(b))
    return [[sum((a[i][k] * b[k][j] for k in range(len(b))), Q(0))
             for j in range(len(b[0]))] for i in range(len(a))]


def tr(a):
    return [[a[j][i] for j in range(len(a))] for i in range(len(a[0]))]


def kron(a, b):
    m, n = len(a), len(a[0])
    r, s = len(b), len(b[0])
    return [[a[i // r][j // s] * b[i % r][j % s]
             for j in range(n * s)] for i in range(m * r)]


def trace(a):
    return sum((a[i][i] for i in range(len(a))), Q(0))


def outer(v):
    return [[v[i] * v[j] for j in range(len(v))] for i in range(len(v))]


def add(a, b):
    return [[a[i][j] + b[i][j] for j in range(len(a[0]))]
            for i in range(len(a))]


def channel(kraus, rho):
    result = zeros(len(rho), len(rho))
    for k in kraus:
        result = add(result, mm(mm(k, rho), tr(k)))
    return result


def run():
    # H_phys = B x E, each dim 2; basis indices are |00>,|01>,|10>,|11>.
    id2 = eye(2)
    V = zeros(4, 2)
    V[0][0] = Q(1)  # |0>_logical -> |0>_B |0>_E
    V[2][1] = Q(1)  # |1>_logical -> |1>_B |0>_E
    assert mm(tr(V), V) == id2

    # All 4 logical matrix units intertwine with boundary-only operators.
    units = []
    for i in range(2):
        for j in range(2):
            unit = zeros(2, 2)
            unit[i][j] = Q(1)
            units.append(unit)
            assert mm(kron(unit, id2), V) == mm(V, unit)
            assert mm(mm(tr(V), kron(unit, id2)), V) == unit

    # The environment's complete 2x2 matrix algebra has no
    # ability to distinguish logical states on this code.
    for e in units:
        compressed = mm(mm(tr(V), kron(id2, e)), V)
        expected = [[e[0][0], Q(0)], [Q(0), e[0][0]]]
        assert compressed == expected

    # Same trivial-Gauss physics, a DIFFERENT encoding
    # which hides the logical bit in E and fixes the boundary B.
    W = zeros(4, 2)
    W[0][0] = Q(1)   # |0>_logical -> |0>_B |0>_E
    W[1][1] = Q(1)   # |1>_logical -> |0>_B |1>_E
    assert mm(tr(W), W) == id2
    ket0 = [Q(1), Q(0), Q(0), Q(0)]
    ket1 = [Q(0), Q(1), Q(0), Q(0)]
    rho0, rho1 = outer(ket0), outer(ket1)
    assert rho0 != rho1
    for o in units:
        assert trace(mm(kron(o, id2), rho0)) == trace(
            mm(kron(o, id2), rho1)
        )

    # H5: exact CPTP pure-state RESET, which strictly decreases
    # entropy from S(I/2)=ln(2) to S(|0><0|)=0.
    e0 = [[Q(1), Q(0)], [Q(0), Q(0)]]
    e1 = [[Q(0), Q(1)], [Q(0), Q(0)]]
    assert add(mm(tr(e0), e0), mm(tr(e1), e1)) == id2
    maximally_mixed = [[Q(1, 2), Q(0)], [Q(0), Q(1, 2)]]
    pure0 = [[Q(1), Q(0)], [Q(0), Q(0)]]
    assert channel([e0, e1], maximally_mixed) == pure0
    assert trace(pure0) == trace(maximally_mixed) == 1
    # D(pure0 || I/2) = ln(2) > 0 but Delta S = -ln(2) < 0.

    # A visible, fixed rational PNAJ gap appears only when
    # distinct judgments share one actually accessible datum.
    jud0, jud1 = Q(0), Q(1)
    for estimate in [Q(-2), Q(0), Q(1, 2), Q(1), Q(2)]:
        assert max(abs(estimate - jud0), abs(estimate - jud1)) >= Q(1, 2)
    assert max(abs(Q(1, 2) - jud0),
               abs(Q(1, 2) - jud1)) == Q(1, 2)

    print("PASS IR132 exact logical/boundary matrix units and isometric code")
    print("PASS IR132 non-reconstructible bulk bit under fixed boundary data")
    print("PASS IR132 trace-preserving reset: relative entropy ln2 > 0, entropy change -ln2 < 0")
    print("PASS IR132 conditional PNAJ minimax gap 1/2 on indistinguishable inputs")


if __name__ == "__main__":
    run()
