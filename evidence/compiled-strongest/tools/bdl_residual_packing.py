#!/usr/bin/env python3
"""Certified finite residual parity-event packing for the BDL local proposal.

Given the complete full-GF(2) syndrome relations and disjoint local sphere
blocks, choose residual rows touching disjoint proposal factors. Their
acceptance events are exactly independent under the LOCAL Gibbs proposal.

This bounds the local-rejection method from above; it is NOT a lower bound
for every possible exact sampler, nor an all-L asymptotic theorem.
"""
from collections import Counter
from fractions import Fraction

from bdl_replacement_chain import replace_z
from bdl_symbolic_kernel import source_symbolic
from bdl_local_spheres import sphere_blocks
from bdl_frontier_audit import error_columns, dependency_basis
from bdl_residual_quotient import mask, rank_gf2


def smallest_representative_mod_blocks(word, spheres):
    """Flip independent entire sphere blocks to minimise Hamming support."""
    for row in spheres:
        a = (word & row).bit_count()
        if 2*a > row.bit_count():
            word ^= row
    return word


def incremental_basis(vectors):
    pivots = {}
    selected = []
    for v in vectors:
        x = v
        while x:
            p = x.bit_length() - 1
            if p in pivots:
                x ^= pivots[p]
            else:
                pivots[p] = x
                selected.append(v)
                break
    return selected


def residual_complement_and_blocks(L):
    first, _, _, _, _, full_rank = source_symbolic(L)
    second = replace_z(first.tanner,L)
    blocks = sphere_blocks(first,L)
    syndrome = list(second.x)
    sid = {x:i for i,x in enumerate(syndrome)}
    sphere_rows = [mask((sid[x] for x in block),len(syndrome))
                   for block in blocks]
    assert all(a & b == 0 for i,a in enumerate(sphere_rows)
               for b in sphere_rows[i+1:])
    cols, syndrome_full = error_columns(second,"Z")
    assert list(syndrome_full) == syndrome
    relations = dependency_basis(cols,syndrome_full,second.q)
    all_rows = [mask(row,len(syndrome)) for row in relations]
    assert len(all_rows) == full_rank
    basis = incremental_basis(sphere_rows + all_rows)
    assert len(basis) == full_rank
    # The original independent sphere rows appear first, then full-residue
    # basis rows. Minimise each latter row modulo the block span.
    complement = [smallest_representative_mod_blocks(v,sphere_rows)
                  for v in basis[len(sphere_rows):]]
    assert rank_gf2(sphere_rows+complement)==full_rank
    return second, syndrome, sphere_rows, complement


def touched_proposal_factors(word, spheres):
    """A whole even-parity block is one independent Gibbs factor."""
    used=set()
    occupied=0
    for i,sphere in enumerate(spheres):
        occupied |= sphere
        if word & sphere:
            used.add(("block",i))
    outside=word & ~occupied
    while outside:
        bit=outside & -outside
        used.add(("free",bit.bit_length()-1))
        outside ^= bit
    return frozenset(used)


def pack_disjoint_factor_events(residual, spheres):
    records = []
    for index, row in enumerate(residual):
        factors = touched_proposal_factors(row,spheres)
        if not factors:
            raise AssertionError("independent residual row with empty support")
        records.append((len(factors),row.bit_count(),index,row,factors))
    records.sort()
    used=set()
    chosen=[]
    for _,_,j,row,factors in records:
        if used.isdisjoint(factors):
            chosen.append((j,row,factors))
            used.update(factors)
    return chosen


def single_parity_pass_probability(word, spheres, z):
    z=Fraction(z)
    if not 0<z<=1:
        raise ValueError("0<z<=1")
    t=(1-z)/(1+z)
    occupied=0
    chi=Fraction(1)
    for sphere in spheres:
        occupied |= sphere
        s=sphere.bit_count()
        a=(word & sphere).bit_count()
        chi *= (t**a+t**(s-a))/(1+t**s)
    chi *= t**(word & ~occupied).bit_count()
    return (1+chi)/2


def audit():
    z=Fraction(1,3)
    for L in (1,2):
        second,syndrome,spheres,residual=residual_complement_and_blocks(L)
        chosen=pack_disjoint_factor_events(residual,spheres)
        assert chosen
        assert all(chosen[i][2].isdisjoint(chosen[j][2])
                   for i in range(len(chosen))
                   for j in range(i+1,len(chosen)))
        assert rank_gf2([v for _,v,_ in chosen])==len(chosen)
        probs=[single_parity_pass_probability(row,spheres,z)
               for _,row,_ in chosen]
        assert all(Fraction(1,2)<=p<1 for p in probs)
        upper=Fraction(1)
        for p in probs:
            upper *= p
        # If all full residual checks B pass, the chosen subset passes;
        # and selected checks are independent under the LOCAL proposal.
        # Hence P(B) <= upper < 1, an exact (nonasymptotic) certificate.
        assert 0<upper<1
        profile=Counter((sum(kind=="block" for kind,_ in factors),
                         sum(kind=="free" for kind,_ in factors))
                        for _,_,factors in chosen)
        print("factor_profile=",sorted(profile.items()))
        print("sample_row_units=",[(index, sorted(factors)[:15], row.bit_count())
                                   for index,row,factors in chosen[:5]])
        print("L=",L,"syndrome_bits=",len(syndrome),
              "sphere_blocks=",len(spheres),
              "residual_rank=",len(residual),
              "independent_factor_disjoint_checks=",len(chosen),
              "mean_factor_span=",round(sum(map(lambda x:len(x[2]),chosen))/len(chosen),2),
              "acceptance_upper_at_z_1_over_3=",float(upper),
              "max_single_pass=",float(max(probs)))
    print("BDL finite factor-disjoint residual packing: PASS")


if __name__=="__main__":
    audit()
