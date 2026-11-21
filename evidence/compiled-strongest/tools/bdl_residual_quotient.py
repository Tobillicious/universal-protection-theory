#!/usr/bin/env python3
"""Exact quotient-Fourier residual certificate after disjoint parity blocks.

This is finite rational mathematics. Summing 2^d residual dual terms is
generically exponential; this does NOT certify a fixed-temperature,
family-wide BDL 3D Gibbs sampler or physical encoded state preparation.
"""
from fractions import Fraction
from itertools import product
from math import isqrt
from random import Random

from bdl_local_spheres import local_partition, sample_local_only


def mask(support, n):
    xs = tuple(support)
    if len(xs) != len(set(xs)) or any(x < 0 or x >= n for x in xs):
        raise ValueError("repeated or out-of-range coordinates")
    return sum(1 << x for x in xs)


def rank_gf2(vectors):
    pivots = {}
    for vector in vectors:
        x = vector
        while x:
            p = x.bit_length() - 1
            if p in pivots:
                x ^= pivots[p]
            else:
                pivots[p] = x
                break
    return len(pivots)


def checked_input(n, sphere_blocks, residual_rows):
    if n < 0:
        raise ValueError("negative syndrome dimension")
    spheres = [mask(block, n) for block in sphere_blocks]
    residual = [mask(row, n) for row in residual_rows]
    if any(x == 0 for x in spheres) or any(x == 0 for x in residual):
        raise ValueError("zero relation is not an independent basis vector")
    seen = 0
    for sphere in spheres:
        if seen & sphere:
            raise ValueError("local sphere supports must be pairwise disjoint")
        seen |= sphere
    if rank_gf2(spheres + residual) != len(spheres) + len(residual):
        raise ValueError("residual rows must complement independent local rows")
    return spheres, residual, seen


def quotient_character_acceptance(n, sphere_blocks, residual_rows, fugacity):
    """EXACT Z_full/Z_local for 0<=z<=1 after eliminating local sphere duals.

    For each residual dual word v, every sphere block S of size s
    contributes (t^a+t^(s-a))/(1+t^s), where a=|v∩S|,
    t=(1-z)/(1+z). The outside contribution is t^b.
    The remaining sum is over 2^d cosets, so NOT generally polynomial.
    """
    z = Fraction(fugacity)
    if not 0 <= z <= 1:
        raise ValueError("this nonnegative-Walsh certificate uses 0<=z<=1")
    spheres, residual, occupied = checked_input(n, sphere_blocks, residual_rows)
    d = len(residual)
    if d > 16:
        raise ValueError("explicit residual Fourier sum is exponentially large; use bounds")
    t = (1-z)/(1+z)
    total = Fraction(0)
    for choices in range(1 << d):
        v = 0
        for j, r in enumerate(residual):
            if choices >> j & 1:
                v ^= r
        b = (v & ~occupied).bit_count()
        term = t**b
        for sphere in spheres:
            s = sphere.bit_count()
            a = (v & sphere).bit_count()
            term *= (t**a + t**(s-a))/(1+t**s)
        total += term
    return total/(1 << d)


def brute_acceptance(n, sphere_blocks, residual_rows, fugacity):
    """Independent normalizer ratio by enumerating all 2^n configurations."""
    if n > 14:
        raise ValueError("exhaustive input limited to n<=14")
    z = Fraction(fugacity)
    spheres, residual, _ = checked_input(n, sphere_blocks, residual_rows)
    zloc = Fraction(0)
    zfull = Fraction(0)
    for x in range(1 << n):
        if any((x & row).bit_count() % 2 for row in spheres):
            continue
        w = z**x.bit_count()
        zloc += w
        if not any((x & row).bit_count() % 2 for row in residual):
            zfull += w
    return zfull/zloc


def source_level_two_inventory(L):
    """Exact source-cell symbolic counts for [[5,1,2]] after R_Z R_X."""
    if not isinstance(L, int) or L < 1:
        raise ValueError("positive integer subdivision L required")
    c = 8*L*L + 12*L + 2
    s = 8*L*(L+1)
    m = 64*L**4 + 256*L**3 + 336*L**2 + 160*L + 24
    f = m - c*s
    assert f == 96*L**3 + 224*L**2 + 144*L + 24
    r = 32*L*L + 48*L + 10
    d = r-c
    assert d == 3*c+2 == 24*L*L + 36*L + 8
    return {"L":L,"syndrome_bits":m,"local_spheres":c,
            "sphere_size":s,"free_bits":f,"full_rank":r,"residual_rank":d}


def cold_gate(L):
    """A rational fugacity sufficient for >= exp(-3/2) acceptance.

    Actual full-law rejection requires all source-exact residual checks,
    a completely verified finite constraint matrix, and their efficient
    predicate. This function supplies the temperature/acceptance gate,
    not an exact sample of the full code.
    """
    info = source_level_two_inventory(L)
    c,s,f = info["local_spheres"],info["sphere_size"],info["free_bits"]
    root = isqrt(c)
    ceil_root = root + int(root*root != c)
    z = Fraction(1, f+s*ceil_root)
    budget = f*z+Fraction(c*s*s,2)*z*z
    assert budget <= Fraction(3,2)
    return z, budget


def exact_local_zero_lower_bound(L, z):
    """Certified acceptance >=1/Z_local because the zero word is valid."""
    p=source_level_two_inventory(L)
    z=Fraction(z)
    if not 0<=z<=1:
        raise ValueError("0<=z<=1 required")
    even = ((1+z)**p["sphere_size"] + (1-z)**p["sphere_size"])/2
    Z = (1+z)**p["free_bits"] * even**p["local_spheres"]
    return Fraction(1)/Z


def tests():
    # Each independent small CSS-style parity system is checked twice:
    # through full 2^n syndrome enumeration and through quotient Fourier.
    fixtures = [
        (7, [(0,1),(2,3,4)], [(1,2,5),(0,3,6)]),
        (6, [(0,1,2,3)], [(1,2),(0,4)]),
        (8, [(0,1),(2,3),(4,5)], [(0,2,4),(1,6),(3,7)]),
        (5, [(0,1,2)], [(0,3),(1,4)]),
    ]
    grid=(Fraction(0),Fraction(1,8),Fraction(1,3),
          Fraction(2,3),Fraction(1))
    for n,blocks,residual in fixtures:
        outcomes=[]
        for z in grid:
            actual=brute_acceptance(n,blocks,residual,z)
            character=quotient_character_acceptance(n,blocks,residual,z)
            assert character==actual,(n,blocks,residual,z,character,actual)
            outcomes.append(actual)
        assert outcomes[0]==1
        assert outcomes[-1]==Fraction(1,2**len(residual))
        assert all(a>=b for a,b in zip(outcomes,outcomes[1:])),outcomes

        # Check an actual finite local-only sampler respects its known sphere
        # equations; no claim about residual equations or frequency accuracy.
        rng=Random(130)
        for _ in range(20):
            x=sample_local_only(tuple(range(n)),tuple(map(frozenset,blocks)),
                                Fraction(1,3),rng)
            assert all(sum(x[i] for i in block)%2==0 for block in blocks)

    for L in (1,2,3,5,8):
        x=source_level_two_inventory(L)
        z,budget=cold_gate(L)
        assert budget <= Fraction(3,2)
        assert z<=1
        if L<=2:
            # Stronger exact arithmetic check than the stated analytic
            # e^(3/2) < 5 bound: Zloc < 5 so expected attempts < 5.
            lower=exact_local_zero_lower_bound(L,z)
            assert lower>Fraction(1,5),("cold gate",L,lower)
        print("L=",L,"m=",x["syndrome_bits"],"c=",x["local_spheres"],
              "s=",x["sphere_size"],"f=",x["free_bits"],
              "d=",x["residual_rank"],"z_gate=",z,
              "logZ_upper_budget=",budget)
    print("BDL residual quotient Fourier, monotonicity and cold gate: PASS")


if __name__=="__main__":
    tests()
