"""Q1 repair: the FAITHFUL HOLD redefined in the full canonical order. Exact, exhaustive (Python 3.9, Fractions).
Two existing particulars; status 0 ended, 1 alive but overridden, 2 free. The canonical order is life first, then
freedom (lexicographic by inclusion); the weak order x <= y holds iff y is better or equal (same keys).
FAITHFUL (new): in every state, H is >= every feasible alternative in the full canonical order, and H ends no one.
C1 Codex's three-state countermodel: H meets the OLD definition (alive-top + false-alarm freedom) but not the new
   one, and H and the lethal A are stochastically incomparable (both-free 1/2 vs 3/4; both-alive 1 vs 3/4).
C2 Exhaustive (2 states, probabilities in {1/4,1/2,3/4}, every pair of state-maps): if H is >= A statewise in the
   full order, H dominates A on EVERY upward-closed event of that order; if moreover H ends no one and A ends
   someone in a positive-probability state, the dominance is STRICT."""
from fractions import Fraction as F
from itertools import combinations, product
import json, sys
sys.dont_write_bytecode = True
OUTS = list(product((0, 1, 2), repeat=2))


def key(o): return (frozenset(i for i in range(2) if o[i] >= 1), frozenset(i for i in range(2) if o[i] == 2))


def ge(y, x):                                  # y >= x in the canonical weak order
    ky, kx = key(y), key(x)
    for a, b in zip(ky, kx):
        if a == b: continue
        return a > b
    return True


UPS = [frozenset(U) for k in range(len(OUTS) + 1) for U in combinations(OUTS, k)
       if all(y in U for x in U for y in OUTS if ge(y, x))]


def prob(dist, U): return sum(p for o, p in dist.items() if o in U)


def law(act, ps):
    d = {}
    for o, p in zip(act, ps): d[o] = d.get(o, F(0)) + p
    return d


def dom(H, A, ps): return all(prob(law(H, ps), U) >= prob(law(A, ps), U) for U in UPS)


if __name__ == '__main__':
    ps3 = (F(1, 2), F(1, 4), F(1, 4))
    H = ((2, 2), (2, 1), (2, 1)); A = ((2, 2), (2, 2), (2, 0))
    old_ok = all(min(h) >= 1 for h in H) and H[0] == (2, 2)
    new_ok = all(ge(h, a) for h, a in zip(H, A))
    both_free = frozenset([(2, 2)]); both_alive = frozenset(o for o in OUTS if min(o) >= 1)
    assert both_free in UPS and both_alive in UPS
    assert old_ok and not new_ok and not dom(H, A, ps3) and not dom(A, H, ps3)
    assert (prob(law(H, ps3), both_free), prob(law(A, ps3), both_free)) == (F(1, 2), F(3, 4))
    assert (prob(law(H, ps3), both_alive), prob(law(A, ps3), both_alive)) == (1, F(3, 4))
    pairs = strict = 0
    for H2 in product(OUTS, repeat=2):
        for A2 in product(OUTS, repeat=2):
            if not all(ge(h, a) for h, a in zip(H2, A2)): continue
            for p in (F(1, 4), F(1, 2), F(3, 4)):
                ps = (p, 1 - p); pairs += 1
                assert dom(H2, A2, ps)
                if all(min(h) >= 1 for h in H2) and any(min(a) == 0 for a in A2):
                    assert not dom(A2, H2, ps); strict += 1
    print(json.dumps({'upsets': len(UPS), 'C1_old_definition_insufficient': True,
                      'C1_both_free': ['1/2', '3/4'], 'C1_both_alive': ['1', '3/4'],
                      'C2_statewise_pairs_checked': pairs, 'C2_always_dominates': True,
                      'C2_strict_against_lethal': strict}, sort_keys=True, indent=2))
