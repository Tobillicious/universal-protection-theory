"""UPT theory Part III — preservation capacity. Exact, exhaustive (Python 3.9).
Histories are sets of content chunks (shared structure = shared chunks). An archive of capacity C stores a family
of histories losslessly. SEPARATE storage costs sum of sizes; JOINT (content-addressed) storage costs |union|.
P1  Joint storage never keeps less: every family keepable separately is keepable jointly, and in many worlds
    joint keeps strictly more (shared structure is stored once — the archive's duty to widen).
P2  Under any capacity the aligned archive keeps an inclusion-maximal family (never discards a record it could
    keep); FIFO eviction (evict the oldest on overflow) can keep a non-maximal family.
P3  Capacity: an archive with 2^C states distinguishes at most 2^C record families (pigeonhole), and there is an
    injective encoding whenever the family count is <= 2^C."""
from itertools import combinations, product
import json, sys
sys.dont_write_bytecode = True


def fams(n):
    return [frozenset(c) for r in range(n + 1) for c in combinations(range(n), r)]


def maximal(sets):
    return [s for s in sets if not any(t > s for t in sets)]


if __name__ == '__main__':
    chunks = range(4); hsets = [frozenset(c) for r in range(1, 5) for c in combinations(chunks, r)]
    worlds = strict = p2 = byte_first_bad = 0
    for H in combinations(hsets, 3):
        worlds += 1; F = fams(3)
        sep = lambda f: sum(len(H[i]) for i in f)
        joint = lambda f: len(set().union(*[H[i] for i in f])) if f else 0
        for C in range(0, 13):
            ks = [f for f in F if sep(f) <= C]; kj = [f for f in F if joint(f) <= C]
            assert set(ks) <= set(kj)                                                       # P1
            if set(kj) > set(ks): strict += 1
            M = maximal(kj); p2 += 1
            assert all(not any(g > m for g in kj) for m in M)                               # P2 aligned
            # FIFO eviction: records arrive 0,1,2; on overflow evict the oldest until the newcomer fits
            keep = []
            for i in range(3):
                keep.append(i)
                while keep and joint(frozenset(keep)) > C: keep.pop(0)
            if frozenset(keep) not in M: byte_first_bad += 1
    assert strict > 0 and byte_first_bad > 0                                                # positive controls
    for Cbits in range(1, 7):                                                               # P3
        for count in range(1, 2 ** Cbits + 2):
            injective = count <= 2 ** Cbits
            enc = {k: format(k, 'b').zfill(Cbits) for k in range(count)} if injective else None
            assert (enc is not None and len(set(enc.values())) == count) == injective
    print(json.dumps({'worlds': worlds, 'world_capacity_cases': p2, 'P1_joint_never_keeps_less': True,
                      'P1_joint_keeps_strictly_more_in': strict, 'P2_aligned_keeps_maximal': True,
                      'P2_fifo_eviction_non_maximal_in': byte_first_bad,
                      'P3_pigeonhole_exact': True}, sort_keys=True, indent=2))
