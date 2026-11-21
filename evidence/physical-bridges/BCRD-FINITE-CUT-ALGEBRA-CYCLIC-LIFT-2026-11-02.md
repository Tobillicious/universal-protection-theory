# BCRD-CYCLE-04 — Native finite cut-map lifting of relational cyclic feedback

**Date:** 2026-11-02 (Pacific/Auckland)
**Record:** focused noncanonical research theorem, finite control. Author-side reviewed, not independently validated. Not a proof that time is physically circular or that the full BCRD/UPT programme is physically closed.
**Research objective:** Promote the *existing* finite relational cyclic-witness result [draft PR #192](https://github.com/Tobillicious/universal-protection-theory/pull/192) into the actual **\(\mathcal B_\Sigma\), \(\Phi_M\)** cut-map vocabulary of frozen BCRD, without returning to quantum Hilbert space or rebuilding X3.

## Frozen programme and preserved prior results

- [Frozen BCRD README (physics-lane commit 2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35)](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md) supplies open \(M=M_2\circ_\Sigma M_1\), cut algebra \(\mathcal B_\Sigma\) (or finite information algebra in classical controls), process map \(\Phi_M:\mathcal B_{\rm in}\to\mathcal B_{\rm out}\), B1–B7. The README does not assert uniqueness of physical cut algebras, unique deterministic bulk reconstruction, or a universally available cyclic feedback/trace.
- [Frozen BCRD M5 critical-pair coherence](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M5-CRITICAL-PAIR-COHERENCE.md) already distinguishes strong full-process equality from weak boundary-only agreement; do not repeat its proof or collapse the distinction.
- [Frozen BCRD M7 Tier-0 intervention semantics](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/M7-TIER0-INTERVENTION-SEMANTICS-GAUGE.md) establishes author-side finite controls with calibrated protocol-response kernels; programme-wide BCRD still not established.
- [Draft PR #191](https://github.com/Tobillicious/universal-protection-theory/pull/191) contains conditional full history lifting, marked-lineage seam and finite attractor controls. [Draft PR #192](https://github.com/Tobillicious/universal-protection-theory/pull/192) contains exact relational cyclic full-witness solutions and a four-stage ERR status ledger.
- Original UPT/X3 protection duties, causal lineage and physical source correspondence are preserved in [October X3 bridge](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/OCT10-PARTICULAR-CONTINUATION-SOURCE-SEMANTIC-BRIDGE.md) and [IR102](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean). This new cyclic control does **not** re-prove X3 or imply continuation of a physical particular.

## CUT-ALG-04A — Full, faithful finite cut-map representation of relational processes

Take a specified **finite classical operational-control** realization with nonempty finite sets \(X,Y\) of distinguishable cut records. Define cut algebras (or finite information algebras)

\[
\mathcal B_X:=\mathcal P(X),\qquad \mathcal B_Y:=\mathcal P(Y)
\]

with information events/predicates as subsets, ordered by inclusion. For an admitted relation \(R\subseteq X\times Y\), define the forward **possibility** process map

\[
\boxed{\Phi_R(A):=\{y\in Y:\exists x\in A\ R(x,y)\}}\quad(A\subseteq X).
\]

This \(\Phi_R:\mathcal B_X\to\mathcal B_Y\) preserves \(\varnothing\) and arbitrary (finite) **unions**, not in general intersections or complements. Thus it is a join-preserving information map, **not necessarily a Boolean algebra homomorphism**. BCRD's frozen \(\Phi_M\) is described simply as a process map, not as an asserted \(*\)-algebra/Boolean homomorphism. This is a *specific finite realization*, not proof that every BCRD physical process has this form.

**Theorem CUT-ALG-04A.** The assignment \(R\mapsto\Phi_R\) is bijective between relations \(R\subseteq X\times Y\) and all maps \(f:\mathcal P(X)\to\mathcal P(Y)\) preserving the empty set and arbitrary unions. It is compatible with identity and exact process composition:

\[
\boxed{\Phi_{S\circ R}=\Phi_S\circ\Phi_R,\qquad \Phi_{\operatorname{id}_X}=\operatorname{id}_{\mathcal P(X)}.}
\]

**Proof (uniqueness):** For any join-preserving \(f\), \(A=\bigcup_{x\in A}\{x\}\) and hence \(f(A)=\bigcup_{x\in A} f(\{x\})\). Define \(R_f(x,y)\iff y\in f(\{x\})\). Then \(f=\Phi_{R_f}\). Conversely each \(\Phi_R\) preserves unions by elementary existential distribution and \(\Phi_R(\varnothing)=\varnothing\). Since the singleton images determine each pair \((x,y)\), the map \(R\mapsto\Phi_R\) is injective as well. For composition, \(z\in(\Phi_S\circ\Phi_R)(A)\iff\exists x\in A,\exists y\,[R(x,y)\land S(y,z)]\iff z\in\Phi_{S\circ R}(A)\). The identity case follows directly. QED.

This provides an exact finite **\(\mathcal B_\Sigma\)-level B5 composition realization**, with process information completely recoverable from singleton cut queries. It does *not* reconstruct an interior microscopic **history** from the exterior \(\Phi_R\).

## CUT-ALG-04B — Cyclic consistency evaluated on native cut maps

Let \(R\subseteq X\times Y\) and let \(\sigma:Y\xrightarrow{\sim}X\) be an independently declared **bijective** terminal-to-initial identification. Define the *twisted loop-solution set*:

\[
\boxed{\operatorname{Loop}_{\sigma}(\Phi_R)
:=\{x\in X:\exists y\in\Phi_R(\{x\})\text{ with }\sigma(y)=x\}.}
\]

This uses only a cut algebra, its process map on singleton physical distinctions, and the specified seam; it does not introduce a Hilbert space, physical clock or separate world state.

**Theorem CUT-ALG-04B.** \(\operatorname{Loop}_{\sigma}(\Phi_R)\) is exactly the set of initial cut records satisfying the complete relation-plus-seam constraint \(R(x,y)\land \sigma(y)=x\). In particular, for \(Y=X,\sigma=\mathrm{id}\),

\[
\operatorname{Loop}_{\rm id}(\Phi_R)\ne\varnothing
\iff \exists x\in X:\ x\in\Phi_R(\{x\}).
\]

For open-composable \(R\subseteq X\times Y\), \(S\subseteq Y\times X\), the two different cut presentations have *equal existence* of complete loop witnesses:

\[
\boxed{
\operatorname{Loop}_{\rm id}(\Phi_S\circ\Phi_R)\ne\varnothing
\iff
\operatorname{Loop}_{\rm id}(\Phi_R\circ\Phi_S)\ne\varnothing.
}
\]

Moreover the full intermediate-witness sets \(\{(x,y):R(x,y)\land S(y,x)\}\) and \(\{(y,x):S(y,x)\land R(x,y)\}\) are bijective under cyclic rotation.

**Proof:** First assertion follows by CUT-ALG-04A singleton reconstruction; \(\sigma\) substitutes the seam equation. Second follows because the first diagonal criterion says \(\exists x,y[R(x,y)\land S(y,x)]\), which is invariant under renaming the distinguished seam and exchanging the quantified cut records. Explicit bijection \((x,y)\leftrightarrow(y,x)\). For longer finite strings, associativity and existential quantifier reassociation prove independence of *parenthesization* (not of arbitrarily changing the physical event order). QED.

**Important distinction:** equality of nonemptiness does not imply equal numbers of **projected recurrent cut records** across different seams. The bijection concerns **complete witness tuples**, not necessarily their projections. B5 and elementary B6 cut-reassociation work **in this defined finite model**, not in every physical BCRD history.

This loop function is a *finite possibility-feedback diagnostic*, not automatically a categorical trace of every BCRD cut algebra, nor a mechanism guaranteeing that a physical cyclic process can be implemented.

## CUT-ALG-04C — Nontrivial B3-style closed intervention witness

For \(X=\{0,1\}\) let first event \(u\) update \(y=1-x\). Its admitted intervention \(j\in\{0,1\}\) additionally writes an intermediate observable marker \(m=j\); so its **actual intermediate cut** can be \(Y=X\times\{0,1\}\). Second event \(v\) reads \(m\) via an admissible downstream test, updates \(z=1-y=x\), and closes the external bit seam via \(z=x\).

For both \(j=0\) and \(j=1\), complete closed witness histories exist and include a nonconstant update \(y\ne x\). But the internal readout \(m\) differs under the two intervention choices. Consequently \(\Phi_{u,j=0}(\{x\})\ne\Phi_{u,j=1}(\{x\})\) at the **declared intermediate cut**, and \(v\)'s local admissible readout distinguishes their causal effect.

Thus the finite cyclic circuit simultaneously has consistent closed external cut records and an actual B3-style intervention-response witness, rather than a pure identity fixed-point singleton.

**Negative control:** one binary flip \(y=1-x\) with identity seam \(y=x\) admits no closed witness, although it is an unproblematic open process. Neither B5 nor a port order-isomorphism supplies a dynamical “paradox filter” or guarantees a physical intervention choice can be executed.

## CUT-ALG-04D — Exterior equality does not give unique complete history

Let the external singleton cut be \(X=\{0\}\), and intermediate cut be \(Y=\{p,q\}\). Let

\[
R=\{(0,p),(0,q)\}\subseteq X\times Y,\qquad
S=\{(p,0),(q,0)\}\subseteq Y\times X.
\]

Then \(S\circ R=\{(0,0)\}\), exactly the **same exterior process relation** \(D=\{(0,0)\}\) as the one-step identity. Both have the same exterior map \(\Phi_D:\mathcal P(X)\to\mathcal P(X)\). But the two-stage history has **two** complete witnesses \((0,p),(0,q)\) while the one-stage process has one. If p and q are physically distinguished by an admitted intermediate cut test, these are not just gauge-redundant interior witnesses.

This is a precise source-grounded warning aligned with **M5's strong-versus-weak boundary coherence**: B1/B5 and equality of *exterior process maps* do not automatically establish full causal history isomorphism (or particular identity). The history-level upgrade belongs to PR #191's explicitly conditional reconstruction theorem and original X3 source semantics.

## Source-level promotion ceiling and next obligation

**PROVED** in the stated finite join-preserving classical information-algebra realization:
- a full-and-faithful correspondence between relation processes and join-preserving finite cut maps (CUT-ALG-04A);
- exact B5-type composition \(\Phi_{S\circ R}=\Phi_S\circ\Phi_R\);
- a well-defined twisted finite cyclic loop-consistency set computed from \(\Phi_R\) on singleton cut distinctions;
- seam-rotation compatibility of *full* complete witness tuples, valid finite cut-elimination reassociation and B3-style intervention witness for a stipulated admissible family;
- exact non-unique-bulk countermodel despite identical outer maps.

**NOT proved:** that actual BCRD cut maps are all join-preserving maps of finite powersets, that the frozen BCRD source provides a universal physical endomorphism trace/feedback, full B6 coherence for overlapping noncommuting event reorders, that actual local interventions have globally consistent cyclic solutions, that the physical universe has cyclic matterspacetime, or that a particular's physical existence persists across a seam. None of these is justified by X3's existing mathematical duty theory alone.

**Next smallest source-level test:** Choose one **already existing exact BCRD finite cut algebra** in the frozen physics-lane controls; explicitly identify its physical cut distinctions and actual process \(\Phi_M\), then check whether it fits this finite join-map submodel or requires a distinct well-defined closure operation. Keep a source-scoped result and separately run B3/M5 adverse critical-pair tests. Avoid promoting the result by broad claims about all cut algebras, or reopening X3.

**Verifier:** \`evidence/physical-bridges/check_bcrd_finite_cut_algebra_cyclic.py\`—standard library, 16 binary relations; 256 ordered pairs and 4,096 ordered triples; twisted seam/negative flip and outer-map/inner-witness no-go. Passed locally. Not a physical or Lean-kernel certificate.
