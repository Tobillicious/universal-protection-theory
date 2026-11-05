# BCRD-NATIVE-01 — Back before Hilbert space: cut-process continuation and representational redlines

**Date:** 2026-11-02 (NZDT)  
**Status:** noncanonical, research-stage structural audit and **conditional** finite-operational-process theorem. No physical source emergence, original X3 preservation, new Hilbert axiom, or universal protection claim.  
**Source anchor:** \`Tobillicious/physics-lane\` frozen commit \`2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35\`, \`orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md\`, especially B1–B7. Corroborating checkpoints \`M1-M2-TWO-SITE-EVENT-ANALYSIS.md\`, \`M5-C-RELATIONAL-CLOSURE.md\`, \`M6-FIXED-LINEAR-REDUCTION-BOUNDARY-SUFFICIENCY.md\`, \`M6-ENDOGENOUS-RELATION-TRADEOFF.md\`, \`M7-TIER0-FULL-BOUNDARY-ALGEBROID.md\`. Frozen status is author incubator, not independently accepted science; no canonical evolution.

## 0. The decisive category error in proposed Proof 29

The frozen BCRD primitive is a **relational cut/process algebra**, not an arbitrarily weighted hypergraph with \(\partial\mathfrak R=0\). An admissible history \(M=M_2\circ_\Sigma M_1\) is associated with a physical cut algebra \(\mathcal B_\Sigma\) and process maps \(\Phi_M:\mathcal B_{\rm in}\to\mathcal B_{\rm out}\). Its research targets include B1 predictive completeness, B2 ledger completeness, B3 causal faithfulness, B4 no physical spectators, B5 exact composition, B6 path/refinement independence, and B7 self-determined locality. These are a **falsifiable programme**, not already discharged universal axioms deriving microscopic quantum physics.

Do not replace that primitive with \(\ell^2(V)\), \(H=\hbar A\), or a tensor factorization and then claim those structures were derived from BCRD. Such choices define a *particular additional model*. B7 in particular allows effective causal/factorization structure to depend on the relational state, making a single background partition especially questionable.

## 1. Exact graph countermodel: closed boundary, no tensor split, no local invariance

Consider the oriented **triangle** chain \(c=[0,1]+[1,2]+[2,0]\), whose chain boundary is
\[
\partial c=([1]-[0])+([2]-[1])+([0]-[2])=0.
\]
Take the (even friendlier than the proposal) **Hermitian** unweighted adjacency
\[
A=\begin{pmatrix}0&1&1\\1&0&1\\1&1&0\end{pmatrix}.
\]
Split vertices into \(V_P=\{0\}\) and \(V_Q=\{1,2\}\). The vertex Hilbert space is necessarily
\[
\ell^2(V)=\ell^2(V_P)\oplus\ell^2(V_Q),\quad \dim\ell^2(V)=3,
\]
whereas \(\dim\bigl(\ell^2(V_P)\otimes\ell^2(V_Q)\bigr)=1\cdot2=2\). No isomorphism of the asserted form exists for this partition.

Let \(P=|0\rangle\langle0|\) and, **as an independent optional modeling choice**, \(H=A\) in \(\hbar=1\) units. Then \([H,P]\ne0\). Exact spectral decomposition of \(A\) (eigenvalues \(2,-1,-1\)) yields
\[
\langle0|e^{-itA}|0\rangle=\tfrac13(e^{-2it}+2e^{it}),\quad
\boxed{C_P(t)=\frac{5+4\cos(3t)}9},\quad
C_P(\pi/3)=\tfrac19.
\]
Thus even **closed topological cycle plus Hermitian adjacency** does not entail \([U,P]=0\), and the closed boundary doesn't imply zero cross-cut amplitude. A directed weighted adjacency can also be non-Hermitian unless conjugate reciprocity or a self-adjoint incidence construction is imposed.

This countermodel disproves the claimed general graph-to-tensor and closure-to-arbitrary-invariant inferences; it does **not** claim to disprove the actual frozen BCRD B1–B7 programme, whose primitive is different.

## 2. BCRD-native finite operational continuation theorem (CON-01)

Take a sequence of operational cut-state sets \(X_0,\ldots,X_n\), each finite, and stochastic physical-state transitions \(K_i:X_i\rightsquigarrow X_{i+1}\). This is one **classical finite operational realization** of possible cut data, not an assumption that BCRD forces stochastic or Hilbert-space dynamics. A state \(\mu_i\in\Delta(X_i)\) evolves as \(\mu_{i+1}=\mu_i K_i\).

An operationally **source-identified**, physically meaningful future continuation/test effect \(f_i:X_i\to[0,1]\) gives a score
\[
C_i(\mu_i)=\langle\mu_i,f_i\rangle=\sum_{x\in X_i}\mu_i(x)f_i(x).
\]
Here \(K_i f_{i+1}(x)=\sum_y K_i(x,y)f_{i+1}(y)\) denotes the **Heisenberg dual** of state pushforward. This dual is *not automatically identical* to the frozen BCRD \(\Phi_M:\mathcal B_{\rm in}\to\mathcal B_{\rm out}\); its variance/covariance direction must be typed and checked for a chosen operational representation.

### CON-01A — exact preservation and compositionality

If for each transition
\[
\boxed{K_i f_{i+1}=f_i,}\tag{CON-01A}
\]
then
\[
C_{i+1}=\langle\mu_i K_i,f_{i+1}\rangle
=\langle\mu_i,K_i f_{i+1}\rangle
=\langle\mu_i,f_i\rangle=C_i.
\]
Induction yields \(\boxed{C_n=C_0}\) for every permitted finite composition. If the source has genuine path/refinement independence, the transport condition must be checked against **all admissible decompositions**, not just one handpicked path.

### CON-01B — quantitative imperfect continuation

If \(\|K_i f_{i+1}-f_i\|_\infty\le\varepsilon_i\), then
\[
|C_{i+1}-C_i|
=|\langle\mu_i,K_i f_{i+1}-f_i\rangle|\le\varepsilon_i,
\]
so
\[
\boxed{|C_n-C_0|\le\sum_{i=0}^{n-1}\varepsilon_i.}\tag{CON-01B}
\]
A one-sided condition \(K_i f_{i+1}\ge f_i-\varepsilon_i\) gives the weaker but often more appropriate protection lower bound \(\boxed{C_n\ge C_0-\sum_i\varepsilon_i}\). A strictly positive **uniform all-history** floor requires a proved uniform total error budget; finite local budgets do not imply it by themselves.

### CON-01C — recovered history distinguishability requires a decoder

For two alternative initial history preparations \(\mu,\nu\) and the full forward composed kernel \(K\), total-variation distance contracts:
\[
D_{\rm TV}(\mu K,\nu K)\le D_{\rm TV}(\mu,\nu).
\]
If an actual decoder \(D\) exists on the accessible final cut such that
\(D_{\rm TV}((\mu K)D,\mu)\le\eta\) and
\(D_{\rm TV}((\nu K)D,\nu)\le\eta\), then by the triangle inequality and contractivity,
\[
\boxed{
D_{\rm TV}(\mu K,\nu K)\ge\max\{0,D_{\rm TV}(\mu,\nu)-2\eta\}.
}\tag{CON-01C}
\]
Without accessible decoder/source correspondence, continuation of a scalar effect does **not** imply recovery of every historical record. This is the operational non-Hilbert analogue of the earlier conditional memory-recovery theorem, not its physical verification.

## 3. Why BCRD cut completeness does not automatically create a protected particular

**Quantifier trap:** B2 ledger completeness says (schematically)
\[
\forall c\;\bigl(\mathrm{Conserved}(c)\Rightarrow\mathrm{RepresentedInLedger}(c)\bigr).
\]
It does **not** entail \(\exists c\;\mathrm{Conserved}(c)\) with the identity/protection semantics sought. B1 future predictability likewise does not imply reversible dynamics, individual persistence, or that a meaningful \(f_i\) satisfies CON-01A.

**Concrete two-state causal Markov countermodel:** Let \(X=\{0,1\}\) and \(K=\begin{psmallmatrix}3/4&1/4\\1/4&3/4\end{psmallmatrix}\). The current state predicts the future (a complete observable cut), the two inputs have different downstream output statistics (causally distinguishable), and ordinary kernel composition is exact. But \(Kf=f\) implies \(f(0)=f(1)\): there is **no nonconstant invariant observable**. An initial bit distinction decays geometrically under repeated applications. This counterexample targets the **inference from finite predictive composition to individual invariance**, not the entire speculative BCRD B1–B7 target, especially B7 endogenous locality. The existence/uniqueness of an actual source-grounded distinguished \(f_i\) remains the core burden.

**Vacuity trap:** \(f_i\equiv1\) obeys CON-01A for every stochastic channel and protects nothing about a particular. A usable continuation observable must be nontrivial, history/identity-sensitive in the **actual declared operational domain**, and must pass the source's B3 causal/B4 spectator tests and original-X3 semantics rather than be chosen solely to make the equation true.

## 4. Quantum and Hilbert space are OPTIONAL downstream representations

If an independently derived cut observable algebra has a suitable **unital \(C^*\)-algebra** structure and a positive state \(\omega\), the GNS construction yields a representation \((\pi_\omega,\mathcal H_\omega,\Omega_\omega)\). This does **not** make its observables noncommutative. E.g. \(\mathcal A=\mathbb C^2\) with faithful probability weights has a GNS Hilbert space \(\mathbb C^2\), but \(\pi(\mathcal A)\) is diagonal/commutative: this is a representation of a *classical* bit.

To introduce self-adjoint quantum Hamiltonians or a spatial tensor factorization, additional structures need to be **derived from operational content**: appropriate noncommutativity, positivity/norm/completion, dynamics as continuous reversible *-automorphisms with an implementer, compositional subsystem independence/local tomography (where applicable), source/generator correspondence, physical units and calibration. GNS alone gives none of the proposed microscopic \(H=\hbar A\) or \(g<\delta/2\) or X3.

If in a **particular faithful covariant quantum representation** a source-grounded self-adjoint idempotent \(e\) is invariant under all relevant observable automorphisms, then \(R=\pi(e)\) is a projection, and any implementing unitary \(U_t\) satisfies \(U_t R U_t^\dagger=R\). This is the correct conditional **direction** from native BCRD preservation to Hilbert invariant projector; it is not an automatic universal emergence theorem.

## 5. Operational structure of the real next proof

The actual next open theorem is **not** "derive \(\mathcal H\) from \(\partial\mathfrak R=0\)". It is:

> Given the frozen BCRD cut/process primitive and its B1–B7 obligations, establish from independently specified physical boundary tests a **nontrivial, representation-independent, history/particular-sensitive family of continuation distinctions** \(f_\Sigma\) on every admissible relational cut, together with complete cut/process maps proving their preservation or quantitatively bounded degradation, while retaining genuine action alternatives and cumulative duties for all original subjects.

The **construction of \(f_\Sigma\)**, its physical truth conditions, faithful observational equivalence, and coverage over state-dependent locality are **open**. CON-01A–C then give exact compositional algebraic theorems *if such source-backed effects and processes are supplied*. Subjective identity, consent and original X3 remain independent semantic/installation obligations.

**Scientific disposition:** This is a useful native-operational redline and new conditional preservation proof, not physical source instantiation. Keep in draft PR #190 as a reviewable alternative to the unsupported Proof 29. Do not modify the frozen physics-lane source, claim a Hilbert-space derivation, or merge/publish as original-X3.
