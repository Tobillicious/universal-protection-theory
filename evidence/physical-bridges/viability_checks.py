#!/usr/bin/env python3
"""Finite exact checks of greatest robustly invariant sets in toy state spaces.
Not a general proof; the Lean results prove the abstract implications.
"""
from itertools import product

def check():
    tested = 0
    for n in (1, 2, 3):
        for transition in product(range(n), repeat=2 * n):
            for mask in range(1 << n):
                safe = {s for s in range(n) if mask & (1 << s)}
                k = set(safe)
                for _ in range(n):
                    k = {s for s in k if any(transition[2*s+a] in k for a in (0, 1))}
                fixed = {s for s in k if any(transition[2*s+a] in k for a in (0, 1))}
                assert fixed == k, (n, transition, safe, k)
                assert k <= safe
                # Outside the greatest fixed point no forever-safe memoryless policy exists.
                for s in range(n):
                    if s in k:
                        assert any(transition[2*s+a] in k for a in (0, 1))
                    else:
                        assert s not in fixed
                tested += 1
    assert tested == 5898, tested
    print(f"PASS: {tested} exact small-model robust-viability instances")

if __name__ == "__main__":
    check()
