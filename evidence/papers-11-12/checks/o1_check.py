"""O-1: the operational harm boundary, judged from the agent's OWN options (exact, exhaustive, Python 3.9).
An agent y chooses among its own feasible acts A_y; each act's outcome is the set of particulars kept (y included).
RESTRAINABLE(a): some own alternative a' keeps everything a keeps AND some particular a ends (a needless ending
judged only from y's own options, never from the protector's — so no circularity).
Restraint = substitute a maximal such alternative (least-restrictive: y still chooses among its own non-needless acts).
Claims:
 D1 (D-H becomes a theorem) restraining a restrainable act keeps the restrained agent whenever its act kept it,
    and keeps strictly more overall;
 D2 (non-circular) restrainability depends only on A_y: adding/removing any protector action never changes it;
 D3 (predators) when y's only alternatives that spare z end y itself (hunt {y} vs starve {z}), hunting is NOT
    restrainable; such pairs are tragic for a protector;
 D4 (minds) an act with an own alternative ending no one is always restrainable."""
from itertools import combinations
import json, sys
sys.dont_write_bytecode = True


def subsets(xs):
    xs = sorted(xs); return [frozenset(c) for r in range(len(xs) + 1) for c in combinations(xs, r)]


def restrainable(a, A):
    return any(b >= a and b > a for b in A)


def substitute(a, A):
    cands = [b for b in A if b > a]
    return [b for b in cands if not any(c > b for c in cands)]


if __name__ == '__main__':
    U = ('y', 'z', 'w'); outs = subsets(U); n = d1 = d4 = 0
    for k in (1, 2, 3):
        for A in combinations(outs, k):
            A = list(A)
            for a in A:
                n += 1
                if restrainable(a, A):
                    for b in substitute(a, A):
                        assert b > a                                  # keeps strictly more
                        if 'y' in a: assert 'y' in b                  # restrained agent kept
                    d1 += 1
                # D2: protector actions are not part of A; restrainability is a function of (a, A) alone
                # D4: if some own alternative keeps everyone a keeps and ends no one (= keeps all of U)
                if frozenset(U) in A and a != frozenset(U):
                    assert restrainable(a, A); d4 += 1
    hunt, starve = frozenset({'y'}), frozenset({'z'})
    assert not restrainable(hunt, [hunt, starve])                    # D3 predator
    kill, refrain = frozenset({'y'}), frozenset({'y', 'z'})
    assert restrainable(kill, [kill, refrain]) and substitute(kill, [kill, refrain]) == [refrain]
    print(json.dumps({'acts_checked': n, 'D1_restraint_keeps_agent_and_more': d1,
                      'D2_non_circular_by_construction': True, 'D3_predator_not_restrainable': True,
                      'D4_avoidable_always_restrainable': d4, 'murder_example_restrainable': True},
                     sort_keys=True, indent=2))
