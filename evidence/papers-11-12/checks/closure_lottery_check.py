"""Independent non-author check of Codex's continuation (CLOSURE-FEEDBACK, COHOLD, STATISTICAL-LOTTERY). Exact.
CLOSURE: nodes 0..3; each directed edge (i,j) is absent or has a tolerance tol in {1,2,3}; the hold duration of a
set C is h(C) = 1 + |C| (and, as a second monotone certificate, h(C) = 2|C|). An edge obliges j to be co-held when
i is held and h(C) > tol. F(C) = C plus every j obliged by some held i. Iterate from a seed until stable.
Claims: the iterate stabilises; contains the seed; is closed (F(K) = K); and is contained in EVERY closed set
containing the seed (least). Cascade A->B->C->D with tolerances 1,2,3 from {A} gives sizes 1,2,3,4.
LOTTERY: q = 5 residues, accept c = m*floor(q/m), option = residue mod m. For every raw law with denominator 20
and every m, TV(option, uniform) <= min(1 - 1/m, TV(raw, uniform)/a), a = c/q; Codex's sharp law gives 1/60."""
from fractions import Fraction as F
from itertools import product, combinations
import json, sys
sys.dont_write_bytecode = True
N = 4


def closure(edges, seed, h):
    C = frozenset(seed); seq = [C]
    while True:
        D = C | {j for (i, j), tol in edges.items() if i in C and h(C) > tol}
        if D == C: return C, seq
        C = frozenset(D); seq.append(C)


def closed(edges, K, h): return all(j in K for (i, j), tol in edges.items() if i in K and h(K) > tol)


if __name__ == '__main__':
    pairs = [(i, j) for i in range(N) for j in range(N) if i != j]
    cases = 0
    for hname, h in (('1+|C|', lambda C: 1 + len(C)), ('2|C|', lambda C: 2 * len(C))):
        for labels in product((None, 1, 3), repeat=len(pairs)):
            if sum(l is not None for l in labels) > 4: continue
            edges = {p: l for p, l in zip(pairs, labels) if l is not None}
            for seed in ((0,), (0, 1)):
                K, seq = closure(edges, seed, h); cases += 1
                assert set(seed) <= K and closed(edges, K, h)
                for r in range(N + 1):
                    for S in combinations(range(N), r):
                        S = frozenset(S)
                        if set(seed) <= S and closed(edges, S, h): assert K <= S, (edges, seed, K, S)
    casc = {(0, 1): 1, (1, 2): 2, (2, 3): 3}
    K, seq = closure(casc, (0,), lambda C: 1 + len(C))
    assert [len(x) for x in seq] == [1, 2, 3, 4]
    tv = lambda P, Q: sum(abs(p - q) for p, q in zip(P, Q)) / 2
    q = 5; U = [F(1, q)] * q; laws = 0
    for raw in product(range(21), repeat=q):
        if sum(raw) != 20: continue
        P = [F(x, 20) for x in raw]; eps = tv(P, U)
        for m in range(1, q + 1):
            c = m * (q // m); a = F(c, q); pa = sum(P[:c])
            if pa == 0: continue
            opt = [sum(P[r] for r in range(c) if r % m == k) / pa for k in range(m)]
            assert tv(opt, [F(1, m)] * m) <= min(1 - F(1, m), eps / a)
            laws += 1
    P = [F(21, 100), F(19, 100), F(1, 5), F(1, 5), F(1, 5)]; m = 3; c = 3; pa = sum(P[:3])
    opt = [sum(P[r] for r in range(c) if r % m == k) / pa for k in range(m)]
    assert tv(opt, [F(1, 3)] * 3) == F(1, 60) and tv(P, U) == F(1, 100)
    print(json.dumps({'closure_cases': cases, 'closure_stable_contains_seed_closed_least': True,
                      'cascade_sizes': [1, 2, 3, 4], 'lottery_laws_checked': laws,
                      'lottery_bound_holds': True, 'sharp_example_tv': '1/60'}, sort_keys=True, indent=2))
