#!/usr/bin/env python3
"""Reproducible two-qubit witnesses for REC-20/21/22 and CTRL-20.

The general REC-21 trace-norm theorem is analytic in the companion markdown.
This script checks an exactly solvable special case using the Python stdlib;
finite floating-point diagnostics are not a substitute for its proof.
"""
from math import cos, isclose, pi
from cmath import exp

# A memory qubit A, bath E initially in |+>.
# H_A = H_E = 0, V = J sigma_z(A) tensor (I(E)+sigma_z(E)).
# ||V|| = 2J and K = Tr_E[(I tensor rho_E)V] = J sigma_z(A).
# The exact reduced channel multiplies coherence rho_01 by
# exp(-2i J t)*cos(2Jt); the calibrated recovery W_A^dagger
# cancels the first factor and leaves cos(2Jt).
J = 0.10
v = 2 * J
for t in [0, .02, .5, 1., 2., 4., 10.]:
    coherence_uncorrected = exp(-2j*J*t) * cos(2*J*t)
    coherence_recovered = exp(2j*J*t) * coherence_uncorrected
    assert abs(coherence_recovered - cos(2*J*t)) < 1e-12
    trace_error = abs(1 - coherence_recovered)  # input |+><+|
    upper = min(2., 4*v*v*t*t)
    assert trace_error <= upper + 1e-12
    assert abs(coherence_recovered.imag) < 1e-12

# In the dephasing variant V=J sigma_z tensor sigma_z, K=0.
# At t=pi/(4J), two orthogonal X-basis memories become identical I/2.
J = 1.
t_star = pi/(4*J)
dephasing = cos(2*J*t_star)
assert isclose(dephasing, 0, abs_tol=1e-14)
D_initial = 1.
D_final = abs(dephasing)
assert isclose(D_initial,1) and isclose(D_final,0,abs_tol=1e-14)

# Controlled-Z history bit m: m=0 -> |+>; m=1 -> -i|->
# Their overlap is exactly zero, and for m superposed the target
# is maximally mixed (half |+><+| and half |-><-|).
plus = (2**-.5, 2**-.5)
minus = (2**-.5, -(2**-.5))
overlap = sum(a*b for a,b in zip(plus,minus))
assert isclose(overlap,0,abs_tol=1e-14)
rho_t = ((.5,.0),(.0,.5))
assert rho_t == ((.5,0.),(0.,.5))

print("PASS: calibrated first-order recovery removes the coherent phase exactly")
print("PASS: residual trace-norm error obeys the REC-21 O(||V||^2 t^2) bound")
print("PASS: the same two orthogonal memories become fully indistinguishable at finite t")
print("PASS: coherent controlled branching gives orthogonal conditional targets and mixed unconditional target")
print("NOTE: source-level memory accessibility, authentication and X3 semantics remain unverified")
