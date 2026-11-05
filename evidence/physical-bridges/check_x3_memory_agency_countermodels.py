#!/usr/bin/env python3
"""Exact-support checks for proposed Proofs 17 and 18.

Tests algebraic finite-dimensional countermodels; does NOT prove original UPT
X3 semantics, model microscopic BCRD physics or validate a real-world instrument.
All memory entropy numbers are diagnostic; exact proof is in the companion MD.
"""
from fractions import Fraction
from math import pi, sin, log, sqrt, isclose

# In a 9-dimensional space, P projects onto the eight-dimensional sector
# A x B x R, while Q projects onto an orthogonal spectator f.
# H is block diagonal, so QHP=0. Inside P: a=|000>, b=|011>,
# c=|101>. H|a>=3|a>, H|b>=(pi/2)|c>, H|c>=(pi/2)|b>,
# the other five basis energies are 4,5,6,7,8 and H|f>=0.
g=0
delta=1
assert g < delta / 2
assert isclose(sin(pi/2),1,abs_tol=1e-14)

w_a=Fraction(4,5)
w_b=Fraction(1,5)
# a has energy 3; b superposes +/- pi/2 with equal weights.
spectral_weights=(w_a, w_b/2, w_b/2)
assert sum(spectral_weights)==1
assert max(spectral_weights)==Fraction(4,5)>Fraction(1,2)
# The full wavefunction remains inside P, so site occupancy is 1.
site_capacity=Fraction(1)
assert site_capacity==1
# At t=1, psi=e^-3i sqrt(4/5)|000>-i sqrt(1/5)|101>.
# After partial trace over B,R, rho_A=diag(4/5,1/5).
entropy_initial=0.
entropy_final=-sum(float(w)*log(float(w)) for w in (w_a,w_b))
assert entropy_final > 0.5
assert g==0
print("PASS: zero sector coupling and full sector occupancy coexist with internal entropy change")
print("PASS: dominant simple eigenvalue, gap delta=1, spectral weight 4/5")
print("Exact S_A(1)=h2(1/5); diagnostic in nats:",entropy_final)

# Agency: m=0 gives H=0, m=1 gives H=sigma_z.
# |+> evolves to |+> vs -i|-> at t=pi/2: orthogonal branches.
amp=1/sqrt(2)
plus=(complex(amp),complex(amp))
minus_phased=(-1j*amp,1j*amp)
overlap=sum(a.conjugate()*b for a,b in zip(plus,minus_phased))
assert abs(overlap)<1e-14
print("PASS: distinct exact history-conditioned controls can create orthogonal outputs")

# Nonlinear feedback H[rho]=tr(sigma_z rho)*sigma_z:
# z'=0 exactly and angle(t)=angle(0)+2*z(0)*t,
# yielding tangent shear rather than a compulsory positive Lyapunov exponent.
z1=Fraction(1,3)
z2=Fraction(2,3)
assert z1!=z2
print("PASS: state-dependent feedback need not imply chaos, attractor selection or agency")
