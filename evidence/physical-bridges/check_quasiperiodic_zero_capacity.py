#!/usr/bin/env python3
"""Reproduce the three-mode incommensurate full-leakage witness numerically.

The exact proof is the trigonometric identity in the accompanying research note;
finite floating-point diagnostics are not a substitute for it.
"""
from math import cos, isqrt, pi, sin, sqrt

# Eigenvalues 0, 1, sqrt(2); all occupied weights are strictly positive.
t = 7*pi/3
beta = pi*(4 - 7*sqrt(2)/3)
assert 2*pi/3 < beta < pi

# Positive barycentric coordinates:
# a0*1 + a1*exp(i5pi/3) + a2*exp(i beta) = 0.
a0 = sin(5*pi/3-beta)
a1 = sin(beta)
a2 = sin(pi/3)
assert min(a0,a1,a2)>0
S = a0+a1+a2
w = (a0/S,a1/S,a2/S)
assert abs(sum(w)-1)<1e-14
z_real = w[0]+w[1]*cos(t)+w[2]*cos(sqrt(2)*t)
z_imag = -w[1]*sin(t)-w[2]*sin(sqrt(2)*t)
assert z_real*z_real+z_imag*z_imag < 1e-26

# For rank-one P=|psi><psi|, ||QHP||^2 = Var_psi(H).
meanE = w[1]+sqrt(2)*w[2]
meanE2 = w[1]+2*w[2]
g2 = meanE2-meanE*meanE
assert g2>0
assert isqrt(2)**2!=2 # sqrt(2) is irrational
print('PASS: three occupied incommensurate eigenmodes with positive weights')
print('PASS: phase cancellation diagnostic C(7pi/3) =', z_real*z_real+z_imag*z_imag)
print('PASS: nonzero cross-sector coupling g =',sqrt(g2))
print('PASS: irrational gaps preclude an exact global or initial-state return')
print('t0 =',t,'weights =',w)
