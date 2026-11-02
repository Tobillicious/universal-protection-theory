#!/usr/bin/env python3
"""Exact local-sphere parity Gibbs subproposal, not a full BDL Gibbs sampler.

Every output satisfies ONLY disjoint local sphere metachecks. Residual
metachecks remain and exact rejection onto them has a separate acceptance
obligation. Source: BDL arXiv:2605.10943v1 §§3.2.2–3.2.6.
"""
from collections import Counter
from fractions import Fraction
from itertools import product
from random import Random

from bdl_replacement_chain import replace_z, y_x
from bdl_symbolic_kernel import source_symbolic


def sphere_blocks(first, L):
    """One disjoint sphere-face parity check per cycle-boundary old Z star."""
    dual = first.tanner.dual()
    blocks = []
    for z in dual.xs:
        y = y_x(dual, z, L)
        incidence = Counter(e for _, edges in y.faces.values() for e in edges)
        if len(incidence) == len(y.edges) and all(deg == 2 for deg in incidence.values()):
            block = frozenset(("xf", z, fid) for fid in y.faces)
            assert len(block) == 8 * L * (L + 1)
            blocks.append(block)
    assert len(blocks) == 8 * L**2 + 12 * L + 2, len(blocks)
    assert sum(map(len, blocks)) == len(set().union(*blocks))
    return blocks


def rational_coin(prob, rng):
    return int(rng.randrange(prob.denominator) < prob.numerator)


def sample_even_block(length, z, rng):
    """EXACT finite-rational Gibbs sampler z^|x|/Z_even on even words."""
    z = Fraction(z)
    if z <= 0 or length < 0:
        raise ValueError("require positive fugacity and nonnegative length")
    suffix = [[Fraction(0), Fraction(0)] for _ in range(length+1)]
    suffix[length] = [Fraction(1), Fraction(0)]
    for i in range(length-1, -1, -1):
        suffix[i][0] = suffix[i+1][0] + z * suffix[i+1][1]
        suffix[i][1] = suffix[i+1][1] + z * suffix[i+1][0]
    parity = 0
    output = []
    for i in range(length):
        prob = z * suffix[i+1][parity ^ 1] / suffix[i][parity]
        bit = rational_coin(prob, rng)
        output.append(bit)
        parity ^= bit
    assert parity == 0
    return tuple(output)


def local_partition(n, blocks, z):
    """Product partition function for local sphere checks only."""
    z = Fraction(z)
    if z <= 0:
        raise ValueError("positive fugacity required")
    occupied = sum(len(block) for block in blocks)
    if occupied > n:
        raise ValueError("invalid block sizes")
    result = (1+z)**(n-occupied)
    for block in blocks:
        size = len(block)
        result *= ((1+z)**size + (1-z)**size)/2
    return result


def sample_local_only(syndrome_coordinates, blocks, z, rng):
    """Return exactly the local-constrained law, NOT the fully valid BDL law."""
    z = Fraction(z)
    if z <= 0:
        raise ValueError("positive fugacity required")
    site_set = set(syndrome_coordinates)
    assigned = {}
    for block in blocks:
        ordered = tuple(sorted(block, key=repr))
        if not set(ordered) <= site_set or any(site in assigned for site in ordered):
            raise ValueError("overlapping or out-of-support local block")
        assigned.update(zip(ordered, sample_even_block(len(ordered), z, rng)))
    p = z/(1+z)
    for site in syndrome_coordinates:
        if site not in assigned:
            assigned[site] = rational_coin(p, rng)
    assert len(assigned) == len(syndrome_coordinates)
    return tuple(assigned[site] for site in syndrome_coordinates)


def audit():
    # Check the exact even-syndrome partition independently by enumeration.
    for size in (2, 3, 4, 5):
        z = Fraction(1,3)
        exact = sum((z**sum(bits) for bits in product((0,1),repeat=size)
                     if sum(bits)%2 == 0),Fraction(0))
        assert exact == local_partition(size,[range(size)],z)
        for trial in range(25):
            assert sum(sample_even_block(size,z,Random(trial)))%2 == 0

    for L in (1,2):
        first,_,_,_,_,all_rank = source_symbolic(L)
        second = replace_z(first.tanner,L)
        blocks = sphere_blocks(first,L)
        all_sites = set(second.x)
        assert all(block <= all_sites for block in blocks)
        # Every sphere is a zero-parity relation of the FULL metacheck map.
        for block in blocks:
            assert all(sum(q in second.d0[x] for x in block)%2 == 0 for q in second.q)
        local_rank = len(blocks)
        assert all_rank == 4*local_rank + 2
        assert len(second.x) == 64*L**4+256*L**3+336*L**2+160*L+24
        z = Fraction(1,3)
        assert local_partition(len(second.x),blocks,z) > 0
        for trial in range(10):
            bits = sample_local_only(second.x,blocks,z,Random(trial))
            lookup = dict(zip(second.x,bits))
            assert all(sum(lookup[s] for s in block)%2 == 0 for block in blocks)
        print("L",L,"local-spheres",local_rank,"bits-per-sphere",len(blocks[0]),
              "full-rank",all_rank,"residual-rank",all_rank-local_rank,
              "syndrome-bits",len(second.x))
    print("BDL independent spherical constraints and exact local Gibbs proposal: PASS")


if __name__ == "__main__":
    audit()
