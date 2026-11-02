#!/usr/bin/env python3
"""BCRD M6 symmetry-protected relational escape controls.

AUTHOR THEORY-INCUBATOR ONLY.

This verifier checks two points:

1. The proposed factorization
      Alg*(Q_i tensor I, X_AB tensor A1, X_BC tensor A2)
      ?= M3 tensor Alg*(A1,A2)
   is false in general because matter paths and relational coefficients remain
   correlated.

2. A nearby qutrit x relational-qubit model with
      A1 = diag(1,2), A2 = sigma_x
   gives a proper, noncommuting, scope-matched triadic algebra of dimension 18
   rather than full M6 dimension 36.  The properness is protected by a combined
   matter-relation parity C, not by a dead spectator factor.

Nothing here establishes M6 Tier 0, state-dependent Xi, HDA, geometry, GR, or QG.
"""

import cmath
import math

TOL = 1.0e-9


def eye(n):
    return tuple(tuple(1.0 + 0j if i == j else 0j for j in range(n)) for i in range(n))


def mat(rows):
    return tuple(tuple(complex(x) for x in row) for row in rows)


def add(a, b):
    n = len(a)
    return tuple(tuple(a[i][j] + b[i][j] for j in range(n)) for i in range(n))


def sub(a, b):
    n = len(a)
    return tuple(tuple(a[i][j] - b[i][j] for j in range(n)) for i in range(n))


def scale(s, a):
    return tuple(tuple(s * x for x in row) for row in a)


def mul(a, b):
    n = len(a)
    return tuple(tuple(sum(a[i][k] * b[k][j] for k in range(n)) for j in range(n)) for i in range(n))


def dagger(a):
    n = len(a)
    return tuple(tuple(a[j][i].conjugate() for j in range(n)) for i in range(n))


def comm(a, b):
    return sub(mul(a, b), mul(b, a))


def kron(a, b):
    na, nb = len(a), len(b)
    return tuple(tuple(a[i // nb][j // nb] * b[i % nb][j % nb] for j in range(na * nb)) for i in range(na * nb))


def frob(a):
    return math.sqrt(sum(abs(x) ** 2 for row in a for x in row))


def expm(a, terms=100):
    n = len(a)
    out = eye(n)
    term = eye(n)
    for k in range(1, terms):
        term = scale(1.0 / k, mul(term, a))
        out = add(out, term)
        if frob(term) < 1.0e-16:
            break
    return out


def vec(a):
    return [x for row in a for x in row]


def rank(vectors):
    if not vectors:
        return 0
    m = [list(map(complex, v)) for v in vectors]
    rows, cols = len(m), len(m[0])
    r = 0
    for col in range(cols):
        pivot = max(range(r, rows), key=lambda i: abs(m[i][col]), default=None)
        if pivot is None or abs(m[pivot][col]) < TOL:
            continue
        m[r], m[pivot] = m[pivot], m[r]
        p = m[r][col]
        m[r] = [x / p for x in m[r]]
        for i in range(rows):
            if i != r and abs(m[i][col]) >= TOL:
                f = m[i][col]
                m[i] = [m[i][j] - f * m[r][j] for j in range(cols)]
        r += 1
        if r == rows:
            break
    return r


def add_if_independent(basis, operator):
    before = rank([vec(x) for x in basis])
    after = rank([vec(x) for x in basis] + [vec(operator)])
    if after > before:
        basis.append(operator)
        return True
    return False


def algebra_closure(generators):
    d = len(generators[0])
    basis = []
    add_if_independent(basis, eye(d))
    for g in generators:
        add_if_independent(basis, g)
        add_if_independent(basis, dagger(g))
    changed = True
    while changed:
        changed = False
        snapshot = list(basis)
        for a in snapshot:
            for b in snapshot:
                if add_if_independent(basis, mul(a, b)):
                    changed = True
                    if len(basis) == d * d:
                        return basis
    return basis


def common_krylov(seed, hamiltonians):
    basis = []
    for o in seed:
        add_if_independent(basis, o)
    changed = True
    while changed:
        changed = False
        snapshot = list(basis)
        for o in snapshot:
            for h in hamiltonians:
                if add_if_independent(basis, comm(h, o)):
                    changed = True
    return basis


I2 = eye(2)
I3 = eye(3)
SIGMA_X = mat(((0, 1), (1, 0)))
SIGMA_Z = mat(((1, 0), (0, -1)))

Q_A = mat(((1, 0, 0), (0, 0, 0), (0, 0, 0)))
Q_B = mat(((0, 0, 0), (0, 1, 0), (0, 0, 0)))
Q_C = mat(((0, 0, 0), (0, 0, 0), (0, 0, 1)))
X_AB = mat(((0, 1, 0), (1, 0, 0), (0, 0, 0)))
X_BC = mat(((0, 0, 0), (0, 0, 1), (0, 1, 0)))


def triadic_dims(a1, a2):
    d_r = len(a1)
    i_r = eye(d_r)
    seed = [kron(q, i_r) for q in (Q_A, Q_B, Q_C)]
    h1 = kron(X_AB, a1)
    h2 = kron(X_BC, a2)

    a_def = algebra_closure(seed + [h1, h2])
    a_pred = algebra_closure(common_krylov(seed, [h1, h2]))

    theta = 0.37
    u1 = expm(scale(-1j * theta, h1))
    u2 = expm(scale(-1j * theta, h2))
    qb = kron(Q_B, i_r)
    qc = kron(Q_C, i_r)
    j1 = sub(mul(dagger(u1), mul(qb, u1)), qb)
    j2 = sub(mul(dagger(u2), mul(qc, u2)), qc)
    a_ledger = algebra_closure(seed + [j1, j2])

    return len(a_pred), len(a_ledger), len(a_def), h1, h2


def factorization_counterexample():
    # Gemini blueprint: A1 = sigma_z direct-sum 1, A2 = sigma_x direct-sum 0.
    a1 = mat(((1, 0, 0), (0, -1, 0), (0, 0, 1)))
    a2 = mat(((0, 1, 0), (1, 0, 0), (0, 0, 0)))
    r_alg = algebra_closure([a1, a2])
    assert len(r_alg) == 5  # M2 direct-sum C
    pred, ledger, deform, _, _ = triadic_dims(a1, a2)
    assert (pred, ledger, deform) == (14, 14, 14)
    assert deform != 3 * 3 * len(r_alg)  # not 45
    print("factorization hostile control: CAUGHT")
    print("Alg*(A1,A2) dim=5 but global pred=ledger=def=14, not 45")


def symmetry_protected_escape():
    # Relational qubit: unequal singular values on AB edge, genuine off-diagonal BC edge.
    a1 = mat(((1, 0), (0, 2)))
    a2 = SIGMA_X
    pred, ledger, deform, h1, h2 = triadic_dims(a1, a2)
    assert (pred, ledger, deform) == (18, 18, 18)
    assert frob(comm(a1, a2)) > 1.0e-6

    # Combined matter-relation parity.
    matter_sign = add(add(Q_A, Q_B), scale(-1.0, Q_C))
    parity = kron(matter_sign, SIGMA_Z)
    assert frob(comm(parity, h1)) < TOL
    assert frob(comm(parity, h2)) < TOL

    # Relation Z population is dynamically movable: [H2, I tensor Z] != 0.
    relation_z = kron(I3, SIGMA_Z)
    assert frob(comm(h2, relation_z)) > 1.0e-6

    # A1 has unequal singular/eigenvalue magnitudes, so no left/right unitary
    # frame can turn it into a scalar multiple of identity.
    assert abs(abs(a1[0][0]) - abs(a1[1][1])) > 1.0e-6

    print("symmetry-protected qutrit x qubit escape: PASS")
    print("pred=ledger=def=18 < 36 with [A1,A2]!=0")
    print("properness protected by combined matter-relation parity, not dead spectator")
    print("relation Z observable moves under H2; M6 Xi(rho) still NOT established")


def main():
    factorization_counterexample()
    symmetry_protected_escape()
    print("BCRD M6 symmetry-protected relational escape controls: PASS")
    print("claim ceiling: finite algebraic control only; M6 Tier 0/HDA/geometry/GR/QG NOT established")


if __name__ == "__main__":
    main()
