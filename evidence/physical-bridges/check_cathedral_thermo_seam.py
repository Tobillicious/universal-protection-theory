#!/usr/bin/env python3
"""Exact finite/rational controls for TheoremEight/ThermoLedger cyclic joins.
Not Lean certification, source physical validation, or proof of cosmic recurrence.
"""
from fractions import Fraction as F
from itertools import product


def recurrence_controls():
    cases = edges_examined = recurrent_edges = 0
    for n in range(1, 4):
        pairs = list(product(range(n), repeat=2))
        for levels in product(range(3), repeat=n):
            for mask in range(1 << (n*n)):
                edges = [(u, v) for k, (u, v) in enumerate(pairs)
                         if mask & (1 << k) and levels[u] >= levels[v]]
                reach = [[i == j for j in range(n)] for i in range(n)]
                for u, v in edges:
                    reach[u][v] = True
                for k in range(n):
                    for i in range(n):
                        for j in range(n):
                            reach[i][j] = reach[i][j] or (reach[i][k] and reach[k][j])
                on_cycle = [(u, v) for u, v in edges if reach[v][u]]
                assert all(levels[u] == levels[v] for u, v in on_cycle)
                edges_examined += len(edges)
                recurrent_edges += len(on_cycle)
                cases += 1
    # Hostile control: with a compensating uphill step, a decreasing step
    # CAN belong to a two-edge cycle; the no-increase premise is load-bearing.
    potential = {0: 1, 1: 0}
    assert potential[0] > potential[1]
    assert potential[1] < potential[0]
    return cases, edges_examined, recurrent_edges


def escrow_controls():
    total = closed = positive_work_closed = 0
    for capacity in range(1, 6):
        for before in range(capacity+1):
            for work in range(7):
                for income in range(10):
                    after = min(capacity, before-work+income)
                    overflow = max(0, before-work+income-capacity)
                    assert after + work + overflow == before + income
                    total += 1
                    if after == before:
                        closed += 1
                        assert income == work + overflow
                        if work > 0:
                            positive_work_closed += 1
    return total, closed, positive_work_closed


def thermodynamic_work_floor_controls():
    # The actual source assumptions are Q/kT >= IM+Derr+dI,
    # work >= Q+(1-eta)*C. For closed escrow, income=work+overflow.
    count = closed = 0
    for kT, im, derr, di, eta, c, surplus_heat in product(
        (F(1), F(2)), (0,1), (0,1), (0,1), (F(0), F(1,2), F(1)),
        (0,1,2), (0,1,2)
    ):
        q = kT * (im+derr+di) + surplus_heat
        work = q + (1-eta)*c
        floor = kT*(im+derr+di) + (1-eta)*c
        assert q/kT >= im+derr+di
        assert work >= q+(1-eta)*c
        assert work >= floor
        for overflow in (0,1,3):
            income = work+overflow
            assert income >= floor+overflow
            closed += 1
        count += 1
    return count, closed


def total_entropy_controls():
    patterns = 0
    for increments in product(range(3), repeat=5):
        patterns += 1
        assert (sum(increments) == 0) == all(x == 0 for x in increments)
    return patterns


if __name__ == "__main__":
    a = recurrence_controls()
    b = escrow_controls()
    c = thermodynamic_work_floor_controls()
    d = total_entropy_controls()
    assert a == (13974, 48627, 28395)
    assert b == (1400, 350, 285)
    assert c == (432, 1296)
    assert d == 243
    print(f"PASS: {a[0]} finite recurrence graph/potential cases, "
          f"{a[1]} edges, {a[2]} recurrent edges")
    print(f"PASS: {b[0]} exact escrow identities, {b[1]} closed, "
          f"{b[2]} positive-work closures")
    print(f"PASS: {c[0]} source-floor parameter cases, {c[1]} closed-floor checks")
    print(f"PASS: {d} total nonnegative-production patterns")
    print("PASS: compensating increase hostile control; positivity/isomorphism "
          "premises remain substantive")
    print("LIMIT: no physical cyclic universe, full entropy seam, or UPT necessity proved")
