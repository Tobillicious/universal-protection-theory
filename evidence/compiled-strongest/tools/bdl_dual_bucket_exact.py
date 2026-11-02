#!/usr/bin/env python3
"""Exact Fourier-dual bucket elimination with evidence on PHYSICAL syndrome bits.

Let B_1...B_c be disjoint true parity checks, R_1...R_d the remaining
independent full-code rows. The character identity sums all B_i dual
choices analytically. For arbitrary fixed syndrome-bit evidence this
program evaluates Z_evidence by exact (possibly signed) rational factors.

A chosen primal elimination width w is an INPUT-dependent cost, not a
uniform theorem. This sampler is classical; no physical quantum encoding.
"""
from dataclasses import dataclass
from fractions import Fraction
from itertools import product
from random import Random


@dataclass(frozen=True)
class Factor:
    vars: tuple[int, ...]
    data: tuple[Fraction, ...]

    def __post_init__(self):
        assert tuple(sorted(set(self.vars))) == self.vars
        assert len(self.data) == (1 << len(self.vars))


def parity(x):
    return x.bit_count() & 1


def rank(rows):
    pivots = {}
    for v in rows:
        while v:
            pivot = v.bit_length() - 1
            if pivot in pivots:
                v ^= pivots[pivot]
            else:
                pivots[pivot] = v
                break
    return len(pivots)


def validate(m, blocks, residual):
    occupied = 0
    if m < 0:
        raise ValueError("negative syndrome dimension")
    for b in blocks:
        if b <= 0 or b >= (1 << m) or (occupied & b):
            raise ValueError("blocks must be disjoint and inside syndrome")
        occupied |= b
    if any(not 0 < v < (1 << m) for v in residual):
        raise ValueError("residual row outside syndrome or zero")
    if rank(list(blocks) + list(residual)) != len(blocks) + len(residual):
        raise ValueError("local plus residual parity rows are dependent")
    return occupied


def build_exact_factors(m, blocks, residual, z, evidence=None):
    """Build *all* exact evidence-conditioned Fourier-dual factors.

    For observed physical x_i=b, h_i(p)=z^b(-1)^(bp);
    for unobserved x_i, h_i(p)=1+z(-1)^p.
    Each disjoint true block B contributes
      [prod_i h_i(v_i)+prod_i h_i(v_i+1)]/2.
    Each remaining physical site contributes h_i(v_i).
    The residual-dual average 2^-d is applied after elimination.
    Evidence factors may have negative entries; signed Rat is essential.
    """
    z = Fraction(z)
    if z <= 0:
        raise ValueError("strictly positive rational fugacity required")
    evidence = {} if evidence is None else dict(evidence)
    if any(i < 0 or i >= m or b not in (0, 1)
           for i, b in evidence.items()):
        raise ValueError("invalid physical syndrome evidence")
    occupied = validate(m, blocks, residual)
    d = len(residual)
    col = [0] * m
    for j, row in enumerate(residual):
        while row:
            bit = row & -row
            col[bit.bit_length() - 1] |= 1 << j
            row -= bit

    def make_factor(indices, is_block):
        positions = tuple(sorted(
            j for j in range(d) if any((col[i] >> j) & 1 for i in indices)
        ))
        coeffs = [
            sum(1 << j for j, k in enumerate(positions) if (col[i] >> k) & 1)
            for i in indices
        ]
        values = []
        for assignment in range(1 << len(positions)):
            vbits = [parity(assignment & coeff) for coeff in coeffs]

            def term(flip):
                out = Fraction(1)
                for i, bit0 in zip(indices, vbits):
                    bit = bit0 ^ flip
                    if i in evidence:
                        if evidence[i]:
                            out *= -z if bit else z
                    else:
                        out *= (1 - z) if bit else (1 + z)
                return out

            values.append(
                (term(0) + term(1)) / 2 if is_block else term(0)
            )
        return Factor(positions, tuple(values))

    factors = []
    for block in blocks:
        indices = [i for i in range(m) if (block >> i) & 1]
        factors.append(make_factor(indices, True))
    for i in range(m):
        if not (occupied >> i) & 1:
            factors.append(make_factor((i,), False))
    return factors, d


def primal_graph(factors, d):
    adjacency = [0] * d
    for factor in factors:
        scope = sum(1 << j for j in factor.vars)
        for j in factor.vars:
            adjacency[j] |= scope & ~(1 << j)
    return adjacency


def minfill_order(adjacency):
    a = list(adjacency)
    remaining = set(range(len(a)))
    order = []
    while remaining:
        def score(i):
            neighbors = a[i]
            k = neighbors.bit_count()
            existing_twice = sum(
                (a[j] & neighbors).bit_count()
                for j in remaining if (neighbors >> j) & 1
            )
            return ((k * (k - 1) - existing_twice) // 2, k, i)

        i = min(remaining, key=score)
        order.append(i)
        neighbors = a[i]
        for j in remaining:
            if (neighbors >> j) & 1:
                a[j] = (a[j] | (neighbors & ~(1 << j))) & ~(1 << i)
        a[i] = 0
        remaining.remove(i)
    return order


def exact_bucket_sum(factors, d, order=None, max_width=None):
    """Exact rational sum-product over all d dual coefficient variables.

    Raises rather than exceed a user-specified elimination-width budget.
    Complexity: sum of 2^bag-size table entries, plus factor multiplications
    and rational bit arithmetic. Does NOT quietly drop big factors.
    """
    factors = list(factors)
    if order is None:
        order = minfill_order(primal_graph(factors, d))
    if sorted(order) != list(range(d)):
        raise ValueError("not an elimination permutation")
    scalar = Fraction(1)
    maximum = 0
    entries = 0
    for v in order:
        bucket = [f for f in factors if v in f.vars]
        factors = [f for f in factors if v not in f.vars]
        if not bucket:
            scalar *= 2
            continue
        union = tuple(sorted(set(j for f in bucket for j in f.vars)))
        outer = tuple(j for j in union if j != v)
        k = len(union)
        maximum = max(maximum, k - 1)
        entries += 1 << k
        if max_width is not None and k - 1 > max_width:
            raise RuntimeError("certified width budget exceeded")
        where = {j: i for i, j in enumerate(union)}
        indexed = [(f, tuple(where[j] for j in f.vars)) for f in bucket]
        outer_idx = [where[j] for j in outer]
        vbit = 1 << where[v]
        data = []
        for state in range(1 << len(outer)):
            base = sum(((state >> i) & 1) << j
                       for i, j in enumerate(outer_idx))
            total = Fraction(0)
            for full in (base, base | vbit):
                value = Fraction(1)
                for factor, indices in indexed:
                    which = sum(((full >> j) & 1) << i
                                for i, j in enumerate(indices))
                    value *= factor.data[which]
                    if not value:
                        break
                total += value
            data.append(total)
        if not outer:
            scalar *= data[0]
        else:
            factors.append(Factor(outer, tuple(data)))
    if any(f.vars for f in factors):
        raise AssertionError("uneliminated dual variable")
    for f in factors:
        scalar *= f.data[0]
    return scalar, maximum, entries


def evidence_partition(m, blocks, residual, z, evidence=None,
                       order=None, max_width=None):
    factors, d = build_exact_factors(m, blocks, residual, z, evidence)
    total, width, entries = exact_bucket_sum(
        factors, d, order=order, max_width=max_width
    )
    return total / (1 << d), width, entries


def exact_syndrome_sample(m, blocks, residual, z, rng, max_width=None):
    """Sequentially sample the ORIGINAL physical syndrome, exactly.

    This can be slow: up to m+1 exact dual partition evaluations;
    no claimed guarantee of polynomial time without a WIDTH certificate.
    """
    evidence = {}
    normalizer, _, _ = evidence_partition(
        m, blocks, residual, z, max_width=max_width
    )
    if normalizer <= 0:
        raise AssertionError("positive fugacity requires nonzero Z")
    for i in range(m):
        with_one, _, _ = evidence_partition(
            m, blocks, residual, z, {**evidence, i: 1},
            max_width=max_width
        )
        p = with_one / normalizer
        if not 0 <= p <= 1:
            raise AssertionError("exact conditional probability outside [0,1]")
        bit = int(rng.randrange(p.denominator) < p.numerator)
        evidence[i] = bit
        normalizer = with_one if bit else normalizer - with_one
    assert normalizer == Fraction(z) ** sum(evidence.values())
    return tuple(evidence[i] for i in range(m))


def brute_partition(m, blocks, residual, z, evidence):
    z = Fraction(z)
    return sum(
        (z ** x.bit_count()
         for x in range(1 << m)
         if all(parity(x & row) == 0 for row in list(blocks) + list(residual))
         and all(((x >> i) & 1) == bit for i, bit in evidence.items())),
        Fraction(0)
    )


def tests():
    def mask(indices):
        return sum(1 << i for i in indices)

    examples = [
        (6, [mask([0,1]), mask([2,3])],
            [mask([0,2,4]), mask([1,3,5])]),
        (7, [mask([0,1,2])],
            [mask([1,3,4]), mask([2,4,5]), mask([0,5,6])]),
        (8, [mask([0,1]), mask([2,3,4])],
            [mask([1,5,7]), mask([0,3,6])]),
    ]
    for m, blocks, residual in examples:
        validate(m, blocks, residual)
        for z in (Fraction(1,3), Fraction(3,4), Fraction(1)):
            for evidence in ({}, {0:1}, {0:0, 3:1},
                             {i:(i%2) for i in range(m)}):
                actual, _, _ = evidence_partition(
                    m, blocks, residual, z, evidence
                )
                expected = brute_partition(
                    m, blocks, residual, z, evidence
                )
                assert actual == expected, (m, z, evidence, actual, expected)
            for seed in range(3):
                bits = exact_syndrome_sample(
                    m, blocks, residual, z, Random(seed)
                )
                word = sum(bit << i for i, bit in enumerate(bits))
                assert all(parity(word & row) == 0
                           for row in blocks + residual)
    print("Exact evidence-conditioned dual elimination and syndrome sampling: PASS")


if __name__ == "__main__":
    tests()
