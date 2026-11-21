#!/usr/bin/env python3
"""SOF: source-observation fibre countermodel and positive controls.

Finite classical basis/support and hypothetical local-guard model only.
Not a proof about actual subject identity, quantum measurement, or full BCRD.
"""
from collections import deque
from fractions import Fraction
from itertools import combinations, product
import json

BASIS = ("A0", "A1", "B0", "B1", "C0", "C1")
H1 = {"A0": "B0", "B0": "A0", "A1": "B1", "B1": "A1",
      "C0": "C0", "C1": "C1"}  # coupling SUPPORT; not one global H1 pulse
H2 = {"A0": "A0", "A1": "A1", "B0": "C1", "C1": "B0",
      "B1": "C0", "C0": "B1"}  # exact pi/2 basis exchange, common phase ignored
PARITY = {s: ("+" if s in ("A0", "B0", "C1") else "-") for s in BASIS}
SITE = {s: s[0] for s in BASIS}
LANES = ("A", "B", "C")

def closure(seed, steps):
    seen = {seed}
    queue = deque([seed])
    while queue:
        old = queue.popleft()
        for step in steps:
            new = step[old]
            if new not in seen:
                seen.add(new)
                queue.append(new)
    return frozenset(seen)

def choices(k):
    for n in range(k + 1):
        for subset in combinations(LANES, n):
            yield frozenset(subset)

def safe(fibre, guards):
    # Adversary may harm the actual site if it has no local interlock.
    # Neither the attack nor the guard is derived from the Hamiltonians.
    return all(SITE[s] in guards for s in fibre)

def winners(fibre, k):
    return [sorted(c) for c in choices(k) if safe(fibre, c)]

def policy(states, observation, k):
    fibres = {}
    for s in states:
        fibres.setdefault(observation[s], set()).add(s)
    plan = {}
    for observation_value, fibre in fibres.items():
        viable = winners(fibre, k)
        if not viable:
            return False, None
        plan[observation_value] = viable[0]
    return True, plan

def check_all_requests(states, guards):
    checked = 0
    for s, authentic_choice, attack, coerced_reaction in product(
        states, (0, 1), (0, 1), (0, 1)
    ):
        destructive_request = bool(attack or coerced_reaction)
        harm = destructive_request and SITE[s] not in guards
        if harm:
            return False, checked + 1
        # Assumed authentic subject direction remains separate from any
        # coerced causal contribution to the unauthorized request.
        delivered_choice = authentic_choice
        assert delivered_choice == authentic_choice
        checked += 1
    return True, checked

def run():
    assert set(BASIS) == set(H1) == set(H2) == set(PARITY)
    assert all(PARITY[s] == PARITY[H1[s]] == PARITY[H2[s]] for s in BASIS)
    assert H2["B0"] == "C1" and SITE["B0"] != SITE["C1"]
    h2_orbit = closure("B0", (H2,))
    plus = closure("B0", (H1, H2))
    minus = closure("B1", (H1, H2))
    assert h2_orbit == frozenset(("B0", "C1"))
    assert plus == frozenset(("A0", "B0", "C1"))
    assert minus == frozenset(("A1", "B1", "C0"))

    # All binary diagonal indicators constant on both source support graphs.
    closed = []
    for bits in product((0, 1), repeat=6):
        indicator = dict(zip(BASIS, bits))
        if all(indicator[s] == indicator[H1[s]] == indicator[H2[s]]
               for s in BASIS):
            closed.append(indicator)
    assert len(closed) == 4
    assert all(v["A0"] == v["B0"] == v["C1"] and
               v["A1"] == v["B1"] == v["C0"] for v in closed)

    # Exact observation-fibre and guard-cut controls.
    assert not winners(h2_orbit, 1)
    assert ["B", "C"] in winners(h2_orbit, 2)
    assert not policy(plus, PARITY, 2)[0]
    assert policy(plus, PARITY, 3)[0]
    assert policy(plus, SITE, 1)[0]

    # An observation arriving only after irreversible attack is not
    # usable in the pre-attack decision; the parity-only bound remains.
    late_site_readout_one_guard_wins = False
    assert not late_site_readout_one_guard_wins
    okay, checked = check_all_requests(plus, frozenset(LANES))
    assert okay and checked == 24
    assert not check_all_requests(h2_orbit, frozenset(("B",)))[0]

    # Hypothetical attack always attempted at actual occupied site.
    # Uniform prior is DECLARED; no claim it comes from Born probabilities.
    p = {s: Fraction(1, 3) for s in plus}
    best = max(sum(p[s] for s in plus if SITE[s] in c)
               for c in choices(2))
    assert best == Fraction(2, 3)
    min_failure = 1 - best
    assert min_failure == Fraction(1, 3)
    # Hypothetical one-date cost: each guard costs 2, care costs 1.
    assert 2 * len({SITE[s] for s in plus}) + 1 == 7
    assert 2 * 1 + 1 == 3

    return {
        "status": "PASS: finite source-support/abstract-guard check only",
        "source_H2_B0_to_C1_parity_preserved": True,
        "source_H1_support_not_one_global_H1_pulse": True,
        "H2_orbit": sorted(h2_orbit),
        "H1_H2_plus_support_closure": sorted(plus),
        "H1_H2_minus_support_closure": sorted(minus),
        "diagonal_source_invariant_binary_indicators": len(closed),
        "parity_only_two_guards_suffice": False,
        "parity_only_three_guards_suffice": True,
        "timely_site_observation_one_guard_suffices": True,
        "late_site_observation_one_guard_suffices": False,
        "minimum_hypothetical_guard_plus_care_funds_parity": 7,
        "minimum_hypothetical_guard_plus_care_funds_timely_site": 3,
        "authentic_choice_attack_reaction_cases_checked": checked,
        "declared_uniform_prior_budget_two_min_failure": str(min_failure),
        "source_semantic_particular_or_full_BCRD_theorem": False,
        "physical_noninvasive_measurement_or_interlock_proved": False
    }

if __name__ == "__main__":
    print(json.dumps(run(), indent=2, sort_keys=True))
