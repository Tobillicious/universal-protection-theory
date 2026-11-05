# MIC-27 — Exact dressed invariant projection: repaired Schrieffer–Wolff micro-derivation

**Date:** 2026-11-01 (NZDT)  
**Status:** mathematically rigorous **conditional finite-dimensional** construction and adversarial review of submitted "Micro-Derivation of the Invariant Projector R." Not derived from a named/frozen BCRD microscopic Hamiltonian, not original UPT X3, and not Lean kernel certified. Draft PR #190; do not merge as demonstrated real-world protection.

## Scope and precise disposition

The submitted draft correctly identifies a useful direction: an isolated unperturbed eigenstate can persist as a **dressed exact spectral eigenstate** of a weakly perturbed Hermitian Hamiltonian. But the submitted argument does **not** prove its exact conclusion:

1. The stated \(\delta\) is only an **internal** \(P\)-sector energy gap; exact dressing needs separation from **every other spectral value of the full unperturbed Hamiltonian**, including the external \(Q\) sector. The known 3-level resonance counterexample in `PROOF-26-MASTER-HISTORY-TO-EFFECT-REPAIR-2026-11-01.md` has an internal gap and \(g<\delta/2\), yet complete transfer.
2. An order-one choice \([S,H_0]+gV_{\rm off}=0\) cancels first-order offdiagonal terms only, not every offdiagonal BCH term. Writing \([e^SHe^{-S},P_0]=0\) afterward without a remainder proof is invalid.
3. The entrywise formula \(S_{ij}=gV_{ij}/(E_i-E_j)\) cannot be used at resonant cross-sector pairs; even when all denominators are bounded below, the **operator norm** bound \(\|S\|\le g/\delta\) is not justified by elementwise inequalities in general. Actual perturbation size is \(v=\|gV_{\rm int}\|\), with units of energy, not a possibly dimensionless \(g\).
4. The claimed \(\|P-R\|<1/2\) does not follow from \(g<\delta/2\) using the draft's own bound \(d\le2g/\delta\). Its later tightened condition already concedes this.
5. Static exact spectral invariance for **one \(H\)** does not automatically survive write/read/feedback **switching**. A single \(R\) must commute with every generator, or the accumulated noncommutation must be controlled.

## MIC-27A — exact Riesz spectral-projection theorem

Let \(\mathcal H\) be finite-dimensional, \(H_0=H_0^\dagger\), and \(E_0\) a **simple, isolated eigenvalue** with normalized eigenvector \(\varphi\) and

\[
P_0=|\varphi\rangle\langle\varphi|,
\qquad
\delta=\min_{\lambda\in\sigma(H_0),\,\lambda\ne E_0}|E_0-\lambda|>0.
\]

This is separation against the **whole** complement of \(\{E_0\}\), not an internal block-only gap. Let \(H=H_0+V\), \(V=V^\dagger\), and \(v=\|V\|_{\rm op}<\delta/2\). Take the positively oriented circle \(\mathcal C=\{z:|z-E_0|=\delta/2\}\) and define

\[
\boxed{R:=\frac{1}{2\pi i}\oint_{\mathcal C}(zI-H)^{-1}\,dz.}\tag{MIC-27A}
\]

**Conclusion:** \(R\) is a rank-one orthogonal spectral projector satisfying

\[
\boxed{R^2=R=R^\dagger,\qquad [H,R]=0,\qquad
\|R-P_0\|\le\frac{2v}{\delta-2v}.}\tag{MIC-27B}
\]

**Exact proof:** For \(H_0\), the contour is distance at least \(\delta/2\) from every eigenvalue and \(\|(z-H_0)^{-1}\|\le 2/\delta\). For \(H_s=H_0+sV\), \(0\le s\le1\), the self-adjoint spectral stability bound gives \(\mathrm{dist}(z,\sigma(H_s))\ge\delta/2-v\); equivalently use a Neumann series for the perturbed resolvent. The contour stays within every \(H_s\)'s resolvent set, and its Riesz projector varies continuously with \(s\). Its integer rank stays equal to rank \(P_0=1\). The spectral theorem makes each Riesz projector orthogonal and commuting with its generator. Using the exact resolvent identity,

\[
(z-H)^{-1}-(z-H_0)^{-1}
=(z-H)^{-1}V(z-H_0)^{-1},
\]

and contour length \(\pi\delta\), one gets

\[
\|R-P_0\|\le
\frac{\pi\delta}{2\pi}
\frac{1}{\delta/2-v}v\frac{2}{\delta}
=\frac{2v}{\delta-2v}.
\]

No truncated perturbation series and no averaging occur. QED.

**Explicit sufficient margin:** If

\[
\boxed{v<\delta/6,}\tag{MIC-27C}
\]

then \(d:=\|P_0-R\|<1/2\). Our earlier all-time invariant-projector theorem gives

\[
\boxed{
\|P_0e^{-itH/\hbar}\varphi\|^2
\ge1-4d^2
\ge1-\frac{16v^2}{(\delta-2v)^2}>0
\quad\forall t\in\mathbb R.
}\tag{MIC-27D}
\]

The \(\delta/6\) condition is **conservative**, not necessary. It is a quantitatively correct replacement for the unsupported \(g<\delta/2\Rightarrow d<1/2\) assertion.

## MIC-27E — exact unitary dressing and exact block diagonalization

This section repairs the attempted Schrieffer–Wolff argument **without assuming** first-order BCH cancellation is exact.

Because both \(P_0\) and \(R\) have rank 1, choose a normalized eigenvector \(\chi\) spanning \(\mathrm{Ran}R\) with \(\langle\varphi,\chi\rangle\in[0,1]\) real (adjust a global phase). Define \(d=\|P_0-R\|=\sqrt{1-|\langle\varphi,\chi\rangle|^2}<1\) and \(\alpha=\arcsin d\). For \(d>0\), let \(u=(\chi-\cos\alpha\,\varphi)/\sin\alpha\); then \(u\perp\varphi\) and \(\|u\|=1\).

Define the **anti-Hermitian** generator

\[
S=\alpha\bigl(|u\rangle\langle\varphi|-|\varphi\rangle\langle u|\bigr),\qquad S^\dagger=-S.
\]

Then \(W=e^S\) is unitary, acts as the planar rotation \(W\varphi=\chi\), and hence

\[
\boxed{WP_0W^\dagger=R,\qquad
H_{\rm eff}:=W^\dagger HW,\qquad
[H_{\rm eff},P_0]=0.}\tag{MIC-27E}
\]

The last equality is **exact** because \(H\) commutes with \(R\). Moreover \(\|S\|=\alpha=\arcsin d\le(\pi/2)d\). If \(d=0\), choose \(S=0,W=I\). For small \(v/\delta\), MIC-27B implies \(\|S\|=O(v/\delta)\).

This is an exact existence construction for a **selected rank-one spectral sector**; it does not prove an exact block diagonalization with uniformly small generator for every arbitrary high-rank active sector, nor yield a physically implementable dressing unitary.

**An additional rank-one capacity improvement:** The projection overlap with the exact eigenstate \(\chi\) is \(w=|\langle\chi,\varphi\rangle|^2=1-d^2\). If \(d<1/\sqrt2\), the existing exact spectral-dominance theorem gives the stronger lower bound

\[
\boxed{
|\langle\varphi,e^{-itH/\hbar}\varphi\rangle|^2\ge(1-2d^2)^2
\ge1-4d^2\quad\forall t.
}\tag{MIC-27F}
\]

This remains a rank-one *return fidelity* certificate, not a proof of continuing physical subjective identity.

## MIC-27G — time-dependent protocol / common-invariant obstruction

For a time-dependent (piecewise bounded) full Hamiltonian \(H(t)\), let \(U(t)\) be its propagator. A static Riesz projector \(R\) for \(H(t_0)\) is **not automatically** invariant through later write/read/control epochs. An exact sufficient condition is

\[
[H(t),R]=0\quad\text{for almost every }t,
\]

which implies \([U(t),R]=0\) for all \(t\).

There is also an exact **finite-time** quantitative relaxation. For any fixed projector \(R\), define the integrated commutator defect

\[
\varepsilon_R(t)=\frac{1}{\hbar}\int_0^{|t|}
\|[H(s),R]\|\,ds
\]

(for negative time integrate over the corresponding signed interval). Differentiating \(U^\dagger(t)RU(t)\) and integrating gives

\[
\boxed{\|[U(t),R]\|\le\varepsilon_R(t).}\tag{MIC-27G1}
\]

For any other projector \(P\) with \(d=\|P-R\|\), \(\|(I-P)U(t)P\|\le2d+\varepsilon_R(t)\), and hence every normalized \(\psi\in\mathrm{Ran}P\) satisfies

\[
\boxed{
C_P(t)\ge1-\min\{1,\,2d+\varepsilon_R(t)\}^2.
}\tag{MIC-27G2}
\]

This exact error budget is **not** automatically an all-time floor: if \(\varepsilon_R(t)\) grows, the right side becomes zero. If \(\sup_t\varepsilon_R(t)<1-2d\), it stays strictly positive (or use the tighter threshold \(2d+\sup_t\varepsilon_R(t)<\sqrt{1-\theta}\) for desired \(C>\theta\)). Independent microphysics must prove the common invariant or a uniform integrated-defect bound **for the complete switched implementation**. Separate epoch-wise invariant projectors are not enough.

## Actual BCRD source / X3 obligations

The proposed draft states \(\mathcal H_P\otimes\mathcal H_Q\) and later calls \(Q=I-P\). A tensor-product **environment factor** and the orthogonal **sector complement** are different mathematical objects. MIC-27A is stated for a single full \(\mathcal H\) and its true orthogonal projection, avoiding this ambiguity.

No named physical BCRD source operator, validated physical inner product, complete \(P_0\) identification, \(\delta\) value or \(\|V\|\) estimate is supplied. Even obtaining such an exact invariant rank-one projection does **not** identify a living particular or discharge `IR102SectorSemanticBridge`'s independent `sectorEntailsX3` and physical installation obligations.

**Review verdict:** Retain **MIC-27A–G** as exact conditional mathematical repairs. Reject the claim that a generic internal gap and first-order Schrieffer–Wolff series have already closed the physical BCRD source problem. Do not label as a Lean-certified or universal-world protection proof.
