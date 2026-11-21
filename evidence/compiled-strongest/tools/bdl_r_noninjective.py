#!/usr/bin/env python3
"""Hull-decrease at ell=3,5 via R-NON-INJECTIVITY — the easy (and here, only)
case of Lemma 13, independent of J_3 and the weight floor.

Lemma 9(3)'s inequality chain (structure-generic, transfers per the corrected
route):
    l_i(R(X)) <= |R(H_{i+1}(X))| <= |H_{i+1}(X)| = l_{i+1}(X)
Equality (NO decrease) requires R injective on the hull H_{i+1}(X). Since the
hull contains X, if R is non-injective on supp X then R is non-injective on H,
so |R(H)| < |H|, the chain is STRICT, and l_i(R(X)) < l_{i+1}(X) — the strict
hull-decrease — WITHOUT any appeal to the junction constant J_3 or the floor.

MEASURED: on PR #215's complex, R (level-2 -> level-1, cell[1]) is non-injective
on supp X for EVERY nontrivial closed membrane X (every nonzero combination of
the ker(partial_2) generators) at ell=3 and ell=5. So the strict hull-decrease
holds for all of them directly.

SCOPE (honest): this is the R-non-injective case. The J_3/floor machinery
(whose 3D margin is tight — see M3-JUNCTION-MARGIN) governs the R-INJECTIVE case,
which does NOT arise for these objects at these scales (block sizes 39-169 make
R collapse everything) but remains the general obstruction. NOT a proof for all
ell (needs R-non-injectivity for every nontrivial membrane proven, not measured).
No Lean claim. Reinterprets the collapse data the retracted support-size check
fumbled: it is R-non-injectivity feeding Lemma 9, not l_i itself.

Run: python3 bdl_r_noninjective.py  (JSON + asserts R non-injective on all).
"""
import json
import sys
from itertools import combinations
from bdl_replacement_chain import replace_x, replace_z, seed
from bdl_cube_layer import kernel_partial2


def report(L):
    L2 = replace_z(replace_x(seed(), L).tanner, L)
    C2, basis, _ = kernel_partial2(L2)
    k = len(basis)
    rows = []
    all_noninjective = True
    for r in range(1, k + 1):
        for combo in combinations(range(k), r):
            v = 0
            for j in combo:
                v ^= basis[j]
            supp = [C2[i] for i in range(len(C2)) if (v >> i) & 1]
            img = {c[1] for c in supp}
            collapse = len(supp) - len(img)
            noninj = collapse > 0
            all_noninjective = all_noninjective and noninj
            rows.append({"combo": list(combo), "supp": len(supp),
                         "R_image": len(img), "collapse": collapse,
                         "R_noninjective": noninj})
    return {
        "ell": 2 * L + 1,
        "n_generators": k,
        "all_nontrivial_membranes_R_noninjective": all_noninjective,
        "min_collapse_over_nontrivial": min(x["collapse"] for x in rows),
        "per_membrane": rows,
    }


def main():
    results = [report(L) for L in (1, 2)]
    print(json.dumps(results, indent=2))
    failures = []
    for r in results:
        if not r["all_nontrivial_membranes_R_noninjective"]:
            failures.append(f"ell={r['ell']}: some nontrivial membrane is R-INJECTIVE "
                            f"-> the J_3/floor case (M3-JUNCTION-MARGIN) is live here")
    if failures:
        print("\nR-INJECTIVE CASE DETECTED (strict decrease no longer free):", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print("R non-injective on EVERY nontrivial closed membrane at ell=3,5 -> strict "
          "hull-decrease holds directly via Lemma 9's chain, independent of J_3/floor. "
          "(Easy case only; R-injective case + all-ell remain open.)", file=sys.stderr)


if __name__ == "__main__":
    main()
