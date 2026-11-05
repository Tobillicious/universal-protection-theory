#!/usr/bin/env python3
"""BDL 3D paper's actual level-0 [[5,1,2]] Tanner seed fixture.

Source: arXiv:2605.10943v1, Eqs. (106)-(109) and Tanner-base.png.
This is NOT level 1/2, a Peierls stability test, or a 3D runtime proof.
"""
from fractions import Fraction
from random import Random
from itertools import product

from finite_syndrome_trellis import (
    SyndromeTrellis, left_nullspace_from_columns, syndrome_preimage
)
from bdl_stability_interface import apply_columns

# Five black Q vertices: NW, NE, CENTER, SW, SE.
# Blue X checks: top middle / bottom middle.
# Red Z checks: middle left / middle right.
X_CHECKS = ((0, 1, 2), (2, 3, 4))
Z_CHECKS = ((0, 2, 3), (1, 2, 4))
QUBITS = 5


def error_columns(checks):
    return [
        tuple(j for j, row in enumerate(checks) if i in row)
        for i in range(QUBITS)
    ]


def gf2_rank(cols):
    basis = {}
    for col in cols:
        row = sum(1 << i for i in col)
        for pivot in sorted(basis):
            if row & (1 << pivot):
                row ^= basis[pivot]
        if row:
            basis[(row & -row).bit_length() - 1] = row
    return len(basis)


def logical_distance(syndrome_checks, stabilizer_checks):
    h = error_columns(syndrome_checks)
    nontrivial_weights = []
    for e in product((0, 1), repeat=QUBITS):
        if apply_columns(len(syndrome_checks), h, e) != (
            0,
        ) * len(syndrome_checks):
            continue
        try:
            syndrome_preimage(QUBITS, stabilizer_checks, e)
        except ValueError:
            nontrivial_weights.append(sum(e))
    return min(nontrivial_weights)


def validate_seed():
    assert all(
        len(set(x) & set(z)) % 2 == 0
        for x in X_CHECKS for z in Z_CHECKS
    )
    assert gf2_rank(error_columns(X_CHECKS)) == 2
    assert gf2_rank(error_columns(Z_CHECKS)) == 2
    assert QUBITS - 2 - 2 == 1
    assert logical_distance(Z_CHECKS, X_CHECKS) == 2
    assert logical_distance(X_CHECKS, Z_CHECKS) == 2

    for checks in (X_CHECKS, Z_CHECKS):
        h = error_columns(checks)
        assert left_nullspace_from_columns(2, h) == []
        for sigma in product((0, 1), repeat=2):
            e = syndrome_preimage(2, h, sigma)
            assert apply_columns(2, h, e) == sigma
        for z in (Fraction(1, 3), Fraction(1, 9)):
            sampler = SyndromeTrellis(2, [], z)
            assert sampler.width == 0
            assert sampler.partition == (1 + z) ** 2
            for i in range(30):
                s = sampler.sample(Random(i))
                assert apply_columns(2, h, syndrome_preimage(2, h, s)) == s


if __name__ == "__main__":
    validate_seed()
    print("BDL level-0 [[5,1,2]] Tanner seed: CSS, distances and exact Gibbs sectors PASS")
