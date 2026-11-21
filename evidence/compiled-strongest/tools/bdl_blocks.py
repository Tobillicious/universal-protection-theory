#!/usr/bin/env python3
"""Block-structure probe for the hull function l_i (M3). Faithful attempt at
WARMSTART-M3-LEXI-DEFINITION §7 step 1 (blocks E_i = bits / ~_2 via degree-2
checks, |e| <= 3) on PR #215's complex.

FINDING (reproducible): PR #215's complex has NO degree-2 checks, so the block
quotient is trivial (|e|=1) under the literal reading; the only candidate
refinement (bits = Q-vertices, degree-2 checks = Q-edges) gives blocks that GROW
with ell (4->14), violating the paper's |e| <= 3. So l_i does not instantiate on
this reconstruction as written. Root cause: the seed's SHARED qubit q2 makes
every z-check degree 3, not 2. This is a reconciliation question for the
bit/check identification under Rep/Par <-> X/Z, not a computed hull.

Run: python3 bdl_blocks.py  (JSON + asserts the obstruction holds reproducibly).
"""
import json
import sys
from collections import defaultdict, Counter
from bdl_replacement_chain import replace_x, replace_z, seed


def check_degrees(c):
    invC2 = defaultdict(int)
    for c1, cod in c.d1.items():
        for c2 in cod:
            invC2[c2] += 1
    c0 = Counter(len(c.d0[g]) for g in c.x)      # C0-check degrees (via d0)
    c2 = Counter(invC2[z] for z in c.z)          # C2-check degrees (via d1)
    return {str(k): v for k, v in sorted(c0.items())}, \
           {str(k): v for k, v in sorted(c2.items())}


def qv_block_sizes(c):
    qv = [b for b in c.q if b[0] == 'qv']
    parent = {b: b for b in qv}

    def find(x):
        while parent[x] != x:
            parent[x] = parent[parent[x]]
            x = parent[x]
        return x
    inv = defaultdict(set)
    for c1, cod in c.d1.items():
        if c1[0] == 'qv':
            for c2 in cod:
                if c2[0] == 'qe':
                    inv[c2].add(c1)
    for c2, bs in inv.items():
        if len(bs) == 2:
            a, b = list(bs)
            ra, rb = find(a), find(b)
            if ra != rb:
                parent[ra] = rb
    comp = defaultdict(int)
    for b in qv:
        comp[find(b)] += 1
    return dict(sorted(Counter(comp.values()).items()))


def report(L, include_level2=True):
    first = replace_x(seed(), L)
    c0_1, c2_1 = check_degrees(first)
    out = {
        "ell": 2 * L + 1,
        "level1_C0_check_degrees": c0_1,
        "level1_C2_check_degrees": c2_1,
        "qv_qe_block_sizes_level1": qv_block_sizes(first),
    }
    deg2 = ("2" in c0_1 or "2" in c2_1)
    if include_level2:   # level-2 at ell=7 is enormous (replace_z); skip it
        second = replace_z(first.tanner, L)
        c0_2, c2_2 = check_degrees(second)
        out["level2_C0_check_degrees"] = c0_2
        out["level2_C2_check_degrees"] = c2_2
        deg2 = deg2 or ("2" in c0_2 or "2" in c2_2)
    out["has_degree2_check"] = deg2
    return out


def main():
    results = [report(1), report(2), report(3, include_level2=False)]
    print(json.dumps(results, indent=2))
    failures = []
    for r in results:
        # The obstruction: no degree-2 check exists (blocks cannot be |e|<=3 via ~_2)
        if r["has_degree2_check"]:
            failures.append(f"ell={r['ell']}: a degree-2 check APPEARED — re-examine; "
                            f"the block obstruction may be resolved")
        # qv/qe refinement blocks exceed 3 (violate |e|<=3) -> also not the paper's blocks
        if max(int(k) for k in r["qv_qe_block_sizes_level1"]) <= 3:
            failures.append(f"ell={r['ell']}: qv/qe blocks are <=3 — this refinement may "
                            f"actually be the paper's E_i; re-examine")
    if failures:
        print("\nSTRUCTURE CHANGED (obstruction analysis needs revisiting):", file=sys.stderr)
        for f in failures:
            print("  -", f, file=sys.stderr)
        sys.exit(1)
    print("Obstruction reproduced: no degree-2 checks on either side; qv/qe refinement "
          "blocks grow with ell (violate |e|<=3). l_i does not instantiate per §7 as "
          "written — bit/check identification needs reconciliation with the source.",
          file=sys.stderr)


if __name__ == "__main__":
    main()
