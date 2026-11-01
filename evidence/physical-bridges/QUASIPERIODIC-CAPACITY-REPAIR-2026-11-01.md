# QPER-1–QPER-4 — Review of proposed Proof 10: quasiperiodic capacity is not automatically protected

**Date:** 2026-11-01 (NZDT)  
**Status:** mathematical hostile review + conditional repaired finite-window / syndetic-return bounds. Noncanonical, AI-assisted; not an established BCRD cosmological law or X3 semantic bridge.  
**Source:** proposed "Proof 10: The Quasiperiodic Sector-Capacity Bound" supplied for adversarial mathematical checking.

## Disposition

The *short-time* inequality \(\|Qe^{-iHt}P\|\le\min(1,g|t|)\), \(g=\|QHP\|\), is correct for bounded self-adjoint \(H\). However, the proposed *uniform all-time* inequality \(\inf_t C(t)\ge1-\min(1,g^2\tau_{\rm rec}^2/4)\) does **not** follow from a single approximate recurrence. Its central midpoint step replaces an \(\varepsilon\)-return with an exact period and then extends one finite window to all times.

The proof's original unprojected Duhamel line
\[
QU(t)P=-i\int_0^t QU(t-s)HP\,ds
\]
is not in general the correct identity: the block-diagonal evolution term is missing. It should use \(H_0=PHP+QHQ\), \(W=PHQ+QHP\):
\[
QU(t)P=-i\int_0^t QU(t-s)QHP\,U_0(s)P\,ds,\qquad U_0=e^{-iH_0t}.
\]
This identity is valid for signed times (or oriented integrals), giving the correct bound \(\|QU(t)P\|\le\min(1,g|t|)\).

## QPER-1. Exact full-support quasiperiodic counterexample with zero sector capacity

Let
\[
H=\operatorname{diag}(0,1,\sqrt2),\quad
t_0=\frac{7\pi}{3},\quad
\beta=\pi\left(4-\frac{7\sqrt2}{3}\right).
\]
The elementary inequalities \(2/3<4-7\sqrt2/3<1\) imply \(2\pi/3<\beta<\pi\).
Under \(U(t_0)\) the three energy eigenvectors acquire phases \(1,e^{i5\pi/3},e^{i\beta}\), respectively.

Set
\[
a_0=\sin(5\pi/3-\beta)>0,\quad
a_1=\sin\beta>0,\quad
a_2=\sin(\pi/3)>0,\quad
S=a_0+a_1+a_2,\quad w_j=a_j/S.
\]
All weights are strictly positive and sum to 1. The elementary unit-circle triangle identity yields
\[
a_0+a_1 e^{i5\pi/3}+a_2e^{i\beta}=0.
\]
Choose the normalized state
\[
|\psi\rangle=\sum_{j=0}^2\sqrt{w_j}|E_j\rangle,\qquad
P=|\psi\rangle\langle\psi|,\qquad Q=I-P.
\]
Then its sector occupancy is precisely its return fidelity,
\[
C_\psi(t)=\left|\sum_j w_j e^{-iE_jt}\right|^2,
\]
and hence
\[
\boxed{C_\psi(t_0)=0.}\tag{QPER-1}
\]

All three spectral components are occupied, the ratios of energy gaps are irrational, and no positive exact projective return exists for this \(\psi\). The coupling is genuinely nonzero:
\[
g^2=\langle H^2\rangle_\psi-\langle H\rangle_\psi^2>0.
\]
Approximate returns nevertheless exist by finite-dimensional quasiperiodic recurrence.

**Conclusion:** quasi-periodicity plus nonzero finite \(g\) and bounded spectral span \(\Delta E=\sqrt2\) does not guarantee any strictly positive all-time sector-capacity floor, even for a state participating in all energy modes.

The example is a formal sector counterexample, not a claim about the destruction of an actual conscious particular.

## QPER-2. One approximate return yields only a finite-window estimate

Let \(\psi\in\operatorname{Ran}P\) be normalized, \(\tau>0\), and suppose for some phase \(\phi\)
\[
\|U(\tau)\psi-e^{i\phi}\psi\|\le\varepsilon.
\]
For \(0\le t\le\tau\),
\[
\|QU(t)\psi\|\le gt
\]
by the signed-time Duhamel estimate, and
\[
\begin{aligned}
QU(t)\psi
&= e^{i\phi}QU(t-\tau)\psi\\
&\quad+QU(t-\tau)\bigl(U(\tau)\psi-e^{i\phi}\psi\bigr),
\end{aligned}
\]
so
\[
\|QU(t)\psi\|\le g(\tau-t)+\varepsilon.
\]
Consequently,
\[
\boxed{\|QU(t)\psi\|\le
\min\{1,gt,g(\tau-t)+\varepsilon\}.}\tag{QPER-2}
\]
The maximum of the two linear envelopes is at most \((g\tau+\varepsilon)/2\) (also when their intersection lies outside the interval), hence
\[
\boxed{C_\psi(t)\ge1-\min\{1,(g\tau+\varepsilon)/2\}^2
\quad\text{for }0\le t\le\tau.}\tag{QPER-2b}
\]
In particular the error \(\varepsilon\) cannot be dropped. At \(t=\tau\), the proposed Proof 10 bound \(g\min(t,\tau-t)=0\) would incorrectly force *exact* return from an *approximate* return. Repeating the same \(\tau\) does not give exact periodicity, and accumulated approximation errors need not remain uniformly bounded. QPER-2 is a **single interval bound** only.

## QPER-3. Valid all-time theorem from relatively dense approximate returns

Suppose there are constants \(R>0,\varepsilon\ge0\) such that **for every** real \(t\), there exists some \(s\in[t-R/2,t+R/2]\) and phase \(\phi_s\) satisfying
\[
\|U(s)\psi-e^{i\phi_s}\psi\|\le\varepsilon.
\]
Then write \(U(t)\psi=U(t-s)U(s)\psi\) and use Duhamel and the error triangle inequality:
\[
\|QU(t)\psi\|\le g|t-s|+\varepsilon\le gR/2+\varepsilon.
\]
Therefore
\[
\boxed{\inf_{t\in\mathbb R}C_\psi(t)
\ge1-\min\{1,gR/2+\varepsilon\}^2.}\tag{QPER-3}
\]

If \(gR/2+\varepsilon<\sqrt{1-\theta}\), then \(C_\psi(t)>\theta\) for every real time. This is a **correct conditional replacement** for Proof 10. For finite-dimensional unitary flows, approximate return sets of a fixed normalized state are relatively dense for each \(\varepsilon>0\) (finite trigonometric almost periodicity / compact orbit closure), but the resulting recurrence-gap constant \(R\) may be arbitrarily large. The stated hypotheses provide no universal useful bound on \(R\) in terms of the spectral span \(\Delta E\) alone.

## QPER-4. Uniform capacity without recurrence via invariant-projector proximity

A distinct and sometimes sharper sufficient condition is available without any recurrence assumptions:

If \(R\) is an orthogonal projector with \([H,R]=0\), let \(d=\|P-R\|\). Then for any real \(t\),
\[
\begin{aligned}
\|QU(t)P\|
&=\|(I-P)U(t)P\|\\
&=\|(I-P)[U(t),P]\|\\
&=\|(I-P)[U(t),P-R]\|\\
&\le2\|P-R\|=2d.
\end{aligned}
\]
Together with unitarity,
\[
\boxed{\|QU(t)P\|\le\min(1,2d),\qquad
C_\psi(t)\ge1-\min(1,2d)^2.}\tag{QPER-4}
\]
Thus \(2d<\sqrt{1-\theta}\) is a sufficient all-time occupancy condition **even when \(H\) has incommensurate energy gaps**.

This is a geometric spectral-projector closeness theorem, not an original BCRD continuation theorem: selecting the *physically appropriate* \(P\) and showing that occupancy constitutes continued historical identity and freedom remain independent X3 obligations.

## Remaining source/physics obligations

- Neither a finite spectral span nor Kronecker recurrence determines a useful uniform survival threshold.
- Identifying which recurrence or invariant projector is physically associated with an existing particular requires a named BCRD source, not a generic Hilbert-space toy construction.
- Even a sharp positive occupancy bound needs the source-level X3 semantic correspondence and actual reach-or-faithfully-hold channel coverage.
- Proof 10 should be preserved as a candidate with failed steps identified, not promoted as a proved unconditional quasiperiodic protection claim.

## Verification

The standard-library checker \`check_quasiperiodic_zero_capacity.py\` reports the explicit three-level phase cancellation and checks the closed-form triangular identity numerically. The underlying proof is exact via the trig identity; numerical diagnostics are not an independent mathematical proof or a physical BCRD validation.
