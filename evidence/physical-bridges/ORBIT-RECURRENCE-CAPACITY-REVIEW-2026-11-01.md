# ORBIT-1–ORBIT-6 — Proofs 11–13 audited: structural recurrence, orbit closure, and exact capacity

**Date:** 2026-11-01 (NZDT)  
**Status:** non-canonical, author-side mathematical research note; adversarial audit of proposed Proofs 11, 12 and 13. Not independently peer reviewed, not a BCRD source-level theorem, and not proof of original UPT X3 physical protection.  
**Prior research:** draft PR #188, including CYCLIC-1, QPER-1–4 and the distinction between a chosen quantum sector and the historically continuing particular.

## Executive dispositions

- **Proof 11:** generic exact projective recurrence is measure-zero for an unrestricted finite-dimensional Hamiltonian of dimension **at least three**, but the stated two-populated-mode theorem and "arbitrary infinitesimal noncommuting perturbation" claim are false.
- **Proof 12:** the orbit-hull fixed-point theorem is correct for the **newly defined** dynamical saturation operator. The proposed boundary-residue conclusion is false under its stated definition, and "if and only if one closed orbit manifold" is too strong.
- **Proof 13:** recurrence is neither sufficient nor necessary for a *selected capacity threshold*; those are provable independence results. The purported universal \(g/\Delta E\) bound is unsupported (and false under the natural interpretation), and sector occupancy must not be equated by definition with X3 continuation.

## ORBIT-1. Precise fragility theorem for global recurrence in dimension >= 3

Let \(H\) be a Hermitian \(d\times d\) matrix with simple spectrum \(E_0<\cdots<E_{d-1}\). Exact **global projective recurrence** is

\[
\exists T>0,\ \phi\in\mathbb R:\quad e^{-iHT}=e^{i\phi}I.
\]

By the finite spectral criterion (HOL-1, PR #188), this is equivalent to the existence of real \(\alpha\), \(\omega>0\) and integers \(n_0,\ldots,n_{d-1}\) with

\[
E_j=\alpha+\omega n_j\quad\forall j.
\]

For a **fixed** integer vector \(n\), these spectra form a subset of a two-parameter affine plane in \(\mathbb R^d\), parameterized by \((\alpha,\omega)\). There are countably many such integer vectors. Hence for \(d\ge3\), the exact-projective-recurrence spectra are contained in a countable union of measure-zero sets in the open chamber of distinct ordered eigenvalues. On the simple-spectrum Hermitian matrices, local spectral coordinates and smooth unitary eigendirections transfer this zero-measure result to the standard Lebesgue measure on the real vector space of Hermitian matrices.

\[
\boxed{d\ge3\implies\text{globally exactly recurrent Hermitian matrices have Lebesgue measure zero}.}\tag{ORBIT-1}
\]

This is a statement about **unrestricted continuous perturbations** and exact global recurrence. It does not rule out exact recurrence enforced by a physical symmetry or by a restricted admissible Hamiltonian family. It also does not imply that any *particular* finite perturbation destroys recurrence.

**Two-mode exception:** For **every** nondegenerate Hermitian \(2\times2\) Hamiltonian with eigenvalue gap \(\Delta>0\), \(U(2\pi/\Delta)=e^{-iE_0(2\pi/\Delta)}I\). Thus exact projective recurrence is universal in dimension 2, including after small noncommuting perturbations.

Example:

\[
H_0=\begin{pmatrix}-1&0\\0&1\end{pmatrix},
\quad V=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad[H_0,V]\ne0.
\]
Yet \(H_\varepsilon=H_0+\varepsilon V\) has spectrum \(\pm\sqrt{1+\varepsilon^2}\) and exact period
\[
T_\varepsilon=\frac{\pi}{\sqrt{1+\varepsilon^2}}>0,\quad U_\varepsilon(T_\varepsilon)=-I.
\]

**Fixed-state / fixed-period exception to the stronger claim:** Let \(H_0=\operatorname{diag}(0,1,2,3)\), \(T=2\pi\), \(\psi=(|0\rangle+|1\rangle)/\sqrt2\), and \(V=|2\rangle\langle3|+|3\rangle\langle2|\). Then \([H_0,V]\ne0\) but the populated two-mode subspace is unchanged; \(U_\varepsilon(T)\psi=\psi\) for **every** real \(\varepsilon\). A perturbation's noncommutation elsewhere does not force any occupied energy gap to shift.

The supplied first-order coefficient also has a gap: \([V,H_0]\ne0\) does **not** imply any \(E_j^{(1)}-E_k^{(1)}\ne0\); an off-diagonal \(V\) can have all diagonal expectations zero. Further, when a *fixed physical vector* \(\psi\) is expanded in the eigenbasis of \(H_\varepsilon\), its spectral weights themselves depend on \(\varepsilon\) and must not be silently treated as constant.

**Correct interpretation:** For \(d\ge3\), generic perturbations destroy exact **global projective** recurrence, but the exact return property may survive under special structures, and near returns remain mathematically possible.

## ORBIT-2. Correct orbit-set closure theorem and its precise fixed points

Let \(X=\mathbb P(\mathbb C^d)\) be quantum ray space, identified with rank-one density operators. For a finite-dimensional strongly continuous unitary group \(U(t)\), define a map on subsets \(S\subseteq X\):

\[
\mathcal B(S)=\overline{\{U(t)\rho U(t)^\dagger:\rho\in S,\ t\in\mathbb R\}}.
\]

This map is inflationary (use \(t=0\)), monotone, and idempotent (the flow acts continuously and has the group property). Moreover:

\[
\boxed{\mathcal B(S)=S\ \iff\ S\text{ is closed and invariant under }U(t)\text{ for all real }t.}\tag{ORBIT-2}
\]

**Proof:** If \(\mathcal B(S)=S\), the right side is closed by definition and invariant because the flow-closure is invariant. Conversely if \(S\) is closed and invariant, it contains the entire orbit hull of each point, and contains its closure; inflationarity gives equality.

Thus \(K=\overline{\mathcal O(\rho_0)}\) is a fixed point, but **not every fixed point is one orbit closure**. For example, with \(H=\operatorname{diag}(0,1,\sqrt2)\), the two-point set \(S=\{|0\rangle\langle0|,|1\rangle\langle1|\}\) is a closed invariant fixed point, but cannot be the orbit closure of one ray (each point is stationary). More generally unions of closed invariant sets are fixed points.

**Type repair:** A ray is not an operator expression \(\psi U^\dagger\); use a density operator \(\rho_0=|\psi_0\rangle\langle\psi_0|\) and \(U(t)\rho_0U(t)^\dagger\), or use rays \([U(t)\psi_0]\) throughout.

## ORBIT-3. The proposed boundary-residue definition invalidates Proof 12's empty-boundary step

Proof 12 defined

\[
\partial_{\mathcal B}(S)=\mathcal B(S)\setminus\operatorname{Int}_X(S).
\]

For any closed invariant \(K\), \(\mathcal B(K)=K\), so the **correct** simplification is

\[
\boxed{\partial_{\mathcal B}(K)=K\setminus\operatorname{Int}_X(K)=\partial_X K.}\tag{ORBIT-3}
\]

For an incommensurate three-level full-support ray, \(K\cong\mathbb T^2\) lies inside ambient \(X=\mathbb{CP}^2\) (real dimension 4). Its ambient interior is empty, so

\[
\boxed{\operatorname{Int}_{\mathbb{CP}^2}(K)=\varnothing,\qquad \partial_{\mathcal B}(K)=K\ne\varnothing.}
\]

The submitted proof's step \(\mathcal B(K)\setminus\operatorname{Int}(K)=K\setminus K\) therefore fails.

If the intended **relational completion residue** is instead

\[
\widehat\partial_{\mathcal B}(S)=\mathcal B(S)\setminus S,
\]

then \(\widehat\partial_{\mathcal B}(K)=\varnothing\) follows exactly. However \(\widehat\partial_{\mathcal B}\) is **not** the ordinary topological boundary \(\partial_X\), and a fixed-point identity for this abstract orbit hull is not an independent derivation of the actual BCRD operator.

A closed invariant orbit set can include times when a chosen subsystem projector has zero occupancy, as in ORBIT-4.

## ORBIT-4. Periodic recurrence is insufficient for continuous rank-one sector capacity

Set \(H=\sigma_x\), \(P=|0\rangle\langle0|\), \(\psi_0=|0\rangle\). Then \(U(\pi)=-I\), so the whole system has **exact global projective return**, but

\[
C(t)=\langle\psi_0|U(t)^\dagger P U(t)|\psi_0\rangle=\cos^2 t.
\]

In particular,

\[
\boxed{F_{\psi_0}(\pi)=1,\qquad C(\pi/2)=0.}\tag{ORBIT-4}
\]

This exact two-mode example suffices; no unspecified destructive-interference choice is needed. In the supplied three-mode proof, when \(P=|\psi_0\rangle\langle\psi_0|\), the expression \(1-|\langle\psi_0|U(t)\psi_0\rangle|^2\) is **leakage**, not active-sector capacity.

## ORBIT-5. Exact all-time capacity protection without any positive exact recurrence period

Let \(H=\operatorname{diag}(0,1,\sqrt2)\), and

\[
|\psi\rangle=\sqrt{49/50}|0\rangle+\tfrac1{10}|1\rangle+\tfrac1{10}|2\rangle,
\qquad P=|\psi\rangle\langle\psi|.
\]

The occupied energy gaps are rationally incommensurate, so no \(T>0\) satisfies \(U(T)\psi=e^{i\phi}\psi\).

Nevertheless, direct evaluation gives, for **every** real time,

\[
C(t)=\left|\frac{49}{50}+\frac{e^{-it}}{100}+\frac{e^{-i\sqrt2t}}{100}\right|^2
\ge\left(\frac{49}{50}-\frac{2}{100}\right)^2=\frac{576}{625}>0.9.
\]

There is also nonzero coupling \(g=\|(I-P)HP\|>0\). Thus exact ray recurrence is **not necessary** for all-time occupancy above a chosen threshold. This is the full-support example preserved in PR #188.

The proposed Proof 13 bound \(\sup_t\|QU(t)P\|\le g/\Delta E_{\rm eff}\) is neither defined precisely nor generally valid. Under the natural choice \(\Delta E_{\rm eff}=E_{\max}-E_{\min}\), take \(H=\delta\sigma_x\), \(P=|0\rangle\langle0|\): then \(g=\delta\), \(\Delta E=2\delta\), so \(g/\Delta E=1/2\), but \(\sup_t\|QU(t)P\|=1\). No such universal leakage bound follows solely from \(g\) divided by spectral span.

## ORBIT-6. New positive result: exact phase-resolved spectral-dominance capacity theorem

**Theorem.** Let \(H=H^*\) on a finite-dimensional Hilbert space and let \(\psi\) be a normalized initial state. Group degeneracies and write its decomposition over **distinct** energies:

\[
|\psi\rangle=\sum_j|\psi_j\rangle,\quad
H\psi_j=E_j\psi_j,\quad
w_j=\|\psi_j\|^2>0,\quad \sum_jw_j=1.
\]

Put \(P=|\psi\rangle\langle\psi|\), \(w_*=\max_jw_j\). Then for **all** real times,

\[
\boxed{C_\psi(t)=\left|\sum_jw_je^{-iE_jt}\right|^2
\ge\bigl[\max(0,\,2w_*-1)\bigr]^2.}\tag{ORBIT-6}
\]

**Proof.** The overlap \(\langle\psi|U(t)|\psi\rangle=\sum_jw_je^{-iE_jt}\). Select a maximal-weight term \(w_*e^{-iE_*t}\). The reverse triangle inequality yields

\[
\left|\sum_jw_je^{-iE_jt}\right|
\ge w_*-\sum_{j\ne *}w_j=2w_*-1.
\]

Absolute value is also nonnegative. Squaring proves the result without any time averaging, perturbation series or recurrence assumption. QED.

**Exact infimum for rationally independent relative gaps.** If the occupied distinct energy differences \(E_j-E_0\), \(j\ge1\), are rationally independent, the relative-phase orbit is dense in its full torus. The minimum modulus over all independently chosen phases of vectors with lengths \(w_j\) is \(\max(0,2w_*-1)\), by the polygon inequality (the largest vector can be exactly opposed by the others if dominant; when no weight exceeds one half, a closed polygon can be formed). Therefore

\[
\boxed{\inf_{t\in\mathbb R}C_\psi(t)
=\bigl[\max(0,\,2w_*-1)\bigr]^2.}\tag{ORBIT-6b}
\]

**Structural stability under small perturbations (qualified):** If a particular occupied eigenvalue is simple and spectrally isolated with weight \(w_*>1/2\), then sufficiently small Hermitian perturbations preserve a continuously varying spectral projector with weight still greater than one half. Hence the **positive uniform capacity floor survives sufficiently small perturbations** even if exact recurrence does not. The floor is an exact property of the mathematical sector; it is not an operationally established criterion for biological/subjective continuation.

## Scope and next source-level obligations

1. This audit examines generic finite-dimensional unitary systems. It **does not** demonstrate that the abstract orbit-completion \(\mathcal B\) is the actual BCRD boundary operator or that \(S^*\) models our physical universe.
2. Full orbit-set invariance means **no missing points in a saturated state set**. It does not prove the survival of a particular at each point on that orbit; an invariant orbit may traverse \(C(t)=0\).
3. The original UPT X3 objective is stronger than a chosen scalar occupation threshold: identity, agency, authorization, and historical continuation must be derived from physical source semantics, not defined away.
4. Future work: derive an operational \(P_p\) from a frozen BCRD source, test whether its spectral weight is structurally dominant or whether an invariant sector \(R\) approximates it (QPER-4 in PR #188), and join this to reach-or-hold coverage for unprotected cases.

**Bottom line:** proof of orbit-hull invariance survives after a boundary-definition repair; recurrence fragility must be qualified by dimension and genericity; exact phase-resolved capacity can be robust and nonperiodic, but capacity is not yet X3 survival.
