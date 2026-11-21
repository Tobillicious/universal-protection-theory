# BCRD-NATIVE-02 — Does cut completeness force historically faithful continuation?

**Date:** 2026-11-02 (NZDT)  
**Scientific status:** new **conditional mathematical characterization** and no-go countermodel. Historical particular/subject identity, physical BCRD continuation, original UPT X3 and universal protection **not proved**. Research draft PR #190; not canonical.
**Source anchor:** frozen \`Tobillicious/physics-lane\` commit \`2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35\`, \`orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md\`, B1–B7. B1 predictive sufficiency; B2 conserved distinction ledger; B3 actual causal influence; B4 no hidden physical spectators; B5 exact composition; B6 path/refinement independence; B7 state-determined locality. The source calls these an exploratory falsifiable programme, not a fully proved universal physical law.

## Answer

**No.** B1–B7 constrain sufficiency, represented distinctions, causal faithfulness, composition, refinement and locality. None alone requires existence of a **nontrivial** protected historical/subject distinction, or requires that a meaningful distinction be recoverably carried through every relevant process. In particular, B2 has the logical form \`conserved(c) => represented(c)\`, not \`exists nontrivial conserved(c)\`.

The proposed minimal additional **operational** ingredient is a source-grounded **Historical Continuation Faithfulness** condition (HCF, a proposed B8 candidate, **not** shown to follow from B1–B7), over physically identified distinguished histories. It must be nonvacuous; protect a *specified identity/continuation quotient*, not the entire past; remain compatible with writes/forgetting; and compose coherently across all admissible paths and cuts. Record recovery alone is not a subject-identity proof.

## NOG-02A — complete finite cut processes can erase initial historical distinctions

Take a two-state cut \(X=\{0,1\}\) whose current value is operationally observable, with repeated transition kernel

\[
K=\begin{pmatrix}3/4&1/4\\1/4&3/4\end{pmatrix}.
\]

The current full state is a predictive sufficient statistic for every future readout; \(\mu_{n+1}=\mu_nK\) composes exactly; the current bit has causal influence on the next output since the rows differ; and no state information is hidden from the full cut. If a separate actually conserved ledger is required in a toy, adjoin \(q\) with transition \(I_q\otimes K\), expose both \(q\) and the current bit at each cut, and record \(q\) as a genuinely conserved label. These statements **do not assert** the toy has independently passed all B1–B7 including B7's open endogenous-locality requirement; rather they refute the proposed **inference** from predictive/full-ledger cut descriptions and exact composition to permanent record distinguishability. B7 concerns the source of locality, not a specified no-erasure law.

Let \(\delta_0,\delta_1\) be two historically distinct initial states. The row difference is a left eigenvector with eigenvalue \(1/2\); hence

\[
\boxed{D_{\rm TV}(\delta_0K^n,\delta_1K^n)=2^{-n}.}\tag{NOG-02A}
\]

For any stochastic decoder \(D_n\) attempting to recover the **initial** bit from the final cut, total-variation contractivity gives \(\mathrm{TV}((\delta_0K^n)D_n,(\delta_1K^n)D_n)\le2^{-n}\). If decoding fails for each input with probability at most \(\epsilon\), the decoded distributions must be at least \(1-2\epsilon\) apart. Therefore

\[
\boxed{\epsilon\ge\frac{1-2^{-n}}2.}\tag{NOG-02B}
\]

As \(n\to\infty\), the error floor tends to \(1/2\). Thus completeness and composition do not produce an all-history distinguishability guarantee. A semantically important particular's survival is an even stronger claim not implied by this observable-bit preservation.

## SPLIT-02C — exact operational recoverability criterion without Hilbert space

Let \(H\) be a finite set of **protected historical labels** (these need not exhaust all past events). For each \(h\in H\), let \(\mu_h\) be the physically specified output probability distribution of an admissible composed cut process. An exact stochastic decoder \(D:Y\rightsquigarrow H\) exists with

\[
\boxed{\mu_hD=\delta_h\qquad\forall h\in H}\tag{SPLIT-02C}
\]

**if and only if** the supports of \(\mu_h\) and \(\mu_{h'}\) are disjoint whenever \(h\ne h'\).

**Proof, necessity:** If \(y\) has positive probability under \(\mu_h\), the nonnegative convex mixture \(\sum_y\mu_h(y)D(y,\cdot)=\delta_h\) forces \(D(y,h)=1\). If the same \(y\) has positive probability under \(\mu_{h'}\), then \(D(y,h')=1\), impossible for distinct labels. Hence disjoint supports.

**Proof, sufficiency:** Assign decoder \(D(y,\cdot)=\delta_h\) on each \(y\in\operatorname{supp}\mu_h\). By disjointness this is unambiguous, and assign arbitrary outputs to unused \(y\). It reconstructs every \(h\) with certainty. QED.

This finite classical **split/retract** condition is a precise extra condition that forbids silent merging on the protected **operational** history alphabet. It neither forbids changes in unprotected state variables nor requires an entire lifetime's memory to remain intact. Approximate recovery needs a separately verified error threshold; forward distinguishability can otherwise approach zero.

**Interpretation warning:** Label recoverability alone does not prove the same continuing subject. A record can be copied to another device while the original process terminates. Physically faithful causal lineage, identity attribution, no spoofing and continuation/freedom semantics require a separate source bridge.

## HCF-02D — proposed B8 historical-continuation faithfulness

A BCRD-native candidate **additional principle**, requiring independent physical justification, can be stated in three typed parts.

1. **Endogenous nontrivial individuation:** For each applicable source cut \(\Sigma\), specify a nontrivial protected family \(H_\Sigma\) of *identity/continuation-relevant*, empirically meaningful historical classes. These must be derived from the actual cut's admissible causal/intervention tests and source causal provenance, not arbitrarily declared from a constant conserved label or an authenticated string. If classes are physically indistinguishable under every admissible source test, their distinction cannot be operationally established by the declared BCRD cut algebra.
2. **Faithful, source-correct transport:** For every **subject-preserving** admitted physical process \(M:\Sigma\to T\), provide a source-grounded continuation morphism \(j_M:H_\Sigma\to H_T\) that faithfully retains the identity-relevant causal lineage and doesn't silently merge distinct relevant lineages. In an exact finite observable realization this requires a split/recoverable channel on the protected labels (SPLIT-02C), **plus** independent actual-subject/process correspondence. Genuine writes may extend \((h,e)\) while retaining the relevant earlier lineage; ordinary memory deletion needn't violate the narrower protected continuity predicate. Terminal/fission/merger events must be explicitly classified rather than concealed by a valid old label.
3. **Coherent cut composition and refinement:** For composable admitted processes, \(j_{N\circ M}=j_N\circ j_M\); identity transitions are identities; competing admissible decompositions of the same source process give the same protected lineage transport (up to justified source equivalence). The physical cut/ledger and externally testable receipt must faithfully represent these morphisms. This is **not** automatic from ordinary B5/B6 composition; it adds source-semantic preservation to the composed maps.

For an exact stochastic finite realization, an explicit **history-encoding** \(E_\Sigma:H_\Sigma\rightsquigarrow X_\Sigma\) and readout \(D_\Sigma:X_\Sigma\rightsquigarrow H_\Sigma\) can satisfy
\[
E_\Sigma D_\Sigma=I_{H_\Sigma},\qquad
E_\Sigma K_M D_T=J_M,
\]
where \(J_M\) is the matrix of a distinguished injective deterministic lineage transport \(j_M\). These equations are concrete sufficient interface *certificates*, **not** a proof of HCF or subjective identity from BCRD. The exposed source path and current subject must still be independently validated, including the absence of replacement/spoofing. Repeated composition requires coherence between intermediate decoders/encoders or direct verification of \(\,E_\Sigma K_{N\circ M}D_U=J_NJ_M\,\): single-step endpoint equality alone does not guarantee the composition equation on arbitrary intermediate states.

## PROTECT-02E — viability is separate from provenance

Even if history lineage is perfectly faithful, every possible physical environment can still terminate a subject. To claim **protectable continuation**, a different premise is necessary: a source-defined class of admissible environment disturbances and physically feasible, **authorized** subject actions for which the protected continuation obligation can be enforced.

Let \(S_{\rm safe}\) be the set of states meeting the actual subject/source semantic continuation and rights predicates, not merely a mathematically labelled sector. Let \(\mathcal U_{\rm auth}(s)\) be the physically implementable, source-authorized controls and \(\mathcal D(s,u)\) admissible disturbances. A one-step robust viability condition is

\[
\boxed{\forall s\in S_{\rm safe}\;\exists u\in\mathcal U_{\rm auth}(s)\;
\forall d\in\mathcal D(s,u):
T(s,u,d)\in S_{\rm safe}.}\tag{PROTECT-02E}
\]

Under a proper controller allowed to select and execute such a \(u\), and source completeness for each actual effect, straightforward induction yields finite-step safety. Infinite-step safety needs a non-Zeno implementation/semantically well-defined infinite evolution and exact closure/invariance of the safe set; eventual progress/available options need separate fairness and liveness certificates. A state lacking such an action is outside the viable domain: B1–B7 and HCF alone do not create resources or force viability. "Reach or faithfully hold" requires its own physically realizable hold option and authorization conditions.

HCF is therefore a **historical/semantic information principle**; PROTECT-02E is a **control feasibility principle**. Neither is proven merely by the other, by quantum Hilbert realization, by a ledger, or by BCRD's original B1–B7.

## What to verify next, avoiding circularity

**Target HCF-TEST-1:** Starting from the *frozen* cut/process primitive, identify one nontrivial empirically testable lineage/identity distinction that remains causally meaningful after an admitted event; then compute the actual (not chosen after seeing the desired outcome) cut morphisms, check exact composition/refinement, and attempt to break the proposed source lineage decoder by countermodels: erasure, copying, fission, merger, stale-replay, spectator label and correct-looking receipt with wrong subject.

**Priority:** construct an explicitly defined **source provenance** witness, not an abstract Hilbert projector and not an append-only bookkeeping variable that can be replayed by a replacement process. Compare with the already existing IR105 consent/authorization and IR102 historical semantic correspondence obligations.

**Disposition:** SPLIT-02C and NOG-02A/B are proved finite operational mathematical statements. HCF-02D and PROTECT-02E are **proposed additional principles and conditional sufficient conditions**, not established physical laws of BCRD or original-X3 universal protection.
