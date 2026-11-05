#!/usr/bin/env python3
"""Small exact counterexample checks for proposed BCRD spectral-sieve Proofs 9/9.1.

This tests a mathematical three-level countermodel; it does NOT verify
a BCRD physical Hamiltonian or a protection-of-particulars theorem.
Standard library only.
"""
from fractions import Fraction
from math import isqrt, sqrt, sin, cos

weights = (Fraction(49, 50), Fraction(1, 100), Fraction(1, 100))
assert sum(weights) == 1
main, small1, small2 = weights
guaranteed_amplitude = main - small1 - small2
assert guaranteed_amplitude == Fraction(24, 25)
guaranteed_capacity = guaranteed_amplitude ** 2
assert guaranteed_capacity == Fraction(576, 625)
assert guaranteed_capacity > Fraction(9, 10)

# H = diag(0, 1, sqrt(2)) and P = |psi><psi|.
# g^2 = <H^2> - <H>^2 = (297 - 2 sqrt(2))/10000 > 0.
g_squared = (297 - 2 * sqrt(2)) / 10000
assert g_squared > 0
assert abs(g_squared - 0.029417157287525388) < 1e-14

# Each participating eigenmode must return with the same phase for an
# exact recurrence of |psi>. This would make sqrt(2) a rational number.
assert isqrt(2) ** 2 != 2

# Finite samples are only diagnostic; the rigorous bound is the triangle
# inequality proved in BOUNDARY-SELECTION-QUASIPERIODIC-AUDIT-2026-11-01.md.
def capacity(t):
    real = float(main) + float(small1)*cos(t) + float(small2)*cos(sqrt(2)*t)
    imag = -float(small1)*sin(t) - float(small2)*sin(sqrt(2)*t)
    return real * real + imag * imag

for t in (0, 0.125, 1, 10, 100, 1000, 10000, 100000):
    assert capacity(t) + 1e-12 >= float(guaranteed_capacity)

# Perfect recurrence does NOT imply persistence of every chosen P sector.
# H = sigma_x, P = |0><0|, U(pi)=-I, but C(pi/2)=cos(pi/2)^2=0.
assert abs(cos(3.141592653589793/2))**2 < 1e-28

print("PASS: exact rational all-time capacity lower bound 576/625 > 0.9")
print("PASS: incommensurate three-level spectrum and nonzero off-diagonal coupling")
print("PASS: numerical spot checks (not relied upon for the proof)")
print("PASS: exact recurrence does not itself imply sector survival")
print("NOTE: spectral and tomographic-gluing theorems require their separate analytic proofs")
