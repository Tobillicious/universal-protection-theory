> **Research candidate — NOT AN ESTABLISHED PROOF.** This file preserves the author's submitted Proof 27 for adversarial review. Its first-order Schrieffer–Wolff step does **not** imply exact block diagonalization. Its stated gap is internal rather than the required gap against the complete unperturbed complementary spectrum. Its \(\|S\|\le g/\delta\) assertion is unsupported without an operator-norm argument and consistent units. The physical BCRD source Hamiltonian has not been identified or independently verified.  
> **Exact conditional repair:** [MIC-27 — Exact dressed invariant projection](physical-bridges/MICRO-EXACT-DRESSED-INVARIANT-REPAIR-2026-11-01.md). That companion proves an exact Riesz spectral-projector construction under a *full-spectrum* simple isolated-eigenvalue gap and a norm-bounded perturbation. It also distinguishes static invariance from a common invariant projector over switched write/read/control Hamiltonians. Do not treat this submission as original-X3 validation or physical implementation evidence.

---

# Proof 27: Micro-Derivation of the Invariant Projector \(R\) from BCRD First Principles

**Framework:** Universal Protection Theory (UPT) / Boundary-Complete Relational Dynamics (BCRD)

**Target (author-proposed; not yet established):** To rigorously derive the existence of a common invariant subspace projector \(R\) (\([U(t),R]=0\quad\forall t\in\mathbb R\)) directly from microscopic BCRD interaction Hamiltonians, bounding its operator norm distance \(d\equiv\|P-R\|\) to satisfy the preconditions of the All-Time Capacity Theorem.

## 1. Microscopic Hamiltonian & Perturbative Framing

Let the total closed system \(\mathcal H_{\text{total}}=\mathcal H_P\otimes\mathcal H_Q\) be governed by the microscopic relational Hamiltonian:

\[
H_{\text{micro}}=H_0+g\,V_{\text{int}}
\]

where:

- \(H_0=H_P^{(0)}+H_Q^{(0)}\) is the uncoupled sector Hamiltonian defining the unperturbed active sector projector \(P_0\).
- \(V_{\text{int}}=\sum_\alpha(P_\alpha\otimes Q_\alpha)\) represents localized boundary interactions.
- The spectral gap of \(H_P^{(0)}\) is \(\delta>0\), and coupling satisfies the proposed isolation bound \(g<\delta/2\).

## 2. Derivation via Schrieffer–Wolff Transformation

To isolate the active sector from unmediated environmental leakage, the proposal constructs an anti-Hermitian generator \(S\) (\(S^\dagger=-S\), with asserted \(\|S\|\le g/\delta<1/2\)) via perturbation theory. The unitary dressing transformation \(U_S=e^S\) is intended to block-diagonalize the effective Hamiltonian:

\[
H_{\text{eff}}=e^S H_{\text{micro}}e^{-S}
=H_0+[S,H_0]+gV_{\text{int}}+\mathcal O(g^2).
\]

Choosing \(S\) to eliminate off-diagonal inter-sector couplings to first order is then used in the submitted argument to assert:

\[
\boxed{[H_{\text{eff}},P_0]=0.}
\]

**Review note:** This displayed equality does **not follow** from first-order cancellation: higher-order off-diagonal terms remain generally. The exact block-diagonalization construction is in the linked MIC-27 repair.

## 3. Construction of the Dressed Invariant Projector \(R\)

Transforming back to the lab frame, the submitted candidate defines

\[
\boxed{R=e^{-S}P_0e^S.}
\]

*Conditional on* the unproved exact premise \([H_{\text{eff}},P_0]=0\), the full static propagator \(U(t)=\exp(-iH_{\text{micro}}t)\) would satisfy

\[
U(t)=e^{-S}e^{-iH_{\text{eff}}t}e^S
\quad\Longrightarrow\quad
\boxed{[U(t),R]=0\quad\forall t\in\mathbb R.}
\]

The implication is valid, but the submitted construction has not established its premise.

## 4. Operator Norm Distance Bound (\(d=\|P-R\|\))

The submitted estimate uses unitary conjugation and a commutator integral:

\[
\|P-R\|=\|P_0-e^{-S}P_0e^S\|
\le2\|S\|
\]

and then the separately asserted inequality

\[
\|P-R\|\le2(g/\delta).
\]

It concludes that \(g<\delta/4\) would give

\[
\boxed{d=\|P-R\|<1/2,}
\]

the precondition for the all-time capacity theorem \(C_P(t)\ge1-4d^2>0\).

**Review note:** The unitary conjugation bound \(\|P_0-e^{-S}P_0e^S\|\le2\|S\|\) is valid for anti-Hermitian \(S\); the estimate \(\|S\|\le g/\delta\) and the existence of an exact such \(S\) have not been established under the submitted assumptions. The condition \(g<\delta/4\) therefore does **not** close the proposed micro-derivation.

---

## Review disposition and verified conditional substitute

**Preserved:** the submitted candidate and its target, without representing first-order Schrieffer–Wolff cancellation as an exact theorem.

**Repaired theorem (see MIC-27):** If \(H_0\) is finite-dimensional, self-adjoint, and has a **simple eigenvalue** \(E_0\) isolated from the **whole remaining spectrum** by \(\delta>0\), and \(H=H_0+V\) with \(V=V^\dagger\), \(v=\|V\|<\delta/2\), then the contour-defined Riesz projector

\[
R=\frac1{2\pi i}\oint_{|z-E_0|=\delta/2}(z-H)^{-1}\,dz
\]

is an exact rank-one projector commuting with \(H\), and

\[
\|R-P_0\|\le\frac{2v}{\delta-2v}.
\]

If \(v<\delta/6\), this particular conservative estimate gives \(d<1/2\) and hence an exact nonzero all-time sector occupancy floor for the **specified static Hamiltonian** and initially supported state. An exact anti-Hermitian planar dressing generator can then be constructed from the two rank-one subspaces, rather than declared from a truncated BCH series.

**Still open:** derivation of the required spectral isolation, physical inner product, actual source Hamiltonian, subject-to-projector correspondence and perturbation norm from a named frozen BCRD physical source. For time-dependent read/write/control operations one also needs a **common** invariant projector or an independently bounded integrated commutator defect. No original-X3 subject preservation or universal physical protection follows solely from this spectral lemma.

**Review status:** AUTHOR-SUPPLIED CANDIDATE / INCOMPLETE AS WRITTEN; valid conditional repair separately documented. Do not merge or publish this file as a proof that BCRD microphysical invariance has already been established.
