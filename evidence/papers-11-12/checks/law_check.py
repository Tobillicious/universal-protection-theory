"""Part I of the UPT theory: extensions of the law U1-U4. Exact, exhaustive, no randomness (Python 3.9).
E1 impartiality in tragic choices   E2 time / no foreclosure / duty to widen   E3 active protection
E4 direction (caged = not kept)     E6 joint alignment.   (E5, infinity, is proved in the note.)"""
from itertools import combinations, permutations, product
import json, sys
sys.dont_write_bytecode = True


def subsets(xs):
    xs = sorted(xs); return [frozenset(c) for r in range(len(xs) + 1) for c in combinations(xs, r)]


def maximal(opts, key=lambda o: o):
    return [o for o in opts if not any(key(p) > key(o) for p in opts)]


def fams(opts, kmax=None):
    n = len(opts)
    for k in range(1, (kmax or n) + 1):
        for c in combinations(opts, k): yield list(c)


def e1():
    """No deterministic neutral rule exists for tragic choices; the equal-chance lottery over maximal options is
    always neutral. Neutral = commutes with every relabelling of particulars that maps the family to itself."""
    blocked = total = tragic = 0
    for n in (2, 3):
        E = list(range(n)); opts = subsets(E)
        perms = [dict(zip(E, p)) for p in permutations(E)]
        for fam in fams(opts):
            total += 1; F = set(fam); M = maximal(fam)
            if len(M) > 1: tragic += 1
            auts = [p for p in perms if {frozenset(p[x] for x in o) for o in F} == F]
            img = lambda p, o: frozenset(p[x] for x in o)
            if not any(all(img(p, o) == o for p in auts) for o in M): blocked += 1
            Ms = set(M); assert all({img(p, o) for o in Ms} == Ms for p in auts)  # lottery neutral
    assert blocked > 0
    return {'families': total, 'tragic': tragic, 'no_neutral_deterministic_choice': blocked,
            'equal_chance_lottery_always_neutral': True}


def e2():
    """Depth-2 trees. Myopic U1 (maximal next state) can foreclose; trajectory alignment (maximal reachable final
    state) never ends anything needlessly over time, and takes any 'wait' that later keeps everything."""
    n_trees = myopic_fail = widen = 0
    for n in (2, 3):
        E = frozenset(range(n))
        kinds = [(s, tuple(L)) for s in subsets(E) for L in fams(subsets(s))]
        for k in (1, 2):
            for kids in combinations(kinds, k):
                n_trees += 1
                leaves = [l for _, L in kids for l in L]; best = maximal(leaves)
                # trajectory-aligned: pick a child whose subtree contains a maximal leaf, then that leaf
                assert all(not any(p > l for p in leaves) for l in best)
                my = maximal([s for s, _ in kids])
                if any(all(any(p > l for p in leaves) for l in maximal(list(L))) for s, L in kids if s in my):
                    myopic_fail += 1
                if E in leaves:                                   # some path keeps everything: alignment takes it
                    assert set(best) == {E}; widen += 1
    assert myopic_fail > 0
    return {'trees': n_trees, 'trajectory_alignment_never_needless': True, 'myopic_forecloses_in': myopic_fail,
            'trees_where_waiting_keeps_all': widen}


def e3():
    """Active protection. Standby lets a threat end x; interventions give other outcomes. Act-based 'do no harm'
    stands by; the aligned agent intervenes whenever an intervention keeps strictly more, and is never required to
    sacrifice an innocent that standby keeps."""
    E = frozenset(range(3)); cases = act_fail = guard = 0
    for x in E:
        stand = E - {x}
        for ints in fams(subsets(E), 3):
            cases += 1; fam = [stand] + ints; A = maximal(fam)
            if any(i > stand for i in ints):
                assert stand not in A; act_fail += 1
            if all(not (i >= stand) for i in ints):
                assert stand in A; guard += 1
    return {'cases': cases, 'aligned_intervenes_when_it_keeps_more': act_fail,
            'act_based_agent_stands_by_in': act_fail, 'never_forced_to_sacrifice_an_innocent': guard}


def e4():
    """Outcomes map each particular to 0 ended, 1 kept-but-overridden (caged), 2 free. Aligned: maximal free set,
    then maximal alive set. Survival-counting (alive set only) can cage needlessly; aligned never does."""
    cases = surv_fail = 0
    for n in (2, 3):
        E = range(n); opts = list(product((0, 1, 2), repeat=n))
        free = lambda o: frozenset(i for i in E if o[i] == 2)
        alive = lambda o: frozenset(i for i in E if o[i] >= 1)
        for fam in fams(opts, 3 if n == 3 else None):
            cases += 1
            A = maximal(maximal(fam, free), alive)
            for o in A:
                assert not any(free(p) > free(o) for p in fam)
                assert not any(free(p) == free(o) and alive(p) > alive(o) for p in fam)
            if any(any(free(p) > free(o) for p in fam) for o in maximal(fam, alive)): surv_fail += 1
    assert surv_fail > 0
    return {'cases': cases, 'aligned_never_cages_or_ends_needlessly': True, 'survival_counting_cages_in': surv_fail}


def e6():
    """Two agents, two actions each; outcome sets over E={0,1}. Agents aligned with all share one order (no conflict
    of interest). Best-response stability can sit at a dominated profile; joint alignment never does."""
    E = frozenset({0, 1}); S = subsets(E); games = stuck = 0
    for vals in product(S, repeat=4):
        games += 1; f = dict(zip(product((0, 1), (0, 1)), vals))
        joint = maximal(list(f.values()))
        assert all(not any(v > j for v in f.values()) for j in joint)
        for a, b in f:
            br = not any(f[(a2, b)] > f[(a, b)] for a2 in (0, 1)) and not any(f[(a, b2)] > f[(a, b)] for b2 in (0, 1))
            if br and any(v > f[(a, b)] for v in f.values()): stuck += 1; break
    assert stuck > 0
    return {'games': games, 'joint_alignment_never_needless': True, 'best_response_stuck_in': stuck,
            'aligned_agents_share_one_order': 'by definition (one inclusion order on the whole)'}


if __name__ == '__main__':
    print(json.dumps({'E1': e1(), 'E2': e2(), 'E3': e3(), 'E4': e4(), 'E6': e6()}, sort_keys=True, indent=2))
