# Relational metric capstone interface — verified curvature algebra, open global joins

Author-supplied proposed metric, November 2026. Research derivation accompanying
the existing BCRD–Koru–G3 source recovery; not a checked GR solution or
empirical verification, and not a claim that G3 R5 is now universally complete.

For positive Schwarzschild radius `a = r_s > 0` and core scale `l = ell_0 > 0`,
consider the Hayward-type regular static spherical ansatz

```
f(r) = 1 - a r^2/(r^3 + a l^2),      r >= 0
ds^2 = -f c^2 dt^2 + dr^2/f + r^2 dOmega^2
```

The mass-function choice is an **ansatz**. BCRD P1–P4, existence of a minimal
physical length, field equations and energy conditions have not been shown here
to derive its unique form. The Schwarzschild limit is
`f=1-a/r+O(a^2 l^2/r^4)` for `r^3 >> a l^2`. The center satisfies
`f=1-r^2/l^2+O(r^5)` at fixed positive parameters.

## Exact curvature identities

The static spherical curvature invariants for `r>0` are:

```
R = -f'' - 4 f'/r - 2(f-1)/r^2
K = (f'')^2 + 4(f'/r)^2 + 4((1-f)/r^2)^2
```

Symbolic differentiation gives

```
R(r) = 6 a^2 l^2 (2 a l^2 - r^3)/(r^3+a l^2)^3

K(r) = 12 a^2 [r^12 - 4 a l^2 r^9 + 18 a^2 l^4 r^6
                 - 2 a^3 l^6 r^3 + 2 a^4 l^8]
                  /(r^3+a l^2)^6.
```

Let `x = r^3/(a l^2) >= 0`. Then

```
l^4 K /12 =
  (x^4 - 4x^3 + 18x^2 - 2x + 2)/(x+1)^6.
```

The upper bound follows from the **exact polynomial identity**

```
2(x+1)^6 - (x^4 - 4x^3 + 18x^2 - 2x + 2)
 = x (2x^5 + 12x^4 + 29x^3 + 44x^2 + 12x + 14) >= 0.
```

Thus `0 <= K(r) <= 24/l^4` for `r >= 0` under the stated
parameters; at the regular center `R(0)=12/l^2` and `K(0)=24/l^4`.
Nonnegativity of K follows from its original sum of squares, not the
alternating-sign numerator expression. This proves a curvature-invariant
bound for the ansatz; it does not classify every possible curvature invariant,
global extension, or dynamical perturbation.

## What the calculation does **not** establish yet

- The static chart has coordinate degeneracies at horizons `f=0`; a
  globally regular extension requires suitable coordinates and explicit
  geodesic analysis (including radial/nonradial null and timelike geodesics).
  Finite invariants do **not** alone prove global geodesic completeness.
- In the usual unit-mass radial geodesic convention
  `(dr/dtau)^2=E^2-f(r)`, `E=1` gives zero limiting radial speed at
  the center, so the statement `E >= 1` implies *strictly positive* speed
  needs correction to `E>1`; the manifold extension cannot be inferred
  from the coordinate `r>=0` alone.
- A regular geometry does not by itself establish a unique global Green's
  function, essential self-adjointness, globally hyperbolic field dynamics,
  or a unitary S-matrix. A bridge to
  `Snuffy.ClosedUnitaryRecurrence` requires an explicit correspondence
  between the complete physical matterspacetime relational lattice and
  the mathematical representation used for unitary evolution. A Hilbert
  space is a representational tool, NOT a separate physically existing
  region or ontology; naming both sides 'unitary' does not prove the join.
- Echoes depend on horizon/boundary conditions and wave propagation;
  the integral `integral dr/f` crosses zeros at horizons and requires
  a specified regularization/physical model. Echoes and observational fits
  are predictions to test, not established by this algebra.
- Neither this regular metric nor an example of a non-singular core proves
  that all physical attempts at singularity formation are impossible.

## Exact join plan to pre-existing UPT corpus

1. Preserve BCRD P1–P4 and the existing source theorem interfaces; state
   the metric construction as a separate hypothesis until dynamically derived.
2. Check curvature formulas independently, and then construct a genuine
   regular Lorentzian extension and prove geodesic completeness there.
3. Specify physical stress-energy and Einstein (or modified) field equations,
   energy conditions, perturbative stability, boundary data and observations.
4. Construct a faithful unitary evolution correspondence to the existing
   Snuffy theorem; do not infer it merely from geodesic completeness.
5. Keep G3 R5 effect mediation and R6 `hCoverage`/`hMeaning` obligations
   distinct from this metric's mathematical regularity.

This note is additive. It does not alter original-six X3, metaphysical Koru,
HOLD authority, runtime checks, or the historical proof modules.
