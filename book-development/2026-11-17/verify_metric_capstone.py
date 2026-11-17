"""Exact symbolic identities for the book's specified static metric.
This verifies algebra for a metric ansatz, not its derivation as a law of nature.
Run: python3 verify_metric_capstone.py
"""
import sympy as s

r, rs, ell, z = s.symbols("r rs ell z", positive=True)
f = 1 - rs*r**2/(r**3 + rs*ell**2)
fp = s.diff(f, r)
fpp = s.diff(fp, r)
Ricci = -fpp - 4*fp/r - 2*(f-1)/r**2
K = fpp**2 + 4*(fp/r)**2 + 4*((1-f)/r**2)**2
zr = r**3/(rs*ell**2)

fp_formula = r*(zr-2)/(ell**2*(1+zr)**2)
fpp_formula = -2*(zr**2-7*zr+1)/(ell**2*(1+zr)**3)
R_formula = 6*(2-zr)/(ell**2*(1+zr)**3)
Kz = 12*(z**4-4*z**3+18*z**2-2*z+2)/(ell**4*(1+z)**6)

checks = {
    "first_derivative": s.factor(fp-fp_formula),
    "second_derivative": s.factor(fpp-fpp_formula),
    "Ricci_identity": s.factor(Ricci-R_formula),
    "Kretschmann_identity": s.factor(K-Kz.subs(z,zr)),
}
for name, residual in checks.items():
    assert residual == 0, (name, residual)
    print(name + ": exact identity PASS")

gap = s.expand(ell**4 * (1+z)**6 * (24/ell**4-Kz))
expected_gap = 24*z**6+144*z**5+348*z**4+528*z**3+144*z**2+168*z
assert s.factor(gap-expected_gap) == 0
coeffs = s.Poly(expected_gap,z).all_coeffs()
assert all(c >= 0 for c in coeffs)
print("K <= 24/ell^4: denominator positive, nonnegative polynomial certificate PASS")
print("bound_gap_polynomial =", expected_gap)

assert s.limit(Ricci,r,0,dir="+") == 12/ell**2
assert s.limit(K,r,0,dir="+") == 24/ell**4
print("central curvature limits: PASS")

# For the horizon polynomial, its positive critical minimum determines the
# number of positive roots. This threshold is independent of coordinate choice.
horizon_poly = r**3-rs*r**2+rs*ell**2
horizon_min = s.factor(horizon_poly.subs(r,2*rs/3))
assert s.factor(horizon_min-rs*(ell**2-4*rs**2/27)) == 0
assert s.factor(horizon_poly.subs({rs:3*s.sqrt(3)*ell/2,r:s.sqrt(3)*ell})) == 0
print("horizon threshold rs^2 = 27 ell^2 / 4: PASS")

# For a radial timelike geodesic with E=1, the exact elapsed-time
# integrand is ell*sqrt(1+z(r))/r. Since z>=0, it is >= ell/r.
# Hence reaching r=0 takes infinite proper time in this marginal case.
radial_speed_squared = s.factor(1-f)
assert s.factor(radial_speed_squared-r**2/(ell**2*(1+zr))) == 0
print("E=1 radial speed squared = r^2/[ell^2(1+z)]: PASS")
print("E=1 core arrival: tau >= ell*log(r0/r) -> infinity")

print("ALL EXACT ALGEBRA CHECKS PASSED")
print("Not certified here: actual-world metric selection; global maximal extension;")
print("dynamical inner-horizon stability; quantum unitarity; recurrence; cosmic genesis.")

