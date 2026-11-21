#!/usr/bin/env python3
"""Exact finite Gibbs sampling with the minimal parity-state dimension.

For an ordered binary parity map A, cut i has states
im(A_prefix) intersect im(A_suffix), of dimension
rank(A_prefix) + rank(A_suffix) - rank(A).
The runtime is polynomial times 2**max(cut_dimensions), not necessarily
polynomial on the BDL family. No constraints or syndrome coordinates are
discarded. Python 3.9+; standard library only.
"""
from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from random import Random
from typing import Callable, Iterable, Sequence


def linear_basis(vectors: Iterable[int]) -> tuple[int, ...]:
    """Canonical reduced GF(2) basis, with decreasing pivot positions."""
    pivots: dict[int, int] = {}
    for value in vectors:
        if not isinstance(value, int) or value < 0:
            raise ValueError("binary vectors must be nonnegative integer masks")
        for pivot in sorted(pivots, reverse=True):
            if value & (1 << pivot):
                value ^= pivots[pivot]
        if value:
            pivot = value.bit_length() - 1
            for old in pivots:
                if pivots[old] & (1 << pivot):
                    pivots[old] ^= value
            pivots[pivot] = value
    return tuple(pivots[p] for p in sorted(pivots, reverse=True))


def intersection_basis(left: Sequence[int], right: Sequence[int]) -> tuple[int, ...]:
    """Compute the intersection without enumerating either ambient span."""
    left = linear_basis(left)
    right = linear_basis(right)
    pivots: dict[int, tuple[int, int]] = {}
    common = []
    for j, original in enumerate(left + right):
        value, combination = original, 1 << j
        for pivot in sorted(pivots, reverse=True):
            if value & (1 << pivot):
                row, origin = pivots[pivot]
                value ^= row
                combination ^= origin
        if value:
            pivots[value.bit_length() - 1] = value, combination
        else:
            image = 0
            for k, row in enumerate(left):
                if combination & (1 << k):
                    image ^= row
            common.append(image)
    return linear_basis(common)


def span_elements(basis: Sequence[int]) -> tuple[int, ...]:
    """Enumerate a span; called only after the explicit state-budget check."""
    elements = [0]
    for row in basis:
        elements += [x ^ row for x in elements]
    return tuple(sorted(elements))


def ordered_columns(m: int, checks: Sequence[Iterable[int]],
                    order: Sequence[int] | None = None
                    ) -> tuple[tuple[int, ...], tuple[int, ...]]:
    if not isinstance(m, int) or m < 0:
        raise ValueError("m must be a nonnegative integer")
    permutation = tuple(range(m)) if order is None else tuple(order)
    if (any(not isinstance(i, int) for i in permutation)
            or sorted(permutation) != list(range(m))):
        raise ValueError("order must be a permutation of syndrome coordinates")
    columns = [0] * m
    for j, check in enumerate(checks):
        row = tuple(check)
        if (len(row) != len(set(row))
                or any(not isinstance(i, int) or i < 0 or i >= m for i in row)):
            raise ValueError("check has duplicate or out-of-range coordinates")
        for i in row:
            columns[i] |= 1 << j
    return permutation, tuple(columns[i] for i in permutation)


@dataclass(frozen=True)
class RankProfile:
    row_rank: int
    cut_dimensions: tuple[int, ...]

    @property
    def width(self) -> int:
        return max(self.cut_dimensions, default=0)

    @property
    def total_states(self) -> int:
        return sum(1 << d for d in self.cut_dimensions)


@dataclass(frozen=True)
class DyadicDraw:
    output: tuple[int, ...]
    coin_words: tuple[int, ...]
    bits_per_word: int


@dataclass(frozen=True)
class ConditionalDyadicDraw:
    output: tuple[int, ...] | None
    attempts: tuple[DyadicDraw, ...]


def cut_bases(columns: Sequence[int]) -> tuple[RankProfile, tuple[tuple[int, ...], ...]]:
    """Polynomial preprocessing; no enumeration of exponential-size spans."""
    m = len(columns)
    prefix: list[tuple[int, ...]] = [()]
    for col in columns:
        prefix.append(linear_basis(prefix[-1] + (col,)))
    suffix: list[tuple[int, ...]] = [()] * (m + 1)
    for i in range(m - 1, -1, -1):
        suffix[i] = linear_basis(suffix[i + 1] + (columns[i],))
    rank = len(prefix[-1])
    dimensions = tuple(len(prefix[i]) + len(suffix[i]) - rank for i in range(m + 1))
    common = tuple(intersection_basis(prefix[i], suffix[i]) for i in range(m + 1))
    if any(len(basis) != d for basis, d in zip(common, dimensions)):
        raise AssertionError("intersection dimension disagrees with independent rank identity")
    return RankProfile(rank, dimensions), common


def parity_rank_profile(m: int, checks: Sequence[Iterable[int]],
                        order: Sequence[int] | None = None) -> RankProfile:
    """Analyse a candidate order before allocating any trellis states."""
    _, columns = ordered_columns(m, checks, order)
    return cut_bases(columns)[0]


def generator_rank_profile(m: int, error_columns: Sequence[Iterable[int]],
                          order: Sequence[int] | None = None) -> RankProfile:
    """Same cut dimensions directly from C=im(H), without metacheck extraction.

    Input columns of H are the syndrome subsets toggled by individual errors.
    The returned row_rank is rank(H), not the rank of a parity presentation.
    """
    permutation, columns = ordered_columns(m, error_columns, order)
    # ordered_columns treats each supplied subset as a row: the resulting
    # vectors are exactly the ordered ROWS of H, living in error-coordinate space.
    del permutation
    return cut_bases(columns)[0]


class RankSyndromeTrellis:
    """Exact z**weight law on ker(A), with minimal ordered parity states.

    The default resource cap raises before allocation; it never truncates the
    distribution. Set max_states_per_cut=None to remove this engineering cap.
    Sampling uses exact rational probabilities and an ideal unbiased RNG API;
    coin generation has expected polynomial bit cost, not a pathwise bit cap.
    """
    def __init__(self, m: int, checks: Sequence[Iterable[int]], fugacity: Fraction,
                 order: Sequence[int] | None = None,
                 max_states_per_cut: int | None = 1 << 18):
        if not isinstance(fugacity, (Fraction, int)) or fugacity <= 0:
            raise ValueError("fugacity must be a strictly positive rational")
        if max_states_per_cut is not None and (
                not isinstance(max_states_per_cut, int) or max_states_per_cut < 1):
            raise ValueError("state cap must be positive or None")
        self.m = m
        self.z = Fraction(fugacity)
        self.order, self.columns = ordered_columns(m, checks, order)
        self.profile, bases = cut_bases(self.columns)
        if (max_states_per_cut is not None
                and (1 << self.profile.width) > max_states_per_cut):
            raise ValueError("exact trellis exceeds state cap; no approximation was made")
        self.states = tuple(span_elements(b) for b in bases)
        self._state_sets = tuple(frozenset(s) for s in self.states)
        self._messages: list[dict[int, Fraction]] | None = None

    @property
    def width(self) -> int:
        return self.profile.width

    def transition(self, i: int, state: int, bit: int) -> int | None:
        if not 0 <= i < self.m or bit not in (0, 1) or state not in self._state_sets[i]:
            raise ValueError("invalid cut, state, or bit")
        following = state ^ self.columns[i] if bit else state
        return following if following in self._state_sets[i + 1] else None

    def build_messages(self) -> Fraction:
        table: list[dict[int, Fraction]] = [{} for _ in range(self.m + 1)]
        table[self.m][0] = Fraction(1)
        for i in range(self.m - 1, -1, -1):
            for state in self.states[i]:
                value = Fraction(0)
                for bit, factor in ((0, Fraction(1)), (1, self.z)):
                    following = self.transition(i, state, bit)
                    if following is not None:
                        value += factor * table[i + 1][following]
                if value <= 0:
                    raise AssertionError("constructed state must be reachable and completable")
                table[i][state] = value
        self._messages = table
        return table[0][0]

    @property
    def partition(self) -> Fraction:
        if self._messages is None:
            self.build_messages()
        assert self._messages is not None
        return self._messages[0][0]

    def branch_weights(self, i: int, state: int) -> tuple[Fraction, Fraction]:
        _ = self.partition
        assert self._messages is not None
        following0 = self.transition(i, state, 0)
        following1 = self.transition(i, state, 1)
        weights = self._messages[i + 1]
        return (weights[following0] if following0 is not None else Fraction(0),
                self.z * weights[following1] if following1 is not None else Fraction(0))

    def probability(self, bits: Sequence[int]) -> Fraction:
        """Compute the law induced by the actual conditional branch weights."""
        if len(bits) != self.m or any(bit not in (0, 1) for bit in bits):
            raise ValueError("sample must have m binary entries")
        probability = Fraction(1)
        state = 0
        for i, original in enumerate(self.order):
            w0, w1 = self.branch_weights(i, state)
            bit = bits[original]
            following = self.transition(i, state, bit)
            if following is None:
                return Fraction(0)
            probability *= (w1 if bit else w0) / (w0 + w1)
            state = following
        return probability

    def sample(self, rng: Random) -> tuple[int, ...]:
        result = [0] * self.m
        state = 0
        for i, original in enumerate(self.order):
            w0, w1 = self.branch_weights(i, state)
            probability1 = w1 / (w0 + w1)
            bit = int(rng.randrange(probability1.denominator) < probability1.numerator)
            following = self.transition(i, state, bit)
            assert following is not None
            result[original] = bit
            state = following
        assert state == 0
        return tuple(result)

    def _coin_bits(self, coin_bits: int | None) -> int:
        if coin_bits is None:
            return (8 * max(1, self.m) - 1).bit_length()
        if not isinstance(coin_bits, int) or coin_bits < 0:
            raise ValueError("coin_bits must be nonnegative")
        return coin_bits

    @staticmethod
    def _dyadic_probability1(w0: Fraction, w1: Fraction, b: int) -> Fraction:
        """Round the less likely branch down; never enlarge a rare branch."""
        exact = w1 / (w0 + w1)
        rare = min(exact, 1 - exact)
        grid = 1 << b
        rounded = Fraction((rare.numerator * grid) // rare.denominator, grid)
        return rounded if exact <= Fraction(1, 2) else 1 - rounded

    def dyadic_overhead(self, coin_bits: int | None = None) -> Fraction:
        """Certified pointwise factor relative to the exact Gibbs law."""
        b = self._coin_bits(coin_bits)
        return (1 + Fraction(2, 1 << b)) ** self.m

    def dyadic_tv_bound(self, coin_bits: int | None = None) -> Fraction:
        b = self._coin_bits(coin_bits)
        return min(Fraction(1), Fraction(self.m, 1 << b))

    def fugacity_interval_factor(self, lower: Fraction, upper: Fraction,
                                 coin_bits: int | None = None) -> Fraction:
        """One-sided warm-start bound against every real z in [lower, upper].

        The endpoints and the proposal fugacity are rational certificates.
        The actual thermal fugacity need not be rational. Physical calibration
        or a verified exponential enclosure must establish its interval.
        """
        if (not isinstance(lower, (int, Fraction))
                or not isinstance(upper, (int, Fraction)) or not 0 < lower <= upper):
            raise ValueError("positive ordered rational interval required")
        ratio = max(Fraction(1), self.z/Fraction(lower), Fraction(upper)/self.z)
        return self.dyadic_overhead(coin_bits) * ratio**self.m

    def dyadic_probability(self, bits: Sequence[int],
                          coin_bits: int | None = None) -> Fraction:
        if len(bits) != self.m or any(bit not in (0, 1) for bit in bits):
            raise ValueError("sample must have m binary entries")
        b = self._coin_bits(coin_bits)
        probability, state = Fraction(1), 0
        for i, original in enumerate(self.order):
            p1 = self._dyadic_probability1(*self.branch_weights(i, state), b)
            bit = bits[original]
            following = self.transition(i, state, bit)
            if following is None:
                return Fraction(0)
            probability *= p1 if bit else 1 - p1
            state = following
        return probability

    def replay_dyadic(self, coin_words: Sequence[int],
                      coin_bits: int | None = None) -> tuple[int, ...]:
        b = self._coin_bits(coin_bits)
        grid = 1 << b
        if len(coin_words) != self.m or any(
                not isinstance(x, int) or not 0 <= x < grid for x in coin_words):
            raise ValueError("one in-range coin word required per coordinate")
        result, state = [0] * self.m, 0
        for i, original in enumerate(self.order):
            p1 = self._dyadic_probability1(*self.branch_weights(i, state), b)
            threshold = p1.numerator * grid // p1.denominator
            bit = int(coin_words[i] < threshold)
            following = self.transition(i, state, bit)
            assert following is not None
            result[original] = bit
            state = following
        assert state == 0
        return tuple(result)

    def sample_dyadic(self, rng: Random, coin_bits: int | None = None) -> DyadicDraw:
        """Pathwise fixed coin count and retained transcript.

        At default precision, output law <= (4/3)*pi pointwise and
        TV(output, pi) <= 1/8. Work has a deterministic bound once the
        rank-width and rational-input bounds are supplied. No rejection
        or mixing oracle is used.
        """
        b = self._coin_bits(coin_bits)
        coins = tuple(rng.getrandbits(b) for _ in range(self.m))
        return DyadicDraw(self.replay_dyadic(coins, b), coins, b)

    def sample_conditional_dyadic(
            self, rng: Random, stable: Callable[[tuple[int, ...]], bool],
            max_attempts: int, coin_bits: int | None = None) -> ConditionalDyadicDraw:
        """Retain all failed attempts; return an explicit charged failure.

        If pi(stable)>=3/4, default coins give proposal acceptance >=2/3,
        cap-failure probability <=(1/3)**max_attempts, and the conditional
        successful law <=2*pi. These bounds require the actual stable
        predicate and its independently established Gibbs-mass certificate.
        """
        if not isinstance(max_attempts, int) or max_attempts < 1:
            raise ValueError("max_attempts must be positive")
        transcript = []
        for _ in range(max_attempts):
            draw = self.sample_dyadic(rng, coin_bits)
            transcript.append(draw)
            if stable(draw.output):
                return ConditionalDyadicDraw(draw.output, tuple(transcript))
        return ConditionalDyadicDraw(None, tuple(transcript))

    def sample_conditional(self, rng: Random, stable: Callable[[tuple[int, ...]], bool],
                           max_attempts: int = 10000) -> tuple[tuple[int, ...], int]:
        """Exact conditional law on success; the finite attempt cap can fail."""
        if not isinstance(max_attempts, int) or max_attempts < 1:
            raise ValueError("max_attempts must be positive")
        for attempt in range(1, max_attempts + 1):
            value = self.sample(rng)
            if stable(value):
                return value, attempt
        raise RuntimeError("conditional rejection cap reached; no sample returned")
