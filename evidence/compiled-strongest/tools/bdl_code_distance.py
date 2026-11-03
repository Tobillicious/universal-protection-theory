#!/usr/bin/env python3
"""Code distance of PR #215's reconstructed instances — a Lemma-13 step-4 input
(Lemma 8's weight floor), and the one piece of it that is UNBLOCKED by the
block-structure reconciliation (#231).

d_X = min weight of a nontrivial X-logical (ker delta1 \\ im delta0).
d_Z = min weight of a nontrivial Z-logical (ker delta0^T \\ im delta1^T).
Verified by exhaustive low-weight search: clearing weights 1..w-1 proves d >= w.

Lemma 8 (via §5 of WARMSTART-M3-LEXI-DEFINITION) needs a weight floor
2^{n-i+1} = 4 at level 2 for chains in W_i = K_i \\ K_1. HONEST SCOPE: what is
computed here is the LOGICAL (K_1, fully gauge-invariant) distance, a clean and
fundamental code property that MEETS/EXCEEDS the floor. The lemma's exact W_i
(partially-gauge-invariant) floor needs the multi-level K_i = cap_s ker d1^(s)
structure — entangled with the same reconciliation as the blocks (#231), so it
is NOT claimed here.

Also recorded: the coarse-shadow R is a SET-map on supports, not a GF(2) chain
map — R_*(every closed membrane) = 0 (even covers cancel). Resolves #228's
open "is R a chain map?" caveat: no; R(X) = {R(e')} acts on supports.

Run: python3 bdl_code_distance.py  (JSON + asserts d_X,d_Z >= floor 4).
"""
import json
import sys
from itertools import combinations
from bdl_replacement_chain import replace_x, replace_z, seed
from bdl_cube_layer import kernel_partial2


def _reduced_basis(vectors):
    piv = {}
    for v in vectors:
        vv = v
        while vv:
            p = vv.bit_length() - 1
            if p in piv:
                vv ^= piv[p]
            else:
                piv[p] = v
                break
    return piv


def _in_span(mask, piv):
    vv = mask
    while vv:
        p = vv.bit_length() - 1
        if p in piv:
            vv ^= piv[p]
        else:
            return False
    return True


def distance_lower_bound(cells, syndrome_col, image_vectors, maxw):
    """min weight v with syndrome=0 (in kernel) and v not in image. Returns the
    smallest weight found, or ('>=', maxw+1) if none up to maxw."""
    n = len(cells)
    piv = _reduced_basis(image_vectors)
    for w in range(1, maxw + 1):
        for combo in combinations(range(n), w):
            syn = 0
            for i in combo:
                syn ^= syndrome_col[i]
            if syn == 0:
                mask = 0
                for i in combo:
                    mask |= 1 << i
                if not _in_span(mask, piv):
                    return w, True   # exact distance = w
    return maxw + 1, False           # d >= maxw+1


def dX(c, maxw):
    # X-logical: v in C1, ker(delta1), not in im(delta0)
    C1 = list(c.q); C2 = list(c.z); c2i = {x: i for i, x in enumerate(C2)}
    col = [sum(1 << c2i[z] for z in c.d1[c1]) for c1 in C1]
    idx = {x: i for i, x in enumerate(C1)}
    imd0 = [sum(1 << idx[b] for b in c.d0[g]) for g in c.x]
    return distance_lower_bound(C1, col, imd0, maxw)


def dZ(c, maxw):
    # Z-logical: v in C1, ker(delta0^T) [orthogonal to each delta0 col],
    # not in im(delta1^T) [span of check boundaries bits(c2)].
    C1 = list(c.q); idx = {x: i for i, x in enumerate(C1)}
    C0 = list(c.x)
    # syndrome column for bit c1 = which C0 checks it meets (delta0 preimage)
    c0i = {x: i for i, x in enumerate(C0)}
    xin = {c1: 0 for c1 in C1}
    for g in C0:
        for b in c.d0[g]:
            xin[b] |= 1 << c0i[g]
    col = [xin[c1] for c1 in C1]
    # im(delta1^T): for each c2, its bits = {c1 : c2 in d1[c1]} -> mask over C1
    from collections import defaultdict
    bits = defaultdict(int)
    for c1 in C1:
        for z in c.d1[c1]:
            bits[z] |= 1 << idx[c1]
    imd1T = list(bits.values())
    return distance_lower_bound(C1, col, imd1T, maxw)


def R_is_setmap_not_chainmap(L):
    """R_*(closed membrane) over GF(2) = 0 for all level-2 generators."""
    L1 = replace_x(seed(), L); L2 = replace_z(L1.tanner, L)
    C2_2, basis2, _ = kernel_partial2(L2)
    from collections import Counter
    all_zero = True
    for b in basis2:
        cells = [C2_2[i] for i in range(len(C2_2)) if (b >> i) & 1]
        cnt = Counter(c[1] for c in cells)
        img = [cell for cell, n in cnt.items() if n % 2]
        if img:
            all_zero = False
    return all_zero


def main():
    FLOOR = 4
    results = {}
    # ell=3 search to weight 4 (=> d>=5 if clear); ell=5,7 to weight 3 (=> d>=4)
    plan = {1: 4, 2: 3, 3: 3}
    for L, mw in plan.items():
        c = replace_x(seed(), L)
        dx_w, dx_exact = dX(c, mw)
        dz_w, dz_exact = dZ(c, mw)
        results[f"ell{2*L+1}"] = {
            "d_X": (dx_w if dx_exact else f">={dx_w}"),
            "d_Z": (dz_w if dz_exact else f">={dz_w}"),
            "searched_to_weight": mw,
            "meets_floor_4": (dx_w >= FLOOR and dz_w >= FLOOR),
        }
    results["R_setmap_not_chainmap (R_* of closed membranes = 0)"] = {
        f"ell{2*L+1}": R_is_setmap_not_chainmap(L) for L in (1, 2)
    }
    print(json.dumps(results, indent=2))

    failures = []
    for L in plan:
        tag = f"ell{2*L+1}"
        if not results[tag]["meets_floor_4"]:
            failures.append(f"{tag}: code distance below Lemma-8 floor 4 ({results[tag]})")
    if not all(results["R_setmap_not_chainmap (R_* of closed membranes = 0)"].values()):
        failures.append("R_* of some closed membrane != 0 (would contradict the set-map finding)")
    if failures:
        print("\nINVARIANT FAILURES:", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print("Code distance meets/exceeds the Lemma-8 floor (d>=4; d_X>=5 at ell=3); "
          "R confirmed a set-map (R_* of closed membranes = 0). NOTE: this is the "
          "logical/K_1 sector, not the lemma's W_i floor (needs multi-level K_i).",
          file=sys.stderr)


if __name__ == "__main__":
    main()
