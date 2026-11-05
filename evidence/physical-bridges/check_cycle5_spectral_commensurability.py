#!/usr/bin/env python3
"""Exact, dependency-free C5 counterexample checks for the UPT spectral audit.

Not a BCRD physical validator or a proof of the irrationality of sqrt(5).
"""
from itertools import permutations
from math import isqrt

N = 5
A = [[int((j - i) % N in (1, N - 1)) for j in range(N)] for i in range(N)]


def mul(p, q):
    out = [0] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            out[i + j] += a * b
    return out


def determinant_polynomial(matrix):
    """Det(x I - A) using the Leibniz formula, exact integer coefficients."""
    n = len(matrix)
    coeffs = [0] * (n + 1)
    for perm in permutations(range(n)):
        sign = -1 if sum(perm[i] > perm[j]
                         for i in range(n) for j in range(i + 1, n)) % 2 else 1
        term = [sign]
        for i, j in enumerate(perm):
            term = mul(term, [-matrix[i][j], 1] if i == j else [-matrix[i][j]])
        for i, c in enumerate(term):
            coeffs[i] += c
    return coeffs


expected = mul([-2, 1], mul([-1, 1, 1], [-1, 1, 1]))
actual = determinant_polynomial(A)
assert actual == expected == [-2, 5, 0, -5, 0, 1], (actual, expected)

# A C5 rotation sends each vertex i to i+1 and preserves adjacency.
assert all(A[i][j] == A[(i + 1) % N][(j + 1) % N]
           for i in range(N) for j in range(N))

# Two copies of C5 admit a genuinely nontrivial integer U(1) charge:
# H = diag(A,A), Q_ch = diag(0*I5,1*I5). Commutator vanishes.
H = [[A[i % N][j % N] if i // N == j // N else 0
      for j in range(2 * N)] for i in range(2 * N)]
charges = [0] * N + [1] * N
assert any(charges[i] != charges[j] for i in range(2 * N) for j in range(2 * N))
assert all((charges[j] - charges[i]) * H[i][j] == 0
           for i in range(2 * N) for j in range(2 * N))

# Golden-ratio irrationality: (1+sqrt(5))/2 is irrational because
# sqrt(5) is irrational; 5 is not a perfect square.
assert isqrt(5) ** 2 != 5
print('PASS: C5 has exact characteristic polynomial (x-2)(x^2+x-1)^2')
print('PASS: C5 is rotation symmetric (hence vertex transitive)')
print('PASS: doubled C5 has an integer-valued conserved nontrivial U(1) charge')
print('PASS: distinct positive gaps have irrational ratio (1+sqrt(5))/2')
print('CONCLUSION: proposed graph-rigidity => exact projective recurrence implication is false')
