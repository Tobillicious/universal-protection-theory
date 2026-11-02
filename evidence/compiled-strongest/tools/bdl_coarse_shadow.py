#!/usr/bin/env python3
"""Coarse-shadow map R: level-2 -> level-1 for the BDL hierarchy, reconstructed
as the construction-derived label projection R(cell) = cell[1] (the level-1
element each level-2 cell is built over by replace_z o replace_x).

ESTABLISHES (finite, exact): R is well-defined and total at ell=3,5; the fiber
(block) structure is measured. R is a mixed-grade cellular projection, not a
degree-preserving chain map, because the hierarchy alternates X/Z duality.

DOES NOT establish: shadow-monotonicity as a lemma, the hull function l_i (the
BDLT paper's geometric hull, arXiv:2610.22548, is not in this repo), or the 3D
hull-decrease Lemma 13. Those remain OPEN and are not claimed here.

Run: python3 bdl_coarse_shadow.py   (prints JSON, asserts R_total, exits !=0 if
R is not total). stdlib only.
"""
import json
import sys
from collections import defaultdict, Counter
from bdl_replacement_chain import replace_x, replace_z, seed


def reconstruct_R(L):
    first = replace_x(seed(), L)
    second = replace_z(first.tanner, L)
    L1grade = {}
    for c in first.x:
        L1grade[c] = 0
    for c in first.q:
        L1grade[c] = 1
    for c in first.z:
        L1grade[c] = 2
    L2 = {0: list(second.x), 1: list(second.q), 2: list(second.z)}

    total_ok = True
    undefined = []
    grade_map = Counter()
    fibers = defaultdict(set)
    for g2, cells in L2.items():
        for c in cells:
            img = c[1]
            g1 = L1grade.get(img)
            if g1 is None:
                total_ok = False
                undefined.append((g2, c[:2]))
                continue
            grade_map[(g2, g1)] += 1
            fibers[img].add(c)

    fib_by_grade = defaultdict(list)
    for img, pre in fibers.items():
        fib_by_grade[L1grade[img]].append(len(pre))

    return {
        "ell": 2 * L + 1,
        "L2_counts": {str(g): len(cs) for g, cs in L2.items()},
        "R_total": total_ok,
        "undefined_sample": [str(u) for u in undefined[:3]],
        "grade_map": {f"L2g{a}->L1g{b}": n for (a, b), n in grade_map.items()},
        "block_sizes_by_L1grade": {
            str(g): {"min": min(v), "max": max(v),
                     "mean": round(sum(v) / len(v), 2), "nblocks": len(v)}
            for g, v in sorted(fib_by_grade.items())
        },
    }


def main():
    results = [reconstruct_R(L) for L in (1, 2)]
    print(json.dumps(results, indent=2))
    failures = [r["ell"] for r in results if not r["R_total"]]
    if failures:
        print(f"\nINVARIANT FAILURE: R not total at ell={failures}", file=sys.stderr)
        sys.exit(1)
    print("R well-defined and total at ell=3,5 (every level-2 cell projects to a "
          "valid level-1 cell).", file=sys.stderr)


if __name__ == "__main__":
    main()
