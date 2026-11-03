#!/usr/bin/env python3
"""BDL relative-floor trap: exact source proof witnesses at ell = 3,5,7.

For original first R_X source and H4/H5 from PR #239:
 short H4 rail + one omitted true C2 cell = full H5 absolute cycle.
For EVERY additive projection P of this SAME boundary, closure of H4
forces P(boundary(omitted_cell))=0. Hence the projected full kernel
contains a true weight-one vector, even for non-coordinate quotients.

This script additionally computes the MINIMAL COORDINATE interface B_min
containing all H4 defects, never assuming it is a valid physical boundary.
No 3D geometry, partially invariant W_i, or full Lemma 13 is inferred.
"""
import json
from bdl_replacement_chain import replace_x, seed
from bdl_competing_membrane_supports import (
    create_families, syndrome_support, gf2_rank, kernel_all_weights
)


def span_rank_from_retained_checks(c, omitted_checks):
    idx={cell:i for i,cell in enumerate(c.z)}
    return gf2_rank([
        sum(1<<idx[z] for z in c.d1[q])
        for q in c.q if q not in omitted_checks
    ])


def case(L):
    old=seed()
    c=replace_x(old,L)
    short,full=create_families(c,old,L)
    bmin=frozenset().union(
        *(syndrome_support(c,s) for s in short.values())
    )
    assert bmin <= set(c.q)
    assert all(set(syndrome_support(c,s)) <= bmin
               for s in short.values())
    rank=span_rank_from_retained_checks(c,bmin)
    relative_dim=len(c.z)-rank
    original_weights,_=kernel_all_weights(c)
    assert len(original_weights)==7 and min(original_weights)==5
    singles=[
        cell for cell in c.z
        if set(syndrome_support(c,frozenset([cell])))<=bmin
    ]
    missed={}
    for rail_name,corrected_name in (
        ("z0_rail_short","z0_rail_full"),
        ("z1_rail_short","z1_rail_full")
    ):
        omitted=short[rail_name]^full[corrected_name]
        assert len(omitted)==1
        one=next(iter(omitted))
        assert set(syndrome_support(c,short[rail_name]))==set(
            syndrome_support(c,frozenset([one]))
        )
        assert one in singles
        missed[rail_name]={
            "omitted_source_cell":repr(one),
            "omitted_weight":1,
            "boundary_equals_original_short_defect":True,
            "remains_closed_in_every_additive_quotient_closing_short":True
        }
    assert len(singles)>=2
    assert relative_dim>=4
    # B_min is necessary for coordinate deletion; a larger coordinate
    # interface can only ENLARGE the relative kernel, not improve floor.
    return {
        "ell":2*L+1,
        "original_C1_equations":len(c.q),
        "minimal_coordinate_boundary_interface_size":len(bmin),
        "retained_parity_equations":len(c.q)-len(bmin),
        "original_absolute_kernel_dimension":3,
        "minimal_interface_relative_kernel_dimension":relative_dim,
        "minimal_interface_relative_weight_floor":1,
        "singleton_relative_cycle_count":len(singles),
        "first_singleton_witnesses":[repr(z) for z in singles[:6]],
        "mandatory_rail_omissions":missed,
        "no_go_scope":"same source ∂2, any additive quotient, full relative kernel"
    }


def main():
    results=[case(L) for L in (1,2,3)]
    print(json.dumps(results,indent=2))
    print("PASS: every additive quotient closing H4 short rails closes omitted weight-one cell")
    print("PASS: even minimal coordinate interface has floor 1 at ell=3,5,7")
    print("NOT RULED OUT: different 3D incidence, different source generator bank, restricted W_i")
    print("UNPROVED: legitimate physical/gauge relative sector or any all-level 3D M3 claim")


if __name__=="__main__":
    main()
