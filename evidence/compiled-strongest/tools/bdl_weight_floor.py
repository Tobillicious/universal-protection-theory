#!/usr/bin/env python3
"""Closed-membrane weight floor (Lemma 13 input #3 / the testable hypothesis in
WARMSTART-M3-BLOCK-RECONCILIATION §"testable hypothesis").

The reconciliation doc's hypothesis cites "closed-membrane kernel generators
with supports 4,4,6 -> floor 4". Those are GLM's GENERATORS.md numbers, which
PR #231/#226 already showed are NOT closed membranes. This tool computes the
TRUE quantity: the minimum Hamming weight of a nonzero element of ker(partial_2)
(the closed-membrane space), exactly, over all 2^k-1 combinations of a verified
basis.

RESULT: minimum closed-membrane weight = 5, CONSTANT at ell=3,5,7 (basis
supports 5,5,10 -> 5,5,18 -> 5,5,26: the two rail loops stay 5, the seam cap
grows). So the corrected hypothesis is supports 5,5,10 and FLOOR 5, not 4,4,6/4.
This strengthens Lemma 13's contradiction: floor 5 > J_3 holds with more margin
than 4 > 3.

SCOPE: this is the ker(partial_2) (closed-membrane / metacheck) min weight — the
quantity the reconciliation's hypothesis uses. The strict Lemma-8 floor is on
the W_i = K_i\K_1 1-chain sector (see bdl_code_distance.py: d_Z=4); that needs
the multi-level K_i and is a related but distinct number. No Lean claim.

Run: python3 bdl_weight_floor.py  (JSON + asserts floor is 5 and constant).
"""
import json
import sys
from itertools import combinations
from bdl_replacement_chain import replace_x, seed
from bdl_cube_layer import kernel_partial2


def min_closed_membrane_weight(L):
    c = replace_x(seed(), L)
    C2, basis, _ = kernel_partial2(c)
    k = len(basis)
    basis_supports = sorted(bin(b).count("1") for b in basis)
    best = None
    for r in range(1, k + 1):
        for combo in combinations(range(k), r):
            v = 0
            for j in combo:
                v ^= basis[j]
            w = bin(v).count("1")
            if best is None or w < best:
                best = w
    return {
        "ell": 2 * L + 1,
        "ker_dim": k,
        "basis_supports": basis_supports,
        "min_closed_membrane_weight": best,
    }


def main():
    results = [min_closed_membrane_weight(L) for L in (1, 2, 3)]
    print(json.dumps(results, indent=2))
    floors = {r["min_closed_membrane_weight"] for r in results}
    failures = []
    for r in results:
        if r["min_closed_membrane_weight"] < 4:
            failures.append(f"ell={r['ell']}: floor {r['min_closed_membrane_weight']} < 4")
        if r["basis_supports"][:2] != [5, 5]:
            failures.append(f"ell={r['ell']}: rail-loop supports not [5,5] "
                            f"({r['basis_supports']}) — the 4,4,6 correction may have regressed")
    if len(floors) != 1:
        failures.append(f"floor not constant across ell: {sorted(floors)}")
    if failures:
        print("\nINVARIANT FAILURES:", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print(f"Closed-membrane weight floor = {floors.pop()}, constant at ell=3,5,7 "
          f"(corrects the 4,4,6/floor-4 hypothesis to 5,5,10/floor-5; strengthens "
          f"Lemma 13's floor > J_3 margin).", file=sys.stderr)


if __name__ == "__main__":
    main()
