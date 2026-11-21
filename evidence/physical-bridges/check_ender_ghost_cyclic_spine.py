#!/usr/bin/env python3
"""Finite productive-spine and variable-hazard controls.
This is a check of definitions/theorems, NOT physical cosmology or real UPT safety.
"""
from fractions import Fraction
from itertools import product
from math import log


def productive_by_length(n, edges):
    """Sources from which a length-n walk exists; equals infinite-walk support on finite graph."""
    productive = set(range(n))
    for _ in range(n):
        productive = {u for u, v in edges if v in productive}
    return productive


def reachability(n, edges):
    r = [[i == j for j in range(n)] for i in range(n)]
    for u, v in edges:
        r[u][v] = True
    for k in range(n):
        for i in range(n):
            if r[i][k]:
                for j in range(n):
                    r[i][j] = r[i][j] or r[k][j]
    return r


def productive_by_cycles(n, edges):
    r = reachability(n, edges)
    cyc = {u for u, v in edges if r[v][u]}
    return {s for s in range(n) if any(r[s][c] for c in cyc)}


def universal_productive_by_length(n, edges):
    """States whose every admissible walk has a successor at every step."""
    outgoing = {u: set() for u in range(n)}
    for u, v in edges:
        outgoing[u].add(v)
    good = set(range(n))
    for _ in range(n):
        good = {u for u, vs in outgoing.items() if vs and vs <= good}
    return good


def universal_productive_by_sinks(n, edges):
    outgoing = {u: set() for u in range(n)}
    for u, v in edges:
        outgoing[u].add(v)
    sinks = {u for u in range(n) if not outgoing[u]}
    reach = reachability(n, edges)
    return {u for u in range(n) if not any(reach[u][s] for s in sinks)}


def run():
    graphs = tested_edges = 0
    terminal_edges = continuing_edges = existential_not_universal = 0
    for n in range(1, 4):
        directed = tuple(product(range(n), repeat=2))
        for mask in range(1 << (n * n)):
            edges = tuple(e for k, e in enumerate(directed) if mask >> k & 1)
            spine = productive_by_length(n, edges)
            assert spine == productive_by_cycles(n, edges)
            universal = universal_productive_by_length(n, edges)
            assert universal == universal_productive_by_sinks(n, edges)
            assert universal <= spine
            existential_not_universal += len(spine - universal)
            for e in edges:
                u, v = e
                tested_edges += 1
                if v not in spine:
                    # An edge whose target has no indefinitely continuing future
                    # is absent from every infinite forward lineage.
                    terminal_edges += 1
                else:
                    # Can lead to arbitrary-length future via target; it is not
                    # a successful universal termination under this definition.
                    continuing_edges += 1
            graphs += 1
    assert graphs == 2 + 16 + 512 == 530
    assert tested_edges == 1 + 32 + 2304 == 2337

    # One cyclic world-state has both an indefinitely continuing branch and
    # a possible terminal transition. Observation of the continuing branch
    # does not imply the terminal option was impossible.
    branch_graph = ((0, 0), (0, 1))
    assert productive_by_length(2, branch_graph) == {0}
    assert universal_productive_by_length(2, branch_graph) == set()

    # Exact countermodel: every generation has positive termination hazard,
    # yet indefinitely many generations can survive with positive probability.
    prob = Fraction(1)
    for n in range(1, 101):
        k = n + 1
        prob *= (1 - Fraction(1, k * k))
        assert prob == Fraction(n + 2, 2 * (n + 1))
    assert prob > Fraction(1, 2)

    # A uniform per-transition lower failure hazard does force survival
    # probability to zero in the infinite limit (geometric bound).
    uniform_survival_100 = Fraction(3, 4) ** 100
    assert uniform_survival_100 < Fraction(1, 10**12)

    # Old G density-zero result uses keeper growth, not recurrence alone.
    for T in (10, 100, 1000):
        periodic_share = sum(Fraction(1, 11) for t in range(1, T + 1)) / T
        assert periodic_share == Fraction(1, 11)
        growing_share = sum(Fraction(1, 1 + t) for t in range(1, T + 1)) / T
        assert float(growing_share) <= log(T + 1) / T
    print(f"PASS: {graphs} directed source graphs, {tested_edges} labelled-edge controls")
    print(f"PASS: {terminal_edges} terminal-target and {continuing_edges} productive-target edge classifications")
    print("PASS: productive core == states reaching some directed cycle")
    print(f"PASS: existential and universal survival separated in {existential_not_universal} graph-state cases")
    print("PASS: eternal self-loop alongside a permitted terminal branch")
    print(f"PASS: exact declining-hazard infinite-lineage survival limit 1/2; P_100={prob}")
    print("PASS: uniform-hazard geometric survival exclusion")
    print("PASS: old density-zero requires growth; periodic finite populations have nonzero share")
    print("LIMIT: existence of infinite past/future and actual UPT guardian mechanism remain unproven")


if __name__ == "__main__":
    run()
