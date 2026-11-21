#!/usr/bin/env python3
"""Exact finite-classical process checks for BCRD HCF-02 (not BCRD physics)."""
from fractions import Fraction

K = ((Fraction(3, 4), Fraction(1, 4)),
     (Fraction(1, 4), Fraction(3, 4)))

def evolve(row):
    return tuple(sum(row[i] * K[i][j] for i in range(2)) for j in range(2))

a = (Fraction(1), Fraction(0))
b = (Fraction(0), Fraction(1))
for n in range(1, 13):
    a, b = evolve(a), evolve(b)
    tv = sum(abs(a[j] - b[j]) for j in range(2)) / 2
    assert tv == Fraction(1, 2 ** n), (n, tv)
    minimum_worst_input_decoder_error = (1 - tv) / 2
    assert minimum_worst_input_decoder_error >= 0
print("PASS: exact-rational Markov erasure formula for n=1..12")

# On a finite classical operational channel, an exact uniform
# decoder exists precisely when the protected labels' supports do not overlap.
cases = [
    (((1, 0, 0), (0, 1, 0)), True),
    (((Fraction(1, 2), Fraction(1, 2), 0), (0, 0, 1)), True),
    (((Fraction(1, 2), Fraction(1, 2), 0),
      (0, Fraction(1, 2), Fraction(1, 2))), False),
]
for output_rows, expected in cases:
    has_disjoint_supports = all(
        not (output_rows[0][j] > 0 and output_rows[1][j] > 0)
        for j in range(len(output_rows[0]))
    )
    assert has_disjoint_supports == expected
print("PASS: exact split-decoder support criterion controls")
print("LIMIT: these tests do not establish original BCRD B1-B7, physical identity or X3")
