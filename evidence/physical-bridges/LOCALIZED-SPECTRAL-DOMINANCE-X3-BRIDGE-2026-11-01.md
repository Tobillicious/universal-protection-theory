# LOC-1 — Round 15: localized spectral-dominance capacity bridge and the unresolved X3 interpretation

**Date:** 2026-11-01 (NZDT)  
**Status:** non-canonical mathematical derivation / hostile review; append to draft PR #189. Not an independently certified BCRD physical-source theorem or the original UPT X3 continuation theorem.

## Disposition

**Accept:** spectral dominance supplies a rigorous all-time **localized cluster occupancy** bound after correcting an equality to an inequality, even when the site projector has rank >1. It also admits an explicit quantitative perturbative stability certificate when the dominant eigenvalue is isolated.

**Not yet proved:** identifying a particular with a chosen set of graph vertices; identifying site occupancy with the original X3 historical continuity, agency, authorization, and realizable freedoms; replacing a named frozen physical BCRD Hamiltonian with a generic adjacency matrix; global protection of all particulars.

The following uses the **exact, phase-resolved** unitary dynamics and does not average over time.

## LOC-1. Localized spectral-dominance bridge

Let \(\mathcal H\) be a finite-dimensional complex Hilbert space, \(H=H^*\), \(U(t)=e^{-itH}\), and \(P_{\mathrm{site}}\) an **orthogonal** projector onto a physically or mathematically specified cluster subspace. Let \(\psi_0\in\operatorname{Ran}P_{\mathrm{site}}\) be normalized. Write the spectral decomposition over **distinct energies** \(H=\sum_E E R_E\), and define

\[
w_E=\|R_E\psi_0\|^2,\quad \sum_Ew_E=1,\quad w_*=\max_E w_E.
\]

Define the actual site-occupancy capacity

\[
C_{\mathrm{site}}(t)=\langle U(t)\psi_0,P_{\mathrm{site}}U(t)\psi_0\rangle=\|P_{\mathrm{site}}U(t)\psi_0\|^2.
\]

Since \(P_{\mathrm{site}}\psi_0=\psi_0\), Cauchy–Schwarz and the exact spectral formula imply

\[
\begin{aligned}
C_{\mathrm{site}}(t)
&\ge|\langle\psi_0,P_{\mathrm{site}}U(t)\psi_0\rangle|^2
=|\langle\psi_0,U(t)\psi_0\rangle|^2\\
&=\left|\sum_E w_Ee^{-iEt}\right|^2
\ge\bigl[\max\{0,2w_*-1\}\bigr]^2.
\end{aligned}
\]

Thus:

\[
\boxed{C_{\mathrm{site}}(t)\ge[\max(0,2w_*-1)]^2,\quad\forall t\in\mathbb R.}\tag{LOC-1}
\]

For \(0<\theta<1\), the condition

\[
\boxed{w_*>\frac{1+\sqrt\theta}{2}}
\]

is sufficient for \(C_{\mathrm{site}}(t)>\theta\) for every time. It is not necessary. A site with a multi-dimensional projector can remain fully occupied even when the return fidelity is low.

**Important repair of the supplied draft:** when \(P_{\mathrm{site}}\ne|\psi_0\rangle\langle\psi_0|\), one has \(\|P_{\mathrm{site}}U(t)\psi_0\|^2\ge|\langle\psi_0,U(t)\psi_0\rangle|^2\), **not equality** in general. This makes the return-fidelity theorem a lower-bound certificate for site occupancy.

**Further typing issue:** the formula \(\sum_{i\in V_p}|i\rangle\langle i|\) is an orthogonal projector only when the source's vertex basis is orthonormal in its **physical** inner product. For nonorthonormal source bases, construct the appropriate Gram-orthogonal projector first.

## LOC-2. Explicit perturbation margin (simple isolated dominant eigenvalue)

Assume the dominant \(w_*=\langle\psi_0,R_*\psi_0\rangle\) comes from a **simple isolated eigenvalue** \(E_*\) of \(H\), with nearest-other-energy gap

\[
\delta=\min_{E\ne E_*}|E-E_*|>0.
\]

Let \(H'=H+V\) with \(V=V^*\), \(\eta=\|V\|<\delta/2\), and **hold the initial normalized vector \(\psi_0\) and physical site projector fixed**. Let \(R_*'\) be the rank-one spectral projector for the perturbed eigenvalue isolated inside the circle \(|z-E_*|=\delta/2\).

The resolvent identity and contour representation of spectral projectors yield

\[
R_*'-R_*=\frac{1}{2\pi i}\oint_{|z-E_*|=\delta/2}
(z-H')^{-1}V(z-H)^{-1}\,dz,
\]

so, since \(\|(z-H)^{-1}\|\le2/\delta\) and \(\|(z-H')^{-1}\|\le1/(\delta/2-\eta)\),

\[
\boxed{\|R_*'-R_*\|\le\frac{2\eta}{\delta-2\eta}.}\tag{LOC-2}
\]

Accordingly,

\[
w_*'=\langle\psi_0,R_*'\psi_0\rangle
\ge w_*-\frac{2\eta}{\delta-2\eta}.
\]

For a desired \(0<\theta<1\), define the strict **dominance margin**

\[
m=w_*-\frac{1+\sqrt\theta}{2}>0.
\]

If

\[
\boxed{\eta<\frac{m\delta}{2(1+m)},}\tag{LOC-3}
\]

then \(w_*'>(1+\sqrt\theta)/2\), and LOC-1 applied to \(H'\) establishes \(C_{\mathrm{site}}^{H'}(t)>\theta\) **for all real times**. This is one explicit, conservative robust certificate; it does not give physical estimates of \(\delta\), \(\eta\), or \(m\) for any named BCRD implementation.

The supplied Round 15 condition \(\delta>\eta\) *alone* is insufficient to preserve an arbitrary threshold: it fails to compare the possible spectral-weight change with the available margin \(m\). If the dominant energy is degenerate, additional projector-rank and spectral-isolation care is required.

## LOC-3. Exact capacity does not control a relational memory observable

Take \(\mathcal H=\mathbb C^3\),

\[
P_{\mathrm{site}}=|0\rangle\langle0|+|1\rangle\langle1|,\quad
H=\operatorname{diag}(0,\Delta,\Lambda),\quad
\psi_0=\sqrt{0.9}|0\rangle+\sqrt{0.1}|1\rangle,\quad\Delta>0,
\]

with \(\Lambda\) distinct from \(0,\Delta\). Then the initial state is fully localized, \(w_*=0.9\), and the site is exactly invariant:

\[
C_{\mathrm{site}}(t)=1\quad\forall t.
\]

But for the physically meaningful *relative-phase observable*

\[
O=|0\rangle\langle1|+|1\rangle\langle0|,
\]

the initial expectation is \(2\sqrt{0.9\cdot0.1}=0.6\), while at \(t=\pi/\Delta\) it is \(-0.6\). Thus a protected site occupation, even with dominant spectral weight, does **not** fix the time evolution of a chosen internal logical/memory observable.

This toy system does not assert that a healthy particular must retain a constant memory bit. Rather, it proves that the scalar occupancy inequality contains no theorem about a specified encoding of memory, interpretation of agency, or authorized access.

A deterministic, unactuated quasiperiodic phase orbit similarly does not imply freedom to choose among physically feasible actions. Dynamical variability and UPT's original normative or operational freedom are distinct types of assertions.

## LOC-4. Exactly what must be formalized (vs. what a paper proof already supports)

**Rigorous, self-contained paper proofs now available:**
- the algebraic dominance inequality for \(|\langle\psi,U(t)\psi\rangle|\) (PR #189, ORBIT-6);
- the site-projector bridge (LOC-1);
- the isolated spectral-projector perturbation bound (LOC-2/3);
- the counterexample separating occupancy from internal memory dynamics (LOC-3).

**Machine checking is desirable but optional for these elementary finite-dimensional lemmas**, provided they are independently reviewed, hypotheses and types are preserved, and all source calculations are reproducible. Do not advertise them as Lean certified unless compiled and kernel checked.

**Indispensable new theorems/empirical interfaces before claiming physical X3:**
1. **Source lock.** Identify a named, frozen BCRD physical Hilbert space, Gram inner product, and actual Hamiltonian; the abstract graph \(\Gamma\) supplied in Round 15 is a proposal, **not source provenance**.
2. **Particular-to-projector map.** Independently derive a map from a historically tracked particular \(p\) to an operational \(P_p(s)\) (possibly time-dependent), without declaring a vertex cluster "the person" by stipulation.
3. **Continuity/refinement.** Establish that the physical source dynamics, boundary effects, authorized interventions and historical trace semantics faithfully refine the model. Show which \(\theta\), if any, is physically sufficient for the same continuing particular.
4. **Freedoms.** Derive and verify actual option/authorization/agency semantics, including feasible nontrivial alternatives, rather than identifying torus exploration with freedom.
5. **Coverage.** Prove source-specific bounds for every relevant particular or supply complete physically validated reach-or-faithfully-hold alternatives; do not exclude intrinsically leaky particulars.
6. **Independent audit and physical evidence.** Distinguish conditional formal correctness from experimentally substantiated universal protection. The project's existing IR-101/102 sector-semantic bridge work is a relevant conditional formal interface, not automatic physical validation.

**Research conclusion:** Round 15 establishes a valid conditional localized-occupancy certificate and a perturbation margin. It **does not** discharge X3 or original UPT universality by itself. Keep as review material, not canonical publication.
