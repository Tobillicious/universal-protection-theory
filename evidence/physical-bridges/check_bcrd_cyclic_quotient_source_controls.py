#!/usr/bin/env python3
"""Frozen BCRD P0/N1/N2-inspired quotient/cyclic finite source controls."""
from itertools import product

STATES = tuple(product((0, 1), repeat=2))


def cut_q(state):
    return state[0]


def gauge_flip(state):
    return (state[0], 1 - state[1])


def future_p0(state):
    return (state[0],)


def future_n1(state):
    return (state[0], state[0] ^ state[1])


def quotient_if_congruent(domain, cut, update, out_cut=None):
    out_cut = out_cut or cut
    image = {}
    for state in domain:
        x = cut(state)
        y = out_cut(update(state))
        if x in image and image[x] != y:
            return None
        image[x] = y
    return image


def run():
    # Frozen source P0: changing n affects neither declared cut nor future.
    assert all(cut_q(gauge_flip(s)) == cut_q(s) for s in STATES)
    assert all(future_p0(gauge_flip(s)) == future_p0(s) for s in STATES)
    quotient = quotient_if_congruent(STATES, cut_q, gauge_flip)
    assert quotient == {0: 0, 1: 1}
    assert not any(gauge_flip(s) == s for s in STATES)
    assert all(quotient[x] == x for x in quotient)
    assert all(gauge_flip(gauge_flip(s)) == s for s in STATES)

    # Frozen source N1: q alone loses future-predictive n dependence.
    assert quotient_if_congruent(
        STATES, cut_q, lambda s: s, out_cut=future_n1
    ) is None
    assert future_n1((0, 0)) != future_n1((0, 1))

    # Frozen source N2: a separate conserved c remains in the ledger.
    ledger_n2 = lambda s: s
    assert cut_q((0, 0)) == cut_q((0, 1))
    assert ledger_n2((0, 0)) != ledger_n2((0, 1))

    # Physical q-intervention is distinct from gauge n-flip.
    flip_q = lambda s: (1 - s[0], s[1])
    qflip = quotient_if_congruent(STATES, cut_q, flip_q)
    assert qflip == {0: 1, 1: 0}

    # A pair of updates compatible with the same q composes on the quotient.
    for s in STATES:
        lhs = cut_q(flip_q(gauge_flip(s)))
        rhs = qflip[quotient[cut_q(s)]]
        assert lhs == rhs

    print("PASS: source P0 q/n gauge flip gives cut-level period 1 but no micro fixed point")
    print("PASS: source N1 future-sensitive n defeats q-only predictive quotient")
    print("PASS: source N2 q-only quotient omits independent conserved ledger c")
    print("PASS: cut-compatible composition and distinguishable q intervention")
    print("LIMIT: frozen-source-inspired finite controls; not physical X3 or cosmology")


if __name__ == "__main__":
    run()
