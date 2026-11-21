# BCRD-CYCLE-01 — Finite attractor and particular-lineage seam: exact repair and no-go controls

**Date:** 2 November 2026 (Pacific/Auckland)  
**Record class:** focused, noncanonical mathematical research audit and finite operational positive controls. **Not** physical cosmology, universal attractor of matterspacetime, independent BCRD acceptance, or renewed proof of original X3. No Hilbert-space, Hamiltonian, or externally progressing cosmic-time premise.

## Provenance / avoid restarting X3

Frozen BCRD primitive: [physics-lane BCRD README at 2b50c811](https://github.com/Tobillicious/physics-lane/blob/2b50c8112bf5450aa4f30bf6e3a8f83b0ec9ec35/orthogonal-validation/theory-incubator/boundary-complete-relational-dynamics/README.md). It states the composition of relational histories through cut algebras, B1 predictive completeness, B2 ledger completeness, B3 intervention-defined causal influence, B4 no physical spectators, B5 exact cut composition, B6 path/refinement independence, and B7 endogenous locality. The BCRD README expressly describes a falsifiable research programme, not a generally accepted theorem for actual cosmology.

**Existing UPT lineage work (do not re-prove it here):**
- [October 10–12 particular-continuation source-semantic bridge](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/OCT10-PARTICULAR-CONTINUATION-SOURCE-SEMANTIC-BRIDGE.md), which preserves original X3 duties, independent real-process completeness, causally continuing same particular and agency/choice obligations.
- [IR102SectorSemanticBridge.lean](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/PhysicalBridges/IR102SectorSemanticBridge.lean), whose source explicitly distinguishes model-sector closure from original-X3 semantics.
- [IR-125 BCRD channel separation review](https://github.com/Tobillicious/universal-protection-theory/blob/main/evidence/physical-bridges/IR125-BCRD-CHANNEL-SEPARATION-REVIEW.md), source-level causal witnesses vs independently reliable instrument capture.
- [Draft PR #190](https://github.com/Tobillicious/universal-protection-theory/pull/190), especially BCRD-native history-continuation and exact decoder controls. This independent PR changes neither its branch nor the canonical X3 paper.

This document answers the **new cosmic-gluing** question only: what would finite cyclic basins and faithful marked-event lineage gluing actually entail?

## A. Attractor theorem — what follows from finiteness alone

**FIN-CYCLE-01.** Let X be a nonempty finite set of physically distinguishable interface configurations (a *separately chosen finite operational model*), and let T:X→X be a deterministic, total, single-valued compositional update. Define

\[
C_{\mathrm{per}}:=\{x\in X:\exists N\in\mathbb N_{>0}\ T^N(x)=x\}.
\]

Then C_per is nonempty and every trajectory enters it after at most |X|−1 updates. Hence, for **any metric** on finite X,

\[
\boxed{\forall x\in X\ \exists k\le |X|-1:\ T^k(x)\in C_{\mathrm{per}},
\qquad \lim_{k\to\infty} d(T^k x,C_{\mathrm{per}})=0.}
\]

**Proof:** Among the |X|+1 values x,T(x),…,T^{|X|}(x), two coincide. From the first repeated value the deterministic trajectory is periodic. At most |X|−1 previous distinct values are transient. The orbit then stays in C_per; distance to it is exactly zero. QED.

**Consequences:** The proposed “eventually dissipative” assumption is unnecessary for a total deterministic finite map; in this precise sense the basin of **the union of all periodic cycles** equals X. This is stronger and more elementary than “nonzero measure.” If a probability measure on X is declared, the basin has measure one, but this alone is not a physically interesting genericity result. If X is not finite, if T is not a total deterministic map, or if the full history is not determined by its cut configuration, the conclusion does not automatically hold. A bounded degree or finite number of effective degrees per epoch does **not** establish that the global BCRD configuration set X is finite.

**COUNTEREXAMPLE A1 — nontrivial cycle without external attraction.** Take X={0,1,2,3} and T(0)=1,T(1)=0,T(2)=2,T(3)=3. C={0,1} is a nontrivial period-two cycle; its basin is precisely C. No open/transient configuration is attracted to C. There are competing fixed cycles {2},{3}. Even more simply a bijection/permutation T has C_per=X with **no transient relaxation**. Thus existence of a nontrivial recurrent core is *not* the claim that generic nonrecurrent configurations are drawn into it.

**COUNTEREXAMPLE A2 — perturbations can destroy the targeted basin.** Let T(0)=1,T(1)=0,T(2)=0,T(3)=2. C={0,1} attracts all four configurations. Allow an intervention U with U(0)=1,U(1)=0,U(2)=3,U(3)=2. Then configurations 2 and 3 remain forever in a distinct period-two orbit under U. The original C is not robust to arbitrary allowed changes. Generic stability cannot be deduced from finite eventual periodicity.

## B. Exact strengthened theorem for attraction to a **specified nontrivial** cycle

**ATTR-01.** Let X be finite; let T:X→X be total; and let C⊆X be a nonempty specified **single cycle** with period N>1 on which T acts cyclically. The following are equivalent:

1. Every x∈X enters C after finitely many T-updates.
2. There exists a rank function V:X→nonnegative integers with
   (a) V(x)=0 exactly on C; (b) T(C)=C; and
   (c) V(Tx)<V(x) for each x∉C.

**Proof 1⇒2:** Define V(x) as the least number of steps needed to enter C. It is finite by assumption; zero precisely on C. For x∉C, V(Tx)=V(x)−1. Cyclicity gives T(C)=C.

**Proof 2⇒1:** Outside C, the nonnegative integer V strictly decreases at each step, so cannot decrease indefinitely. It reaches zero after no more than V(x) steps, placing the orbit in C. Forward invariance keeps it there. QED.

**ROBUST-ATTR-01 — explicitly intervention-limited sufficient condition.** Let \(\mathscr T\) be a source-specified family of admitted relational updates on X, each satisfying S(C)⊆C and \(V(Sx)<V(x)\) for all x∉C with the **same** nonnegative integer V. Then every finite or infinite schedule of such allowed updates reaches C in at most V(x) updates, stays in C, and **cannot** escape into a different recurrent class. This gives robust **containment**, but **exactly the same period-N trace** within C requires separate agreement of all admissible updates on the cycle and its event annotations. Unrestricted interventions are not covered.

**Crucial hidden-assumption redline:** Writing T=σ∘F already *chooses* a terminal-to-initial identification σ. Proving an attractor of T does not derive σ from the frozen BCRD gluing axioms or demonstrate that the universe physically changes its topology toward cyclic closure. Iterated T-paths are a covering/unwrapping description of a chosen closed process; not proof of multiple physical cosmic births.

## C. Particular-persistence: why injectivity of σ is not sufficient

The proposed theorem defines a “particular” as a maximal directed event chain; this need not be a unique particular in a branching/merging relational history. Different maximal chains can overlap; a continuing particular may branch, lose records, incorporate new events, or have physically distinct identity semantics supplied elsewhere by original X3. A boundary event signature alone is not an independently validated subject-identification map.

**COUNTEREXAMPLE C1 — injection swaps marked particular seams.** Let open M have two distinct causally ordered, separately marked event strands

\[
a_{\rm in}\to a_{\rm mid}\to a_{\rm out},\qquad
b_{\rm in}\to b_{\rm mid}\to b_{\rm out},
\]

where the source identifies A and B as different particular-lineage annotations. Both boundary antichains have no internal order. The boundary bijection

\[
\sigma(a_{\rm out})=b_{\rm in},\qquad
\sigma(b_{\rm out})=a_{\rm in}
\]

is **injective**, **surjective**, and an order-isomorphism of the empty interface orders, but yields one joined length-six circuit rather than separately continuing marked A and B circuits. An injective seam preserves ports from colliding, not the declared **particular marking** or causal ancestry correspondence. Therefore it is not sufficient for the proposed specific lineages.

Even the identity boundary bijection is insufficient to prove physical or subjective continuation: a disconnected surrogate device can carry the same ledger while the actual source-causal process ends. See original X3 source-bridge requirements rather than re-inventing them here.

**Necessity is also unproved:** The claim that **every** event or signature on a named lineage must inject into new boundary records may be too strong if several record tokens represent one physical lineage or are gauge-equivalent. The required fidelity should be imposed on **source-justified distinct particular classes**, not on all syntactically distinct interface symbols.

## D. Positive finite combinatorial seam theorem

**MARKED-CYCLE-01.** Let an admissible finite open event network have an explicitly identified protected subnetwork that is a **disjoint union** of m finite directed paths \(\ell_j\), each with at least two directed edges, one designated input port and one designated output port. Assume:
- paths and ports are distinct after quotienting genuine source gauge redundancies;
- each path carries a source-verified lineage marking j, and different j are source-identified as different causal particular lineages;
- the closure gluing identifies exactly each output port to the input port **of the same j**, without extra identifications among protected vertices or edges;
- all edge/port incidence relations, causal event annotations and operationally meaningful intervention-response witnesses on those paths are preserved by the gluing; and
- the resulting closed process is admitted by the relevant BCRD cut composition and path/refinement rules.

Then the protected event subnetwork of the closed quotient consists of m **disjoint directed cycles**. Each protected event has exactly one incoming and outgoing marked continuation edge; no marked path is truncated, merged with a different marked path, or replaced by a disconnected labelled record by the **specified combinatorial construction**.

**Proof:** Each open protected path is already connected, with exactly one successive marked outgoing edge from its interior vertices and exactly one marked incoming edge to them. Its terminal and initial endpoints are identified one-to-one to each other; those become one seam vertex with one incoming and one outgoing marked edge. Since the quotient makes no cross-j identifications, no protected paths fuse. Each finite, connected directed path thus closes into a directed cycle, and the m cycles remain disjoint. Nontriviality follows from path length≥2. QED.

**Scope:** This is a sufficient **finite marked-incidence** result, not the claimed iff theorem for a general BCRD particular, original X3 historical identity, all histories or physical cosmology. An actual physical lineage must be independently source-identified, and the witness must agree with prior X3 semantics. A global strict partial order cannot coexist with directed cycles in its quotient; use local open-process causal ordering plus *separately validated* globally consistent cyclic process/intervention semantics.

## E. What is actually new and still needs demonstration

**Already developed; do not reopen casually:** source-level X3 continuing duties, candidate particular continuation, IR102's sector-semantic separation, BCRD channel witness vs sensor capture. They have explicit evidence and prior hostile-review history. This focused PR does not audit every theorem in the compiled UPT edition.

**Actual new circular-matterspacetime research joins:**
1. **Justified closed gluing σ:** derive whether the *frozen* BCRD cut/process category admits a cyclic trace/feedback closure operation satisfying its B5/B6 compositional/refinement constraints; do not assume a trace is freely available in every category.
2. **Intrinsic cyclic causal semantics:** prove globally consistent intervention-response predictions and their B3/B4 faithfulness on the quotient, without erroneously requiring the global directed event relation to remain a strict partial order.
3. **Nontrivial structural attractor:** exhibit a concrete, BCRD-derived configuration class, nontrivial target C, and single source-derived descending V (or an alternative justified invariant/convergence structure) across declared admissible updates; avoid treating a prechosen σ or finite deterministic toy as cosmic necessity.
4. **Causal lineage across the seam:** use the original X3 physical-source correspondence and show its lineages/rights actually extend across the *new* cyclic seam; a bare bijection of ports is not enough.

### Final claim ceiling

This document proves exact finite deterministic convergence to **some** periodic core, an if-and-only-if finite rank characterization for attraction to a **specified** cycle, a robustness sufficient condition under explicitly limited updates, and a marked-path combinatorial closed-lineage construction. It also gives precise counterexamples to the proposed sweeping attractor and injective-seam conclusions.

**It does NOT prove that the real universe is cyclic, that matterspacetime naturally converges to a closed topology, that original X3 is established physically, or that any cosmological event recurs.**

**Executable diagnostics:** check_bcrd_cyclic_attractor_lineage.py performs exhaustive checks over all 288 total maps on sets of sizes 1–4, plus independent attractor/perturbation/seam countercontrols.
