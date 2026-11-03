#!/usr/bin/env python3
"""Head-to-head BDL M3 membrane-generator dispute.

Two DISTINCT, source-labelled hypotheses on the SAME level-1
R_X reconstructed complex:
  H4: reconstructed earlier 4/4/6 "rail + short seam" supports at ell=3.
  H5: full 5/5/10 "rail + full seam" supports at ell=3.

Tests ell=3,5,7 (subdivision parameters, NOT vector weights), without
assuming that either hypothesized membrane is an absolute cycle.

We independently:
  - reconstruct the original C^1 -> C^2 boundary rows from d1;
  - compute each candidate's EXACT C^1 parity defect;
  - verify corrected cycles, rank and full ker partial_2 membership;
  - exhaust every nonzero combination in the complete rank-3 kernel;
  - measure the distinct "relative boundary" interpretation without
    declaring a physical boundary or changing the source;
  - report all three J3 readings, never equating J3 with 2D's 3.

The precise original GLM generator-bank file is not in this repository.
H4 is reconstructed from the described 'two old rails + four seam
faces + vertical q2 edges' candidate; archive-original identity NOT
asserted. An alternative topology / restricted gauge sector requires
its OWN source-warranted incidence and should be checked separately.

No 3D hull/weight-floor Lemma 13, M4/M5 or physical UPT claim.
"""
import json
from collections import Counter, defaultdict
from itertools import combinations
from bdl_replacement_chain import replace_x, replace_z, seed, vertex, edge, y_q
from bdl_cube_layer import kernel_partial2, verify_kernel


def submask(cells, full_index):
    """Exact GF2 vector with source-cell membership checked."""
    out = 0
    for cell in cells:
        if cell not in full_index:
            raise AssertionError(f"candidate not a true source C2 cell: {cell}")
        out ^= 1 << full_index[cell]
    if out.bit_count() != len(cells):
        raise AssertionError("duplicate candidate C2 cells")
    return out


def syndrome_support(c, candidate):
    """INDEPENDENT of kernel basis: direct XOR of source d1 incidences."""
    defect = []
    for q in c.q:
        if len(c.d1[q] & candidate) % 2:
            defect.append(q)
    return tuple(defect)


def classify_defect(cell):
    if cell[0] == "qv":
        return "qv"
    if cell[0] == "xe":
        return "xe"
    return repr(cell[0])


def create_families(c, old, L):
    all_cells = set(c.z)
    def vz(z, t):
        return ("zv", z, t)
    def v_edge(q, z):
        return ("qe", q, edge((0, vertex(z)), (1, vertex(z))))
    old_neighbors = {
        "z0": ("q0", "q2"),
        "z1": ("q1", "q2"),
    }
    corrected_neighbors = {
        "z0": ("q0", "q2", "q3"),
        "z1": ("q1", "q2", "q4"),
    }
    def rail(z, neighbors):
        return frozenset({vz(z, 0), vz(z, 1)}
                         | {v_edge(q, z) for q in neighbors})
    H4 = {
        "z0_rail_short": rail("z0", old_neighbors["z0"]),
        "z1_rail_short": rail("z1", old_neighbors["z1"])
    }
    H5 = {
        "z0_rail_full": rail("z0", corrected_neighbors["z0"]),
        "z1_rail_full": rail("z1", corrected_neighbors["z1"])
    }
    seam = frozenset(
        c2 for c2 in c.z
        if c2[0] == "xf" and c2[2][0] == "seam" and c2[2][2] == "q2"
    )
    # Vertical q2 edges at the two old Z vertices:
    cap_short_qe = frozenset(v_edge("q2", z) for z in old.zs)
    cap_full_qe = frozenset(
        c2 for c2 in c.z if c2[0] == "qe" and c2[1] == "q2"
    )
    H4["q2_cap_short"] = seam | cap_short_qe
    H5["q2_cap_full"] = seam | cap_full_qe
    if not all(v <= all_cells for v in [*H4.values(), *H5.values()]):
        raise AssertionError("candidate wrongly names a nonexistent source cell")
    assert len(seam) == 4 * L, ("source q2 seam count changed", len(seam))
    assert len(cap_full_qe) == 4 * L + 2
    assert len(cap_short_qe) == 2
    return H4, H5


def independent_basis_rank(vectors):
    pivots = {}
    for raw in vectors:
        value = raw
        while value:
            p = value.bit_length() - 1
            if p in pivots:
                value ^= pivots[p]
            else:
                pivots[p] = value
                break
    return len(pivots)


def kernel_all_weights(c):
    C2, basis, equations = kernel_partial2(c)
    assert verify_kernel(basis, equations), "reference kernel failed parity"
    assert len(basis) == 3, "reconstructed ker partial2 no longer rank three"
    weights = []
    for count in range(1, len(basis) + 1):
        for combo in combinations(range(len(basis)), count):
            x = 0
            for j in combo:
                x ^= basis[j]
            assert x, "dependent reference kernel basis"
            actual_support = frozenset(C2[i] for i in range(len(C2)) if x >> i & 1)
            assert not syndrome_support(c, actual_support)
            weights.append(len(actual_support))
    return sorted(weights),basis


def source_endpoint_rel_boundary(c):
    """Independent geometrically named *candidate* relative boundary.

    Old Z-check-copy endpoints in Q-vertex cells. This is merely a
    possible relative-chain boundary, NOT a physically sanctioned
    quotient / proof that a true 3D cell complex exists.
    """
    return frozenset(
        q for q in c.q if q[0] == "qv"
        and isinstance(q[2], tuple)
        and len(q[2]) == 2
        and q[2][0] in (0,1)
        and q[2][1] in (vertex("z0"), vertex("z1"))
    )


def source_named_restriction_interface(c,old,L):
    """Independent candidate RELATIVE boundary from native restriction seams.

    This B is defined geometrically from *all* Q-restriction edges in
    the X-cells plus Q-vertices on old Z endpoints BEFORE checking
    H4/H5 defects. It is NOT a documented physical boundary condition:
    removing these C1 incidences changes the source code.
    """
    boundary=set(source_endpoint_rel_boundary(c))
    for x in old.xs:
        for q in old.xq[x]:
            for e in y_q(old,q,L).edges:
                boundary.add(("xe",x,e))
    assert boundary <= set(c.q), "relative interface refers to absent source C1"
    return frozenset(boundary)


def gf2_rank(row_masks):
    piv={}
    for raw in row_masks:
        v=raw
        while v:
            p=v.bit_length()-1
            if p in piv:
                v^=piv[p]
            else:
                piv[p]=v
                break
    return len(piv)


def candidate_relative_quotient(c,old,L):
    """C2 -> C1/B exact restricted-incidence map, not original ker d1^T."""
    named=source_named_restriction_interface(c,old,L)
    c2idx={z:i for i,z in enumerate(c.z)}
    eqs=[
        sum(1<<c2idx[z] for z in c.d1[q])
        for q in c.q if q not in named
    ]
    full_eqs=[
        sum(1<<c2idx[z] for z in c.d1[q])
        for q in c.q
    ]
    full_dim=len(c.z)-gf2_rank(full_eqs)
    relative_dim=len(c.z)-gf2_rank(eqs)
    assert full_dim == 3
    assert relative_dim >= full_dim
    return named,{
        "construction":"native Q-restriction C1 edges + all old-Z endpoint Q-vertices",
        "discarded_C1_check_count":len(named),
        "retained_C1_check_count":len(c.q)-len(named),
        "full_absolute_kernel_dim":full_dim,
        "hypothetical_relative_kernel_dim":relative_dim,
        "changes_original_complex":True,
        "physically_justified_boundary":False
    }


def junction_candidates(c):
    in_c2 = Counter()
    for cod in c.d1.values():
        in_c2.update(cod)
    return {
        "C0_check_degree": max(map(len, c.d0.values())),
        "C2_check_degree": max(in_c2.values()),
        "bit_to_region_fanout": max(map(len,c.d1.values())),
    }


def check_level_one(L):
    old = seed()
    c = replace_x(old, L)
    C2 = tuple(c.z)
    c2idx = {x:i for i,x in enumerate(C2)}
    H4,H5 = create_families(c,old,L)
    rows = []
    endpoint = source_endpoint_rel_boundary(c)
    named_interface,relative_audit = candidate_relative_quotient(c,old,L)
    for family,label in [(H4,"H4"),(H5,"H5")]:
        for name, support in family.items():
            mask = submask(support, c2idx)
            defects = syndrome_support(c, support)
            assert ((mask >> 0) & 1) in (0,1)
            rows.append({
                "family":label,
                "candidate":name,
                "support_weight":len(support),
                "absolute_closed":len(defects)==0,
                "boundary_defect_count":len(defects),
                "defect_types":dict(sorted(Counter(map(classify_defect,defects)).items())),
                "defect_cells":[repr(q) for q in defects],
                "relative_to_source_endpoint_candidates":set(defects)<=endpoint,
                "relative_to_restriction_interface":set(defects)<=named_interface,
                "source_support_cells":[repr(cell) for cell in sorted(support)],
            })
    correct_masks=[submask(s,c2idx) for s in H5.values()]
    old_masks=[submask(s,c2idx) for s in H4.values()]
    assert independent_basis_rank(correct_masks)==3
    assert independent_basis_rank(old_masks)==3
    allweights,fullbasis=kernel_all_weights(c)
    assert len(allweights)==7
    for mask in correct_masks:
        assert all((mask & row).bit_count()%2==0
                   for row in (sum(1<<c2idx[z] for z in c.d1[q]) for q in c.q))
    # An explicit source-cycle family with 3 independent vectors must
    # exhaust the exact rank-3 kernel. No basis-independent 4-cycle
    # exists in this declared absolute C2 complex.
    assert all(not syndrome_support(c,s) for s in H5.values())
    assert all(syndrome_support(c,s) for s in H4.values())
    assert all(set(syndrome_support(c,s))<=named_interface for s in H4.values())
    assert relative_audit["hypothetical_relative_kernel_dim"]>3, (
        "this quotient unexpectedly retained only the original kernel")
    assert min(allweights)==5
    assert 4 not in allweights
    if L==1:
        assert sorted(map(len,H4.values()))==[4,4,6]
        assert sorted(map(len,H5.values()))==[5,5,10]
    assert sorted(map(len,H4.values()))==[4,4,4*L+2]
    old_defects=[syndrome_support(c,v) for v in H4.values()]
    assert sorted(map(len,old_defects))==[3,3,8*L+4],(
        "old support defects changed",list(map(len,old_defects)))
    assert sorted(map(len,H5.values()))==[5,5,8*L+2]
    return {
        "ell":2*L+1,
        "C1_count":len(c.q),"C2_count":len(c.z),
        "kernel_dimension":3,
        "old_reconstruction_weights":sorted(map(len,H4.values())),
        "source_closed_basis_weights":sorted(map(len,H5.values())),
        "absolute_kernel_nonzero_weights":allweights,
        "absolute_minimum":min(allweights),
        "source_endpoint_relative_boundary_size":len(endpoint),
        "source_named_restriction_relative_quotient":relative_audit,
        "candidates":rows,
        "junction_candidates_level1":junction_candidates(c)
    }


def check_level_two(L):
    first=replace_x(seed(),L)
    second=replace_z(first.tanner,L)
    allweights,basis=kernel_all_weights(second)
    return {
        "ell":2*L+1,"C1_count":len(second.q),"C2_count":len(second.z),
        "kernel_dimension":len(basis),
        "absolute_kernel_nonzero_weights":allweights,
        "absolute_minimum":min(allweights),
        "junction_candidates_level2":junction_candidates(second),
        "note":"No projection of H4/H5 generators across mixed-degree R is assumed"
    }


def main():
    first=[check_level_one(L) for L in (1,2,3)]
    second=[check_level_two(L) for L in (1,2)]
    print(json.dumps({
        "source_model":"PR215 original seed, first replace_x, optional second replace_z",
        "H4":"reconstructed old bank candidate, NOT independently retrieved GLM file",
        "H5":"source-valid full-rail and q2 full-seam absolute cycles",
        "level1":first,"level2":second
    },indent=2))
    print("BOTH HYPOTHESES TESTED UNDER THE SAME EXACT C2 BOUNDARY: PASS")
    print("OLD 4/4/6 RECONSTRUCTION: NOT ABSOLUTE CYCLES IN THIS SOURCE COMPLEX")
    print("FULL 5/5/10 SOURCE BASIS: ABSOLUTE CYCLES AND RANK-COMPLETE")
    print("ALL ell=3,5,7 LABELS: SUBDIVISION SIZES, NOT MEMBRANE SUPPORTS")
    print("H4 RELATIVE TO A HYPOTHETICAL SOURCE-NAMED INTERFACE: CLOSED ONLY AFTER DROPPING REAL C1 CHECKS")
    print("RELATIVE SECTOR GEOMETRY AND PHYSICAL STATUS: UNVALIDATED, NOT RULED OUT")
    print("STRICT M3 W_i FLOOR / 3D J3 / HULL DECREASE: OPEN")


if __name__=="__main__":
    main()
