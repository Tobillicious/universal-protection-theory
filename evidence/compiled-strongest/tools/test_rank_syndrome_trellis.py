#!/usr/bin/env python3
"""Independent exact laws, residual-language counts, and finite-coin checks."""
from collections import Counter, defaultdict
from fractions import Fraction
from itertools import permutations, product
from random import Random
import unittest

from finite_syndrome_trellis import (
    SyndromeTrellis, left_nullspace_from_columns, syndrome_preimage,
)
from rank_syndrome_trellis import (
    RankSyndromeTrellis, generator_rank_profile, intersection_basis,
    linear_basis, parity_rank_profile, span_elements,
)


def valid(bits, rows):
    return all(sum(bits[i] for i in row) % 2 == 0 for row in rows)


def exact_law(m, rows, z):
    weights = {x: z ** sum(x) if valid(x, rows) else Fraction(0)
               for x in product((0, 1), repeat=m)}
    total = sum(weights.values(), Fraction(0))
    return total, {x: weight / total for x, weight in weights.items()}


def residual_language_counts(code, order):
    """No rank computation: count distinct possible-future sets at every cut."""
    answer = []
    words = [tuple(x[i] for i in order) for x in code]
    for cut in range(len(order) + 1):
        languages = defaultdict(set)
        for x in words:
            languages[x[:cut]].add(x[cut:])
        answer.append(len({frozenset(suffixes) for suffixes in languages.values()}))
    return tuple(answer)


class RankTrellisTests(unittest.TestCase):
    def test_linear_algebra_against_enumerated_spans(self):
        rng = Random(213)
        for _ in range(160):
            left = [rng.randrange(64) for _ in range(rng.randrange(7))]
            right = [rng.randrange(64) for _ in range(rng.randrange(7))]
            ls = set(span_elements(linear_basis(left)))
            rs = set(span_elements(linear_basis(right)))
            actual = set(span_elements(intersection_basis(left, right)))
            self.assertEqual(actual, ls & rs)
            self.assertEqual(linear_basis(left), linear_basis(reversed(left)))

    def test_all_small_parity_maps_entire_law_and_minimal_states(self):
        cases = 0
        for m in range(4):
            for r in range(4):
                for masks in product(range(1 << m), repeat=r):
                    rows = [tuple(i for i in range(m) if mask & (1 << i)) for mask in masks]
                    code = [x for x in product((0, 1), repeat=m) if valid(x, rows)]
                    for order in {tuple(range(m)), tuple(reversed(range(m)))}:
                        expected_states = residual_language_counts(code, order)
                        for z in (Fraction(1, 3), Fraction(3, 4), Fraction(2)):
                            sampler = RankSyndromeTrellis(m, rows, z, order)
                            partition, law = exact_law(m, rows, z)
                            self.assertEqual(sampler.partition, partition)
                            self.assertEqual(tuple(map(len, sampler.states)), expected_states)
                            self.assertEqual(
                                {x: sampler.probability(x) for x in law}, law)
                    cases += 1
        self.assertEqual(cases, 689)

    def test_comparison_with_original_sampler(self):
        rng = Random(214)
        for _ in range(80):
            m = rng.randrange(1, 8)
            rows = [tuple(i for i in range(m) if rng.randrange(2))
                    for _ in range(rng.randrange(7))]
            order = list(range(m))
            rng.shuffle(order)
            z = Fraction(rng.randrange(1, 5), rng.randrange(1, 6))
            original = SyndromeTrellis(m, rows, z, order)
            compressed = RankSyndromeTrellis(m, rows, z, order)
            self.assertEqual(original.partition, compressed.partition)
            self.assertLessEqual(compressed.width, original.width)
            for i in range(8):
                self.assertTrue(valid(compressed.sample(Random(i)), rows))

    def test_basis_invariance_and_redundant_checks(self):
        rng = Random(215)
        for _ in range(60):
            m, r = 7, 5
            masks = [rng.randrange(1 << m) for _ in range(r)]
            changed = masks[:]
            for _ in range(20):
                a, b = rng.sample(range(r), 2)
                changed[a] ^= changed[b]
            changed.extend((0, changed[0], changed[1] ^ changed[2]))
            rows = lambda values: [tuple(i for i in range(m) if x & (1 << i))
                                   for x in values]
            order = list(range(m))
            rng.shuffle(order)
            a = RankSyndromeTrellis(m, rows(masks), Fraction(2, 7), order)
            b = RankSyndromeTrellis(m, rows(changed), Fraction(2, 7), order)
            self.assertEqual(a.profile.cut_dimensions, b.profile.cut_dimensions)
            self.assertEqual(a.partition, b.partition)

    def test_nontrivial_exponential_row_frontier_compression(self):
        r = 32  # I+J is invertible over F2 when r is even.
        rows = [tuple(j for i in range(r) if i != row for j in (2*i, 2*i+1))
                for row in range(r)]
        z = Fraction(1, 3)
        original = SyndromeTrellis(2*r, rows, z)
        compressed = RankSyndromeTrellis(2*r, rows, z)
        self.assertEqual(original.width, r)
        self.assertEqual(compressed.width, 1)
        self.assertEqual(compressed.profile.total_states, 3*r + 1)
        self.assertEqual(compressed.partition, (1 + z*z) ** r)
        for seed in range(40):
            bits = compressed.sample(Random(seed))
            self.assertTrue(all(bits[2*i] == bits[2*i+1] for i in range(r)))

    def test_generator_profile_without_parity_basis(self):
        cases = 0
        for m in range(4):
            for q in range(4):
                for masks in product(range(1 << m), repeat=q):
                    columns = [tuple(i for i in range(m) if mask & (1 << i))
                               for mask in masks]
                    checks = left_nullspace_from_columns(m, columns)
                    for order in {tuple(range(m)), tuple(reversed(range(m)))}:
                        generator = generator_rank_profile(m, columns, order)
                        parity = parity_rank_profile(m, checks, order)
                        self.assertEqual(generator.cut_dimensions, parity.cut_dimensions)
                    cases += 1
        self.assertEqual(cases, 689)

    def test_fixed_coin_output_law_against_all_random_words(self):
        for rows, m in (([], 3), ([(0, 1, 2)], 3), ([(0, 1), (1, 2)], 3)):
            sampler = RankSyndromeTrellis(m, rows, Fraction(2, 3), [2, 0, 1])
            b, counts = 2, Counter()
            for coins in product(range(1 << b), repeat=m):
                counts[sampler.replay_dyadic(coins, b)] += 1
            for bits in product((0, 1), repeat=m):
                self.assertEqual(Fraction(counts[bits], (1 << b) ** m),
                                 sampler.dyadic_probability(bits, b))

    def test_dyadic_global_ratio_total_variation_and_retained_record(self):
        rng = Random(216)
        for _ in range(120):
            m = rng.randrange(8)
            rows = [tuple(i for i in range(m) if rng.randrange(2))
                    for _ in range(rng.randrange(6))]
            sampler = RankSyndromeTrellis(m, rows, Fraction(rng.randrange(1, 6), 7))
            _, pi = exact_law(m, rows, sampler.z)
            mu = {x: sampler.dyadic_probability(x) for x in pi}
            self.assertEqual(sum(mu.values()), 1)
            self.assertTrue(all(mu[x] <= Fraction(4, 3)*pi[x] for x in pi))
            self.assertLessEqual(sampler.dyadic_overhead(), Fraction(4, 3))
            tv = sum(abs(mu[x]-pi[x]) for x in pi) / 2
            self.assertLessEqual(tv, sampler.dyadic_tv_bound())
            self.assertLessEqual(sampler.dyadic_tv_bound(), Fraction(1, 8))
            draw = sampler.sample_dyadic(rng)
            self.assertEqual(len(draw.coin_words), m)
            self.assertEqual(draw.output, sampler.replay_dyadic(
                draw.coin_words, draw.bits_per_word))

    def test_linear_conditioning_uses_the_complete_partition(self):
        rows = [(0, 1, 2, 3)]
        extra = [(0, 1)]
        z = Fraction(2, 5)
        full = RankSyndromeTrellis(4, rows, z)
        conditioned = RankSyndromeTrellis(4, rows + extra, z)
        mass = sum((full.probability(x) for x in product((0, 1), repeat=4)
                    if valid(x, extra)), Fraction(0))
        self.assertEqual(mass, conditioned.partition/full.partition)
        for x in product((0, 1), repeat=4):
            expected = full.probability(x)/mass if valid(x, extra) else 0
            self.assertEqual(conditioned.probability(x), expected)

    def test_real_fugacity_interval_envelope(self):
        for m, rows in ((0, []), (2, []), (3, [(0, 1, 2)]), (4, [(0, 1), (1, 3)])):
            proposal = Fraction(2, 5)
            sampler = RankSyndromeTrellis(m, rows, proposal)
            radius = Fraction(1, 4*max(1, m))
            lower, upper = proposal*(1-radius), proposal*(1+radius)
            factor = sampler.fugacity_interval_factor(lower, upper)
            self.assertLessEqual(factor, Fraction(16, 9))
            for target in (lower, (3*lower+upper)/4, proposal, upper):
                _, pi = exact_law(m, rows, target)
                self.assertTrue(all(sampler.dyadic_probability(x) <= factor*pi[x] for x in pi))
        with self.assertRaises(ValueError):
            sampler.fugacity_interval_factor(0, upper)

    def test_capped_dyadic_conditioning_and_complete_failed_transcript(self):
        class RecordedWords:
            def __init__(self, words):
                self.words = iter(words)
            def getrandbits(self, b):
                word = next(self.words)
                assert 0 <= word < 1 << b
                return word

        sampler = RankSyndromeTrellis(2, [], Fraction(2, 3))
        stable = lambda bits: bits != (1, 1)
        accepted, failures = Counter(), 0
        b, attempts = 2, 2
        # Enumerate the entire finite random source, including unused suffixes.
        for words in product(range(1 << b), repeat=sampler.m*attempts):
            result = sampler.sample_conditional_dyadic(RecordedWords(words), stable, attempts, b)
            for draw in result.attempts:
                self.assertEqual(draw.output, sampler.replay_dyadic(draw.coin_words, b))
            if result.output is None:
                failures += 1
                self.assertEqual(len(result.attempts), attempts)
            else:
                accepted[result.output] += 1
        mu = {x: sampler.dyadic_probability(x, b) for x in product((0, 1), repeat=2)}
        mass = sum(mu[x] for x in mu if stable(x))
        total = (1 << b) ** (sampler.m*attempts)
        self.assertGreater(failures, 0)
        self.assertEqual(Fraction(failures, total), (1-mass)**attempts)
        for x in mu:
            self.assertEqual(Fraction(accepted[x], total-failures),
                             mu[x]/mass if stable(x) else 0)

    def test_actual_published_level_zero_seed_sectors(self):
        # PR213 pinned seed, source-matched to BDL Eqs. 106–109.
        # This covers only level zero, not an all-level complexity theorem.
        for rows in (((0, 1, 2), (2, 3, 4)), ((0, 2, 3), (1, 2, 4))):
            columns = [tuple(j for j, row in enumerate(rows) if i in row) for i in range(5)]
            checks = left_nullspace_from_columns(2, columns)
            sampler = RankSyndromeTrellis(2, checks, Fraction(1, 9))
            self.assertEqual(sampler.width, 0)
            self.assertEqual(sampler.partition, Fraction(10, 9) ** 2)
            for sigma in product((0, 1), repeat=2):
                error = syndrome_preimage(2, columns, sigma)
                self.assertEqual(tuple(sum(error[j] for j, c in enumerate(columns) if i in c) % 2
                                       for i in range(2)), sigma)

    def test_validation_and_preallocation_resource_gate(self):
        with self.assertRaises(ValueError):
            RankSyndromeTrellis(2, [(0, 0)], Fraction(1, 3))
        with self.assertRaises(ValueError):
            RankSyndromeTrellis(2, [(2,)], Fraction(1, 3))
        with self.assertRaises(ValueError):
            RankSyndromeTrellis(2, [], Fraction(1, 3), [0, 0])
        with self.assertRaises(ValueError):
            RankSyndromeTrellis(2, [], 0.25)
        rows = [(i, i+8) for i in range(8)]
        profile = parity_rank_profile(16, rows)
        self.assertEqual(profile.width, 8)
        with self.assertRaisesRegex(ValueError, "no approximation"):
            RankSyndromeTrellis(16, rows, Fraction(1, 3), max_states_per_cut=128)
        t = RankSyndromeTrellis(0, [], Fraction(1, 3))
        self.assertEqual(t.partition, 1)
        self.assertEqual(t.sample(Random(0)), ())
        self.assertEqual(t.sample_dyadic(Random(0)).output, ())
        with self.assertRaises(ValueError):
            t.sample_conditional(Random(0), lambda _: True, 0)


if __name__ == "__main__":
    unittest.main(verbosity=2)
