#!/usr/bin/env python3
"""Symbolic first-R_X seed syndrome law and its five-parity-block sampler.

The theorem concerns PR215's cellular replacement of the five-qubit seed,
for every integer L>=1. It is not an all-level BDL initialization theorem.
No full matrix is needed for counts, partition formulas, or block sampling.
"""
from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from random import Random
from typing import Sequence


MASKS = (1, 2, 3, 4, 5)


def first_replacement_parameters(L: int) -> dict:
    """Exact symbolic sizes; safe even when explicit matrices are enormous."""
    if not isinstance(L, int) or L < 1:
        raise ValueError("L must be a positive integer")
    return {
        "L": L, "ell": 2*L+1,
        "qubits": 16*L*L+32*L+12,
        "X_checks": 8*L*L+12*L+4,
        "Z_checks": 8*L*L+20*L+10,
        "X_error_zero_columns": 8*L*L+12*L,
        "X_error_nonzero_block_sizes": (8*L, 4, 1, 4, 1),
        "X_error_metacheck_rank": 3,
        "Z_error_metacheck_rank": 0,
    }


def seed_first_metacheck_column(label) -> int:
    """Read the proved three metachecks from the actual source cell label."""
    if label[0] == "xf":
        _, x, face = label
        if x not in ("x0", "x1"):
            raise ValueError("not a first replacement of the named seed")
        if face[0] == "bulk":
            return 0
        if face[0] == "seam":
            return 1 if face[2] == "q2" else 0
    elif label[0] == "qe":
        _, q, endpoints = label
        if q not in ("q0", "q1", "q2", "q3", "q4"):
            raise ValueError("unknown seed qubit")
        u, v = endpoints
        if u[0] == v[0]:
            return 1 if q == "q2" else 0
        if u[1] != v[1] or u[1][0] != "v":
            raise ValueError("invalid boundary-cylinder edge")
        z = u[1][1]
        if z not in ("z0", "z1"):
            raise ValueError("unknown seed Z vertex")
        return (3 if z == "z0" else 5) if q == "q2" else (2 if z == "z0" else 4)
    elif label[0] == "zv":
        if label[1] in ("z0", "z1") and label[2] in (0, 1):
            return 2 if label[1] == "z0" else 4
    raise ValueError("not a recognized first-replacement syndrome cell")


def parity_weights(length: int, z: Fraction) -> tuple[Fraction, Fraction]:
    """Even/odd full weight sums, with all normalization factors retained."""
    if (not isinstance(length, int) or length < 0
            or not isinstance(z, (Fraction, int)) or z <= 0):
        raise ValueError("nonnegative length and positive fugacity required")
    z = Fraction(z)
    plus, minus = (1+z)**length, (1-z)**length
    return (plus+minus)/2, (plus-minus)/2


def parity_table(length: int, z: Fraction) -> tuple[tuple[Fraction, Fraction], ...]:
    if (not isinstance(length, int) or length < 0
            or not isinstance(z, (Fraction, int)) or z <= 0):
        raise ValueError("nonnegative length and positive rational fugacity required")
    z = Fraction(z)
    even, odd = Fraction(1), Fraction(0)
    result = [(even, odd)]
    for _ in range(length):
        even, odd = even+z*odd, odd+z*even
        result.append((even, odd))
    return tuple(result)


@dataclass(frozen=True)
class BlockConfiguration:
    x_free: tuple[int, ...]
    x_blocks: tuple[tuple[int, ...], ...]  # masks 1,2,3,4,5, in that order
    z_free: tuple[int, ...]

    @property
    def weight(self) -> int:
        return sum(self.x_free) + sum(map(sum, self.x_blocks)) + sum(self.z_free)


@dataclass(frozen=True)
class BoundedBlockDraw:
    configuration: BlockConfiguration
    coin_words: tuple[int, ...]
    bits_per_word: int


class FiveParityBlockLaw:
    """Full binary law with the five actual column types, not parity-only data.

    Quotient patterns are (u xor v,u,u,v,v). Full within-block strings are
    sampled at their conditional Gibbs weight, so original labels are retained.
    """
    def __init__(self, lengths: Sequence[int], x_free: int, z_free: int,
                 z: Fraction, max_coordinates: int | None = 1_000_000):
        self.lengths = tuple(lengths)
        if len(self.lengths) != 5 or any(not isinstance(k, int) or k < 1 for k in self.lengths):
            raise ValueError("five positive block lengths required")
        if any(not isinstance(k, int) or k < 0 for k in (x_free, z_free)):
            raise ValueError("free-coordinate counts must be nonnegative")
        if not isinstance(z, (Fraction, int)) or z <= 0:
            raise ValueError("strictly positive rational fugacity required")
        self.x_free, self.z_free, self.z = x_free, z_free, Fraction(z)
        self.coordinates = x_free+z_free+sum(self.lengths)
        if max_coordinates is not None and (
                not isinstance(max_coordinates, int) or max_coordinates < 1
                or self.coordinates > max_coordinates):
            raise ValueError("explicit output exceeds coordinate cap; use symbolic parameters")
        self.decisions = self.coordinates+2
        self._tails = {k: parity_table(k, self.z) for k in set(self.lengths)}
        self._weights = [self._tails[k][-1] for k in self.lengths]
        self.macro_weights = {
            (u, v): self._weights[0][u ^ v] * self._weights[1][u]
            * self._weights[2][u] * self._weights[3][v] * self._weights[4][v]
            for u in (0, 1) for v in (0, 1)
        }

    @classmethod
    def first_replacement(cls, L: int, z: Fraction,
                          max_coordinates: int | None = 1_000_000):
        p = first_replacement_parameters(L)
        return cls(p["X_error_nonzero_block_sizes"], p["X_error_zero_columns"],
                   p["X_checks"], z, max_coordinates)

    @property
    def partition(self) -> Fraction:
        return (1+self.z)**(self.x_free+self.z_free) * sum(self.macro_weights.values())

    def _bits(self, bits: int | None) -> int:
        if bits is None:
            return (8*self.decisions-1).bit_length()
        if not isinstance(bits, int) or bits < 0:
            raise ValueError("coin bit count must be nonnegative")
        return bits

    def domination_factor(self, bits: int | None = None) -> Fraction:
        return (1+Fraction(2, 1 << self._bits(bits)))**self.decisions

    @staticmethod
    def _rounded(q: Fraction, bits: int) -> Fraction:
        grid = 1 << bits
        rare = min(q, 1-q)
        p = Fraction(rare.numerator*grid//rare.denominator, grid)
        return p if q <= Fraction(1, 2) else 1-p

    def _walk(self, choose) -> BlockConfiguration:
        w = self.macro_weights
        u = choose((w[1, 0]+w[1, 1])/sum(w.values()))
        v = choose(w[u, 1]/(w[u, 0]+w[u, 1]))
        free_probability = self.z/(1+self.z)
        x_free = tuple(choose(free_probability) for _ in range(self.x_free))
        blocks = []
        for length, wanted in zip(self.lengths, (u ^ v, u, u, v, v)):
            tails = self._tails[length]
            block = []
            for remaining in range(length, 0, -1):
                p1 = self.z*tails[remaining-1][wanted ^ 1]/tails[remaining][wanted]
                bit = choose(p1)
                block.append(bit)
                wanted ^= bit
            assert wanted == 0
            blocks.append(tuple(block))
        z_free = tuple(choose(free_probability) for _ in range(self.z_free))
        return BlockConfiguration(x_free, tuple(blocks), z_free)

    def is_valid(self, config: BlockConfiguration) -> bool:
        if (len(config.x_free) != self.x_free or len(config.z_free) != self.z_free
                or len(config.x_blocks) != 5
                or tuple(map(len, config.x_blocks)) != self.lengths):
            return False
        if any(b not in (0, 1) for field in (config.x_free, *config.x_blocks, config.z_free)
               for b in field):
            return False
        a, b, c, d, e = (sum(block) % 2 for block in config.x_blocks)
        return a == (c ^ e) and b == c and d == e

    def sample_exact(self, rng: Random) -> BlockConfiguration:
        """Exact reference mode; rational-coin bit cost has an unbounded tail."""
        def choose(q):
            return int(rng.randrange(q.denominator) < q.numerator)
        return self._walk(choose)

    def replay(self, coins: Sequence[int], bits: int | None = None) -> BlockConfiguration:
        bits = self._bits(bits)
        grid = 1 << bits
        if len(coins) != self.decisions or any(
                not isinstance(c, int) or not 0 <= c < grid for c in coins):
            raise ValueError("one in-range coin word required for every decision")
        source = iter(coins)
        def choose(q):
            p = self._rounded(q, bits)
            threshold = p.numerator*grid//p.denominator
            return int(next(source) < threshold)
        return self._walk(choose)

    def sample_dyadic(self, rng: Random, bits: int | None = None) -> BoundedBlockDraw:
        bits = self._bits(bits)
        coins = tuple(rng.getrandbits(bits) for _ in range(self.decisions))
        return BoundedBlockDraw(self.replay(coins, bits), coins, bits)

    def probability(self, config: BlockConfiguration, bits: int | None = None,
                    dyadic: bool = False) -> Fraction:
        """Actual path law, including the two macro decisions and all raw bits."""
        if not self.is_valid(config):
            return Fraction(0)
        parities = tuple(sum(block) % 2 for block in config.x_blocks)
        choices = iter((parities[2], parities[4], *config.x_free,
                        *(b for block in config.x_blocks for b in block), *config.z_free))
        probability = Fraction(1)
        b = self._bits(bits)
        def choose(q):
            nonlocal probability
            bit = next(choices)
            p = self._rounded(q, b) if dyadic else q
            probability *= p if bit else 1-p
            return bit
        assert self._walk(choose) == config
        return probability

    def source_order_x(self, config: BlockConfiguration, syndrome_labels) -> tuple[int, ...]:
        if not self.is_valid(config):
            raise ValueError("invalid block configuration")
        groups = {0: config.x_free, **dict(zip(MASKS, config.x_blocks))}
        expected = {key: len(value) for key, value in groups.items()}
        used = {key: 0 for key in groups}
        result = []
        for label in syndrome_labels:
            key = seed_first_metacheck_column(label)
            if used[key] >= expected[key]:
                raise ValueError("source layout does not match the block law")
            result.append(groups[key][used[key]])
            used[key] += 1
        if used != expected:
            raise ValueError("incomplete source layout")
        return tuple(result)
