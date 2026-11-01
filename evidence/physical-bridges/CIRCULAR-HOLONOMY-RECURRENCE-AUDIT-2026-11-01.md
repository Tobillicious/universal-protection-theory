# HOL-1 — Hostile audit of proposed Proof 8: BCRD holonomy recurrence

**Date:** 2026-11-01 (NZDT)  
**Status:** research / adversarial mathematical audit; source-to-physics bridge OPEN. The proposed Proof 8 conclusion is **not established** by its stated premises. This is not a claim that circular time is impossible.  
**Target proposed implication:** \\(B(S^*)=S^*\\), zero set-boundary, and \\(\\mathcal T\\cong S^1\\) \\(\\Rightarrow\\) \\(U(T)=e^{i\\phi}I\\) for full physical Hilbert-space evolution.

## 1. The conceptual/type interfaces

**(i) Different notions of boundary.** The earlier lattice definition \\(\\partial_B(X)=B(X)\\setminus X\\) (when \\(X\\) is a set) is not the differential/topological boundary of a manifold and is not the gauge curvature \\(F_\\nabla\\). \\(B(S^*)=S^*\\) yields \\(\\partial_B(S^*)=\\varnothing\\) by definition, but not \\(F_\\nabla=0\\) and not any constraint on holonomy.

**(ii) A U(1) line bundle is not the full microscopic Hilbert-space bundle.** A \\(U(1)\\) connection has scalar holonomy as a property of its one-dimensional representation. To identify its holonomy with \\(U(T)\\) on a multidimensional \\(\\mathcal H\\), Proof 8 must show that *the entire* physical evolution acts in the same scalar representation after one period. That is the desired phase-locking statement, not a consequence of merely naming a \\(U(1)\\) connection.

**(iii) Period versus topology.** The circle is a topological space, not a specified clock metric. A choice of circumference \\(T>0\\), clock normalization, flow speed, and state-space gluing/transport rule is additional physical structure. \\(\\oint dt=T\\) merely restates that chosen normalization; it does not calculate a cosmic period.

**(iv) Stokes' theorem.** A generator of \\(\\pi_1(S^1)\\) does not bound a two-chain *in* \\(S^1\\). It is invalid to infer trivial holonomy from an application of Stokes' theorem over a nonexistent disk in this base.

## 2. Exact counterexample: flat U(1) connection with arbitrary holonomy

Write \\(S^1=\\mathbb R/(2\\pi\\mathbb Z)\\), coordinate \\(\\theta\\), and put on a trivial complex line bundle the connection one-form
\\[
A=\\alpha\\,d\\theta,\\qquad \\(\\alpha\\in\\mathbb R\\).
\\]
Since the base is one-dimensional, \\(F=dA=0\\) (the abelian wedge term vanishes), but
\\[
\\boxed{\\operatorname{Hol}_A(S^1)=e^{-i2\\pi\\alpha}.}
\\]
The holonomy can be any element of \\(U(1)\\). It need not equal \\(1\\), and \\(\\oint A\\) is not forced to be \\(2\\pi n\\). This is a mathematically consistent flat connection on a compact circle; quantizing its Wilson loop would require an independent condition.

This counterexample alone does not refute phase-*scalar* holonomy in a \\(U(1)\\) line bundle: scalarity is automatic there. It refutes the claimed derivation of quantization/triviality from flatness and makes clear why that scalar phase cannot simply be equated with full microscopic evolution.

## 3. Exact counterexample: finite unitary Hamiltonian with no projective global period

On \\(\\mathcal H=\\mathbb C^3\\), take
\\[
H=\\operatorname{diag}(0,1,\\sqrt 2),\\qquad
U(t)=\\operatorname{diag}(1,e^{-it},e^{-i\\sqrt2t}).
\\]
If \\(U(T)=e^{i\\phi}I\\) for \\(T>0\\), the first eigenvalue forces \\(e^{i\\phi}=1\\). The others then require
\\[
T=2\\pi m,\\qquad \\(\\sqrt2 T=2\\pi n\\quad (m,n\\in\\mathbb Z),
\\]
which implies \\(n=\\sqrt2m\\), impossible for nonzero \\(m\\). Therefore no exact projective period exists for this Hamiltonian.

One may *postulate* circular physical time and require its quantum dynamics to descend to a single-valued/projectively single-valued description. That would exclude this Hamiltonian or require additional twisted boundary data. It is an **extra admissibility/physical-selection rule**, not a consequence of compactifying the time coordinate.

Similarly a flat \\(U(2)\\) connection \\(A=\\operatorname{diag}(0,\\alpha)\\,d\\theta\\) has holonomy \\(\\operatorname{diag}(1,e^{-i2\\pi\\alpha})\\), generally noncentral. Global flatness and a closed base do not ban such transport.

## 4. Correct finite-dimensional spectral criterion (exact projective recurrence)

For a time-independent self-adjoint \\(H\\) on finite-dimensional \\(\\mathcal H\\) with eigenvalues \\(E_0,\\ldots,E_{N-1}\\):
\\[
\\boxed{\\exists T>0,\\phi:\\ U(T)=e^{i\\phi}I
\\iff
\\exists T>0:\\ (E_j-E_0)T\\in2\\pi\\mathbb Z\\quad\\forall j.}\\tag{HOL-1}
\\]
**Proof.** The spectral theorem diagonalizes \\(U(T)\\) with eigenvalues \\(e^{-iE_jT}\\). They are equal exactly when all eigenvalue gaps have integral \\(2\\pi\\)-phase differences. QED.

Consequently, precise periodic recurrence requires *commensurability of all energy gaps* (or equivalent dynamically derived monodromy constraints). Compactness and unitarity alone give neither. Approximate quantum recurrences may exist under separate finite-dimensional hypotheses; approximate return does not imply uninterrupted X3 continuation.

## 5. A narrower, valid conditional holonomy-to-capacity bridge

If BCRD **independently derives** (a) a physically justified global Hilbert evolution \\(U(t)\\), (b) a concrete period \\(T\\) and central holonomy \\(U(T)=e^{i\\phi}I\\), (c) a physically grounded particular projector \\(P_p\\), and (d) a measured/derived coupling bound \\(g_p=\\|(I-P_p)HP_p\\|\\) with \\(g_pT/2<\\sqrt{1-\\theta_p}\\), then the **separate** CYCLIC-1 theorem yields sector occupancy \\(C_p(t)>\\theta_p\\) for all times.

A further, source-level physical and semantic theorem is still needed to identify this occupancy with the same continuing particular and the original X3 priority/freedom requirements. Original UPT reach-or-hold may address vulnerable particulars without intrinsic sector invariance; no universal physical coverage is inferred here.

## 6. Exact next gauntlet question

**Derive from a named BCRD source Hamiltonian/connection, without assuming the answer, either:**

1. An explicit map from the physical temporal evolution to a circle action (or an associated bundle with fully specified state gluing), including the gauge-invariant meaning of a return of an individual particular; **and**
2. An independently computed period or a source-derived \\(U(T)=e^{i\\phi}I\\) (or spectral/monodromy criterion), not merely a chosen circle circumference; **and**
3. A source-defined particular's historical/semantic X3 correspondence, together with any extra reach-or-hold protection needed where a sector leakage bound fails.

**Review disposition:** reject Proof 8 as a proof of derived cosmic recurrence in its current form; retain it as a concrete candidate whose essential physical inputs are now precisely identified. Do not promote the conditional Proof 7 or this audit into an established universal protection theorem.
