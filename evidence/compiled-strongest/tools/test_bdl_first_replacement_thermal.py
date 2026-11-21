#!/usr/bin/env python3
"""Exact independent source equations, full finite laws and coin transcripts."""
from collections import Counter
from fractions import Fraction
from itertools import product
from random import Random
import unittest

from bdl_replacement_chain import seed, replace_x
from bdl_frontier_audit import error_columns, dependency_basis
from bdl_first_replacement_thermal import (
    MASKS, BlockConfiguration, FiveParityBlockLaw, first_replacement_parameters,
    parity_table, parity_weights, seed_first_metacheck_column,
)


def basis(vectors):
    pivots = {}
    for v in vectors:
        while v:
            p = v.bit_length()-1
            if p not in pivots:
                pivots[p] = v
                break
            v ^= pivots[p]
    return pivots


def in_span(v, pivots):
    while v:
        p = v.bit_length()-1
        if p not in pivots:
            return False
        v ^= pivots[p]
    return True


def all_configurations(law):
    lengths = (law.x_free, *law.lengths, law.z_free)
    for word in product((0, 1), repeat=law.coordinates):
        fields, i = [], 0
        for length in lengths:
            fields.append(tuple(word[i:i+length]))
            i += length
        yield BlockConfiguration(fields[0], tuple(fields[1:6]), fields[6])


def fourier_partition(checks, m, z):
    """Independent 2^rank character sum over the full source-coordinate map."""
    words = [sum(1 << i for i in row) for row in checks]
    r, total = len(words), Fraction(0)
    for coefficients in product((0, 1), repeat=r):
        mask = 0
        for bit, row in zip(coefficients, words):
            if bit:
                mask ^= row
        weight = bin(mask).count("1")
        total += (1+z)**(m-weight) * (1-z)**weight
    return total / (1 << r)


class FirstReplacementThermalTests(unittest.TestCase):
    def test_even_odd_block_weights_against_full_enumeration(self):
        self.assertEqual(parity_weights(1, 1), (Fraction(1), Fraction(1)))
        self.assertTrue(all(isinstance(x, Fraction) for x in parity_weights(1, 1)))
        for z in (Fraction(1, 7), Fraction(2, 3), Fraction(2)):
            for length in range(10):
                actual = [Fraction(0), Fraction(0)]
                for bits in product((0, 1), repeat=length):
                    actual[sum(bits) % 2] += z**sum(bits)
                self.assertEqual(tuple(actual), parity_weights(length, z))
                self.assertEqual(tuple(actual), parity_table(length, z)[-1])

    def test_complete_small_output_laws(self):
        for lengths, xfree, zfree in (
                ((1, 1, 1, 1, 1), 0, 0),
                ((2, 1, 1, 1, 1), 1, 0),
                ((1, 2, 1, 2, 1), 0, 1)):
            for z in (Fraction(1, 3), Fraction(3, 4), Fraction(2)):
                law = FiveParityBlockLaw(lengths, xfree, zfree, z)
                configurations = list(all_configurations(law))
                normalizer = sum((z**c.weight for c in configurations if law.is_valid(c)),
                                 Fraction(0))
                self.assertEqual(law.partition, normalizer)
                total, total_dyadic, variation = Fraction(0), Fraction(0), Fraction(0)
                for c in configurations:
                    target = z**c.weight/normalizer if law.is_valid(c) else Fraction(0)
                    actual = law.probability(c)
                    mu = law.probability(c, dyadic=True)
                    self.assertEqual(actual, target)
                    self.assertLessEqual(mu, Fraction(4, 3)*target)
                    total += actual
                    total_dyadic += mu
                    variation += abs(actual-mu)
                self.assertEqual(total, 1)
                self.assertEqual(total_dyadic, 1)
                self.assertLessEqual(variation/2, Fraction(1, 8))
                self.assertLessEqual(law.domination_factor(), Fraction(4, 3))

    def test_actual_finite_coin_source_law(self):
        law = FiveParityBlockLaw((1, 1, 1, 1, 1), 0, 0, Fraction(2))
        b = 2
        counts = Counter(law.replay(words, b)
                         for words in product(range(1 << b), repeat=law.decisions))
        self.assertGreater(len(counts), 1)
        for config in all_configurations(law):
            self.assertEqual(Fraction(counts[config], (1 << b)**law.decisions),
                             law.probability(config, bits=b, dyadic=True))
        for seed_value in range(20):
            draw = law.sample_dyadic(Random(seed_value))
            self.assertEqual(len(draw.coin_words), law.coordinates+2)
            self.assertEqual(draw.configuration, law.replay(draw.coin_words, draw.bits_per_word))

    def test_three_symbolic_checks_are_complete_on_actual_cells(self):
        for L in range(1, 9):
            c = replace_x(seed(), L)
            columns, labels = error_columns(c, "X")
            relations = dependency_basis(columns, labels, c.q)
            classes = [seed_first_metacheck_column(label) for label in labels]
            self.assertEqual(Counter(classes), {
                0: 8*L*L+12*L, 1: 8*L, 2: 4, 3: 1, 4: 4, 5: 1})
            predicted = [sum(1 << i for i, value in enumerate(classes) if value & (1 << bit))
                         for bit in range(3)]
            actual = [sum(1 << i for i in row) for row in relations]
            self.assertEqual(len(basis(predicted)), 3)
            self.assertEqual(len(basis(actual)), 3)
            self.assertTrue(all(in_span(row, basis(actual)) for row in predicted))
            label_index = {label: i for i, label in enumerate(labels)}
            for support in columns.values():
                value = 0
                for label in support:
                    value ^= classes[label_index[label]]
                self.assertEqual(value, 0)
            other_columns, other_labels = error_columns(c, "Z")
            self.assertEqual(dependency_basis(other_columns, other_labels, c.q), [])

    def test_symbolic_partition_against_full_coordinate_fourier_sum(self):
        for L in (1, 2, 3, 5):
            c = replace_x(seed(), L)
            columns, labels = error_columns(c, "X")
            relations = dependency_basis(columns, labels, c.q)
            for z in (Fraction(1, 9), Fraction(2, 5), Fraction(3, 2)):
                law = FiveParityBlockLaw.first_replacement(L, z)
                full = fourier_partition(relations, len(labels), z)*(1+z)**len(c.x)
                self.assertEqual(law.partition, full)
                even, odd = parity_weights(8*L, z)
                e4, o4 = parity_weights(4, z)
                closed = (1+z)**(law.x_free+law.z_free) * (
                    even*(e4*e4+z*z*o4*o4)+2*z*odd*e4*o4)
                self.assertEqual(full, closed)

    def test_sampled_source_words_have_actual_error_preimages(self):
        for L in (1, 2, 4):
            c = replace_x(seed(), L)
            columns, labels = error_columns(c, "X")
            loc = {s: i for i, s in enumerate(labels)}
            image_basis = basis(sum(1 << loc[s] for s in support) for support in columns.values())
            other, other_labels = error_columns(c, "Z")
            other_loc = {s: i for i, s in enumerate(other_labels)}
            other_basis = basis(sum(1 << other_loc[s] for s in support) for support in other.values())
            law = FiveParityBlockLaw.first_replacement(L, Fraction(2, 7))
            for seed_value in range(15):
                draw = law.sample_dyadic(Random(seed_value))
                x = law.source_order_x(draw.configuration, labels)
                self.assertTrue(in_span(sum(b << i for i, b in enumerate(x)), image_basis))
                self.assertTrue(in_span(sum(b << i for i, b in enumerate(draw.configuration.z_free)),
                                        other_basis))
                self.assertTrue(all(sum(x[i] for i in row) % 2 == 0
                                    for row in dependency_basis(columns, labels, c.q)))

    def test_symbolic_large_scale_does_not_materialize_a_matrix(self):
        L = 54*10**26
        p = first_replacement_parameters(L)
        self.assertEqual(p["qubits"], 16*L*L+32*L+12)
        self.assertEqual(sum(p["X_error_nonzero_block_sizes"])+p["X_error_zero_columns"],
                         p["Z_checks"])
        self.assertEqual(p["X_error_metacheck_rank"], 3)
        with self.assertRaisesRegex(ValueError, "symbolic"):
            FiveParityBlockLaw.first_replacement(L, Fraction(1, 9))

    def test_unit_fugacity_joint_syndrome_count(self):
        for L in (1, 2, 4, 8):
            p = first_replacement_parameters(L)
            law = FiveParityBlockLaw.first_replacement(L, Fraction(1))
            self.assertEqual(law.partition, 2**(p["qubits"]-1))

    def test_input_and_layout_validation(self):
        for function in (parity_weights, parity_table):
            with self.assertRaises(ValueError):
                function(-1, Fraction(1, 9))
            with self.assertRaises(ValueError):
                function(2, 0.1)
        for L in (0, -1, 0.5):
            with self.assertRaises(ValueError):
                first_replacement_parameters(L)
        with self.assertRaises(ValueError):
            FiveParityBlockLaw((1, 2), 0, 0, Fraction(1, 9))
        with self.assertRaises(ValueError):
            FiveParityBlockLaw((1, 1, 1, 1, 1), 0, 0, 0.1)
        law = FiveParityBlockLaw.first_replacement(1, Fraction(1, 9))
        draw = law.sample_dyadic(Random(3))
        with self.assertRaises(ValueError):
            law.source_order_x(draw.configuration, [])
        with self.assertRaises(ValueError):
            law.replay([], 4)
        with self.assertRaises(ValueError):
            seed_first_metacheck_column(("unknown",))


if __name__ == "__main__":
    unittest.main(verbosity=2)
