#!/usr/bin/env python3
"""Source-explicit disjoint endpoint metachecks under BDL R_Z.

For every previous X vertex x there is a new metacheck R_x with only
'qe' vertical-edge and 'zv' endpoint coordinates. These sit entirely
OUTSIDE the spherical blocks and are mutually disjoint.

Consequence: for any fixed 0<z<=1, local-sphere-only rejection has an
all-L exponentially small acceptance upper bound in this algebraic
two-level source-cell family. This is NOT a general Gibbs-sampling no-go.
"""
from collections import Counter
from fractions import Fraction

from bdl_replacement_chain import seed, replace_x, replace_z, edge, vertex
from bdl_local_spheres import sphere_blocks
from bdl_residual_quotient import source_level_two_inventory


def endpoint_relations(previous):
    """Construct one parity row R_x per old X-check; independent of L."""
    out=[]
    for x in previous.x:
        vertical=edge((0,vertex(x)),(1,vertex(x)))
        relation={("zv",x,0),("zv",x,1)}
        relation.update(("qe",q,vertical) for q in previous.tanner.xq[x])
        assert len(relation)==2+len(previous.tanner.xq[x])
        out.append((x,frozenset(relation)))
    return out


def acceptance_upper(rows, z):
    """Exact product of disjoint free-Bernoulli even-parity probabilities."""
    z=Fraction(z)
    if not 0<z<=1:
        raise ValueError("0<z<=1 for this monotone fugacity certificate")
    t=(1-z)/(1+z)
    upper=Fraction(1)
    for _,row in rows:
        upper *= (1+t**len(row))/2
    return upper


def audit():
    for L in (1,2):
        previous=replace_x(seed(),L)
        current=replace_z(previous.tanner,L)
        endpoint=endpoint_relations(previous)
        spheres=sphere_blocks(previous,L)
        sphere_union=set().union(*spheres)

        # Every endpoint relation is an actual full-code parity relation.
        # δ0 maps a new X check to incident new qubits; their XOR vanishes.
        all_x=set(current.x)
        occupied=set()
        for x,row in endpoint:
            assert row <= all_x
            assert row.isdisjoint(sphere_union)
            assert not occupied.intersection(row)
            occupied.update(row)
            parity=set()
            for check in row:
                parity.symmetric_difference_update(current.d0[check])
            assert not parity,("invalid endpoint relation",x)

        info=source_level_two_inventory(L)
        assert len(endpoint)==len(previous.x)==info["local_spheres"]+2
        # The rows are independent by disjointness. Since they are
        # disjoint from every local sphere and valid full-code checks,
        # they contribute independent residual rank.
        assert len(endpoint) <= info["residual_rank"]
        assert all(len(row)>=2 for _,row in endpoint)

        degrees=Counter(len(row) for _,row in endpoint)
        z=Fraction(1,3)
        upper=acceptance_upper(endpoint,z)
        t=(1-z)/(1+z)
        universal=((1+t*t)/2)**len(endpoint)
        assert 0<upper <= universal <1
        print("L=",L,"explicit_endpoints=",len(endpoint),
              "relation_weights=",sorted(degrees.items()),
              "acceptance_upper_z1over3=",float(upper),
              "universal_simple_upper=",float(universal))

    # Exact all-L cell-count identities from parent source-cell proof:
    # |X_1|=8L²+12L+4, so at each fixed 0<z<=1 the upper bound
    # ((1+t²)/2)^|X_1| decays exponentially in L².
    for L in (1,2,3,4):
        previous=replace_x(seed(),L)
        relations=endpoint_relations(previous)
        assert len(relations)==8*L*L+12*L+4
        assert len(set().union(*(row for _,row in relations))) == sum(
            len(row) for _,row in relations)
    print("BDL all-L endpoint relation schema and finite incidence checks: PASS")


if __name__=="__main__":
    audit()
