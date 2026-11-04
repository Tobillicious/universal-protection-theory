#!/usr/bin/env python3
"""Independent exhaustive controls for original-order selection and realization.

These are finite mathematical checks, separate from the generic Lean proofs.
No physical measurement or original-domain finiteness is inferred.
"""
from itertools import product
import json


def better(a, b):
    """Original stagewise set inclusion: b strictly improves a."""
    for left, right in zip(a, b):
        if left != right:
            return left < right
    return False


def maximal(family, value):
    return value in family and not any(better(value, other) for other in family)


def no_needless_loss(family, value):
    """Independent stage/particular oracle from the original English rule."""
    return all(not (
        all(other[k] == value[k] for k in range(stage))
        and value[stage].issubset(other[stage])
        and any(p not in value[stage] for p in other[stage])
    ) for other in family for stage in range(4))


def check_profiles():
    # One existing and one new particular exercise all four priorities.
    # Each has the three valid states ended/held/free.
    worlds = []
    for old, new in product(range(3), repeat=2):
        worlds.append((frozenset([0]) if old else frozenset(),
                       frozenset([0]) if old == 2 else frozenset(),
                       frozenset([1]) if new else frozenset(),
                       frozenset([1]) if new == 2 else frozenset()))
    decisions = 0
    for mask in range(1, 1 << len(worlds)):
        family = [w for i, w in enumerate(worlds) if mask & (1 << i)]
        full_maxima = [w for w in family if no_needless_loss(family, w)]
        assert full_maxima
        # Every implementation subset is audited against the FULL family.
        for flags in product([False, True], repeat=len(family)):
            implemented = {w for w, flag in zip(family, flags) if flag}
            # Exercise the executable candidate search with reversed ordering;
            # its result is checked against the independent needless-loss oracle.
            found = next((w for w in reversed(family)
                          if maximal(family, w) and w in implemented), None)
            target = [w for w in full_maxima if w in implemented]
            assert (found is not None) == bool(target)
            if found is not None:
                assert found in target
            decisions += 1
    return decisions


def check_fibres():
    # Enumerate every two-state observation partition and every state/action
    # compatibility relation; compare common-fibre witnesses to ALL policies.
    checked = 0
    for observe in product(range(2), repeat=2):
        for relation_bits in range(16):
            works = lambda s, a: bool(relation_bits & (1 << (2 * s + a)))
            policies = list(product(range(2), repeat=2))
            exists_policy = any(all(works(s, policy[observe[s]]) for s in range(2))
                                for policy in policies)
            fibres_work = all(any(all(works(s, a) for s in range(2) if observe[s] == o)
                                  for a in range(2)) for o in range(2))
            assert exists_policy == fibres_work
            checked += 1
    return checked


def negative_controls():
    empty, one, both = frozenset(), frozenset([0]), frozenset([0, 1])
    low, high = (empty,), (one,)
    # Choosing the best implementable option alone can ignore an original
    # full-feasible strict improver that has not been implemented.
    assert maximal([low], low) and not maximal([low, high], low)
    # An arbitrary maximal tie may fail implementation although another works.
    left, right = (frozenset([0]),), (frozenset([1]),)
    assert maximal([left, right], left) and maximal([left, right], right)
    implemented = {right}
    assert left not in implemented and right in implemented
    # Individually feasible freedoms need not be jointly feasible.
    assert all(any(p in a[0] for a in [left, right]) for p in range(2))
    assert not any(a[0] == both for a in [left, right])
    # Per-hidden-state delivery is possible, but a single indistinguishable
    # observation cannot choose both required opposite actions.
    assert all(any(a == s for a in range(2)) for s in range(2))
    assert not any(all(a == s for s in range(2)) for a in range(2))
    # A fabricated realization flag certifies no actual retained fact.
    fake_realises = lambda _policy, _target: True
    assert fake_realises(False, True) and False != True
    # A finite exact representation cannot cover the next original chain cut.
    for n in range(16):
        representatives = list(range(n + 1))
        missing = max(representatives) + 1
        assert all(set(range(missing + 1)) != set(range(r + 1))
                   for r in representatives)
    return 6


def main():
    result = {
        "status": "PASS",
        "original_order_selection_cases": check_profiles(),
        "observation_fibre_cases": check_fibres(),
        "negative_control_families": negative_controls(),
        "scope": "Exhaustive finite mathematics; no physical/semantic promotion.",
    }
    print(json.dumps(result, sort_keys=True))


if __name__ == "__main__":
    main()
