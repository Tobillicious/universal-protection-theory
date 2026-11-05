#!/usr/bin/env python3
"""Finite CYCLIC-G2-JOIN-01 controls. Not a Lean or physical BCRD certification."""
from itertools import product

BITS = (0, 1)
STATES = tuple(product(BITS, repeat=2))
UNARY_MAPS = tuple(product(BITS, repeat=2))
POLICIES = tuple(product(UNARY_MAPS, repeat=2))


def local_step(policy, state):
    return tuple(policy[i][state[i]] for i in (0, 1))


def run(step, state, count):
    for _ in range(count):
        state = step(state)
    return state


def splice(p, q, choose):
    return tuple((p if choose[i] == 0 else q)[i] for i in (0, 1))


def check():
    tested = eligible = nonconstant = 0
    for p, q, choose, start, n in product(
            POLICIES, POLICIES, STATES, STATES, (1, 2, 3, 4)):
        tested += 1
        selected = splice(p, q, choose)
        for k in range(n + 1):
            current = run(lambda s: local_step(selected, s), start, k)
            for i in (0, 1):
                source = p if choose[i] == 0 else q
                source_state = run(lambda s: local_step(source, s), start, k)
                assert current[i] == source_state[i]
        if (run(lambda s: local_step(p, s), start, n) == start and
            run(lambda s: local_step(q, s), start, n) == start):
            eligible += 1
            assert run(lambda s: local_step(selected, s), start, n) == start
            if run(lambda s: local_step(selected, s), start, 1) != start:
                nonconstant += 1

    # Non-local controls: both source maps close after two steps at s0,
    # but their blockwise hybrid is not period-two at s0.
    def flip_both(s):
        return (1 - s[0], 1 - s[1])

    def swap(s):
        return (s[1], s[0])

    def bad_splice(s):
        return (flip_both(s)[0], swap(s)[1])

    initial = (0, 0)
    assert run(flip_both, initial, 2) == initial
    assert run(swap, initial, 2) == initial
    assert run(bad_splice, initial, 2) != initial
    assert swap((0, 0))[1] != swap((1, 0))[1]

    print(f"PASS: {tested} finite local-block source-policy cases")
    print(f"PASS: {eligible} matched closure premises imply spliced closure")
    print(f"PASS: {nonconstant} eligible cases have nonconstant internal update")
    print("PASS: nonlocal cross-block control loses source period-two closure")
    print("LIMIT: neither source authorization nor physical cyclic matterspacetime proved")


if __name__ == "__main__":
    check()
