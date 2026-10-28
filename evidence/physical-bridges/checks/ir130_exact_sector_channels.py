#!/usr/bin/env python3
"""IR-130 independent exact rational 6x6 CPTP channel checks.

Complements Lean's coordinate separation theorem; does not certify
BCRD physics, boundary readout accessibility, or living subject semantics.
Uses only Python stdlib Fraction (no float tolerance).
"""
from fractions import Fraction as Q

N = 6

def zeros():
    return [[Q(0) for _ in range(N)] for _ in range(N)]

def eye():
    result = zeros()
    for i in range(N):
        result[i][i] = Q(1)
    return result

def matrix(entries):
    result = zeros()
    for (i, j), value in entries.items():
        result[i][j] = Q(value)
    return result

def diagonal(xs):
    return matrix({(i, i): v for i, v in enumerate(xs)})

def transpose(a):
    return [[a[j][i] for j in range(N)] for i in range(N)]

def multiply(a, b):
    return [[sum((a[i][k] * b[k][j] for k in range(N)), Q(0))
             for j in range(N)] for i in range(N)]

def add(a, b):
    return [[a[i][j] + b[i][j] for j in range(N)]
            for i in range(N)]

def subtract(a, b):
    return [[a[i][j] - b[i][j] for j in range(N)]
            for i in range(N)]

def sum_matrices(matrices):
    result = zeros()
    for m in matrices:
        result = add(result, m)
    return result

def apply_channel(kraus, rho):
    return sum_matrices(
        multiply(multiply(k, rho), transpose(k)) for k in kraus
    )

def complete(kraus):
    return sum_matrices(
        multiply(transpose(k), k) for k in kraus
    ) == eye()

def trace(a):
    return sum((a[i][i] for i in range(N)), Q(0))

def real_hilbert_schmidt_square(a):
    return sum((a[i][j] * a[j][i]
                for i in range(N) for j in range(N)), Q(0))

def test():
    # Sector order is +0,+1,+2,-0,-1,-2.
    p = diagonal([1, 1, 0, 1, 1, 0])
    q = diagonal([0, 0, 1, 0, 0, 1])
    d0 = diagonal([1, 1, Q(3, 5), 1, 1, Q(3, 5)])
    d1 = diagonal([0, 0, Q(4, 5), 0, 0, Q(4, 5)])
    a1 = matrix({(0, 2): Q(4, 5), (3, 5): Q(4, 5)})

    pinching = [p, q]
    dephasing = [d0, d1]
    damping = [d0, a1]

    for label, ks in [
        ("pinching", pinching),
        ("dephasing", dephasing),
        ("amplitude damping", damping),
    ]:
        assert complete(ks), "Kraus completeness failed: " + label

    maximally_mixed = diagonal([Q(1, 6)] * 6)
    active_level_2 = diagonal([0, 0, 1, 0, 0, 0])
    coherent = matrix({
        (0, 0): Q(1, 2),
        (2, 2): Q(1, 2),
        (0, 2): Q(1, 2),
        (2, 0): Q(1, 2),
    })
    for state in [maximally_mixed, active_level_2, coherent]:
        assert trace(state) == 1

    # Nonidentity channels have real physical fixed states.
    assert apply_channel(pinching, maximally_mixed) == maximally_mixed
    assert apply_channel(dephasing, maximally_mixed) == maximally_mixed
    assert apply_channel(dephasing, active_level_2) == active_level_2
    assert apply_channel(damping, active_level_2) != active_level_2

    # Their actual state differences are exactly distinguishable.
    d_pin = subtract(apply_channel(pinching, coherent), coherent)
    d_soft = subtract(apply_channel(dephasing, coherent), coherent)
    d_amp = subtract(apply_channel(damping, active_level_2), active_level_2)
    assert real_hilbert_schmidt_square(d_pin) == Q(1, 2)
    assert real_hilbert_schmidt_square(d_soft) == Q(2, 25)
    assert real_hilbert_schmidt_square(d_amp) == Q(512, 625)

    # Intra-sector amplitude transfer is NOT the given diagonal
    # 'soft truncation': the former redistributes population.
    damped = apply_channel(damping, active_level_2)
    assert damped[0][0] == Q(16, 25)
    assert damped[2][2] == Q(9, 25)
    assert apply_channel(dephasing, active_level_2)[2][2] == 1

    print("PASS IR-130 exact six-dimensional rational CPTP controls")
    print("pinching coherent delta^2 = 1/2")
    print("soft dephasing coherent delta^2 = 2/25")
    print("amplitude damping |2> delta^2 = 512/625")
    print("nonidentity pinching and dephasing have fixed valid states")

if __name__ == "__main__":
    test()
