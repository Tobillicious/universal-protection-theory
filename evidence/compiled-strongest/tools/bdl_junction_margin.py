#!/usr/bin/env python3
"""Lemma-13 margin analysis in 3D: floor vs the junction constant J_3.

Lemma 13's contradiction needs  floor > J_3  (a nontrivial chain's weight floor
exceeds the number of regions an R-injective hull can be confined to at one
junction). In 2D (BDLT) J_3 = 3 (check degree <= 3) and floor = 4, margin 1.

This measures both constants on the 3D complex (PR #215). FINDING: the margin
is TIGHT and its SIGN depends on the precise J_3 identification:

  floor = 5 (min closed-membrane weight, constant ell=3,5,7; from #234)
  J_3 candidates (coarse = level 1):
    - bit->region fan-out max|d1(b)| = 4  (constant across BOTH levels) -> margin +1
    - C2-check degree             = 4 (lvl1), 5 (lvl2)                  -> margin +1 / 0
    - C0-check degree             = 5 (lvl1), 6 (lvl2)                  -> margin 0 / -1

So the optimistic 2D value J_3=3 does NOT transfer; 3D junctions fan out to 4-6.
The margin is positive (+1) ONLY under the bit->region-fan-out identification
(the only candidate that stays <= 4 at every level/scale); under the
check-degree identifications it is <= 0 and FAILS at level 2. Which notion is the
true J_3 needs the precise R-injective-hull confinement argument (Codex/source),
NOT measurement. This tool does not claim closure; it flags the risk.

Run: python3 bdl_junction_margin.py  (JSON + asserts the measured constants are
stable; makes NO closure assertion).
"""
import json
import sys
from itertools import combinations
from collections import defaultdict
from bdl_replacement_chain import replace_x, replace_z, seed
from bdl_cube_layer import kernel_partial2


def floor_level1(L):
    c = replace_x(seed(), L)
    _, basis, _ = kernel_partial2(c)
    k = len(basis)
    best = None
    for r in range(1, k + 1):
        for combo in combinations(range(k), r):
            v = 0
            for j in combo:
                v ^= basis[j]
            w = bin(v).count("1")
            best = w if best is None else min(best, w)
    return best


def junction_candidates(c):
    invC2 = defaultdict(int)
    for b, cod in c.d1.items():
        for z in cod:
            invC2[z] += 1
    return {
        "C0_check_degree": max(len(c.d0[g]) for g in c.x),
        "C2_check_degree": max(invC2.values()),
        "bit_to_region_fanout": max(len(c.d1[b]) for b in c.q),
    }


def main():
    results = {}
    for L in (1, 2, 3):
        c = replace_x(seed(), L)
        fl = floor_level1(L)
        j = junction_candidates(c)
        results[f"ell{2*L+1}_level1"] = {
            "floor": fl,
            "J3_candidates": j,
            "margins_floor_minus_J3": {k: fl - v for k, v in j.items()},
        }
    # level-2 check degrees for reference (growth with level)
    for L in (1, 2):
        c2 = replace_z(replace_x(seed(), L).tanner, L)
        results[f"ell{2*L+1}_level2_refdegrees"] = junction_candidates(c2)
    print(json.dumps(results, indent=2))

    # Assert the measured constants are stable (documentation gate), NOT closure.
    failures = []
    for L in (1, 2, 3):
        r = results[f"ell{2*L+1}_level1"]
        if r["floor"] != 5:
            failures.append(f"ell={2*L+1}: floor {r['floor']} != 5 (expected from #234)")
        if r["J3_candidates"]["bit_to_region_fanout"] != 4:
            failures.append(f"ell={2*L+1}: bit->region fan-out "
                            f"{r['J3_candidates']['bit_to_region_fanout']} != 4")
    if failures:
        print("\nMEASURED CONSTANTS CHANGED (re-examine margin analysis):", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print("Measured: floor=5; J_3 candidates 4 (bit-fanout, stable) / 4-5 (C2) / "
          "5-6 (C0). Margin floor>J_3 holds (+1) ONLY for the bit-fanout notion; "
          "FAILS (<=0) for check-degree at level 2. Closure depends on the precise "
          "J_3 from the construction - NOT claimed here.", file=sys.stderr)


if __name__ == "__main__":
    main()
