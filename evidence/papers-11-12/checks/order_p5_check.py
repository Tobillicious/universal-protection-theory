"""Round-2 checks (exact, exhaustive, Python 3.9).
G  (Codex N5) Life-first vs freedom-first. Outcomes map each of n existing particulars to 0 ended, 1 overridden,
   2 free. Freedom-first = (free set, alive set); life-first = (alive set, free set), lexicographic by inclusion.
   LIFE GUARD: some canonically aligned option keeps alive everyone standby keeps alive.
   Expect: life-first satisfies the life guard in EVERY family (guard_first_stage); freedom-first fails in some
   (Codex's example). FREE GUARD under freedom-first holds in every family; under life-first it can fail.
   Also record what each order does in the two telling cases.
P  (Codex N8) P5 on RAYS: two pure states (rational real unit vectors) can share one exact copier iff |c| in {0,1}
   (c = overlap); c = -1 is the SAME physical state. Broadcasting is weaker: commuting rho = diag(3/4,1/4),
   sigma = diag(1/4,3/4) are broadcast by CNOT-with-blank (correct marginals) though the joint is correlated,
   not rho (x) rho."""
from fractions import Fraction as F
from itertools import combinations, product
import json, sys
sys.dont_write_bytecode = True


def keys(o, n):
    return frozenset(i for i in range(n) if o[i] == 2), frozenset(i for i in range(n) if o[i] >= 1)


def better(ka, kb):
    for x, y in zip(ka, kb):
        if x == y: continue
        return x > y
    return False


def aligned(fam, key):
    return [o for o in fam if not any(better(key(p), key(o)) for p in fam)]


if __name__ == '__main__':
    res = {}
    for n in (2, 3):
        outs = list(product((0, 1, 2), repeat=n))
        FF = lambda o: keys(o, n)                      # (free, alive)
        LF = lambda o: keys(o, n)[::-1]                # (alive, free)
        stats = {'families': 0, 'lifefirst_life_guard_fails': 0, 'freefirst_life_guard_fails': 0,
                 'freefirst_free_guard_fails': 0, 'lifefirst_free_guard_fails': 0}
        for k in (1, 2, 3):
            for fam in combinations(outs, k):
                stats['families'] += 1
                for s in fam:
                    for name, key in (('lifefirst', LF), ('freefirst', FF)):
                        A = aligned(fam, key)
                        alive_s, free_s = keys(s, n)[1], keys(s, n)[0]
                        if not any(keys(o, n)[1] >= alive_s for o in A): stats[name + '_life_guard_fails'] += 1
                        if not any(keys(o, n)[0] >= free_s for o in A): stats[name + '_free_guard_fails'] += 1
        assert stats['lifefirst_life_guard_fails'] == 0 and stats['freefirst_free_guard_fails'] == 0
        assert stats['freefirst_life_guard_fails'] > 0 and stats['lifefirst_free_guard_fails'] > 0
        res['n%d' % n] = stats
    # telling cases (n=2): (a free, b ended) vs (a overridden, b alive)
    o1, o2 = (2, 0), (1, 1)
    ff = aligned([o1, o2], lambda o: keys(o, 2)); lf = aligned([o1, o2], lambda o: keys(o, 2)[::-1])
    assert ff == [o1] and lf == [o2]
    # P5 on rays
    vs = {(F(1), F(0)), (F(0), F(1))}
    for m in range(1, 20):
        for k in range(1, m):
            a, b, c = m * m - k * k, 2 * m * k, m * m + k * k
            for sa, sb in product((1, -1), repeat=2):
                vs.add((F(sa * a, c), F(sb * b, c))); vs.add((F(sb * b, c), F(sa * a, c)))
    pairs = same_ray_minus = 0
    for u in vs:
        for w in vs:
            pairs += 1; c = u[0] * w[0] + u[1] * w[1]; ac = abs(c)
            ok = (ac == ac * ac)
            assert ok == (c in (F(-1), F(0), F(1)))
            if c == -1: assert (w[0], w[1]) == (-u[0], -u[1]); same_ray_minus += 1
    rho, sig = (F(3, 4), F(1, 4)), (F(1, 4), F(3, 4))
    for d in (rho, sig):                               # CNOT on diag(d) (x) |0><0| gives diag(d0, 0, 0, d1)
        joint = (d[0], F(0), F(0), d[1]); mA = (joint[0] + joint[1], joint[2] + joint[3]); mB = (joint[0] + joint[2], joint[1] + joint[3])
        assert mA == d and mB == d and joint != (d[0] * d[0], d[0] * d[1], d[1] * d[0], d[1] * d[1])
    print(json.dumps({'guards': res,
                      'case_free_a_vs_alive_both': {'freedom_first_chooses': 'a free, b ended',
                                                    'life_first_chooses': 'a held, b alive'},
                      'P5_ray_pairs': pairs, 'P5_cloneable_iff_abs_overlap_0_or_1': True,
                      'P5_minus_psi_same_state_cases': same_ray_minus,
                      'broadcast_not_clone_commuting_example': True}, sort_keys=True, indent=2))
