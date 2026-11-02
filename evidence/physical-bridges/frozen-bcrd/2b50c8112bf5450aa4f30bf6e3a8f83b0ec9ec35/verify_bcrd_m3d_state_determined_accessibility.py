#!/usr/bin/env python3
"""BCRD M3d finite state-determined accessibility controls.

AUTHOR THEORY-INCUBATOR ONLY.

Layer A: one fixed six-dimensional unitary acts on the one-excitation matter
sector {|L>,|M>,|R>} tensored with a relational bit r in {0,1}.  The relational
state controls whether the L-M event is available.  No graph is changed by the
test harness; the process law is fixed and the boundary state selects the
active interaction structure.

Layer B: an endogenous-update sanity control shows that the same closed unitary
framework can update the relational bit from matter before the controlled L-M
event, so interaction availability need not be an externally toggled switch.

This is a finite mechanism/control for state-dependent accessibility.  It is
NOT a theorem of B7, not emergent geometry, and not GR/HDA.
"""

import itertools
import math

TOL = 1.0e-10


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


def mul(a, b):
    n = len(a)
    return tuple(
        tuple(sum(a[i][k] * b[k][j] for k in range(n)) for j in range(n))
        for i in range(n)
    )


def dagger(a):
    n = len(a)
    return tuple(tuple(a[j][i].conjugate() for j in range(n)) for i in range(n))


def kron(a, b):
    na, nb = len(a), len(b)
    return tuple(
        tuple(a[i // nb][j // nb] * b[i % nb][j % nb] for j in range(na * nb))
        for i in range(na * nb)
    )


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


def span_contains(basis, operator):
    before = rank([vec(x) for x in basis])
    after = rank([vec(x) for x in basis] + [vec(operator)])
    return before == after


def same_space(a, b):
    return all(span_contains(a, x) for x in b) and all(span_contains(b, x) for x in a)


def edge_partial_swap_3(i, j, theta):
    rows = [list(row) for row in eye(3)]
    c, s = math.cos(theta), math.sin(theta)
    rows[i][i] = c
    rows[j][j] = c
    rows[i][j] = -1j * s
    rows[j][i] = -1j * s
    return mat(rows)


def projector3(i):
    rows = [[0j for _ in range(3)] for _ in range(3)]
    rows[i][i] = 1.0 + 0j
    return mat(rows)


def projector2(i):
    rows = [[0j, 0j], [0j, 0j]]
    rows[i][i] = 1.0 + 0j
    return mat(rows)


def phase_port_3(i, phi=math.pi / 2.0):
    rows = [list(row) for row in eye(3)]
    rows[i][i] = complex(math.cos(phi), math.sin(phi))
    return mat(rows)


def outer(psi):
    n = len(psi)
    return tuple(tuple(psi[i] * psi[j].conjugate() for j in range(n)) for i in range(n))


def apply_unitary_to_rho(u, rho):
    return mul(u, mul(rho, dagger(u)))


def trace(a):
    return sum(a[i][i] for i in range(len(a)))


def expectation(obs, rho):
    return trace(mul(obs, rho))


def ket_matter_relation(coeffs, r):
    v = [0j] * 6
    norm2 = sum(abs(x) ** 2 for x in coeffs)
    assert norm2 > 0
    norm = math.sqrt(norm2)
    for i, amp in enumerate(coeffs):
        v[2 * i + r] = amp / norm
    return tuple(v)


I2 = eye(2)
I3 = eye(3)
P0 = projector2(0)
P1 = projector2(1)
X2 = mat(((0, 1), (1, 0)))
Q_L, Q_M, Q_R = projector3(0), projector3(1), projector3(2)
Q_PORTS_6 = [kron(q, I2) for q in (Q_L, Q_M, Q_R)]

THETA = math.pi / 4.0
U_LM = edge_partial_swap_3(0, 1, THETA)
U_MR = edge_partial_swap_3(1, 2, THETA)
U_MR_6 = kron(U_MR, I2)

# One fixed relationally controlled event: r=0 -> identity on L-M, r=1 -> U_LM.
C_LM = add(kron(I3, P0), kron(U_LM, P1))

# Symmetric finite history so the enabled sector has bidirectional accessibility
# among all three ports while the disabled sector leaves L isolated.
U_FIXED = mul(C_LM, mul(U_MR_6, C_LM))


def witness_states_for_relation(r):
    states = []
    for i, j in itertools.combinations(range(3), 2):
        for phase in (1.0 + 0j, 1.0j, -1.0j):
            coeffs = [0j, 0j, 0j]
            coeffs[i] = 1.0 + 0j
            coeffs[j] = phase
            states.append(ket_matter_relation(coeffs, r))
    return states


def signalling_matrix_for_relation(r):
    """Finite witness implementation of the frozen M3a binary criterion.

    Interventions are local unitary phase channels V_i rho V_i^dagger, hence CPTP.
    This is not an exhaustive optimization over all local CPTP channels/states.
    """
    adjacency = [[0 for _ in range(3)] for _ in range(3)]
    witnesses = witness_states_for_relation(r)
    interventions = [kron(phase_port_3(i), I2) for i in range(3)]

    for a in range(3):
        for b in range(3):
            if a == b:
                continue
            for psi in witnesses:
                rho = outer(psi)
                out0 = apply_unitary_to_rho(U_FIXED, rho)
                rho1 = apply_unitary_to_rho(interventions[a], rho)
                out1 = apply_unitary_to_rho(U_FIXED, rho1)
                delta = expectation(Q_PORTS_6[b], sub(out1, out0))
                if abs(delta) > TOL:
                    adjacency[a][b] = 1
                    break
    return adjacency


def effective_process_for_relation(r):
    # Extract the 3x3 matter block acting inside the invariant relation sector r.
    rows = [[0j for _ in range(3)] for _ in range(3)]
    for i in range(3):
        for j in range(3):
            rows[i][j] = U_FIXED[2 * i + r][2 * j + r]
    return mat(rows)


def predictive_algebra(u, steps=12):
    gens = []
    un = I3
    for _ in range(steps):
        for q in (Q_L, Q_M, Q_R):
            gens.append(mul(dagger(un), mul(q, un)))
        un = mul(u, un)
    return algebra_closure(gens)


def current(u_edge, q_target):
    return sub(mul(dagger(u_edge), mul(q_target, u_edge)), q_target)


def ledger_algebra_for_relation(r):
    # All currents are pulled back to the initial matter cut of the symmetric history.
    storage = [Q_L, Q_M, Q_R]
    if r == 0:
        # L-M controlled events are identity in this sector; only M-R carries flux.
        j_mr = current(U_MR, Q_R)
        return algebra_closure(storage + [j_mr])

    # r=1: history is U_LM(first), then U_MR, then U_LM(last).
    j_lm_local = current(U_LM, Q_M)
    j_mr_local = current(U_MR, Q_R)

    j1 = j_lm_local
    j2 = mul(dagger(U_LM), mul(j_mr_local, U_LM))
    before_j3 = mul(U_MR, U_LM)
    j3 = mul(dagger(before_j3), mul(j_lm_local, before_j3))
    return algebra_closure(storage + [j1, j2, j3])


def endogenous_relation_update_control():
    """Show the relation bit can be changed by a fixed closed unitary from matter.

    W_UPDATE flips r iff the excitation is at M.  A later C_LM therefore sees
    different interaction availability generated internally by the preceding state.
    """
    p_not_m = sub(I3, Q_M)
    w_update = add(kron(p_not_m, I2), kron(Q_M, X2))

    # |M,r=0> -> |M,r=1>; |R,r=0> -> |R,r=0> exactly.
    ket_m0 = ket_matter_relation((0, 1, 0), 0)
    ket_r0 = ket_matter_relation((0, 0, 1), 0)

    def apply_vec(u, v):
        return tuple(sum(u[i][j] * v[j] for j in range(len(v))) for i in range(len(v)))

    out_m = apply_vec(w_update, ket_m0)
    out_r = apply_vec(w_update, ket_r0)

    assert abs(out_m[2 * 1 + 1] - 1.0) < TOL
    assert abs(out_r[2 * 2 + 0] - 1.0) < TOL

    # The same subsequent controlled event C_LM is enabled for the first history
    # and disabled for the second solely because W_UPDATE changed the relation state.
    after_m = apply_vec(C_LM, out_m)
    after_r = apply_vec(C_LM, out_r)
    assert abs(after_m[2 * 0 + 1]) > TOL  # amplitude reaches L when enabled
    assert abs(after_r[2 * 0 + 0]) < TOL  # no L amplitude when disabled

    print("M3d endogenous relation-update sanity control: PASS")


def main():
    adj0 = signalling_matrix_for_relation(0)
    adj1 = signalling_matrix_for_relation(1)

    expected0 = [[0, 0, 0], [0, 0, 1], [0, 1, 0]]
    expected1 = [[0, 1, 1], [1, 0, 1], [1, 1, 0]]
    assert adj0 == expected0, (adj0, expected0)
    assert adj1 == expected1, (adj1, expected1)
    assert adj0 != adj1

    u0 = effective_process_for_relation(0)
    u1 = effective_process_for_relation(1)
    pred0 = predictive_algebra(u0)
    pred1 = predictive_algebra(u1)
    ledger0 = ledger_algebra_for_relation(0)
    ledger1 = ledger_algebra_for_relation(1)

    assert len(pred0) == 5
    assert len(ledger0) == 5
    assert same_space(pred0, ledger0)
    assert len(pred1) == 9
    assert len(ledger1) == 9
    assert same_space(pred1, ledger1)

    print("M3d state-determined accessibility: PASS")
    print(f"relation r=0 signalling={adj0} pred_dim={len(pred0)} ledger_dim={len(ledger0)}")
    print(f"relation r=1 signalling={adj1} pred_dim={len(pred1)} ledger_dim={len(ledger1)}")
    print("same fixed U_FIXED; boundary relational state changes operational accessibility")
    print("algebra change: C direct-sum M_2(C) (dim 5) -> M_3(C) (dim 9)")

    endogenous_relation_update_control()

    print("claim ceiling: finite state-controlled/self-update mechanism controls only")
    print("NOT exhaustive CPTP reconstruction; NOT B7 theorem; NOT geometry/GR/HDA")


if __name__ == "__main__":
    main()
