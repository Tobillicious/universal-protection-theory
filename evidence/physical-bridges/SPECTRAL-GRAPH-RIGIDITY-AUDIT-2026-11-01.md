# SPEC-1 — Hostile audit of proposed Proof 8R: graph symmetry does not enforce exact recurrence

**Date:** 2026-11-01 (NZDT)  
**Disposition:** proposed Proof 8R is **false as stated**; rigorous finite-graph counterexample and corrected sufficient spectral theorem.  
**Scope:** mathematical audit of a proposed bridge, not a statement that circular physical time is impossible, nor a theorem of universal X3 protection.  
**Related:** \`CYCLIC-SECTOR-CAPACITY-THEOREM-2026-11-01.md\` and \`CIRCULAR-HOLONOMY-RECURRENCE-AUDIT-2026-11-01.md\` (same draft PR).

## 1. Exact connected vertex-transitive integer-adjacency counterexample

Let \(\Gamma=C_5\), the five-cycle, and \(H=A_{C_5}\) its real symmetric unweighted adjacency matrix:

\[
H=\begin{pmatrix}
0&1&0&0&1\\
1&0&1&0&0\\
0&1&0&1&0\\
0&0&1&0&1\\
1&0&0&1&0
\end{pmatrix}.
\]

The graph is finite, compact as a discrete space, connected, 2-regular, vertex-transitive, and possesses the nontrivial dihedral automorphism group \(D_5\). All matrix elements are integers. Nonetheless,

\[
\boxed{\chi_H(x)=(x-2)(x^2+x-1)^2.}
\]

Its distinct energies, in increasing order, are

\[
E_0=-(1+\sqrt5)/2,\quad
E_1=(\sqrt5-1)/2,\quad
E_2=2.
\]

The two positive gaps above \(E_0\) are

\[
\Delta_1=\sqrt5,\qquad
\Delta_2=(5+\sqrt5)/2,\qquad
\frac{\Delta_2}{\Delta_1}=\frac{1+\sqrt5}{2}\notin\mathbb Q.
\]

If some \(T>0\) satisfied \(e^{-iHT}=e^{i\phi}I\), the finite-dimensional spectral criterion would force both \(\Delta_1T\) and \(\Delta_2T\) to lie in \(2\pi\mathbb Z\), implying \(\Delta_2/\Delta_1\in\mathbb Q\), contradiction. Therefore

\[
\boxed{\nexists T>0,\phi\in\mathbb R:\ e^{-iHT}=e^{i\phi}I.}
\]

**What this refutes:** vertex transitivity, integer-valued adjacency, finite-dimensionality, and algebraic-integer spectra do not force rationally commensurate energy gaps. Algebraic numbers need not be rationally dependent.

The counterexample tests the *proposed general implication*. It does not prove that any specific BCRD Hamiltonian has this spectrum.

## 2. Nontrivial, genuinely conserved U(1) charge does not rescue 8R

Take the disjoint union of two copies of \(C_5\); it is still a finite vertex-transitive graph (within-copy rotations and swapping copies act transitively). On \(\mathbb C^5\oplus\mathbb C^5\), set

\[
\widetilde H=H\oplus H,\qquad
Q_{\mathrm{ch}}=0\,I_5\oplus 1\,I_5,\qquad
R(\theta)=e^{i\theta Q_{\mathrm{ch}}}.
\]

Then \(Q_{\mathrm{ch}}\) has nontrivial **integer** spectrum \(\{0,1\}\),

\[
[\widetilde H,Q_{\mathrm{ch}}]=0,\qquad
R(\theta+2\pi)=R(\theta).
\]

Thus the model has an exact nontrivial, compact U(1) symmetry with quantized, conserved charge. Its Hamiltonian spectrum still contains the irrational gap ratio above, so no projective global period exists.

A finite lattice boundary closure operator can independently be defined on \(\mathcal L=\mathcal P(V)\), e.g. \(B(X)=\text{union of connected components meeting }X\). This map is monotone, inflationary, idempotent, graph-automorphism equivariant, and satisfies \(B(V)=V\). It does not force energy commensurability.

**Typing caveat:** A boundary map on the finite *set* lattice \(\mathcal P(V)\) is not directly a complex-linear map on state vectors. The expression \(B(e^{i\theta}\psi)=e^{i\theta}B(\psi)\) requires a separate Hilbert-space realization. If gauge phases act trivially on gauge-invariant subsets \(X\), the set-level map is equivariant but constrains no relative quantum energies. A physically nontrivial lift must be independently constructed.

## 3. Invalid inference in the proposed argument

The chain

\[
\text{finite graph + symmetry}\ \Rightarrow\
\text{algebraic energy levels}\ \Rightarrow\
\text{rational gap ratios}
\]

fails at its second implication; \(C_5\) supplies the exact counterexample.

Also, \([H,Q_{\mathrm{ch}}]=0\) only guarantees block decomposition by charge. It does **not** imply \(H=\alpha I+\omega Q_{\mathrm{ch}}\) or an integer-spaced energy ladder. A global wavefunction-phase symmetry is automatic for linear Schrödinger dynamics and is not the claimed nontrivial energy quantization mechanism. Noether's theorem requires the relevant continuous symmetry of the **dynamical action**, not mere equivariance of a separately defined set-closure map.

Finite cardinality of the underlying relational lattice does not by itself bound the number of continuous rays/states of its complex Hilbert representation, and a continuous U(1) phase orbit of a nonzero vector cannot be a finite set of distinct vectors.

## 4. Corrected constructive theorem: integer-spaced Hamiltonian spectrum is sufficient

**SPEC-2 (spectral ladder ⇒ exact projective recurrence).**
Let \(H=H^*\) act on a finite-dimensional Hilbert space. Suppose its spectrum obeys

\[
\sigma(H)\subseteq\alpha+\omega\mathbb Z,
\qquad \omega>0.
\]

Then, putting \(T=2\pi/\omega\), the spectral theorem yields

\[
U(T)=e^{-iHT}=e^{-i\alpha T}I.
\]

**Proof:** For each spectral value \(E_j=\alpha+\omega n_j\), \(e^{-iE_jT}=e^{-i\alpha T}e^{-i2\pi n_j}=e^{-i\alpha T}\). Summing over the orthogonal spectral projections gives the identity. QED.

**Corollary:** Any real symmetric matrix with exclusively *integer* eigenvalues has an exact period \(T=2\pi\) in units where \(H\) is that matrix. Merely having an *integer matrix* is not sufficient (see \(C_5\)). More generally, rationally commensurate gaps are necessary and sufficient for an exact projective period in finite dimensions.

**Important:** SPEC-2 is a sufficient criterion, *not* a derived BCRD law. A BCRD-native proof must show why its particular Hamiltonian satisfies the ladder condition and what determines \(\omega\) (hence the physical period).

## 5. Relation to Cyclic Sector-Capacity theorem and UPT

Even after SPEC-2, the separately established CYCLIC-1 bound only ensures

\[
\|QU(t)P\|\le \min\{1,\,\|QHP\|\,\mathrm{dist}(t,T\mathbb Z)\}.
\]

A positive sector-capacity threshold requires the additional quantitative inequality

\[
\frac{T}{2}\|QHP\|<\sqrt{1-\theta}
\]

and a **physical and historical X3 bridge** identifying occupancy of the chosen \(P_p\) with continuation of the same particular. Rational gaps alone neither guarantee this inequality nor universal coverage.

The original UPT reach-or-faithfully-hold architecture is a separate candidate route for vulnerable particulars; its source/controller/effect semantic and real-world installation obligations remain open.

## 6. The next properly scoped BCRD question

For a **named frozen BCRD source Hamiltonian**, compute the exact characteristic/minimal polynomial in its physical inner product; determine whether all energy gaps are rationally commensurate, and exhibit a physically specified period if so. Alternatively, derive a source-mandated spectral ladder (or fully specified projective circle action) independently of the recurrence conclusion.

Do not replace the missing proof with an appeal to finite graph symmetry, algebraicity, U(1) charge quantization, or Knaster–Tarski closure. These properties alone are insufficient.

## Reproduction

The standard-library checker \`check_cycle5_spectral_commensurability.py\` computes the exact characteristic polynomial from the adjacency matrix using integer polynomial arithmetic and confirms the reported coefficients. The irrationality step is exact mathematics: if \((1+\sqrt5)/2\) were rational then \(\sqrt5\) would be rational, contradiction.
