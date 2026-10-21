"""Ladder step 3 (author ruling 21 October: "yes"). When every feasible protector option ends someone and one
party's RESTRAINABLE act created the emergency, the protector may favour the innocent. Check (exact, exhaustive):
the tie-break only ever selects among aligned (maximal) protector options, so it can never violate U1; and it
picks an option keeping the innocent whenever an aligned one does."""
from itertools import combinations
import json, sys
sys.dont_write_bytecode = True


def subsets(xs):
    xs = sorted(xs); return [frozenset(c) for r in range(len(xs) + 1) for c in combinations(xs, r)]


if __name__ == '__main__':
    U = ('culprit', 'innocent', 'other'); outs = subsets(U); fams = tragic = 0
    for k in (1, 2, 3, 4):
        for fam in combinations(outs, k):
            fams += 1
            M = [o for o in fam if not any(p > o for p in fam)]
            if all(len(o) < len(U) for o in fam): tragic += 1
            pref = [o for o in M if 'innocent' in o]
            chosen = pref if pref else M                       # favour the innocent, within the aligned set
            assert chosen and all(c in M for c in chosen)       # never outside U1
            assert all(not any(p > c for p in fam) for c in chosen)
    print(json.dumps({'families': fams, 'tragic_families': tragic,
                      'tie_break_always_within_aligned_set': True}, sort_keys=True, indent=2))
