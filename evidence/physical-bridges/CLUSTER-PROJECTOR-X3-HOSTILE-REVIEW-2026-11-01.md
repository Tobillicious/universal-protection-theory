# LOC-5–LOC-9 — Proofs 14–16: source projector construction, exact dominance, and X3 semantic boundary

**Date:** 2026-11-01 (NZDT)  
**Status:** research-stage mathematical audit; explicitly non-canonical, not Lean-certified, not a physical BCRD instantiation, not an original-X3 proof. Related PRs #188 and #189.  
**Input:** proposed Proof 14 "BCRD Particular Construction", Proof 15 "Exact Spectral Dominance Capacity", and Proof 16 "Satisfying UPT's X3 Requirements".

## Dispositions

- **Proof 14 — not proved.** A vertex subset supplies a mathematical projection **in the declared orthonormal \(\ell^2(V)\) representation**, but high internal clustering neither controls absolute \(\|QHP\|\), guarantees a simple isolated ground state, selects a specific initial state with spectral weight \(>1/2\), nor constructs a continuing subject with X3 semantics. The "native BCRD" name is not a source provenance certificate.
- **Proof 15 — valid conditional theorem.** The exact reverse-triangle calculation is correct for **state-return fidelity** when weights correspond to distinct energy eigenspaces (degeneracies grouped). For a rank->1 physical site projector, fidelity is a *lower bound*, not its definition: LOC-1 in this PR.
- **Proof 16 — not proved.** A positive site/ray overlap does not independently entail historical memory, uninterrupted identity, authorized freedom, responsive intervention, or the original X3 requirements. Unitarity of the closed total state is not a proof of local memory preservation or agency. Quasiperiodic torus motion is not the same as having authorized choices. This is the exact logical separation formalized in \`PhysicalBridges/IR102SectorSemanticBridge.lean\`.

## LOC-5. Matrix-norm correction: cross-boundary squared entries are Frobenius norm, not operator norm

Let \(P=\sum_{i\in V_p}|i\rangle\langle i|\), \(Q=I-P\), with an **orthonormal** vertex basis, and \(M=QHP\). Then

\[
\boxed{\|M\|_{\mathrm{op}}^2
\le\|M\|_{\mathrm F}^2
=\sum_{i\in V_p}\sum_{k\notin V_p}|H_{ki}|^2.}\tag{LOC-5}
\]

The equality proposed in Proof 14 between \(\|M\|_{\rm op}^2\) and the sum of all squared entries is generally false. E.g. \(M=I_2\) has \(\|M\|_{\rm op}^2=1\) but \(\|M\|_{\mathrm F}^2=2\). Frobenius control is a **sufficient upper bound**, if absolute cross-edge weights are independently controlled.

For signed, directed or complex-valued edges, the ratio of sums used in Proof 14 is not a well-defined, representation-independent norm condition without extra conventions. A relative edge-density ratio \(\gamma\gg1\) does not supply an absolute small-coupling bound.

## LOC-6. Exact high-clustering counterexample with unbounded leakage and no dominant energy weight

For each real \(n\ge2\), consider three vertices, cluster \(V_p=\{1,2\}\), complement \(\{3\}\), and the *self-adjoint weighted adjacency Hamiltonian*

\[
H_n=
\begin{pmatrix}
0&n^3&n\\
n^3&0&0\\
n&0&0
\end{pmatrix},\qquad
P=\operatorname{diag}(1,1,0),\quad Q=\operatorname{diag}(0,0,1).
\]

The internal weighted edge sum is \(2n^3\), and the exterior weighted edge sum is \(2n\), so

\[
\gamma(V_p)=n^2\longrightarrow\infty,
\qquad
\boxed{\|QH_nP\|_{\rm op}=n\longrightarrow\infty.}\tag{LOC-6}
\]

Thus arbitrarily large clustering ratio does **not** imply an absolute \(g\le\epsilon\).

The cluster's compressed Hamiltonian is \(PHP=\left(\begin{smallmatrix}0&n^3\\n^3&0\end{smallmatrix}\right)\), with eigenvalue separation \(2n^3\); even that large cluster gap does not force an **arbitrary initially localized preparation** to have a dominant full-H energy weight. For \(\psi_0=|1\rangle\),

\[
\sigma(H_n)=\{0,\pm\sqrt{n^6+n^2}\},
\quad
w_+=w_-=\tfrac12,\quad w_0=0,
\quad
\boxed{w_*=\tfrac12.}\tag{LOC-6b}
\]

Hence the strict dominance prerequisite \(w_*>1/2\) fails **for every \(n\)** despite arbitrarily high clustering ratio. The graph is connected and has finite capacity for each \(n\). This counterexample concerns a **proposed general hypergraph-to-projector implication**, not a sourced BCRD physical Hamiltonian.

A separate ground-state isolation objection: an internally dense \(K_3\) cluster with positive uniform edge weight \(L\) has adjacency spectrum \(\{2L,-L,-L\}\); its lowest eigenvalue is twofold degenerate. Density does not imply a simple ground state.

The phrase "adjusting the initial preparation to make \(w_*>1/2\)" **adds a preparation hypothesis**, rather than deriving it for any preexisting particular. Such preparation cannot substitute for the original X3 obligation to protect particulars regardless of their spectral weights.

## LOC-7. A viable conditional graph-to-dominance theorem from absolute coupling and isolation

A legitimate, concrete theorem can instead start with independent verifiable source inputs. Let

\[
H=H_0+W,\quad H_0=PHP+QHQ,\quad W=PHQ+QHP,\quad
g=\|W\|=\|QHP\|.
\]

Suppose \(H_0\) has a **simple** eigenvalue \(\lambda\) with normalized eigenvector \(\varphi\in\operatorname{Ran}P\), isolated from all **other** eigenvalues of the *full block-diagonal* \(H_0\) by \(\delta>0\). In particular, this isolation must include eigenvalues of \(QHQ\), not merely the internal \(PHP\) gap.

If \(g<\delta/2\), the Riesz spectral projector \(R\) of \(H\) for the unique perturbed eigenvalue within a circle of radius \(\delta/2\) centered at \(\lambda\) has rank one, and standard resolvent calculus gives

\[
\boxed{\|R-|\varphi\rangle\langle\varphi|\|
\le d:=\frac{2g}{\delta-2g}.}\tag{LOC-7}
\]

Because \(R_0\varphi=\varphi\),

\[
\|(I-R)\varphi\|=\|(R_0-R)\varphi\|\le d,
\quad\text{so}\quad
\boxed{\langle\varphi,R\varphi\rangle\ge1-d^2.}\tag{LOC-7b}
\]

If, for a desired \(\theta\in(0,1)\),

\[
\boxed{1-d^2>\frac{1+\sqrt\theta}{2},}\tag{LOC-7c}
\]

then the chosen full-H energy eigenmode has weight \(> (1+\sqrt\theta)/2\). Consequently, by LOC-1, **the unperturbed cluster vector \(\varphi\)** satisfies

\[
\boxed{\|Pe^{-itH}\varphi\|^2>\theta\quad\forall t\in\mathbb R.}\tag{LOC-7d}
\]

This gives an exact, nonaveraged and no-period-required **conditional mathematical construction**. It is a sufficient certification path: source-defined cluster \(P\), absolute block coupling \(g\), spectral isolation \(\delta\), and a specified initial vector \(\varphi\). It does not derive these premises from mere topology or high clustering; it does not assert historical continuity or freedom.

For a *fixed preexisting state* \(\psi_0\in\operatorname{Ran}P\), the initial dominant overlap condition must also be checked or derived. Choosing \(\varphi\) does not retroactively prove protection of arbitrary inhabitants of the cluster.

## LOC-8. X3 is strictly stronger than quantum occupancy; concrete separation models

### Occupancy vs. internal memory observable

Take \(\mathcal H=\mathbb C^3\), \(P=|0\rangle\langle0|+|1\rangle\langle1|\), and

\[
H=\operatorname{diag}(0,\Delta,\Lambda),\qquad
\psi_0=\sqrt{0.9}|0\rangle+\sqrt{0.1}|1\rangle.
\]

Then \(C_{\mathrm{site}}(t)=1\) for all \(t\), the dominant energy weight is \(0.9\), yet the internal relative-phase observable \(O=|0\rangle\langle1|+|1\rangle\langle0|\) changes its expectation from \(+0.6\) at time 0 to \(-0.6\) at \(t=\pi/\Delta\). The occupancy bound alone places no constraint on *which* historically meaningful memory observables persist, nor their authorized evolution.

### Quasiperiodic motion vs. freedom

A deterministic closed Schrödinger trajectory can densely fill a torus while the model supplies **no agent action variables or alternative authorized transitions** at a given state. Thus a rich phase orbit does not imply UPT's independently defined option, authorization, or freedom predicates. A static energy eigenstate can have \(w_*=1\), \(C_{\mathrm{site}}\equiv1\), and no demonstrated agency. Neither example asserts that an actual person lacks autonomy; they expose a missing logical bridge.

### Source proof interface already recorded in the repository

\`evidence/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean\` explicitly requires independent hypotheses

\[
\begin{aligned}
&\text{complete}: \quad physicalStep(s,t)\Rightarrow modelStep(s,t),\\
&\text{sectorClosed}: \quad sector(s)\land modelStep(s,t)\Rightarrow sector(t),\\
&\text{sectorEntailsX3}: \quad sector(s)\Rightarrow x3(s).
\end{aligned}
\]

Its theorem \`physical_sector_semantic_bridge\` then transfers protection along physical reachable histories. Its \`sector_closure_alone_insufficient\` countermodel explicitly shows that closed-sector membership does not force an independently defined X3 predicate.

**Proof 16 supplies no derivation of the indispensable \`sectorEntailsX3\` premise.** It replaces historically grounded continuation and choice with projector occupancy and phase motion, respectively. The correct bridge requires semantic and physical evidence; it cannot be discharged by relabeling the predicates.

## LOC-9. Verification and nonvacuity checklist

For any next candidate, record and independently verify:
1. Exact frozen source Hamiltonian \(H\), physical inner product/Gram matrix, vertex/hyperedge representation and provenance.
2. Physical map identifying a particular \(p\) and meaningful time-dependent or fixed \(P_p\), *without choosing the projector solely for the desired bound*.
3. Absolute numerical or symbolic \(\|QHP\|\), and isolation of a specified eigenvalue against the **full** block-diagonal \(H_0\).
4. Initial preparation provenance and actual spectral weights, including degeneracies.
5. Perturbation envelope showing the lower bound persists under realistic admissible effects; source/controller correspondence if an effect gate is invoked.
6. An independently supported observable/trace/transition interpretation that makes \`sectorEntailsX3\` physically meaningful for historical continuation, agency, authorization and all originally defined freedoms.
7. Review the finite-capacity, dimension, scaling, and physical units before promoting abstract finite matrices as models of the world.

**Conclusion:** Preserve Proof 15 and the repaired LOC-1 / LOC-7 as conditional finite-dimensional mathematics. Proof 14 does not construct a BCRD-native physical subject from clustering; Proof 16 does not prove X3. No weakening of original X3 is suggested.
