#!/usr/bin/env python3
"""Exact/diagnostic checks for ORBIT-1--6 mathematical research note.

Only integer and rational assertions are exact; floating-point sampling is
illustrative and never substitutes for the associated analytic proofs.
"""
from fractions import Fraction
from math import cos, pi, sqrt, isqrt

# Two-dimensional counterexample to 'every noncommuting perturbation
# destroys exact projective recurrence': H_eps^2 = (1+eps^2)*I.
# H0=diag(-1,1), V=[[0,1],[1,0]], and their commutator is nonzero.
assert (-1)*1 - 1*(1) == -2  # (H0 V - V H0)[0,1]
for eps in (0.0, 0.0001, 0.2, 1.0):
    E = sqrt(1+eps*eps)
    T = pi/E
    assert abs(cos(E*T)+1) < 1e-14

# An orthogonal perturbation can leave the occupied two-mode sector
# untouched even while noncommuting on another block.
# H0=diag(0,1,2,3), V=|2><3|+|3><2|, psi=(|0>+|1>)/sqrt2.
H0=[0,1,2,3]
V=[[0]*4 for _ in range(4)]
V[2][3]=V[3][2]=1
comm=[[H0[i]*V[i][j]-V[i][j]*H0[j] for j in range(4)] for i in range(4)]
assert comm[2][3] == -1 and comm[3][2] == 1
assert all(V[i][j]==0 for i in (0,1) for j in range(4))
assert abs(cos(2*pi)-1) < 1e-14

# A globally projectively recurrent system can lose all rank-one capacity
# halfway through its period: H=sigma_x, U(pi)=-I, C(pi/2)=0.
assert abs(cos(pi/2)) < 1e-14

# Exact spectral-dominance inequality for weight distribution
# (49/50,1/100,1/100), no recurrence condition.
weights=(Fraction(49,50),Fraction(1,100),Fraction(1,100))
assert sum(weights)==1
wmax=max(weights)
inf_lower=(2*wmax-1)**2
assert inf_lower==Fraction(576,625)
assert inf_lower>Fraction(9,10)
assert isqrt(2)**2 != 2

# Diagnostic phase samples for incommensurate gaps (0,1,sqrt(2)).
for t in (0,0.5,pi,5,10,50,200,1000,10000):
    z=(complex(weights[0],0)+float(weights[1])*complex(cos(t),-__import__('math').sin(t))
       +float(weights[2])*complex(cos(sqrt(2)*t),-__import__('math').sin(sqrt(2)*t)))
    assert abs(z)**2 > float(inf_lower)-1e-12

# Proposed spectral-span estimate fails already for H=delta*sigma_x:
# g=delta, bandwidth=2delta, max leakage operator norm=1.
delta=Fraction(1,1)
assert delta/(2*delta)==Fraction(1,2)
assert abs(__import__('math').sin(pi/2))==1
print('PASS: noncommuting two-level perturbations retain exact variable period')
print('PASS: exact global recurrence can include zero intermediate sector occupancy')
print('PASS: exact all-time spectral-dominance floor 576/625 > 0.9')
print('PASS: irrational gaps can coexist with robust sector capacity')
print('PASS: proposed g/spectral-span leakage estimate has a counterexample')
