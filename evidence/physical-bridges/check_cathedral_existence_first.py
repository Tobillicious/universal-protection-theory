#!/usr/bin/env python3
"""Finite shadows of existence-first quotient/cyclic transfer; not evidence of cosmology."""
from itertools import permutations, product

checked = equivariant = invariant_predicates = transfer_checks = 0
for n in range(1, 6):
    events = range(n)
    for m in range(1, n + 1):
        for pi in product(range(m), repeat=n):
            intrinsic_time = set(pi)
            assert intrinsic_time and all(
                any(pi[e] == t for e in events) for t in intrinsic_time)
            for f in permutations(events):
                checked += 1
                if any(pi[f[e]] != (pi[e] + 1) % m for e in events):
                    continue
                equivariant += 1
                assert set(pi) == set(range(m)), (n, m, pi, f)
                for bits in range(1 << n):
                    P = lambda e: bool((bits >> e) & 1)
                    if not all(P(f[e]) == P(e) for e in events):
                        continue
                    invariant_predicates += 1
                    for t0 in range(m):
                        assert any(pi[e] == t0 for e in events)
                        premise = all(P(e) for e in events if pi[e] == t0)
                        if premise:
                            assert all(P(e) for e in events)
                            transfer_checks += 1

assert checked > 0 and equivariant > 0 and transfer_checks > 0

# A cyclic event model can fail protection in both phases.
pi = (0, 1)
f = (1, 0)
P = (False, False)
assert all(pi[f[e]] == (pi[e] + 1) % 2 for e in range(2))
assert not any(P)

# A one-event ontology does not entail an infinite physical time axis.
E = (0,)
T = {0}
assert len(E) == 1 and len(T) == 1

phase_checks = 0
for m in range(2, 13):
    for n in range(-100, 101):
        assert n % m == (n + m) % m
        assert n != n + m
        phase_checks += 1

print(f"PASS: {checked:,} event-permutation/phase assignments")
print(f"PASS: {equivariant:,} equivariant systems, all time phases occupied")
print(f"PASS: {invariant_predicates:,} equivariant/invariant predicate assignments")
print(f"PASS: {transfer_checks:,} one-protected-phase to all-phases implications")
print(f"PASS: {phase_checks:,} phase-wrap/nonrepeating-history cases")
print("PASS: single-event and cyclic-but-unprotected independence countermodels")
print("LIMIT: no proof of cosmic recurrence, real guardians or physical UPT")
