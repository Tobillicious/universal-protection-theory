"""Verifiable secret sharing (bivariate, BGW-style), t = 1, over Z_5 — exact, exhaustive (Python 3.9).
Dealer picks a symmetric bivariate polynomial S(x,y) = s + b(x+y) + c x y and gives receiver i the line
f_i(y) = S(i, y). Receivers i, j cross-check f_i(j) == f_j(i) (both equal S(i,j)). The share of i is f_i(0).
V1 CONSISTENCY against a CHEATING dealer: for EVERY assignment of lines to the honest receivers (any lines at all,
not necessarily from one S), if every honest pair's cross-check passes, the honest shares f_i(0) lie on ONE
degree-1 line, so the secret they reconstruct (its value at 0) is fixed. Checked for honest sets of size 3 and 4
(four receivers, at most one corrupt).
V2 PRIVACY (honest dealer): one receiver's whole line f_i is uniform over the lines consistent with its index,
whatever the secret: its view reveals nothing.
V3 CONTROL: an unchecked third row can disagree with two honest rows. This is a conflict witness, not a claim
that two pair-consistent rows fail to determine a symmetric polynomial, nor a full VSS protocol proof."""
from itertools import product, combinations
import json, sys
sys.dont_write_bytecode = True
P = 5
LINES = list(product(range(P), repeat=2))                 # f(y) = u + w y


def ev(line, y): return (line[0] + line[1] * y) % P


def collinear(pts):
    (x1, y1), (x2, y2) = pts[0], pts[1]
    inv = pow((x2 - x1) % P, P - 2, P); slope = ((y2 - y1) * inv) % P
    return all((y1 + slope * (x - x1)) % P == y % P for x, y in pts)


if __name__ == '__main__':
    v1 = {}
    for H in ((1, 2, 3), (1, 2, 3, 4)):
        passing = 0
        for assign in product(LINES, repeat=len(H)):
            f = dict(zip(H, assign))
            if all(ev(f[i], j) == ev(f[j], i) for i, j in combinations(H, 2)):
                passing += 1
                assert collinear([(i, ev(f[i], 0)) for i in H]), (H, assign)
        v1['honest_%d' % len(H)] = {'assignments': P ** (2 * len(H)), 'passing_cross_checks': passing}
    for i in (1, 2, 3, 4):                                   # V2
        views = {}
        for s, b, c in product(range(P), repeat=3):
            line = ((s + b * i) % P, (b + c * i) % P)
            views.setdefault(s, {}); views[s][line] = views[s].get(line, 0) + 1
        dists = [tuple(sorted(views[s].items())) for s in range(P)]
        assert len(set(dists)) == 1
    bad = 0                                                  # V3: two honest receivers, third party disagrees
    for f1, f2, f3 in product(LINES, repeat=3):
        if ev(f1, 2) == ev(f2, 1) and not (ev(f1, 3) == ev(f3, 1) and ev(f2, 3) == ev(f3, 2)):
            if not collinear([(1, ev(f1, 0)), (2, ev(f2, 0)), (3, ev(f3, 0))]): bad += 1
    assert bad > 0
    print(json.dumps({'parameters': {'field': P, 'degree': 1, 'receivers': 4}, 'security_scope': 'finite primitive consistency and honest-dealer one-view privacy; not a complete malicious-party VSS protocol', 'V1_consistency': v1, 'V1_honest_shares_always_collinear': True,
                      'V2_one_view_independent_of_secret': True, 'V3_two_honest_insufficient_cases': bad},
                     sort_keys=True, indent=2))
