#!/usr/bin/env python3
"""Exact finite-rational regression gates for UPT warm-start M0/M4.

These checks test mathematical identities on finite examples. They are not
proof that BDLT's 2D model transfers to the 3D syndrome Gibbs law, nor a
polynomial-time sampler for that law. No floating-point approximations.
"""
from fractions import Fraction as Q
from itertools import product
import unittest


def minimum_domination(proposal, target):
    """Least pointwise C for proposal <= C*target; None means no finite C."""
    if len(proposal) != len(target) or not proposal:
        raise ValueError('laws need the same nonempty finite support')
    if any(x < 0 for x in (*proposal, *target)):
        raise ValueError('negative masses')
    if sum(proposal) != 1 or sum(target) != 1:
        raise ValueError('laws must be normalized')
    if any(m > 0 and p == 0 for m, p in zip(proposal, target)):
        return None
    return max((m / p for m, p in zip(proposal, target) if p > 0), default=Q(0))


def condition(target, accepted):
    z = sum(target[i] for i in accepted)
    if z <= 0:
        raise ValueError('conditioning event has zero mass')
    return [target[i] / z if i in accepted else Q(0) for i in range(len(target))]


def independent_product(laws):
    """Form exact finite product law, each factor already normalized."""
    return [__product(p) for p in product(*laws)]


def __product(items):
    out = Q(1)
    for value in items:
        out *= value
    return out


def gibbs_tilt(target, weights):
    """Normalize target(x)*weights(x): partition-function factors included."""
    if len(target) != len(weights) or any(w <= 0 for w in weights):
        raise ValueError('positive tilt weights of matching length required')
    z = sum(p * w for p, w in zip(target, weights))
    return [p * w / z for p, w in zip(target, weights)]


def may_3d_unstable_upper_bound(level):
    """Author-reported BDL 3D bound 4*2^(-2^(k-1)); for small level checks."""
    if level < 1:
        raise ValueError('level must be positive')
    return Q(4, 2 ** (2 ** (level - 1)))


class RatioGateTests(unittest.TestCase):
    def test_exponential_block_cost(self):
        # Each factor costs only 3/2, but many factors cost (3/2)^b.
        p = [Q(1, 2), Q(1, 2)]
        m = [Q(3, 4), Q(1, 4)]
        for b in (1, 2, 4, 8):
            self.assertEqual(
                minimum_domination(independent_product([m] * b),
                                   independent_product([p] * b)),
                Q(3, 2) ** b)

    def test_exact_conditional_event(self):
        p = [Q(1, 4)] * 4
        m = condition(p, {0, 1, 2})
        self.assertEqual(sum(p[i] for i in (0, 1, 2)), Q(3, 4))
        self.assertEqual(minimum_domination(m, p), Q(4, 3))

    def test_normalized_tilt_oscillation(self):
        p = [Q(1, 5), Q(1, 5), Q(3, 5)]
        w = [Q(2), Q(3), Q(1)]
        m = gibbs_tilt(p, w)
        self.assertEqual(sum(m), 1)
        # C_min <= max weight / min weight is a certified sufficient bound.
        self.assertLessEqual(minimum_domination(m, p), max(w) / min(w))

    def test_support_obstruction(self):
        self.assertIsNone(minimum_domination([Q(0), Q(1)], [Q(1), Q(0)]))

    def test_3d_stable_event_lower_bound(self):
        # For k >= 3, 4*2^(-2^(k-1)) <= 1/4, hence stable mass >= 3/4.
        self.assertEqual(may_3d_unstable_upper_bound(3), Q(1, 4))
        for k in (3, 4, 5):
            self.assertLessEqual(may_3d_unstable_upper_bound(k), Q(1, 4))


if __name__ == '__main__':
    unittest.main()
