# CYCLIC-1 — Exact cyclic sector-capacity bound (research candidate)

**Date:** 2026-11-01 (NZDT)  
**Status:** mathematical derivation, author-side / AI-assisted review; **not** independently certified, not canonical, not a physical X3 protection claim.  
**Source scope:** abstract bounded self-adjoint Hamiltonian and a chosen orthogonal sector projector. This does not assert that real BCRD cosmology has circular time, or that a quantum projector faithfully represents a continuing particular.

## Statement

Let \\(\\mathcal H\\) be a complex Hilbert space, \\(H=H^*\\) a bounded time-independent Hamiltonian, \\(P=P^*=P^2\\) an orthogonal projection and \\(Q=I-P\\). Put
\\[
U(t)=e^{-itH},\\qquad g=\\|QHP\\|.
\\]
Assume a **separately supplied** exact projective recurrence period \\(T>0\\):
\\[
U(T)=e^{i\\phi}I.
\\]
Then, for every real \\(t\\),
\\[
\\boxed{\\|QU(t)P\\|\\le
\\min\\bigl\\{1,\\;g\\,\\operatorname{dist}(t,T\\mathbb Z)\\bigr\\}.}\\tag{CYCLIC-1}
\\]
For any normalized \\(\\psi\\in\\operatorname{Ran}P\\), define the **sector occupancy**, not biological or X3 continuation, as
\\[
C_\\psi(t)=\\langle U(t)\\psi,P U(t)\\psi\\rangle
=1-\\|QU(t)\\psi\\|^2.
\\]
For all real times,
\\[
\\boxed{C_\\psi(t)\\ge 1-
\\min\\left\\{1,\\frac{T^2g^2}{4}\\right\\}.}\\tag{CYCLIC-2}
\\]
In particular, for \\(0\\le\\theta<1\\),
\\[
\\boxed{\\frac{Tg}{2}<\\sqrt{1-\\theta}
\\quad\\Longrightarrow\\quad C_\\psi(t)>\\theta
\\text{ for all }t\\in\\mathbb R.}\\tag{CYCLIC-3}
\\]

## Proof (including the repaired negative-time argument)

Set \\(H_0=PHP+QHQ\\) and \\(W=H-H_0=PHQ+QHP\\).
The unitary \\(U_0(t)=e^{-itH_0}\\) preserves both \\(P\\) and \\(Q\\), so \\(QU_0(t)P=0\\).
The off-diagonal self-adjoint block \\(W\\) satisfies
\\[
\\|W\\|=\\|QHP\\|=g.
\\]
Duhamel's formula, valid also for negative real \\(s\\), gives
\\[
U(s)-U_0(s)=-i\\int_0^s U(s-r)W U_0(r)\\,dr.
\\]
For negative \\(s\\) interpret the integral with reversed orientation. Taking the \\(Q\\)-to-\\(P\\) block and operator norms,
\\[
\\|QU(s)P\\|
=\\|Q(U(s)-U_0(s))P\\|
\\le |s|\\|W\\|=|s|g.
\\]
Unitarity also gives \\(\\|QU(s)P\\|\\le1\\).

For every integer \\(n\\), the group property and recurrence imply
\\[
U(t)=e^{in\\phi}U(t-nT).
\\]
Hence
\\[
\\|QU(t)P\\|
=\\|QU(t-nT)P\\|
\\le\\min\\{1,\\;g|t-nT|\\}.
\\]
Minimizing over integers \\(n\\) proves CYCLIC-1. Since \\(\\operatorname{dist}(t,T\\mathbb Z)\\le T/2\\), squaring the bound yields the leakage bound and CYCLIC-2. Finally \\(gT/2<\\sqrt{1-\\theta}\\) implies \\(1-(gT/2)^2>\\theta\\), proving CYCLIC-3. QED.

**Repair relative to an earlier draft:** It is unnecessary to claim \\(\\|QU(s)^*P\\|=\\|QU(s)P\\|\\), which need not hold in arbitrary Hilbert spaces. The negative-time Duhamel estimate and exact-period translation establish the result without that equality.

## Nontrivial exact example

Let \\(\\mathcal H=\\mathbb C^2\\), \\(P=|0\\rangle\\langle0|\\), and
\\[
H=10\\sigma_z+\\sigma_x=
\\begin{pmatrix}10&1\\\\1&-10\\end{pmatrix}.
\\]
Since \\(H^2=101I\\), for \\(T=\\pi/\\sqrt{101}\\) we have
\\[
U(T)=-I,\\qquad g=\\|QHP\\|=1.
\\]
Thus \\(gT/2=\\pi/(2\\sqrt{101})\\approx0.1563<\\sqrt{0.05}\\), and CYCLIC-3 certifies \\(C_\\psi(t)>0.95\\) for \\(\\psi=|0\\rangle\\), all times.

The coupling is genuinely nonzero and the sector occupancy oscillates. In fact,
\\[
C_{|0\\rangle}(t)=1-\\frac{\\sin^2(\\sqrt{101}t)}{101}
\\ge\\frac{100}{101}.
\\]
This example demonstrates a **conditional sector bound**, not universal physical preservation.

## Dependencies and explicit open obligations

* Uses only: bounded self-adjoint \\(H\\), orthogonal \\(P\\), standard unitary Duhamel estimate, and exact recurrence \\(U(T)=e^{i\\phi}I\\).
* Does **not** derive the period \\(T\\), phase locking, circular physical time, a BCRD-native \\(P_p\\), or a complete world Hamiltonian.
* \\(C_\\psi(t)>\\theta\\) is an operationally chosen sector probability criterion; **not** a source-established sufficient condition for original X3 (continuing identity, authorization, freedom, or delivered service).
* Protection of actual particulars would require independently warranted projectors/semantics, physical source-to-model refinement, and composition with UPT reach-or-hold mechanisms for intrinsically leaky channels.
* The contemporary BCRD source-register candidate `SOURCE-REGISTER-NO-GO.md` identifies nonzero coupling for the *chosen register-UP* sector. This does not identify that register with a person or a real X3 particular.
* See `CIRCULAR-HOLONOMY-RECURRENCE-AUDIT-2026-11-01.md` for the Proof 8 hypothesis audit. Neither research note modifies a canonical manuscript or authorizes a public universal-protection claim.
