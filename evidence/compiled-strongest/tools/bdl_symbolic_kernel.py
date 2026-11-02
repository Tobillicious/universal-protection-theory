#!/usr/bin/env python3
"""Source-cell BDL kernel transfer, exact dual weights and Gibbs partition.

Requires the source-derived R_X/R_Z constructors on parent draft PR #215.
Tests are exact finite GF(2) and rational arithmetic, NOT a full-family
3D sampling/physical-embedding certificate.
"""
from collections import Counter, defaultdict
from fractions import Fraction

from bdl_replacement_chain import (
    edge, vertex, y_q, seed, replace_x, replace_z, rank,
)


def first_rx_cocycles(L, c=None):
    """Explicit three Z-check relations for R_X of the [[5,1,2]] seed.

    R0: central q2 vertical star plus all its seam faces.
    R1/R2: the vertical endpoint edges plus doubled z points.
    """
    t = seed()
    middle = set()
    for face in t.faces:
        for i in range(L):
            middle.add(("xf", face[0], ("seam", face, "q2", i)))
    middle.update(("qe", "q2", e) for e in y_q(t, "q2", L).edges)
    endpoints = []
    for z in t.zs:
        row = {("zv", z, 0), ("zv", z, 1)}
        for q in t.qs:
            if z in t.qz[q]:
                row.add(("qe", q, edge((0, vertex(z)), (1, vertex(z)))))
        endpoints.append(row)
    result = [middle] + endpoints
    if c is not None:
        all_z = set(c.z)
        for row in result:
            assert row <= all_z
            assert all(len(row & c.d1[q]) % 2 == 0 for q in c.q)
        assert any(element[0] == "xf" for element in middle)
        for j, z in enumerate(t.zs):
            marker = ("zv", z, 0)
            assert marker in result[j + 1]
            assert all(marker not in row for k, row in enumerate(result) if k != j + 1)
    return result


def dual_word_weights(rows, site_weight=lambda _: 1):
    """Enumerate weights of all 2^r combinations of independent parity rows."""
    result = []
    for mask in range(1 << len(rows)):
        support = set()
        for j, row in enumerate(rows):
            if mask >> j & 1:
                support.symmetric_difference_update(row)
        result.append(sum(site_weight(s) for s in support))
    return result


def first_level_dual_boundary_inventory(L, first):
    """Check exact path/cycle inventory of the dual Tanner local stars."""
    t = first.tanner.dual()
    boundary = defaultdict(lambda: (set(), set()))
    for x, q1, z, q2 in t.faces:
        v, e = boundary[x]
        for q in (q1, q2):
            v.update((q, z))
            e.add(tuple(sorted((q, z), key=repr)))
    classification = Counter((len(v), len(e)) for v, e in boundary.values())
    assert classification == {(8, 8): 8 * L**2 + 12 * L + 2,
                              (5, 4): 8 * L + 8}, classification
    q_degrees = Counter(len(t.qz[q]) for q in t.qs)
    assert q_degrees == {1: 8 * L + 8, 2: 16 * L**2 + 24 * L + 4}, q_degrees

    # χ(Tot R_X) = Σ_x χ(Y_x) - Σ_q χ(Y_q) + 2|V_Z|,
    # χ(Y_x) = 2 - χ(boundary X_x); χ(Y_q) = 2 - deg(q).
    x_euler = sum(2 - len(v) + len(e) for v, e in boundary.values())
    q_euler = sum(2 - len(t.qz[q]) for q in t.qs)
    chi2 = x_euler - q_euler + 2 * len(t.zs)
    assert chi2 == 32 * L**2 + 48 * L + 12, (L, chi2)
    return boundary, chi2


def expanded_site_weight(L, boundary):
    """Count new Z-checks under R_Z descended from one old Z-check."""
    def count(z):
        v, e = boundary[z]
        if (len(v), len(e)) == (8, 8):
            return 8 * L**2 + 8 * L + 2
        assert (len(v), len(e)) == (5, 4)
        return 4 * L**2 + 6 * L + 2
    return count


def source_symbolic(L):
    """Reconstruct one stage and derive second-stage exact rank/weights.

    No level-2 materialization needed to compute the symbolic results.
    """
    if L < 1:
        raise ValueError("positive L required")
    first = replace_x(seed(), L)
    relations = first_rx_cocycles(L, first)
    boundary, chi2 = first_level_dual_boundary_inventory(L, first)
    w1 = dual_word_weights(relations)
    cycle = 8 * L**2 + 8 * L + 2
    path = 4 * L**2 + 6 * L + 2
    w2 = dual_word_weights(relations, expanded_site_weight(L, boundary))
    assert w1 == [0, 8*L+2, 5, 8*L+5, 5, 8*L+5, 10, 8*L+8], w1
    assert w2 == [
        0, (8*L+2)*cycle, cycle+4*path, (8*L+1)*cycle+4*path,
        cycle+4*path, (8*L+1)*cycle+4*path,
        2*cycle+8*path, 8*L*cycle+8*path,
    ], w2
    n2 = sum(expanded_site_weight(L, boundary)(z) for z in first.z)
    assert n2 == 64*L**4+192*L**3+208*L**2+104*L+20, n2
    # H^1=1 by BDL replacement theorem, H^2=3 by R_Z dual
    # kernel preservation, so dim ker δ0_at_lvl2 = χ2 - 2.
    h0_2 = chi2 - 2
    assert h0_2 == 32*L**2+48*L+10
    return first, relations, w1, w2, n2, h0_2


def fourier_partition(n, weights, z):
    """Exact Z for π(σ) ∝ z^|σ| subject to r independent parity rows.

    1_{Aσ=0} = 2^-r Σ_{u∈rowspan A} (-1)^(u·σ).
    """
    z = Fraction(z)
    return sum(((1+z)**(n-w)*(1-z)**w for w in weights),
               Fraction(0)) / len(weights)


def audit():
    from finite_syndrome_trellis import SyndromeTrellis

    for L in (1, 2, 3, 4):
        first, rows, w1, w2, n2, h0 = source_symbolic(L)
        m1 = len(first.z)
        assert m1 == 8*L*L+20*L+10
        assert len(first.x) - rank(first.d0.values(), first.q) == 0
        assert len(first.z) - rank(first.d1.values(), first.z) == 3

        if L <= 2:
            index = {z: i for i, z in enumerate(first.z)}
            checks = [tuple(index[z] for z in row) for row in rows]
            for z in (Fraction(1, 3), Fraction(3, 4)):
                trellis = SyndromeTrellis(m1, checks, z)
                assert trellis.width <= 3
                assert trellis.partition == fourier_partition(m1, w1, z)

            second = replace_z(first.tanner, L)
            assert len(second.z) == n2
            assert len(second.x) - rank(second.d0.values(), second.q) == h0
            assert len(second.z) - rank(second.d1.values(), second.z) == 3
            new_zset = set(second.z)
            lifted = []
            for row in rows:
                relation = {z for z in new_zset if z[1] in row}
                assert all(len(relation & second.d1[q]) % 2 == 0 for q in second.q)
                lifted.append(relation)

            actual_weights = dual_word_weights(lifted)
            assert actual_weights == w2
            if L == 1:
                index2 = {z: i for i, z in enumerate(second.z)}
                checks2 = [tuple(index2[z] for z in row) for row in lifted]
                t2 = SyndromeTrellis(len(second.z), checks2, Fraction(1, 3))
                assert t2.width <= 3
                assert t2.partition == fourier_partition(n2, w2, Fraction(1, 3))

            print("L=",L,"m_1=",m1,"m_2=",n2,"H0_2=",h0,
                  "X-dual-weights-1=",w1,"X-dual-weights-2=",w2)

    print("BDL kernel transfer, explicit cocycles, χ-ranks and exact Gibbs duality: PASS")


if __name__ == "__main__":
    audit()
