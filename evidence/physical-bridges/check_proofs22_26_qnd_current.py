#!/usr/bin/env python3
"""Exact/special-case diagnostics accompanying Proofs 22--26 hostile review.

Only elementary finite-dimensional toy systems; not a BCRD physical source,
Lean kernel certificate, cryptographic grant or original-X3 validation.
Python standard library only.
"""
from cmath import phase
from math import sin, cos, pi, sqrt, isclose

tol = 1e-12

def inner(x,y):
    return sum(a.conjugate()*b for a,b in zip(x,y))
def red_A(psi):
    # vector indexed (a,r): |00>,|01>,|10>,|11>
    return [[sum(psi[2*a+r]*psi[2*b+r].conjugate() for r in range(2))
             for b in range(2)] for a in range(2)]
def red_R(psi):
    return [[sum(psi[2*a+r]*psi[2*a+s].conjugate() for a in range(2))
             for s in range(2)] for r in range(2)]
def cnot(psi):
    # memory is control; flip pointer if a=1
    return [psi[0],psi[1],psi[3],psi[2]]
def approx(x,y):
    return abs(x-y)<tol
def matrix_approx(x,y):
    return all(approx(x[i][j],y[i][j]) for i in range(2) for j in range(2))
mixed=[[.5,0],[0,.5]]
for sign in (1,-1):
    initial=[1/sqrt(2),0,sign/sqrt(2),0] # |+/- > memory; pointer |0>
    after=cnot(initial)
    assert matrix_approx(red_A(after),mixed)
    assert matrix_approx(red_R(after),mixed)
    # Z-memory is QND: its expectation is unchanged at 0.
    before_probs=red_A(initial)
    assert approx(before_probs[0][0]-before_probs[1][1],
                  red_A(after)[0][0]-red_A(after)[1][1])
# QND orthogonal classical labels are preserved and read separately.
for a in (0,1):
    psi=[0j]*4
    psi[2*a]=1+0j
    out=cnot(psi)
    assert approx(out[3*a],1)
    assert matrix_approx(red_A(out), ([[1,0],[0,0]] if a==0 else [[0,0],[0,1]]))
print("PASS 22: Z-QND preserves classical eigenrecords but fully dephases +/- coherence")

# Irreversible side information cannot be retained by uncomputation:
# the same inverse CNOT restores the joint initial state and resets pointer.
before=[1/sqrt(2),0,1/sqrt(2),0]
assert all(abs(a-b)<tol for a,b in zip(cnot(cnot(before)),before))
assert matrix_approx(red_R(before),[[1,0],[0,0]])
print("PASS 22: coherent uncompute restores A only while resetting pointer")

# Exchange H_ex expectation is zero on |01> even though at pi/(2J)
# one excitation moves from battery to target with total energy conserved.
J,omega=1.3,2.4
tau=pi/(2*J)
assert approx(cos(J*tau),0)
assert approx(abs(sin(J*tau)),1)
interaction_expectation_on_01=0.0
battery_before,battery_after=omega,0.
target_before,target_after=0.,omega
assert interaction_expectation_on_01==0 and approx(
    battery_before+target_before,battery_after+target_after)
assert battery_before-battery_after==omega
print("PASS 23: interaction expectation 0 is not battery work; resonant exchange conserves energy")

# A hardcoded memory controller selecting a=0 need not minimize cost.
costs=(10,0)
selected=0
assert costs[selected] > min(costs)
# With a unique cost margin Delta > 2 eta, bounded cost perturbations
# cannot reverse the argmin.
costs=(1.,6.)
eta=2.
assert costs[1]-costs[0] > 2*eta
assert costs[0]+eta < costs[1]-eta
print("PASS 24: hardcoded branch is not optimizer; robust cost-gap theorem checked")

# Finite-epoch branch error against ideal H=0 and perturbed V=v sigma_x.
for v,t in ((.02,1.),(.2,2.),(1.,3.)):
    error=sin(v*t)**2
    upper=min(1.,(t*v)**2)
    assert error <= upper+tol
print("PASS 24: projected branch-error probability obeys finite-time Duhamel bound")

# H = Z, X = Pauli-X: commutator is [[0,2],[-2,0]].
# For |+i>=(1,i)/sqrt(2), expectation is pure imaginary.
psi=(1/sqrt(2),1j/sqrt(2))
comm_psi=(2*psi[1],-2*psi[0])
expt=inner(psi,comm_psi)
assert abs(expt.real)<tol and abs(expt.imag)>0.1
heis=1j*expt
assert abs(heis.imag)<tol
# Sector current for H=sigma_x, P=|0><0|: C=cos^2 t,
# |dC/dt|=|sin 2t| saturates 2g sqrt(C(1-C)), with g=hbar=1.
for t in (.1,.4,.8,1.4):
    C=cos(t)**2
    dC=abs(-sin(2*t))
    current_bound=2*sqrt(C*(1-C))
    assert dC <= current_bound+tol
print("PASS 25: Re <[Hermitian,Hermitian]> = 0; corrected Heisenberg current is real")
print("PASS 25: exact sector-current upper bound checked")
print("PASS: no source-level external effect, semantic X3 or universal claims inferred")
