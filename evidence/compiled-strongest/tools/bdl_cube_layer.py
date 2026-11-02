#!/usr/bin/env python3
"""Membrane-exactness toolkit for the BDL warm-start (M3 prerequisite work).

Three FINITE, verified facts on PR #215's reconstructed complex. This file
proves none of the M3 lemmas; it establishes measured premises and corrects a
bank enumeration error. What it does and does NOT establish is stated per fact.

1. GENERATORS  -- extracts and verifies ker(partial_2), the closed-membrane
   space. Confirms dim = 3 at every scale/level, and that the generators are
   genuine cycles. (Corrects BANKS/.../GENERATORS.md, whose support-4/4/6
   enumerations are NOT closed; verified supports are 5/5/10 at ell=3.)

2. CUBE-LAYER HOMOLOGY  -- a rank-3 cube layer delta2:C2->C3 drives H^2: 3->0
   (full bulk exactness) while H^1 (the one logical qubit) is INVARIANT, because
   delta2 never touches delta0/delta1. => fill all three generators, no
   boundary-annulus excision. NOTE: this delta2 is the kernel-transpose, so it
   demonstrates the HOMOLOGICAL facts only. It is NOT a local/geometric delta2;
   whether the genuine 3D cells achieve this with bounded support is OPEN (the
   3D Appendix-B analogue), and this file does not claim it.

3. INTERACTION GRAPH  -- bounded-degree locality (Theorem 4 premise), measured:
   D_Z,D_X and support sizes are constant in ell at each level (level 1 D_Z=10;
   level 2 D_Z=8,D_X=16 -> D is per-level, not global). dim C^2 = 8L^2+20L+10
   ~ 2*ell^2: the complex is 2D as built, so the 3D structure is the open work
   item, not already present.

Run: python3 bdl_cube_layer.py          (prints JSON, asserts invariants)
Exits non-zero if any invariant fails. stdlib only.
"""
import json
import sys
from collections import defaultdict
from statistics import mean

from bdl_replacement_chain import replace_x, replace_z, rank, seed


# ---- GF(2) null space -------------------------------------------------------
def null_space_gf2(row_masks, n):
    pivot = {}
    for r in row_masks:
        v = r
        while v:
            p = v.bit_length() - 1
            if p in pivot:
                v ^= pivot[p]
            else:
                pivot[p] = v
                break
    cols = sorted(pivot)
    for p in cols:
        for q in cols:
            if q != p and (pivot[q] >> p) & 1:
                pivot[q] ^= pivot[p]
    pivot_set = set(pivot)
    basis = []
    for f in (j for j in range(n) if j not in pivot_set):
        vec = 1 << f
        for p, row in pivot.items():
            if (row >> f) & 1:
                vec |= 1 << p
        basis.append(vec)
    return basis


def kernel_partial2(c):
    """ker(partial_2) = {v in C2 : v^T delta1 = 0}."""
    C2 = list(c.z)
    idx = {cell: i for i, cell in enumerate(C2)}
    rows = []
    for cod in c.d1.values():
        m = 0
        for c2 in cod:
            m ^= 1 << idx[c2]
        if m:
            rows.append(m)
    basis = null_space_gf2(rows, len(C2))
    return C2, basis, rows


def verify_kernel(basis, rows):
    return all(bin(b & m).count("1") % 2 == 0 for b in basis for m in rows)


# ---- the three facts --------------------------------------------------------
def analyse(c):
    C0, C1, C2 = list(c.x), list(c.q), list(c.z)
    r0 = rank(c.d0.values(), c.q)
    r1 = rank(c.d1.values(), c.z)
    basis, rows = kernel_partial2(c)[1:]
    kernel_ok = verify_kernel(basis, rows)
    ngen = len(basis)

    # cube layer: C3 = one cell per generator; delta2 = transpose incidence
    idx = {cell: i for i, cell in enumerate(C2)}
    gen_sets = [set(i for i in range(len(C2)) if (b >> i) & 1) for b in basis]
    d2 = {c2: set() for c2 in C2}
    for k, gs in enumerate(gen_sets):
        for i in gs:
            d2[C2[i]].add(k)
    r2 = rank(d2.values(), list(range(ngen)))
    d2d1_zero = True
    for cod in c.d1.values():
        acc = set()
        for c2 in cod:
            acc ^= d2[c2]
        if acc:
            d2d1_zero = False
            break

    H1 = len(C1) - r0 - r1
    H2_before = len(C2) - r1
    H2_after = len(C2) - r1 - r2

    # interaction graph degrees
    zneigh = defaultdict(set)
    for c1 in C1:
        for z in c.d1[c1]:
            zneigh[z] |= c.d1[c1]
    DZ = max((len(zneigh[z] - {z}) for z in C2), default=0)
    x_in = defaultdict(set)
    for c0, cod in c.d0.items():
        for c1 in cod:
            x_in[c1].add(c0)
    xneigh = defaultdict(set)
    for c1, xs in x_in.items():
        for x in xs:
            xneigh[x] |= xs
    DX = max((len(xneigh[x] - {x}) for x in C0), default=0)
    check_supp = defaultdict(int)
    for cod in c.d1.values():
        for c2 in cod:
            check_supp[c2] += 1
    max_supp = max(check_supp.values(), default=0)
    max_qdeg = max((len(c.d1[c1]) for c1 in C1), default=0)

    return {
        "dimC0": len(C0), "dimC1": len(C1), "dimC2": len(C2),
        "rank_d0": r0, "rank_d1": r1, "rank_d2": r2,
        "ker_partial2": ngen, "kernel_verified": kernel_ok,
        "delta2_delta1_zero": d2d1_zero,
        "H1_logical": H1, "H2_before_cube": H2_before, "H2_after_cube": H2_after,
        "gate_pass_full_delta2": (r1 + r2 == len(C2)),
        "gate_pass_zero_delta2": (r1 == len(C2)),  # must be False (neg control)
        "D_Z": DZ, "D_X": DX, "max_check_support": max_supp,
        "max_qubit_degree": max_qdeg,
    }


def main():
    results = {"level1": {}, "level2": {}}
    for L in (1, 2, 3):
        results["level1"][f"ell{2*L+1}"] = analyse(replace_x(seed(), L))
    for L in (1, 2):
        first = replace_x(seed(), L)
        results["level2"][f"ell{2*L+1}"] = analyse(replace_z(first.tanner, L))
    print(json.dumps(results, indent=2))

    # ---- invariant assertions (CI gate) ----
    failures = []
    for lvl, byell in results.items():
        for ell, s in byell.items():
            tag = f"{lvl}/{ell}"
            if s["ker_partial2"] != 3:
                failures.append(f"{tag}: ker(partial2) != 3 ({s['ker_partial2']})")
            if not s["kernel_verified"]:
                failures.append(f"{tag}: kernel basis not verified")
            if not s["delta2_delta1_zero"]:
                failures.append(f"{tag}: delta2.delta1 != 0")
            if s["H1_logical"] != 1:
                failures.append(f"{tag}: H1 (logical) != 1 ({s['H1_logical']})")
            if s["H2_after_cube"] != 0:
                failures.append(f"{tag}: cube layer did not clear H2 ({s['H2_after_cube']})")
            if not s["gate_pass_full_delta2"]:
                failures.append(f"{tag}: exactness gate failed with full delta2")
            if s["gate_pass_zero_delta2"]:  # negative control MUST be False
                failures.append(f"{tag}: NEG CONTROL leaked (delta2=0 passed the gate)")
    # locality: level-1 degree bounds constant across ell (bounded, ell-independent)
    l1 = results["level1"]
    if len({s["D_Z"] for s in l1.values()}) != 1:
        failures.append(f"level1 D_Z not constant in ell: {[s['D_Z'] for s in l1.values()]}")
    if len({s["D_X"] for s in l1.values()}) != 1:
        failures.append(f"level1 D_X not constant in ell: {[s['D_X'] for s in l1.values()]}")

    if failures:
        print("\nINVARIANT FAILURES:", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print("ALL INVARIANTS HOLD "
          "(ker=3, kernel verified, delta2.delta1=0, H1=1 invariant, "
          "H2->0 with full delta2, neg-control rejects delta2=0, D bounded in ell).",
          file=sys.stderr)


if __name__ == "__main__":
    main()
