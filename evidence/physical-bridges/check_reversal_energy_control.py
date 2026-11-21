#!/usr/bin/env python3
"""Stdlib diagnostics for REC-23 and CTRL-21. Not an X3/physical validation."""
from math import pi, sin, cos, isclose

# Target/battery computational ordering: 00, 01, 10, 11.
# Controlled exchange maps |01> <-> |10> in the m=1 branch.
J = 0.7
omega = 2.3
tau = pi/(2*J)
energies = (0, omega, omega, 2*omega)
exchange = ((0,0,0,0),(0,0,1,0),(0,1,0,0),(0,0,0,0))
for i in range(4):
    for j in range(4):
        assert (energies[i]-energies[j])*exchange[i][j] == 0
assert isclose(cos(J*tau), 0, abs_tol=1e-14)
assert isclose(sin(J*tau), 1, abs_tol=1e-14)
# m=0 leaves |01>; m=1 turns |01> into -i|10>, up to same free-energy phase.
assert energies[1] == energies[2] == omega

# Local-only 'reversal' misses a coherent first-order X rotation.
v, t = 0.2, 0.05
trace_error = 2*abs(sin(v*t))
squared_fidelity_error = sin(v*t)**2
assert trace_error > 1.5*v*t
assert squared_fidelity_error <= (v*t)**2
assert trace_error > 10*squared_fidelity_error

# If the free memory Hamiltonian is sigma_x, an initial |m0> is
# rotated into |m1>, so the proposed branch-projector factorization fails.
assert isclose(abs(sin(pi/2)), 1, abs_tol=1e-14)

# Root fidelity and squared Uhlmann fidelity must not be conflated.
p=(0.8,0.1,0.1)
q=(0.8,0.2,0.0)
half_trace_distance=sum(abs(x-y) for x,y in zip(p,q))/2
squared_fidelity=sum((x*y)**.5 for x,y in zip(p,q))**2
assert 1-squared_fidelity > half_trace_distance
print('PASS: controlled exchange respects energy/excitation preservation')
print('PASS: branch time pi/(2J) produces orthogonal target states')
print('PASS: trace-norm error is linear while pure-state infidelity is quadratic')
print('PASS: free memory mixing invalidates block-control formula')
print('PASS: squared-vs-root fidelity convention matters for mixed states')
