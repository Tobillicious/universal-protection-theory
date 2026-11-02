#!/usr/bin/env python3
"""Hull-decrease check (3D Lemma 13 analogue) at the finite test scales.

Hull function (author's definition): l_i(X) = number of level-i blocks X
touches. Blocks = cells at each level; the coarse-shadow map R: level-2 ->
level-1 is the construction-derived label projection R(cell)=cell[1]
(see bdl_coarse_shadow.py). Then for a level-2 chain X:
    l_2(X)        = |supp X|                 (distinct level-2 cells)
    l_1(R(X))     = |{ cell[1] : cell in X}| (distinct level-1 blocks touched)
    hull-decrease = l_2(X) - l_1(R(X))

Lemma 13 (3D analogue): hull-decrease >= 1 for nontrivial chains (K_i \\ K_1).
Tested here on EVERY nonzero combination of the level-2 closed-membrane
generators (ker partial_2), at ell = 3 and 5.

SCOPE: this VERIFIES the hull-decrease inequality EMPIRICALLY at ell=3,5 on the
closed-membrane sector. It is NOT a proof for all ell (that is the junction/
crossing analysis). Shadow-monotonicity (decrease >= 0) is checked as a premise.

Run: python3 bdl_hull_decrease.py  (JSON + asserts; exits !=0 on any violation).
"""
import json
import sys
from itertools import combinations
from bdl_replacement_chain import replace_x, replace_z, seed
from bdl_cube_layer import kernel_partial2


def hull_decrease_report(L):
    second = replace_z(replace_x(seed(), L).tanner, L)
    C2, basis, rows = kernel_partial2(second)
    ngen = len(basis)

    def supp(mask):
        return [C2[i] for i in range(len(C2)) if (mask >> i) & 1]

    rows_out = []
    min_decrease = None
    monotone_ok = True
    for r in range(1, ngen + 1):
        for combo in combinations(range(ngen), r):
            x = 0
            for k in combo:
                x ^= basis[k]
            cells = supp(x)
            l2 = len(cells)                       # level-2 blocks touched
            coarse = {c[1] for c in cells}        # R(X) support at level 1
            l1R = len(coarse)                     # level-1 blocks touched
            dec = l2 - l1R
            if dec < 0:
                monotone_ok = False
            min_decrease = dec if min_decrease is None else min(min_decrease, dec)
            rows_out.append({"combo": combo, "l2": l2, "l1_R": l1R, "decrease": dec})

    return {
        "ell": 2 * L + 1,
        "n_generators": ngen,
        "n_nontrivial_chains_tested": len(rows_out),
        "shadow_monotone (all decrease>=0)": monotone_ok,
        "min_hull_decrease": min_decrease,
        "hull_decrease_ge_1 (Lemma 13 at this scale)": (min_decrease is not None and min_decrease >= 1),
        "per_chain": rows_out,
    }


def main():
    results = [hull_decrease_report(L) for L in (1, 2)]
    print(json.dumps(results, indent=2))
    failures = []
    for r in results:
        if not r["shadow_monotone (all decrease>=0)"]:
            failures.append(f"ell={r['ell']}: shadow-monotonicity violated (decrease<0)")
        if not r["hull_decrease_ge_1 (Lemma 13 at this scale)"]:
            failures.append(f"ell={r['ell']}: hull-decrease < 1 (min={r['min_hull_decrease']})")
    if failures:
        print("\nINVARIANT FAILURES:", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print("Hull-decrease >= 1 holds on every nontrivial closed-membrane chain at "
          "ell=3,5; shadow-monotonicity holds. (Empirical at these scales; NOT a "
          "proof for all ell.)", file=sys.stderr)


if __name__ == "__main__":
    main()
