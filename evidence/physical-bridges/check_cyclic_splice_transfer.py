#!/usr/bin/env python3
"""Exact finite diagnostics for the cyclic extension of UPT G2Splice.

Standard library only. These checks concern finite controlled state models.
The synthetic grades below do not certify physical historical continuation.
Run: python3 check_cyclic_splice_transfer.py
"""

from itertools import permutations, product
import json


BITS = (0, 1)
STATES = tuple(product(BITS, repeat=2))
LOCAL_MAPS = tuple(product(BITS, repeat=2))
POLICIES = tuple(product(LOCAL_MAPS, repeat=2))
CHOICES = tuple(product(BITS, repeat=2))


def require(condition, detail):
    if not condition:
        raise AssertionError(detail)


def mix(left, right, choice):
    return tuple((left, right)[pick][i] for i, pick in enumerate(choice))


def transition(policy, state):
    return tuple(local[state[i]] for i, local in enumerate(policy))


def run(policy, seed, steps):
    trace = [seed]
    for _ in range(steps):
        trace.append(transition(policy, trace[-1]))
    return tuple(trace)


def diagnostic_grade(trace, node):
    """Synthetic local trace test; neither life nor freedom is inferred."""
    changes = sum(a[node] != b[node] for a, b in zip(trace, trace[1:]))
    return min(2, changes)


def four_stage(grades):
    existing, future = (0,), (1,)
    return tuple(
        frozenset(node for node in category if grades[node] >= threshold)
        for category, threshold in (
            (existing, 1), (existing, 2), (future, 1), (future, 2)
        )
    )


def verify_injective_shared_cut():
    # All 16 independent two-bit transition laws, 24 full-state bijections,
    # four common seeds, periods 1..4, ordered policy pairs and block choices.
    runs = {
        (policy, seed, steps): run(policy, seed, steps)
        for policy, seed, steps in product(POLICIES, STATES, range(1, 5))
    }
    closed_pairs = splices = active_splices = 0
    for image in permutations(STATES):
        seam = dict(zip(STATES, image))
        for seed, steps in product(STATES, range(1, 5)):
            closed = [
                policy for policy in POLICIES
                if seam[runs[policy, seed, steps][-1]] == seed
            ]
            for left, right in product(closed, repeat=2):
                closed_pairs += 1
                lt, rt = runs[left, seed, steps], runs[right, seed, steps]
                require(lt[-1] == rt[-1], "injective seam endpoint equality")
                lg = tuple(diagnostic_grade(lt, i) for i in range(2))
                rg = tuple(diagnostic_grade(rt, i) for i in range(2))
                for choice in CHOICES:
                    selected = mix(left, right, choice)
                    trace = runs[selected, seed, steps]
                    expected = tuple(mix(a, b, choice) for a, b in zip(lt, rt))
                    require(trace == expected, "source-style block trace agreement")
                    require(seam[trace[-1]] == seed, "spliced cyclic closure")
                    splices += 1
                    active_splices += any(s != seed for s in trace[1:])
                # Choose the better local trace grade, exactly as G2Splice does.
                best_choice = tuple(int(rg[i] > lg[i]) for i in range(2))
                best_trace = runs[mix(left, right, best_choice), seed, steps]
                actual = four_stage(tuple(diagnostic_grade(best_trace, i) for i in range(2)))
                wanted = tuple(a | b for a, b in zip(four_stage(lg), four_stage(rg)))
                require(actual == wanted, "all four stage unions")
    require(active_splices > 0, "active closed examples are exercised")
    require((closed_pairs, splices, active_splices) == (7872, 31488, 21504),
            "locked original cyclic splice counts")
    return {
        "all_state_seam_permutations": 24,
        "local_transition_policies": 16,
        "common_seeds": 4,
        "step_lengths": [1, 2, 3, 4],
        "closed_ordered_policy_pairs": closed_pairs,
        "verified_block_splices": splices,
        "verified_splices_with_internal_changes": active_splices,
        "four_stage_union_checks": closed_pairs,
    }


def verify_seam_fibers():
    fibers = rectangular = injective_fibers = 0
    for image in product(STATES, repeat=len(STATES)):
        seam = dict(zip(STATES, image))
        injective = len(set(image)) == len(STATES)
        for target in STATES:
            fiber = frozenset(s for s in STATES if seam[s] == target)
            mixing_closed = all(
                mix(a, b, choice) in fiber
                for a, b, choice in product(fiber, fiber, CHOICES)
            )
            # For nonempty F, closure under all binary coordinate mixes is
            # equivalent to F being the product of its coordinate projections.
            projections = [set(s[i] for s in fiber) for i in range(2)]
            rectangular_set = frozenset(product(*projections))
            require(mixing_closed == (fiber == rectangular_set), "fiber criterion")
            if injective:
                require(mixing_closed, "every injective seam fiber is rectangular")
                injective_fibers += 1
            fibers += 1
            rectangular += mixing_closed
    return {
        "all_total_state_seams": 256,
        "all_target_fibers": fibers,
        "rectangular_fibers": rectangular,
        "injective_seam_fibers": injective_fibers,
    }


def verify_missing_hypotheses():
    # Noninjective seam with a nonrectangular fiber: both endpoint choices
    # close, but mixing their coordinates does not.
    seed = (0, 0)
    seam = lambda s: (s[0] ^ s[1], 0)
    left, right = ((0, 0), (0, 0)), ((1, 1), (1, 1))
    lt, rt = run(left, seed, 1), run(right, seed, 1)
    bad = run(mix(left, right, (0, 1)), seed, 1)
    require(seam(lt[-1]) == seed == seam(rt[-1]), "closed originals")
    require(seam(bad[-1]) != seed, "nonrectangular seam fiber control")

    # Different seeds: even a bijective seam can couple the blocks. A third
    # phase bit changes in every policy, so both originals have active bulk.
    seam3 = lambda s: (s[1], s[0], 1 - s[2])
    p = lambda s: (s[0], s[1], 1 - s[2])
    q = lambda s: (1 - s[0], 1 - s[1], 1 - s[2])
    a, b = (0, 0, 0), (0, 1, 0)
    choice3 = (0, 1, 0)
    mixed_seed = mix(a, b, choice3)
    mixed_end = mix(p(mixed_seed), q(mixed_seed), choice3)
    require(seam3(p(a)) == a and seam3(q(b)) == b, "different-seed closed originals")
    require(seam3(mixed_end) != mixed_seed, "shared-cut hypothesis control")

    # Incomplete block coverage: only the first bit belongs to the closed
    # chosen block. The default second-bit transition reads that first bit.
    p2 = lambda s: (s[0], s[1] ^ s[0])
    q2 = lambda s: (1 - s[0], s[1])
    splice2 = lambda s: (q2(s)[0], p2(s)[1])
    require(p2(p2(seed)) == seed == q2(q2(seed)), "covered policies close")
    require(splice2(splice2(seed)) != seed, "uncovered coupled carrier control")

    # Shared budget: the splice closes dynamically but exceeds a resource cap.
    identity, flip = (0, 1), (1, 0)
    p_resource, q_resource = (flip, identity), (identity, flip)
    combined = mix(p_resource, q_resource, (0, 1))
    for policy in (p_resource, q_resource, combined):
        require(run(policy, seed, 2)[-1] == seed, "resource example cyclic closure")
    cost = lambda policy: sum(local == flip for local in policy)
    require(cost(p_resource) <= 1 and cost(q_resource) <= 1, "individual budgets")
    require(cost(combined) > 1, "shared resource feasibility is separate")

    return [
        "nonrectangular noninjective seam fiber breaks closure",
        "different seeds can break closure despite an injective seam and active histories",
        "uncovered interacting carrier breaks the block argument",
        "dynamic cyclic closure does not establish shared-budget feasibility",
    ]


def verify_guarded_splice_join():
    """PR #205 guard plus the original splice theorem on the same traces.

    The closure seam acts on the complete two-bit modeled cut. A guardian
    sees any of the 16 coarsenings to one bit; its policy lifts to the full
    cut by composition. All modeled actions in this diagnostic are allowed.
    We explicitly check that each mixed action is fibre-common safe and
    that the actual mixed trace executes that selected action.
    """
    indices = {s: i for i, s in enumerate(STATES)}
    cuts = tuple(product(BITS, repeat=len(STATES)))
    identity = ((0, 1), (0, 1))
    runs = {(p, s, n): run(p, s, n)
            for p, s, n in product(POLICIES, STATES, range(1, 5))}
    certified = {}
    configurations = guarded = proper_guarded = 0
    for key, trace in runs.items():
        action, seed, _ = key
        count = 0
        for cut, mask in product(cuts, range(16)):
            configurations += 1
            protected = frozenset(s for i, s in enumerate(STATES) if mask & (1 << i))
            if seed not in protected:
                continue
            visited = {cut[indices[s]] for s in trace[:-1]}
            # Use the spliced action on every encountered observation;
            # use identity on other fibres. This is a single cut-only policy.
            guardian = tuple(action if o in visited else identity for o in BITS)
            fibre_guard = all(
                transition(guardian[cut[indices[s]]], s) in protected
                for s in protected
            )
            if not fibre_guard:
                continue
            require(all(transition(guardian[cut[indices[s]]], s) == t
                        for s, t in zip(trace, trace[1:])),
                    "mixed effects execute the chosen fibre-common action")
            require(all(s in protected for s in trace),
                    "PR205 guarded trace preserves protection")
            count += 1
            guarded += 1
            proper_guarded += len(protected) < len(STATES)
        certified[key] = count

    joined = 0
    for image in permutations(STATES):
        seam = dict(zip(STATES, image))
        for seed, steps in product(STATES, range(1, 5)):
            closed = [p for p in POLICIES if seam[runs[p, seed, steps][-1]] == seed]
            for left, right, choice in product(closed, closed, CHOICES):
                mixed = mix(left, right, choice)
                require(seam[runs[mixed, seed, steps][-1]] == seed,
                        "guardian-joined splice is still cyclic")
                joined += certified[mixed, seed, steps]
    require(configurations == 65536, "all cut/protection/trace models exercised")
    require(joined > 0 and proper_guarded > 0, "nonvacuous guarded join cases")
    require((guarded, proper_guarded, joined) == (17632, 13536, 2297856),
            "locked guardian/splice join counts")
    return {
        "cut_protection_trace_configurations": configurations,
        "certified_guarded_trace_configurations": guarded,
        "certified_with_proper_protected_subset": proper_guarded,
        "guarded_closed_splice_instances": joined,
    }


def verify_pr205_boundary_controls():
    # Common-action selection is weaker than factoring entire safe sets.
    same_cut_safe_sets = (frozenset({0}), frozenset({0, 1}))
    require(same_cut_safe_sets[0] != same_cut_safe_sets[1], "safe sets do not factor")
    require(set.intersection(*(set(s) for s in same_cut_safe_sets)) == {0},
            "PR205 still supplies a common safe selector")
    empty_safe_sets = (frozenset(), frozenset())
    require(empty_safe_sets[0] == empty_safe_sets[1], "empty safe sets factor")
    require(not set.intersection(*(set(s) for s in empty_safe_sets)),
            "factorization without a safe choice supplies no guardian")

    # Both donor actions preserve a GLOBAL correlation predicate. Their
    # block splice closes dynamically but is not a safe mixed action.
    seed = (0, 0)
    identity, flip = (0, 1), (1, 0)
    left, right = (identity, identity), (flip, flip)
    protected = frozenset({(0, 0), (1, 1)})
    require(all(transition(p, s) in protected
                for p, s in product((left, right), protected)), "safe donor actions")
    mixed = mix(left, right, (0, 1))
    trace = run(mixed, seed, 2)
    require(trace[-1] == seed and trace[1] not in protected,
            "injective seam closure does not imply action-splice safety")

    # An injective seam on a lossy quotient needs that quotient to respect
    # block mixing. Otherwise equal observed endpoints can mix to a new cut.
    quotient = lambda s: s[0] ^ s[1]
    left, right = ((0, 0), (0, 0)), ((1, 1), (1, 1))
    lt, rt = run(left, seed, 1), run(right, seed, 1)
    mixed_end = run(mix(left, right, (0, 1)), seed, 1)[-1]
    require(quotient(lt[-1]) == quotient(rt[-1]) == quotient(seed),
            "donor quotient cuts close under identity seam")
    require(quotient(mixed_end) != quotient(seed),
            "lossy quotient without block compatibility breaks closure")
    return [
        "common safe selector can exist when entire safe sets do not factor",
        "factoring empty safe sets does not supply a guardian",
        "safe donor actions can have an unsafe mixed action despite cyclic closure",
        "injective quotient seam still needs cut/block-splice compatibility",
    ]


def main():
    report = {
        "status": "PASS",
        "shared_cut_transfer": verify_injective_shared_cut(),
        "exact_fiber_criterion": verify_seam_fibers(),
        "missing_hypothesis_controls": verify_missing_hypotheses(),
        "pr205_guarded_splice_join": verify_guarded_splice_join(),
        "pr205_boundary_controls": verify_pr205_boundary_controls(),
        "scope": "Finite exact diagnostics; Lean checks are reported separately; no physical seam, provenance, or universe-UPT certificate.",
    }
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
