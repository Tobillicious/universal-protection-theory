#!/usr/bin/env python3
"""Finite BDL Definition-5.1 stability and linear-event conditioning interface.

A decoder must be supplied and validated; an arbitrary coarse map is NOT
assumed to satisfy BDL Lemma 5.2 or to be linear.
"""
from fractions import Fraction
from random import Random
from typing import Callable, Iterable, Sequence

from finite_syndrome_trellis import SyndromeTrellis, left_nullspace_from_columns, syndrome_preimage


def apply_columns(dim: int, columns: Sequence[Iterable[int]], coefficients: Sequence[int]) -> tuple[int, ...]:
    if len(columns) != len(coefficients):
        raise ValueError("wrong coefficient length")
    result = [0] * dim
    for bit, col in zip(coefficients, columns):
        if bit not in (0, 1):
            raise ValueError("nonbinary error vector")
        if bit:
            for i in col:
                if not 0 <= i < dim:
                    raise ValueError("column index outside domain")
                result[i] ^= 1
    return tuple(result)


def definition_5_1_stable(
    syndrome: tuple[int, ...],
    error_columns: Sequence[Iterable[int]],
    stabilizer_columns: Sequence[Iterable[int]],
    decoder: Callable[[tuple[int, ...]], Sequence[int]],
) -> bool:
    """BDL Definition 5.1, one CSS error sector, exact finite F2 test.

    H=δ1; G=δ0; f corrects syndrome, i.e. Hf(σ)=σ.
    Stable iff f(σ)+f(σ+Hej)+ej ∈ im(G) for EVERY weight-one error ej.
    The H*G=0 chain-complex equation and decoder validity are checked.
    Does NOT implement or substitute for BDL's published RG decoder.
    """
    m = len(syndrome)
    q = len(error_columns)
    if any(bit not in (0, 1) for bit in syndrome):
        raise ValueError("nonbinary syndrome")
    error_cols = [tuple(c) for c in error_columns]
    stabilizer_cols = [tuple(c) for c in stabilizer_columns]
    if any(apply_columns(m, error_cols, col) != (0,) * m for col in stabilizer_cols):
        raise ValueError("δ1 δ0 != 0: not a chain complex")

    def checked_decode(s: tuple[int, ...]) -> tuple[int, ...]:
        f = tuple(decoder(s))
        if len(f) != q or apply_columns(m, error_cols, f) != s:
            raise ValueError("decoder failed Hf(s)=s")
        return f

    f0 = checked_decode(syndrome)
    for j in range(q):
        shifted = tuple(
            a ^ b for a, b in zip(
                syndrome,
                apply_columns(m, error_cols, tuple(int(k == j) for k in range(q)))
            )
        )
        f1 = checked_decode(shifted)
        residual = tuple(f0[k] ^ f1[k] ^ int(k == j) for k in range(q))
        assert apply_columns(m, error_cols, residual) == (0,) * m
        try:
            syndrome_preimage(q, stabilizer_cols, residual)
        except ValueError:
            return False
    return True


def linear_zero_conditioned_sampler(m: int, error_columns: Sequence[Iterable[int]],
                                     coarse_rows: Sequence[Iterable[int]],
                                     fugacity: Fraction,
                                     order: Sequence[int] | None = None):
    """Exact π(. | Cσ=0) if a VERIFIED LINEAR coarse map C is supplied.

    Such linearity has not been proved here for the full BDL RG decoder.
    """
    base_rows = left_nullspace_from_columns(m, error_columns)
    original = SyndromeTrellis(m, base_rows, fugacity, order)
    conditioned = SyndromeTrellis(
        m, base_rows + [tuple(c) for c in coarse_rows], fugacity, order
    )
    return conditioned, conditioned.partition / original.partition


if __name__ == "__main__":
    import unittest

    class StabilityTests(unittest.TestCase):
        def test_definition_5_1_with_one_logical_bit(self):
            # Three-bit repetition complex: He=(e0+e1,e1+e2), G=0.
            h = [(0,), (0, 1), (1,)]
            d = {(0, 0):(0, 0, 0), (1, 0):(1, 0, 0),
                 (0, 1):(0, 0, 1), (1, 1):(0, 1, 0)}
            self.assertTrue(definition_5_1_stable((0, 0), h, [], lambda s:d[s]))
            self.assertFalse(definition_5_1_stable((1, 0), h, [], lambda s:d[s]))
            self.assertFalse(definition_5_1_stable((0, 1), h, [], lambda s:d[s]))
            self.assertFalse(definition_5_1_stable((1, 1), h, [], lambda s:d[s]))

        def test_stability_depends_on_specified_decoder(self):
            h = [(0,), (0, 1), (1,)]
            d = {(0, 0):(0, 0, 0), (1, 0):(1, 0, 0),
                 (0, 1):(0, 0, 1), (1, 1):(1, 0, 1)}
            self.assertFalse(definition_5_1_stable((0, 0), h, [], lambda s:d[s]))
            # An arbitrary always-zero coarse map would be unsound here.

        def test_rejects_bad_decoder_and_noncomplex(self):
            h = [(0,), (0, 1), (1,)]
            with self.assertRaises(ValueError):
                definition_5_1_stable((0, 0), h, [], lambda s:(1, 0, 0))
            with self.assertRaises(ValueError):
                definition_5_1_stable((0, 0), h, [(0,)], lambda s:(0, 0, 0))

        def test_linear_coarse_event_exact_mass_and_sampling(self):
            h = [(0, 1), (1, 2)]
            z = Fraction(1, 3)
            conditioned, mass = linear_zero_conditioned_sampler(3, h, [(0,)], z)
            self.assertEqual(mass, Fraction(5, 6))
            self.assertEqual(conditioned.partition, Fraction(10, 9))
            for seed in range(100):
                s = conditioned.sample(Random(seed))
                self.assertEqual(sum(s) % 2, 0)
                self.assertEqual(s[0], 0)
            self.assertLessEqual(Fraction(1, 1) / mass, Fraction(4, 3))

    unittest.main(verbosity=2)
