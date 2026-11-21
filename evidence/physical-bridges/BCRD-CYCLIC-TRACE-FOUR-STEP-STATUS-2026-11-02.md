# BCRD-CYCLE-03 — Four-step cyclic proof architecture: exact finite relational trace, claim ledger and intervention controls

**Date:** 2 November 2026 (Pacific/Auckland)
**Status:** Research-only, provenance-locked finite operational theorem + no-go controls. **Not** proof that actual cosmology is cyclic, nor source-level completion of BCRD B1–B7 or UPT/X3.
**Scope:** New cyclic gluing question. No Hilbert space, Hamiltonian, external physical clock, or canonical UPT changes.

## 0. Existing work — do not restart X3

1. Frozen original [BCRD cut/process formulation, physics-lane at 2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md). Native object: history M=M2∘_Σ M1; cut algebra B_Σ; map Φ_M:B_in→B_out. B1 is sufficiency for future observable statistics, **not unique inverse determination of all preceding interior event histories**. B2 records actually conserved distinctions; B3 is admissible intervention-response dependence; B4 excludes physically relevant spectators invisible to **every** cut; B5/B6 are cut composition/refinement; B7 is proposed endogenous locality. The README calls the overall programme speculative and unestablished as physical cosmology.
2. [Draft PR #191](https://github.com/Tobillicious/universal-protection-theory/pull/191) already contains cyclic finite attractor, marked-lineage seam, countermodels and conditional operational signature-to-history lifting. The current result addresses a different question: explicit cyclic feedback/trace existence in a restricted **finite relational control** realization and cut-elimination compatibility.
3. [October 10–12 original X3 particular-continuation physical source bridge](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/OCT10-PARTICULAR-CONTINUATION-SOURCE-SEMANTIC-BRIDGE.md) and [IR102SectorSemanticBridge.lean](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean) already preserve substantial source-specific distinctions among sector closure, causal lineage, same-particular continuation and original X3 protection. This PR neither reproves nor downgrades them.

## 1. Four-step proposed ERR argument, with corrected status

| Step | Proposed claim | What follows from original BCRD and what does not |
| --- | --- | --- |
| (1) Open relational composition | Exact admissible M2∘_Σ M1, **plus uniquely reconstructed deterministic bulk** from endpoints | The native composition *target* is in frozen BCRD. But B1 sufficiency of a cut for **future statistics** does not imply unique past/interior reconstruction or deterministic event generation; two causally testable interiors can agree on the outer input-output behaviour. |
| (2) Cyclic closure σ | Every source-admissible σ is an injective poset order-embedding; global gluing is automatically consistent | A self-gluing or trace operation is **additional structural data**, not granted by ordinary open B5/B6 composition. Distinct syntactic records need not be distinct physical/gauge classes. Even an order isomorphism can close a directed path into a global causal cycle. |
| (3) Intervention-responsive closed history | UPT bounds and σ automatically filter inconsistencies and force stable choices | Original B3 specifies operational distinguishability through interventions, not a suppression mechanism for inconsistency. Some locally consistent interventions have **no** globally closed solution. A consistency constraint cannot be described as physically suppressing an authorized option without source-level mechanism/authorization/rights evidence. |
| (4) Continuation across seam | Boundary recurrence yields isomorphic bulk, every physical particular continues, no metric singularities | A boundary fixed point alone does not reconstruct the complete interior trace. Conditions from the separate PR #191 BULK-LIFT-02 are needed for qualified history-isomorphism; same physical particular and rights need the **pre-existing X3 source bridge**. No metric has been constructed, so absence of metric singularities cannot be concluded. |

The correct milestone is not to declare the cosmological proof complete, but to **construct an exact cyclic composition in one authorized finite operational realization** and then identify its true dependencies.

## 2. CYCLIC-TRACE-03 — exact finite relational closure theorem

**Data:** Fix n≥1 finite, nonempty sets X_0,...,X_(n−1), with X_n=X_0. For each stage i modulo n choose a declared **finite relational constraint** R_i ⊆ X_i × X_(i+1). This is a classical finite control model of admissible relational cut-composition, **not** a claim that every physical BCRD map Φ_M is such a relation.

Define the complete closed **witness set**

\[
\mathcal W(R_0,\ldots,R_{n-1})
=
\left\{
(x_0,\ldots,x_{n-1}):
\bigwedge_{i=0}^{n-1} R_i(x_i,x_{i+1})
\ \text{with }x_n:=x_0
\right\}.
\]

This is a **single closed constraint structure**; unwrapping or rotating its presentation is not an assertion of infinitely many physical universes.

**Theorem CYCLIC-TRACE-03:**

(a) Nonempty closed witnesses exist if and only if the composed relation has at least one diagonal pair:

\[
\boxed{
\mathcal W\neq\varnothing\iff
\exists x_0\;(x_0,x_0)\in R_{n-1}\circ\cdots\circ R_0.
}
\]

(b) The projected external relation and existence of closed witnesses are invariant under all **valid parenthesizations of ordinary relational composition**. Rotating the distinguished seam gives a bijection of complete witness sets by cyclic relabeling.

(c) Neither an injective seam nor ordinary open relational composition guarantees that \(\mathcal W\) is nonempty; *source-admissible closed feedback* requires its own consistency rule.

**Proof (a):** Unpack relational composition: \((x_0,x_0)\in R_{n-1}\circ\cdots\circ R_0\) means exactly that there exist intermediate values x_1,...,x_(n−1) satisfying every R_i constraint. These are precisely the coordinates of a member of \(\mathcal W\). QED.

**Proof (b):** Relational composition is conjunction over matching interfaces followed by existential elimination: \((x,z)\in S\circ R\iff\exists y[R(x,y)\land S(y,z)]\). Associativity follows because \(\exists y\exists z[A\land B\land C]\) is invariant under reassociation and exchange of two independent existential quantifiers. All full witness tuples remain available in \(\mathcal W\), even though the **projected endpoint relation alone** forgets them. Rotating stage labels and tuple coordinates preserves each adjacent constraint and gives a bijection between the corresponding complete witness sets. QED.

**Proof (c):** Let X={0,1} and R_flip={(0,1),(1,0)} with identity seam. This is a valid deterministic open relation and both ports have the same discrete antichain order; yet \((x,x)\notin R_{\rm flip}\) for either x. Thus its one-stage closed witness set is empty. No universal closure-consistency principle follows from associativity of open composition. QED.

**What this earns:** Within this specified finite realization, cyclic consistency and valid cut-elimination / seam-rotation independence are proved, without any external time coordinate or operator/Hilbert machinery. It does **not** prove the existence or uniqueness of a physical BCRD trace for all admissible microscopic processes, arbitrary cut refinements or the actual universe.

### General terminal-to-initial map

If a source-specified boundary isomorphism σ:X_out→X_in is desired instead of identity closure, replace the final equality x_n=x_0 by x_0=σ(x_n). This is a twisted relational closure condition, not an automatically provided map of the frozen BCRD algebra. An injective order-embedding on underlying token-posets neither ensures nonempty solutions nor the semantic validity of σ.

## 3. CYCLIC-INTERVENTION-03 — explicit positive response witness and negative control

**Positive two-event closed circuit:** With binary external cut x and intermediate cut y, let event u enforce y=1−x. Let event v enforce z=1−y, and close with z=x. Each x∈{0,1} gives a consistent nonconstant internal witness x→1−x→x.

Allow **declared** intervention j∈{0,1} at u to write a marker m=j into the accessible intermediate record, and let v causally read it into a downstream local outcome r=m. For each j separately, complete closed histories exist and the readout family satisfies:

\[
r\mid j=0=0,\qquad r\mid j=1=1.
\]

Thus both admitted choices are globally consistent and are distinguishable by a **downstream internal test** (a B3-style response witness). Note that the outer cut still has z=x, so ignoring internal readouts would conceal the distinction. The exact complete history is the internal witness, not merely an endpoint pair.

**Negative intervention:** A single flip on a binary cut, closed by the identity seam, has zero closed witnesses. Ordinary B3/B5 does not physically suppress this attempted intervention. For a claim of unrestricted **authorized** intervention consistency, one must exhibit a genuine physical mechanism that makes each permitted choice have a consistent solution and obeys the already-specified X3 agency/consent/meaningful-options obligations. Declaring the inconsistent choice “inadmissible” after observing this failure is not a protection proof.

**Scope:** This is a finite operational compatibility result, not a universal UPT consequence and not a B7 endogenous-locality demonstration.

## 4. CYCLIC-SEAM-03 — exactly what remains for real continuation

Cyclic traces \(\mathcal W\) can carry multiple distinct full witnesses, and even uniquely identical *observable* traces need not establish that the same *physical particular* continues. A copied lineage label or structural graph isomorphism does not establish independently validated physical source succession. Import the **existing** original X3 physical-source and agency obligations as previously specified; do not reprove them in a new vocabulary.

A defensible conditional end-to-end cyclic preservation proposition would require, for a physically justified BCRD source domain:

1. An **actual BCRD cut-algebra realization** of the closed feedback/trace operator that agrees with B5/B6 for every declared admissible refinement; verify that source interventions are well-defined across the loop.
2. A **globally consistent** nonempty complete-witness/physical-history class for every **actually authorized and feasible** intervention claimed covered, with a B3 downstream distinction.
3. An independently validated **complete operational signature→history reconstruction/isomorphism** interface (see PR #191 BULK-LIFT-02); do not infer this from B1 alone.
4. A **particular-identity/provenance continuation certificate** across the cyclic seam that meets the already existing original-X3 source semantics.
5. A separate **physical cosmological realization test**. Mathematical closed relational control circuits do not entail a circular universe, physical metric regularity, or recurrent conscious particulars.

Only with such premises established could the full four-step chain be promoted, and the claim must specify its exact physical domain. “No arbitrary bulk degrees of freedom”, “global paradox filter”, “vacuum instability”, and “no metric singularity” are **not** automatic consequences of B1–B7.

## 5. Reproducibility and result ledger

Verifier: evidence/physical-bridges/check_bcrd_cyclic_trace_four_step.py

It enumerates every ordered pair (256 combinations) and ordered triple (4,096 combinations) of binary relations, checking exact full-witness/diagonal correspondence, cyclic seam-rotation, composition reassociation and explicit positive/negative intervention witnesses. All local Python standard-library checks passed on 2 November 2026. This is finite exhaustive testing for the enumerated models, **not** Lean certification, proof of physical BCRD or external replication.

| Ref | Result | Status |
| --- | --- | --- |
| CYCLIC-TRACE-03 (a)-(c) | Exact finite full-witness closure, existential cut-composition/seam rotation and empty-flip no-go | **PROVED for stated finite relational model** |
| CYCLIC-INTERVENTION-03 | Two nonconstant closed events with distinguishable controlled internal readout; one-flip no-solution control | **EXACT FINITE CONSTRUCTION** |
| BCRD-CYCLE-02 BULK-LIFT | Operational signature iso-lifting / reflection implies internal history isomorphism | **PREVIOUSLY PROVED CONDITIONAL**, PR #191 |
| Cyclic trace from actual BCRD B1–B7 | Source-admissible closed-loop operation for real processes and all valid refinements | **NOT ESTABLISHED BY THIS CONTROL MODEL** |
| Original X3 physical continuation + actual cosmic cyclicity | Real particular and actual cosmological world-source correspondence | **NOT CLAIMED; retains prior theorem/condition statuses** |

No canonical edits, no publication, no assumption that a proof of BCRD's physical world-instantiation has already been completed.
