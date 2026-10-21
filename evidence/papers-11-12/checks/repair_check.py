"""UPT law repair round 1 — exact, exhaustive Python checks (Python 3.9, Fractions, no randomness).
R1 (F1)  Canonical order = lexicographic partial order: a later stage is consulted only when all earlier stages
         are EQUAL. The old staged global filter differs; count disagreements; lex-aligned never has a stage-1
         needless loss.
R2 (F9)  U2★ exhaustive: with E nonempty, criterion S guarantees no needless existing loss over EVERY family
         iff S == E.
R3 (F5,F8,F4) E7 on the alarm model with p in [0,1] INCLUSIVE: hold >= standby for all p, strict iff p>0;
         hold > strike for all p; strike vs standby incomparable iff p>0 (standby >= strike at p=0); a flawed
         hold (false-hold loss q) dominates standby iff (1-p)q == 0. Codex's relational-z model: a hold that
         loses z w.p. 1/2 does NOT dominate standby (so "faithful" must keep every particular).
R4 (F2)  E1 marginals: the uniform option lottery gives equal chance to symmetry-equivalent particulars;
         arbitrary particulars need not (Codex's {a,b},{a,c},{d}: 2/3 vs 1/3)."""
from fractions import Fraction as F
from itertools import combinations, permutations, product
import json, sys
sys.dont_write_bytecode = True


def subsets(xs):
    xs = sorted(xs); return [frozenset(c) for r in range(len(xs) + 1) for c in combinations(xs, r)]


def fams(opts, kmax=None):
    for k in range(1, (kmax or len(opts)) + 1):
        for c in combinations(opts, k): yield list(c)


def lex_better(ka, kb):
    """ka strictly better than kb in the lexicographic partial order of stage keys (sets)."""
    for x, y in zip(ka, kb):
        if x == y: continue
        return x > y
    return False


def r1():
    dis = cases = 0
    for n in (1, 2, 3):
        U = frozenset(range(n))
        for E in subsets(U):
            N = U - E; key = lambda o: (o & E, o & N)
            for fam in fams(subsets(U)):
                cases += 1
                lex = {o for o in fam if not any(lex_better(key(p), key(o)) for p in fam)}
                st1 = [o for o in fam if not any((p & E) > (o & E) for p in fam)]
                staged = {o for o in st1 if not any((p & N) > (o & N) for p in st1)}
                if lex != staged: dis += 1
                for o in lex:
                    assert not any(any((p & E) >= ((o & E) | {x}) for p in fam) for x in E - o)
    assert dis > 0
    return {'family_split_cases': cases, 'staged_filter_disagrees_with_lex': dis,
            'lex_aligned_never_stage1_needless': True}


def r2():
    rows = 0
    for n in (1, 2, 3):
        U = list(range(n)); opts = subsets(U); allfams = list(fams(opts))
        for E in subsets(U):
            if not E: continue
            for S in subsets(U):
                rows += 1; guaranteed = True
                for fam in allfams:
                    A = [o for o in fam if not any((p & S) > (o & S) for p in fam)]
                    if any(any((p & E) >= ((o & E) | {x}) for p in fam) for o in A for x in E - o):
                        guaranteed = False; break
                assert guaranteed == (S == E), (n, E, S)
    return {'criterion_pairs': rows, 'U2_star_iff_S_equals_E': True}


SETS2 = subsets(('x', 'y'))
UP2 = [frozenset(U) for k in range(len(SETS2) + 1) for U in combinations(SETS2, k)
       if all(t in U for s in U for t in SETS2 if t >= s)]


def geq(L, M, ups=UP2):
    return all(sum(L.get(s, 0) for s in U) >= sum(M.get(s, 0) for s in U) for U in ups)


def dist(pairs):
    d = {}
    for pr, s in pairs:
        if pr: d[s] = d.get(s, F(0)) + pr
    return d


def r3():
    xy, x, y = frozenset({'x', 'y'}), frozenset({'x'}), frozenset({'y'}); pts = 0
    for i in range(0, 21):
        p = F(i, 20)
        H = dist([(1, xy)]); S = dist([(p, y), (1 - p, xy)]); K = dist([(1, x)])
        assert geq(H, S) and (not geq(S, H)) == (p > 0)
        assert geq(H, K) and not geq(K, H)
        assert (not geq(K, S) and not geq(S, K)) == (p > 0)
        if p == 0: assert geq(S, K)
        for j in range(0, 21):
            q = F(j, 20); pts += 1
            Hq = dist([(p, xy), ((1 - p) * (1 - q), xy), ((1 - p) * q, x)])
            assert geq(Hq, S) == ((1 - p) * q == 0)
    sets3 = subsets(('x', 'y', 'z'))
    up3 = [frozenset(U) for k in range(len(sets3) + 1) for U in combinations(sets3, k)
           if all(t in U for s in U for t in sets3 if t >= s)]
    Hz = dist([(F(1, 2), frozenset('xyz')), (F(1, 2), frozenset('xy'))]); Sz = dist([(1, frozenset('xyz'))])
    assert not geq(Hz, Sz, up3)
    return {'p_points_inclusive': 21, 'pq_points': pts, 'hold_weak_all_p_strict_iff_p_pos': True,
            'strike_standby_incomparable_iff_p_pos': True, 'flawed_hold_dominates_iff_no_false_loss_mass': True,
            'relational_z_counterexample_confirmed': True}


def r4():
    fam = [frozenset('ab'), frozenset('ac'), frozenset('d')]
    marg = {q: F(sum(q in o for o in fam), len(fam)) for q in 'abcd'}
    assert marg == {'a': F(2, 3), 'b': F(1, 3), 'c': F(1, 3), 'd': F(1, 3)}
    checked = 0
    for n in (2, 3):
        U = list(range(n)); perms = [dict(zip(U, p)) for p in permutations(U)]
        for fam in fams(subsets(U)):
            M = [o for o in fam if not any(p > o for p in fam)]; Fs = set(fam)
            auts = [s for s in perms if {frozenset(s[v] for v in o) for o in Fs} == Fs]
            m = {v: F(sum(v in o for o in M), len(M)) for v in U}
            for s in auts:
                for v in U: assert m[v] == m[s[v]]
            checked += 1
    return {'codex_example_marginals': {k: str(v) for k, v in marg.items()},
            'families': checked, 'symmetry_equivalent_particulars_equal_chance': True}


if __name__ == '__main__':
    print(json.dumps({'R1': r1(), 'R2': r2(), 'R3': r3(), 'R4': r4()}, sort_keys=True, indent=2))
