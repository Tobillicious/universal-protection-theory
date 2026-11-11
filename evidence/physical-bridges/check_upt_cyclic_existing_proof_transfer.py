#!/usr/bin/env python3
"""Finite cyclic-feasibility and historical-prefix controls.
Diagnostic only: no BCRD physical cyclicity or reproof of UPT/X3.
"""
from itertools import product

def prefixes(s):
    return tuple(s[:i] for i in range(len(s) + 1))

def strict_history_cycle_exists(alphabet=(0, 1), max_length=3, max_cycle=3):
    histories = [t for n in range(max_length + 1) for t in product(alphabet, repeat=n)]
    prefix = {(a, b) for b in histories for a in prefixes(b)}
    tested = 0
    for length in range(1, max_cycle + 1):
        for cycle in product(histories, repeat=length):
            if all((cycle[i], cycle[(i + 1) % length]) in prefix for i in range(length)):
                assert all(cycle[i] == cycle[0] for i in range(length))
            tested += 1
    return tested

def top_exists(choices):
    return any(all(c <= p for c in choices) for p in choices)

def union_closed(choices):
    return all(any(a | b <= c for c in choices) for a, b in product(choices, repeat=2))

def test_unions():
    states = tuple(frozenset(j for j in range(2) if (mask >> j) & 1)
                   for mask in range(4))
    families = [tuple(states[j] for j in range(4) if (mask >> j) & 1)
                for mask in range(1, 16)]
    for choices in families:
        assert union_closed(choices) == top_exists(choices)
    return len(families)

def test_cyclic_choice_and_selection():
    def closed_history(action):
        carrier = (0, 1, 0)
        kept = frozenset({'existing_A'}) if action == 'keep' else frozenset()
        return carrier, kept

    end_carrier, end_keep = closed_history('end')
    keep_carrier, keep_keep = closed_history('keep')
    assert end_carrier == keep_carrier
    assert end_carrier[0] == end_carrier[-1]
    assert end_keep < keep_keep
    assert union_closed([end_keep, keep_keep])
    # A closed history can select the dominated outcome despite a top's existence.
    assert not all(other <= end_keep for other in (end_keep, keep_keep))
    assert all(other <= keep_keep for other in (end_keep, keep_keep))

    # Distinct, independently consistent closed options may lack a common top.
    exclusive = [frozenset({'A'}), frozenset({'B'})]
    assert not union_closed(exclusive) and not top_exists(exclusive)

if __name__ == '__main__':
    count = strict_history_cycle_exists()
    assert count == 3615
    print(f'PASS: {count} finite list-cycle candidates; no strict literal prefix loop')
    n = test_unions()
    assert n == 15
    print(f'PASS: all {n} finite outcome families over two existing particulars')
    test_cyclic_choice_and_selection()
    print('PASS: cyclic carrier does not force protection-aligned selection')
    print('PASS: cyclic option family need not satisfy G9 union feasibility')
    print('LIMIT: finite diagnostics, not physical BCRD/UPT/X3 proof')
