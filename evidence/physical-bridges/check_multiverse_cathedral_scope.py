#!/usr/bin/env python3
"""Exact finite shadows of banked universal-scope and top-policy theorems.

NOT a physical multiverse model, a new Lean compile, or UPT implementation.
"""
from itertools import product


def strict_subset(a, b):
    return a != b and (a & b) == a


def scope_max(scope, feasible, outcome):
    return outcome in feasible and not any(
        strict_subset(outcome & scope, q & scope) for q in feasible
    )


def needless_loss(feasible, outcome):
    return any(strict_subset(outcome, q) for q in feasible)


def check_scope_theorem():
    total = 0
    scopes = 0
    correct_scopes = 0
    violating_witnesses = 0
    for n in range(4):
        M = 1 << n
        universe = M - 1
        for scope in range(M):
            scopes += 1
            guarantee = True
            witness = False
            for familymask in range(1 << M):
                feasible = tuple(q for q in range(M) if familymask & (1 << q))
                for o in range(M):
                    total += 1
                    bad = scope_max(scope, feasible, o) and needless_loss(feasible, o)
                    if bad:
                        guarantee = False
                        witness = True
            assert guarantee == (scope == universe), (n, scope)
            if guarantee:
                correct_scopes += 1
            if witness:
                violating_witnesses += 1
            for cutmask in range(M):
                all_local = ((scope & cutmask) == cutmask and
                    (scope & (universe ^ cutmask)) == (universe ^ cutmask))
                assert all_local == (scope == universe)
    return total, scopes, correct_scopes, violating_witnesses


def check_multiverse_common_top():
    families = 0
    joinable = 0
    joint_top = 0
    for n in range(1, 4):
        M = 1 << n
        for familymask in range(1, 1 << M):
            feasible = tuple(q for q in range(M) if familymask & (1 << q))
            joinable_now = all(
                any(((p | q) & r) == (p | q) for r in feasible)
                for p in feasible for q in feasible
            )
            greatest_now = any(
                all((q & r) == q for q in feasible) for r in feasible
            )
            assert joinable_now == greatest_now
            joinable += joinable_now
            joint_top += greatest_now
            families += 1
    assert families == 273
    policies = (0b01, 0b10)
    assert any(p & 0b01 for p in policies)
    assert any(p & 0b10 for p in policies)
    assert not any(p & 0b11 == 0b11 for p in policies)
    return families, joinable, joint_top


if __name__ == '__main__':
    a = check_scope_theorem()
    b = check_multiverse_common_top()
    assert a == (16658, 15, 4, 11), a
    print(f'PASS universal-scope law: {a[0]:,} scope/family/outcome checks')
    print(f'PASS: {a[1]} scopes; {a[2]} complete and {a[3]} incomplete with counterexamples')
    print(f'PASS: {b[0]} nonempty global policy families; {b[1]} union-closed/top')
    print('PASS: per-world successful policies need not combine into one global policy')
    print('LIMIT: conditional scope and greatestness, not actual physical UPT')
