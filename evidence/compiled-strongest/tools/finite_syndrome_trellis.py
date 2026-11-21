#!/usr/bin/env python3
"""Exact finite GF(2)-syndrome Gibbs sampler; complexity exposed by frontier width.

Executable finite-model theorem witness, NOT a polynomial sampler for the
Balasubramanian--Davydova--Lin 3D family absent a uniform width bound.
"""
from __future__ import annotations

from fractions import Fraction
from itertools import product
from random import Random
from typing import Callable, Iterable, Sequence


def left_nullspace_from_columns(m: int, columns: Sequence[Iterable[int]]) -> list[tuple[int, ...]]:
    """A complete parity presentation A of im(H), for H with m rows.

    Each column is a subset of syndrome coordinates toggled by one error.
    The output rows span ker(H^T), so ker(A) = im(H) over F2.
    """
    if m < 0:
        raise ValueError("m must be nonnegative")
    equations: list[int] = []
    for col in columns:
        indices = list(col)
        if len(indices) != len(set(indices)) or any(i < 0 or i >= m for i in indices):
            raise ValueError("column must contain distinct in-range indices")
        equations.append(sum(1 << i for i in indices))
    pivots: dict[int, int] = {}
    for row in equations:
        for pivot in sorted(pivots):
            if row & (1 << pivot):
                row ^= pivots[pivot]
        if row:
            pivots[(row & -row).bit_length() - 1] = row
    free = [i for i in range(m) if i not in pivots]
    basis: list[tuple[int, ...]] = []
    for f in free:
        solution = 1 << f
        for pivot in sorted(pivots, reverse=True):
            row = pivots[pivot]
            if ((row & ~(1 << pivot)) & solution).bit_count() % 2:
                solution ^= 1 << pivot
        basis.append(tuple(i for i in range(m) if solution & (1 << i)))
    return basis


def syndrome_preimage(m: int, columns: Sequence[Iterable[int]],
                      syndrome: Sequence[int]) -> tuple[int, ...]:
    """Find e with H*e=syndrome by polynomial GF(2) elimination, no oracle.

    The representative need not be minimum weight. A real preparation
    additionally needs a physical implementation of the Pauli operator.
    """
    if len(syndrome) != m or any(x not in (0, 1) for x in syndrome):
        raise ValueError("syndrome has wrong shape or non-binary entries")
    cols = []
    for col in columns:
        items = tuple(col)
        if len(items) != len(set(items)) or any(i < 0 or i >= m for i in items):
            raise ValueError("column must contain distinct in-range indices")
        cols.append(sum(1 << i for i in items))
    basis: dict[int, tuple[int, int]] = {}
    for j, v0 in enumerate(cols):
        v, coefficients = v0, 1 << j
        for pivot in sorted(basis):
            if v & (1 << pivot):
                bvec, bcoeff = basis[pivot]
                v ^= bvec
                coefficients ^= bcoeff
        if v:
            basis[(v & -v).bit_length() - 1] = (v, coefficients)
    residual = sum(bit << i for i, bit in enumerate(syndrome))
    solution = 0
    for pivot in sorted(basis):
        if residual & (1 << pivot):
            bvec, bcoeff = basis[pivot]
            residual ^= bvec
            solution ^= bcoeff
    if residual:
        raise ValueError("syndrome does not belong to im(H)")
    return tuple((solution >> j) & 1 for j in range(len(cols)))


class SyndromeTrellis:
    """Exact pi(sigma) proportional to z^weight(sigma) on ker(A).

    z must be a strictly positive rational. For m sites and frontier width
    w, arithmetic operation count is O(poly(m,r)*2^w); numerator/denominator
    bit cost remains polynomial for rational z of polynomial input length.
    This width must be measured/bounded for any proposed code family.
    """
    def __init__(self, m: int, checks: Sequence[Iterable[int]],
                 fugacity: Fraction, order: Sequence[int] | None = None):
        if m < 0 or fugacity <= 0:
            raise ValueError("m>=0 and fugacity>0 required")
        self.m = m
        self.z = Fraction(fugacity)
        self.order = list(range(m)) if order is None else list(order)
        if sorted(self.order) != list(range(m)):
            raise ValueError("order must be a permutation of all syndrome positions")
        where = {orig: pos for pos, orig in enumerate(self.order)}
        self.rows = []
        for check in checks:
            orig = list(check)
            if len(orig) != len(set(orig)) or any(i not in where for i in orig):
                raise ValueError("check has duplicate or unknown variable")
            if orig:
                self.rows.append(tuple(sorted(where[i] for i in orig)))
        self.end_here: list[list[int]] = [[] for _ in range(m)]
        self.touches: list[list[int]] = [[] for _ in range(m)]
        first_last = []
        for j, row in enumerate(self.rows):
            first_last.append((row[0], row[-1]))
            self.end_here[row[-1]].append(j)
            for i in row:
                self.touches[i].append(j)
        # After i sites: parity rows whose supports cross the prefix/suffix cut.
        self.frontiers = [
            tuple(j for j, (start, end) in enumerate(first_last) if start < i <= end)
            for i in range(m + 1)
        ]
        self.width = max(map(len, self.frontiers), default=0)
        self._messages: list[dict[tuple[int, ...], Fraction]] | None = None

    def transition(self, i: int, state: tuple[int, ...], bit: int) -> tuple[int, ...] | None:
        if bit not in (0, 1) or len(state) != len(self.frontiers[i]):
            raise ValueError("wrong bit/state shape")
        partial = dict(zip(self.frontiers[i], state))
        if bit:
            for row in self.touches[i]:
                partial[row] = partial.get(row, 0) ^ 1
        for row in self.end_here[i]:
            if partial.get(row, 0):
                return None
            partial.pop(row, None)
        return tuple(partial.get(row, 0) for row in self.frontiers[i + 1])

    def build_messages(self) -> Fraction:
        table: list[dict[tuple[int, ...], Fraction]] = [{} for _ in range(self.m + 1)]
        table[self.m][()] = Fraction(1)
        for i in range(self.m - 1, -1, -1):
            for state in product((0, 1), repeat=len(self.frontiers[i])):
                weight = Fraction(0)
                for bit, factor in ((0, Fraction(1)), (1, self.z)):
                    nxt = self.transition(i, state, bit)
                    if nxt is not None:
                        weight += factor * table[i + 1].get(nxt, Fraction(0))
                table[i][state] = weight
        self._messages = table
        return table[0][()]

    @property
    def partition(self) -> Fraction:
        if self._messages is None:
            self.build_messages()
        assert self._messages is not None
        return self._messages[0][()]

    def sample(self, rng: Random) -> tuple[int, ...]:
        _ = self.partition
        assert self._messages is not None
        state: tuple[int, ...] = ()
        processed = []
        for i in range(self.m):
            nxt0 = self.transition(i, state, 0)
            nxt1 = self.transition(i, state, 1)
            w0 = self._messages[i + 1].get(nxt0, Fraction(0)) if nxt0 is not None else Fraction(0)
            w1 = self.z * self._messages[i + 1].get(nxt1, Fraction(0)) if nxt1 is not None else Fraction(0)
            if w0 + w1 <= 0:
                raise AssertionError("unreachable prefix state")
            q = w1 / (w0 + w1)
            bit = int(rng.randrange(q.denominator) < q.numerator)
            processed.append(bit)
            state = nxt1 if bit else nxt0
            assert state is not None
        assert state == ()
        result = [0] * self.m
        for i, bit in enumerate(processed):
            result[self.order[i]] = bit
        return tuple(result)

    def sample_conditional(self, rng: Random, stable: Callable[[tuple[int, ...]], bool],
                           max_attempts: int = 10000) -> tuple[tuple[int, ...], int]:
        """Exact pi(.|stable) conditional on success; a cap can cause failure.

        If an independently proven bound says pi(stable)>=3/4, the UNLIMITED
        repeat-until-accepted algorithm has expected attempts <=4/3. A call
        at the finite max_attempts cap can fail, but never returns a false
        sample. The stability predicate must be implemented/verified by caller.
        """
        for attempt in range(1, max_attempts + 1):
            x = self.sample(rng)
            if stable(x):
                return x, attempt
        raise RuntimeError("conditional rejection cap reached; no sample returned")


def is_valid(bits: Sequence[int], checks: Sequence[Iterable[int]]) -> bool:
    return all(sum(bits[i] for i in row) % 2 == 0 for row in checks)


def brute_partition(m: int, checks: Sequence[Iterable[int]], z: Fraction) -> Fraction:
    return sum((z ** sum(x) for x in product((0, 1), repeat=m) if is_valid(x, checks)), Fraction(0))


if __name__ == '__main__':
    import unittest

    class ExactSamplerTests(unittest.TestCase):
        def test_complete_kernel_representation(self):
            cols = [(0, 1), (1, 2)]
            a = left_nullspace_from_columns(3, cols)
            self.assertEqual(a, [(0, 1, 2)])
            for y in product((0, 1), repeat=3):
                in_image = any(
                    tuple((e[0]*int(i in cols[0]) + e[1]*int(i in cols[1])) % 2
                          for i in range(3)) == y
                    for e in product((0, 1), repeat=2))
                self.assertEqual(is_valid(y, a), in_image)

        def test_preimage_without_oracle(self):
            cols = [(0, 1), (1, 2), (0, 1)]
            for y in product((0, 1), repeat=3):
                if sum(y) % 2:
                    with self.assertRaises(ValueError):
                        syndrome_preimage(3, cols, y)
                else:
                    e = syndrome_preimage(3, cols, y)
                    result = tuple(
                        sum(e[j] for j, col in enumerate(cols) if i in col) % 2
                        for i in range(3))
                    self.assertEqual(result, y)

        def test_rank_deficient_image(self):
            cols = [(0, 1), (0, 1), ()]
            a = left_nullspace_from_columns(3, cols)
            self.assertEqual(len(a), 2)
            self.assertEqual(sum(is_valid(x, a) for x in product((0, 1), repeat=3)), 2)

        def test_exact_trellis_against_enumeration(self):
            examples = [([], 4), ([(0, 1, 2)], 3), ([(0, 1), (2, 3)], 4),
                        ([(0, 1, 2), (1, 2, 3)], 4), ([(0,), (1, 2)], 3),
                        ([(0, 4), (1, 5), (2, 6), (3, 7)], 8)]
            for rows, m in examples:
                for z in (Fraction(1, 3), Fraction(3, 4), Fraction(2, 1)):
                    for order in (None, list(reversed(range(m)))):
                        sampler = SyndromeTrellis(m, rows, z, order)
                        self.assertEqual(sampler.partition, brute_partition(m, rows, z))
                        for i in range(40):
                            self.assertTrue(is_valid(sampler.sample(Random(i)), rows))

        def test_entire_output_law_exact_not_just_partition(self):
            rows = [(0, 1, 2), (1, 2, 3)]
            sampler = SyndromeTrellis(4, rows, Fraction(2, 5), [3, 1, 0, 2])
            z = sampler.partition
            for bits in product((0, 1), repeat=4):
                state = ()
                probability = Fraction(1)
                for i, orig in enumerate(sampler.order):
                    next0 = sampler.transition(i, state, 0)
                    next1 = sampler.transition(i, state, 1)
                    w0 = sampler._messages[i + 1].get(next0, Fraction(0)) if next0 is not None else Fraction(0)
                    w1 = sampler.z * sampler._messages[i + 1].get(next1, Fraction(0)) if next1 is not None else Fraction(0)
                    denom = w0 + w1
                    chosen = bits[orig]
                    probability *= (w1 if chosen else w0) / denom if denom else 0
                    state = next1 if chosen else next0
                    if state is None:
                        break
                expected = sampler.z ** sum(bits) / z if is_valid(bits, rows) else 0
                self.assertEqual(probability, expected)

        def test_order_matters_to_frontier_width(self):
            r = 6
            rows = [(i, r+i) for i in range(r)]
            bad = SyndromeTrellis(2*r, rows, Fraction(1, 2))
            good = SyndromeTrellis(2*r, rows, Fraction(1, 2),
                                   [j for i in range(r) for j in (i, i+r)])
            self.assertEqual(bad.width, r)
            self.assertEqual(good.width, 1)
            self.assertEqual(bad.partition, good.partition)
            self.assertEqual(good.partition, (1 + Fraction(1, 4)) ** r)

        def test_conditional_sampling_and_normalization(self):
            t = SyndromeTrellis(3, [], Fraction(1, 3))
            stable = lambda x: sum(x) <= 1
            self.assertEqual((1 + 3*Fraction(1, 3)) / t.partition, Fraction(27, 32))
            for i in range(100):
                x, count = t.sample_conditional(Random(i), stable)
                self.assertTrue(stable(x))
                self.assertGreaterEqual(count, 1)

        def test_validation(self):
            with self.assertRaises(ValueError):
                SyndromeTrellis(3, [(0, 0)], Fraction(1, 2))
            with self.assertRaises(ValueError):
                SyndromeTrellis(3, [(1,)], Fraction(1, 2), [2, 0, 0])

    unittest.main(verbosity=2)
