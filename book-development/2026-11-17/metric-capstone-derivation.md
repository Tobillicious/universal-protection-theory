# Metric capstone: the complete curvature-bound derivation for the stated ansatz

This section proves the scalar-curvature bound claimed for the metric already in the draft. It does not identify a chosen regular example with a uniquely derived complete-Koru physical law.

## Geometry and attribution

For \(r_s>0\) and \(\ell>0\), take:

\[
ds^2=-f(r)c^2dt^2+\frac{dr^2}{f(r)}+r^2d\Omega^2,\qquad
f(r)=1-\frac{r_s r^2}{r^3+r_s\ell^2}.
\]

This is the static Hayward metric, with \(r_s=2m\) in geometric units. Hayward's equation (5) gives this function. See [Formation and evaporation of non-singular black holes](https://arxiv.org/html/gr-qc/0506126).

Put \(z=r^3/(r_s\ell^2)\ge0\). For \(r>0\), direct differentiation gives:

\[
f'=\frac{r(z-2)}{\ell^2(1+z)^2},\qquad
f''=-\frac{2(z^2-7z+1)}{\ell^2(1+z)^3}.
\]

Every displayed denominator is positive.

## Ricci scalar

Substitution into \(R=-f''-4f'/r-2(f-1)/r^2\) yields:

\[
\boxed{R(r)=\frac{6(2-z)}{\ell^2(1+z)^3}},\qquad
\lim_{r\to0}R(r)=\frac{12}{\ell^2}.
\]

The intermediate divisions by \(r\) have removable limits for this ansatz.

## Kretschmann invariant and global bound

The spherical metric gives:

\[
K=(f'')^2+4(f'/r)^2+4((1-f)/r^2)^2.
\]

Thus:

\[
\boxed{K(r)=
\frac{12(z^4-4z^3+18z^2-2z+2)}{\ell^4(1+z)^6}}.
\]

Its sum-of-squares form establishes nonnegativity. To establish the global upper bound, rather than only a central limit, calculate:

\[
\begin{aligned}
&\ell^4(1+z)^6\left(\frac{24}{\ell^4}-K(r)\right)\\
&=24z^6+144z^5+348z^4+528z^3+144z^2+168z\ge0.
\end{aligned}
\]

All coefficients are nonnegative and \(z\ge0\). Divide by the positive factor:

\[
\boxed{0\le K(r)\le24/\ell^4\quad(r>0)}.
\]

At the center, continuity gives \(K(0)=24/\ell^4\). This completes the scalar-curvature bound for all \(r\ge0\) in the specified metric.

## Horizon classification

For positive radius, \(f=0\) is equivalent to:

\[
P(r)=r^3-r_s r^2+r_s\ell^2=0.
\]

Its only positive critical point is the minimum \(r=2r_s/3\), because \(P'=r(3r-2r_s)\). There:

\[
P(2r_s/3)=r_s(\ell^2-4r_s^2/27).
\]

Since \(P(0)>0\) and \(P\to+\infty\):

- \(r_s^2<27\ell^2/4\): no positive horizon root;
- equality: one double positive root at \(r=\sqrt3\,\ell\);
- \(r_s^2>27\ell^2/4\): two simple positive roots.

This reproduces Hayward's critical mass \(m_*=(3\sqrt3/4)\ell\). Bounded curvature does not itself remove horizons.

## Correct radial proper-time result

In geometric units, radial timelike geodesics satisfy:

\[
\dot r^2=E^2-f(r).
\]

At \(E=1\), the exact equation is:

\[
\dot r^2=\frac{r^2}{\ell^2(1+z)}.
\]

For an inward branch starting at \(r_0>0\):

\[
\tau(r)-\tau(r_0)=
\ell\int_r^{r_0}\frac{\sqrt{1+u^3/(r_s\ell^2)}}{u}\,du
\ge\ell\log(r_0/r).
\]

The \(E=1\) trajectory approaches the center only at infinite proper time. The earlier assertion that every \(E\ge1\) inward trajectory crosses the core at finite proper time is incorrect.

For \(E>1\), the limiting squared radial speed is \(E^2-1>0\). That local calculation still does not prove completeness of every causal geodesic on a specified maximal extension.

## The larger singularity claim

The algebra proves bounded \(R\) and \(K\) for this chosen static metric. A universal no-singularity theorem additionally requires a physical selection law and control of every allowed geometry.

Global extension, dynamical stability, quantum unitarity, recurrence, and real successor-universe genesis do not follow merely from these two bounded invariants. In particular, bounded curvature is not an equation proving \(S^\dagger S=I\). A static metric also does not itself specify reflective boundary conditions producing gravitational-wave echoes.

There is an elementary independence example for completeness. Restrict flat Minkowski spacetime to \(t<0\). Every curvature component and scalar invariant is zero. The inertial timelike geodesic \(\gamma(\tau)=(\tau,0,0,0)\), for \(-1<\tau<0\), reaches the omitted endpoint after finite proper time and has no extension within that spacetime. Bounded curvature therefore does not imply geodesic completeness. The flat extension is available in this example, but proving the appropriate maximal extension is precisely additional work. This example tests the implication, not the physical identity of the author's U.

The author's claim concerning this U and future singularities is retained as the target; it is not silently weakened to the existence of one regular metric example.

## Verification

The accompanying <code>verify_metric_capstone.py</code> differentiates \(f\), checks both exact curvature identities, checks the full nonnegative bound polynomial, verifies the horizon threshold, and verifies the \(E=1\) radial equation. All checks pass with SymPy 1.14.0.

This is a completed proof segment for the ansatz, not a completed derivation of actual universal cosmology.

