#!/usr/bin/env python3
"""Cross-replay the original complete 840-bit BDL Gibbs partition under
a DISTINCT, exactly invertible GF(2) residual complement basis.

Not an independent physical validation: same source cellular model, but
different complete dual coordinate system and different elimination order.
"""
from fractions import Fraction
from hashlib import sha256

from bdl_residual_basis_search import (
    source_problem, pick_complement, dual_factor_graph, basis_rank
)
from bdl_residual_order_search import search_order, certify_order
from bdl_dual_bucket_exact import evidence_partition

ORIGINAL_FULL_Z_SHA = (
    "82311cad726376c992a38fe99c7bace54f9b1fd10c694590dacd7dd1360daaca"
)
ORIGINAL_FIRSTBIT_P_SHA = (
    "f7162bc6c26ae696ac4e8cc3fc6725914567950ac762dfd7dfa94e60312e4805"
)


def digest(q):
    return sha256(f"{q.numerator}/{q.denominator}".encode()).hexdigest()


def audit():
    m,blocks,full,d=source_problem(1)
    assert m==840 and len(full)==90 and d==44
    standard=pick_complement(blocks,full,"original",0)
    alternative=pick_complement(blocks,full,"random",0)
    assert standard!=alternative,"must test a genuinely distinct dual basis"
    assert basis_rank(blocks+standard)==basis_rank(blocks+alternative)==90

    graph,scopes=dual_factor_graph(m,blocks,alternative)
    order=search_order(graph,"degree",2)
    certificate=certify_order(graph,order)
    assert certificate["width"]==14
    assert certificate["table_entries"]==229758

    z=Fraction(1,3)
    Z,w,entries=evidence_partition(
        m,blocks,alternative,z,order=order,max_width=14)
    assert w==14 and entries==229758
    assert digest(Z)==ORIGINAL_FULL_Z_SHA,digest(Z)

    Z1,_,_=evidence_partition(
        m,blocks,alternative,z,evidence={0:1},
        order=order,max_width=14)
    Z0,_,_=evidence_partition(
        m,blocks,alternative,z,evidence={0:0},
        order=order,max_width=14)
    assert Z0+Z1==Z
    p=Z1/Z
    assert digest(p)==ORIGINAL_FIRSTBIT_P_SHA,digest(p)

    print("Distinct full-row-rank GF2 complement basis: YES")
    print("Source full metacheck dimension: 90; physical syndrome bits: 840")
    print("Alternative primal induced width:",w)
    print("Alternative total Boolean table entries:",entries)
    print("Exact full Gibbs partition SHA-256:",digest(Z))
    print("Exact first physical syndrome marginal SHA-256:",digest(p))
    print("Cross-basis complete source Gibbs/evidence normalization: PASS")


if __name__=="__main__":
    audit()
