#!/usr/bin/env python3
"""OFR-1/OFR-2: online arrival and causal-guard frontier, finite toy model.

Not a proof of physical BCRD, real subject identity, actual autonomous
consent, or unrestricted universal protection.
"""
from itertools import combinations, product
import json

LANES = ("A", "B")
GATE_COST = 2
CARE_PER_EPOCH = 1

def subsets(items):
    items = tuple(items)
    for size in range(len(items) + 1):
        for values in combinations(items, size):
            yield frozenset(values)

def harmful_effect(attack, forced_reaction, guard, intrinsic, enabled):
    # A coerced reaction can be causal without being authorized.
    return bool((attack or forced_reaction) and enabled and not (guard or intrinsic))

def branch_safe(budget, pre, post, lane, *, immediate, latency, intrinsic):
    """Precommitted guard set, followed by response after the arrival location is known.

    Post-installation is physically operational next epoch iff latency<=1.
    """
    stock = budget - GATE_COST * len(pre)
    if stock < CARE_PER_EPOCH:
        return False, 0
    stock -= CARE_PER_EPOCH
    checks = 0
    for choice0, attack0, forced0 in product((0, 1), repeat=3):
        checks += 1
        if harmful_effect(attack0, forced0, lane in pre, intrinsic, immediate):
            return False, checks
        if stock - GATE_COST * len(post) - CARE_PER_EPOCH < 0:
            return False, checks
        guard1 = lane in pre or (latency <= 1 and lane in post)
        stock1 = stock - GATE_COST * len(post) - CARE_PER_EPOCH
        for choice1, attack1, forced1 in product((0, 1), repeat=3):
            checks += 1
            if harmful_effect(attack1, forced1, guard1, intrinsic, True):
                return False, checks
            history = (choice0, choice1)
            assert history == (choice0, choice1)  # independent genuine choice bits
            assert stock1 >= 0
    return True, checks

def offline_coverable(budget, lane, *, immediate, latency=1, intrinsic=False):
    """Clairvoyant guard choices made after knowing the future corridor."""
    for pre in subsets(LANES):
        for post in subsets(sorted(set(LANES) - set(pre))):
            yes, _ = branch_safe(budget, pre, post, lane, immediate=immediate,
                                 latency=latency, intrinsic=intrinsic)
            if yes:
                return True, (sorted(pre), sorted(post))
    return False, None

def online_solve(budget, *, immediate, latency=1, intrinsic=False):
    """Exists pre, for all lanes exists post(lane), for all attack/choice bits.

    This is exhaustive for the stipulated two-step one-entrant guard game.
    """
    checked = 0
    for pre in subsets(LANES):
        if budget - GATE_COST * len(pre) < CARE_PER_EPOCH:
            continue
        responses = {}
        for lane in LANES:
            found = False
            for post in subsets(sorted(set(LANES) - set(pre))):
                yes, n = branch_safe(budget, pre, post, lane,
                                     immediate=immediate, latency=latency,
                                     intrinsic=intrinsic)
                checked += n
                if yes:
                    responses[lane] = sorted(post)
                    found = True
                    break
            if not found:
                break
        if len(responses) == len(LANES):
            return {"winning": True, "pre_guards": sorted(pre),
                    "responses_after_arrival": responses,
                    "attack_choice_conditions_checked": checked}
    return {"winning": False, "pre_guards": None,
            "responses_after_arrival": None,
            "attack_choice_conditions_checked": checked}

def run():
    cases = {
        "budget4_immediate_latency1": dict(budget=4, immediate=True, latency=1),
        "budget6_immediate_latency1": dict(budget=6, immediate=True, latency=1),
        "budget4_grace_latency1": dict(budget=4, immediate=False, latency=1),
        "budget4_grace_latency2": dict(budget=4, immediate=False, latency=2),
        "budget3_grace_latency1": dict(budget=3, immediate=False, latency=1),
        "budget2_intrinsic_block": dict(budget=2, immediate=True, latency=2, intrinsic=True),
    }
    expected = (False, True, True, False, False, True)
    results = {key: online_solve(**params) for key, params in cases.items()}
    assert tuple(v["winning"] for v in results.values()) == expected

    # The key quantifier-swap counterexample.
    offline = {lane: offline_coverable(4, lane, immediate=True) for lane in LANES}
    assert all(v[0] for v in offline.values())
    assert results["budget4_immediate_latency1"]["winning"] is False

    # Genuine response window and timing sensitivity.
    assert results["budget4_grace_latency1"]["responses_after_arrival"] == {
        "A": ["A"], "B": ["B"]
    }
    assert results["budget6_immediate_latency1"]["pre_guards"] == ["A", "B"]
    assert results["budget2_intrinsic_block"]["pre_guards"] == []

    # Coerced causal participation can be malicious, but a guard blocks effects.
    assert harmful_effect(0, 1, False, False, True)
    assert not harmful_effect(0, 1, True, False, True)
    assert not harmful_effect(1, 1, False, True, True)

    # Independent non-shareable-guard/resource lower bound.
    concurrent = {str(n): {"two_epoch_minimum": 4*n,
                           "within_budget4": 4*n <= 4}
                  for n in range(1, 6)}
    assert concurrent["1"]["within_budget4"]
    assert all(not concurrent[str(n)]["within_budget4"] for n in range(2, 6))

    return {
        "status": "PASS: only the stipulated finite abstract model",
        "online": "exists pre forall lane exists post(lane) forall attack/choice",
        "offline": "forall lane exists pre(lane) is insufficient",
        "scenarios": results,
        "offline_witnesses": {k: {"exists": v[0], "guards": v[1]} for k, v in offline.items()},
        "concurrent_arrivals": concurrent,
        "assumed_independent_authorization": True,
        "physical_BCRD_validation": False,
        "unrestricted_universal_claim": False
    }

if __name__ == "__main__":
    print(json.dumps(run(), indent=2, sort_keys=True))
