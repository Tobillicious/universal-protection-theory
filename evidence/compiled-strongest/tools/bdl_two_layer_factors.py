#!/usr/bin/env python3
"""Exact TWO-LAYER BDL parity-block Gibbs proposal.

Combines source-genuine disjoint spheres with source-genuine disjoint endpoint
relations. All these blocks are pairwise disjoint in syndrome coordinates,
so this law is exactly product-samplable, with NO dropped factor constraints.

The remaining 2*c full-code metachecks are NOT solved by this script.
"""
from collections import Counter
from fractions import Fraction
from itertools import product
from random import Random

from bdl_replacement_chain import seed, replace_x, replace_z
from bdl_local_spheres import sphere_blocks, sample_even_block, rational_coin
from bdl_residual_endpoint_obstruction import endpoint_relations
from bdl_residual_quotient import source_level_two_inventory


def checked_blocks(coords, blocks):
    site_set = set(coords)
    if len(site_set) != len(coords):
        raise ValueError("syndrome labels must be unique")
    used=set()
    for block in blocks:
        if not block or not set(block) <= site_set or not used.isdisjoint(block):
            raise ValueError("blocks must be nonempty, disjoint, and in the syndrome")
        used.update(block)
    return len(coords)-len(used)


def even_partition(n,z):
    z=Fraction(z)
    if n<0 or z<=0:
        raise ValueError("positive rational z and nonnegative n required")
    return ((1+z)**n+(1-z)**n)/2


def product_partition(coords, blocks, z):
    """Full normalized unconditioned partition for the TWO-LAYER proposal."""
    z=Fraction(z)
    if z<=0:
        raise ValueError("positive rational fugacity required")
    free=checked_blocks(coords,blocks)
    Z=(1+z)**free
    for block in blocks:
        Z *= even_partition(len(block),z)
    return Z


def sample_two_layer_only(coords, blocks, z, rng):
    """Exact finite Gibbs law conditioned only on BOTH disjoint block families."""
    z=Fraction(z)
    if z<=0:
        raise ValueError("positive rational fugacity required")
    _=checked_blocks(coords,blocks)
    data={}
    for block in blocks:
        ordered=tuple(sorted(block,key=repr))
        data.update(zip(ordered,sample_even_block(len(block),z,rng)))
    p=z/(1+z)
    for site in coords:
        if site not in data:
            data[site]=rational_coin(p,rng)
    return tuple(data[site] for site in coords)


def source_two_layer(L):
    """Reconstruct actual finite source-cell constraints at subdivision L."""
    before=replace_x(seed(),L)
    after=replace_z(before.tanner,L)
    sphere=[frozenset(b) for b in sphere_blocks(before,L)]
    endpoint=[frozenset(r) for _,r in endpoint_relations(before)]
    blocks=sphere+endpoint
    free=checked_blocks(after.x,blocks)
    info=source_level_two_inventory(L)
    c=info["local_spheres"]
    assert len(sphere)==c
    assert len(endpoint)==len(before.x)==c+2
    assert len(blocks)==2*c+2
    assert info["full_rank"]-len(blocks)==2*c

    # Full block census from source-cell vertex classification, not a
    # small-instance extrapolation.
    endpoint_lengths=Counter(map(len,endpoint))
    assert endpoint_lengths == {
        5:8*L-4, 6:8*L*L-12*L+12, 7:16*L-4,
    },endpoint_lengths
    count=sum(map(len,endpoint))
    assert count==48*L*L+80*L+24
    assert free==96*L**3+176*L*L+64*L
    return before,after,sphere,endpoint,free,info


def low_temperature_gate(L):
    """A sufficient all-L constant-rejection regime after two-layer sampling.

    This is an analytic bound, not an estimator of true residual acceptance.
    """
    info=source_level_two_inventory(L)
    c=info["local_spheres"]
    s=info["sphere_size"]
    endpoint_sq=288*L*L+552*L+136
    free=96*L**3+176*L*L+64*L
    # ceil sqrt(total block size-square sum)
    from math import isqrt
    root=isqrt(c*s*s+endpoint_sq)
    if root*root != c*s*s+endpoint_sq:
        root += 1
    z=Fraction(1,free+root)
    budget=free*z+Fraction(c*s*s+endpoint_sq,2)*z*z
    assert budget <= Fraction(3,2)
    return z,budget


def audit():
    # Independent exact small-system partition check.
    coords=tuple(range(8))
    blocks=[frozenset((0,1)),frozenset((2,3,4)),frozenset((5,6))]
    for z in (Fraction(1,3),Fraction(3,4),Fraction(2,1)):
        expected=sum((z**sum(bits) for bits in product((0,1),repeat=8)
                      if all(sum(bits[i] for i in block)%2==0
                             for block in blocks)),Fraction(0))
        assert expected==product_partition(coords,blocks,z)
        rng=Random(321)
        for _ in range(50):
            x=sample_two_layer_only(coords,blocks,z,rng)
            assert all(sum(x[i] for i in block)%2==0 for block in blocks)

    for L in (1,2):
        before,after,spheres,endpoints,free,info=source_two_layer(L)
        all_blocks=spheres+endpoints
        assert all(block<=set(after.x) for block in all_blocks)
        for row in all_blocks:
            parity=set()
            for x in row:
                parity.symmetric_difference_update(after.d0[x])
            assert not parity,("block is not a full-code metacheck",L)
        z=Fraction(1,3)
        rng=Random(1304)
        lookup={x:i for i,x in enumerate(after.x)}
        for _ in range(8):
            bits=sample_two_layer_only(after.x,all_blocks,z,rng)
            for row in all_blocks:
                assert sum(bits[lookup[x]] for x in row)%2==0
        print("L=",L,"hard_syndrome_bits=",len(after.x),
              "sphere_blocks=",len(spheres),"endpoint_blocks=",len(endpoints),
              "two_layer_constrained_rank=",len(all_blocks),
              "remaining_full_metacheck_rank=",2*len(spheres),
              "unconstrained_bits=",free,
              "z_cold_gate=",low_temperature_gate(L)[0])

    for L in (1,2,3,4):
        z,budget=low_temperature_gate(L)
        assert 0<z<=1 and budget<=Fraction(3,2)
    print("BDL two-layer exact Gibbs factors and residual-rank gate: PASS")


if __name__=="__main__":
    audit()
