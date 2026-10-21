"""E7 under the life-first canonical order (author ruling R-ORDER), WITHOUT using D-H. Exact (Python 3.9).
Particulars x (target) and y (suspect); each 0 ended, 1 overridden (held), 2 free. Order: lexicographic over
(alive set, free set), by inclusion. Upward-closed sets of outcomes are computed in that order.
Actions: standby (real: x ended, y free; false: both free); strike (y ended, x free, both states);
hold (real: x free, y HELD; false: y held then released, both free).
Claim: the hold dominates standby for every p, strictly iff p > 0, and strictly dominates strike for every p —
even counting the held suspect as overridden (no D-H needed)."""
from fractions import Fraction as F
from itertools import combinations, product
import json, sys
sys.dont_write_bytecode = True
OUTS = list(product((0, 1, 2), repeat=2))


def key(o): return (frozenset(i for i in range(2) if o[i] >= 1), frozenset(i for i in range(2) if o[i] == 2))


def better(a, b):
    for x, y in zip(key(a), key(b)):
        if x == y: continue
        return x > y
    return False


def geq_or_eq(a, b): return a == b or better(a, b) or key(a) == key(b)


UPS = [frozenset(U) for k in range(len(OUTS) + 1) for U in combinations(OUTS, k)
       if all(t in U for s in U for t in OUTS if better(t, s) or key(t) == key(s))]


def dom(L, M): return all(sum(L.get(s, 0) for s in U) >= sum(M.get(s, 0) for s in U) for U in UPS)


def dist(pairs):
    d = {}
    for pr, s in pairs:
        if pr: d[s] = d.get(s, F(0)) + pr
    return d


if __name__ == '__main__':
    for i in range(21):
        p = F(i, 20)
        S = dist([(p, (0, 2)), (1 - p, (2, 2))]); K = dist([(1, (2, 0))]); H = dist([(p, (2, 1)), (1 - p, (2, 2))])
        assert dom(H, S) and (not dom(S, H)) == (p > 0)
        assert dom(H, K) and not dom(K, H)
    print(json.dumps({'upsets': len(UPS), 'p_points': 21, 'hold_dominates_standby_strict_iff_p_pos': True,
                      'hold_strictly_dominates_strike': True, 'D_H_not_used': True}, sort_keys=True, indent=2))
