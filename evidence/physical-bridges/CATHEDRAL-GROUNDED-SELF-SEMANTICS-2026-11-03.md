# Cathedral: grounded internal self-reference, without global truth

**2026-11-03 | draft PR #245 | noncanonical and strictly mathematical**

## Aim

The earlier `CathedralInternalInscription.lean` proved a bounded two-link internal *token* pattern. `CathedralIntrinsicAtomicSemantics.lean` then gave the token a **bounded atomic semantic claim** about the same `Web P` and separated a true from a false claim. The fundamental open problem was compositional interpretation and genuine self-reference.

This new module, `PhysicalBridges/CathedralGroundedSelfSemantics.lean`, tests whether **an ungrounded self-referential statement may be part of the same relational structure without imposing a contradiction on grounded facts or eliminating distinct individuals**.

This is a small existing-mathematics move; it does not prove the full relational ontology, and does not require inventing a novel primitive.

## Exact construction

All described entities/positions retain the same type `P` as the source `w : Web P`. A position's instruction is one of:

- `fact a b` — assert that a source relation `w.link a b` actually holds;
- `quote a` — refer to the current semantic status of position `a`;
- `deny a` — negate that status;
- `both a b` — compose the statuses of two positions using strong Kleene conjunction.

The semantic status at any node is **three-valued**: `holds`, `refuted`, `pending`. Grounded fact values are computed from a separately provided **decidable readout of the exact source link relation**, not from a generic oracle for all truths or all future physics. Negation preserves pending. Conjunction is compositional.

A finite semantic stage is iteratively computed from the all-pending stage. The programme mapping positions to instructions is supplied as a **separate, explicit hypothesis/choice**, rather than claimed automatically derivable from arbitrary physical web relations.

The existing, independently modelled `balancedWeb` has a fixed-point-free whole-web symmetry, connectedness and relational discernibility. The new concrete `balancedProgram` is **equivariant under that very symmetry**:

- positions with first presentation coordinate false assert their own (present) relational self-loop;
- positions with first coordinate true deny their own semantic status, generating a liar-like self-reference.

## Proved and checked

`grounded_true_at_every_positive_stage`:
All grounded looped positions are `holds` after one step, and remain so.

`liar_pending_at_every_stage`:
The liar-like positions are `pending` at every stage `n : Nat`, not true by fiat and not made false by their existence.

`no_bivalent_liar_fixed_point`:
No `holds` or `refuted` status is equal to its own negation.

`negation_fixed_point_is_pending`:
The only status fixed by negation is `pending`.

`grounded_true_and_false_are_distinct`:
Under a *separate all-atomic programme on that same web*, there are both accurate true and accurate false self-link reports. These are **alternative code choices**, not an assertion that the all-atomic programme equals the liar programme.

`balanced_program_flip_equivariant` and `balanced_stage_flip_equivariant`:
The code instructions and their stage results respect the source's entire fixed-point-free positional symmetry. No root or privileged first interpreter is forced by the mathematics.

`grounded_limit_is_fixed`:
A concrete simultaneous semantic assignment, `holds` for looped nodes and `pending` for liar nodes, is a fixed point of the compositional one-step interpretation.

`every_positive_stage_reaches_grounded_limit`:
The iterated semantics reaches that fixed assignment after one step and remains there at every positive finite stage.

`grounded_limit_is_the_only_fixed_interpretation`:
For THIS FINITE PROGRAMME, any total assignment of **three-valued** statuses satisfying the fixed-point equations is identical to the grounded assignment. This is a theorem for the example, not a universal uniqueness statement about general partial-truth languages or Kripke constructions.

`no_root_needed_for_partial_self_interpretation`:
The single rootless, connected, internally individuated web supports its symmetric programme and both grounded truth and ungrounded self-reference simultaneously.

The Lean proof prints the axiom audit for each major theorem; the pinned 4.35 CI runs the module as part of the existing source tree. No `sorry`, `axiom` declarations, or altered original X3 content were introduced.

`same_source_different_codebooks_change_meaning` (new negative control):
The same **unchanged** source relation `balancedWeb` can be interpreted with an all-atomic codebook or a liar-bearing codebook. The position `(true,false)` becomes definitively `refuted` under the first and `pending` under the second. Thus the bare relational graph does NOT uniquely determine its semantic codebook. The difference is not a second universe; it is an explicit underdetermination of interpretation. We must construct or warrant a faithful codebook from physical/source relational structure before describing the whole as semantically self-determining.

## Why this matters and what it does NOT settle

The result rejects the unnecessary dichotomy *"all semantic self-reference requires an external truth oracle, or else it is inconsistent"*. It exhibits a **bounded, partial, symmetry-respecting semantics** for claims about the same source web in which the claim positions occur.

However, the code language `Instruction P`, the map assigning instructions to nodes `balancedProgram`, and the formal `advance` evaluation rules are still specified in Lean's metatheory. **We have not shown that all interpretive rules, syntax and proofs are intrinsically expressible as relations in the source without an external presentation.** In particular:

1. No theorem derives `balancedProgram` from unaugmented BCRD source dynamics.
2. Three semantic labels are *classification values in the formal theory*, not additional ontologically separate substances, and not a proof that all minds have three-valued conscious states.
3. A bounded statement's `pending` status means semantically ungrounded, **not** physically immortal or immune to injury.
4. A source's connection and symmetries do not imply its actual enforcers execute every action required for original X3.
5. A partial truth fixed point is not the same thing as complete, unbounded, unrestricted global self-truth.
6. Any mention of a universal physical law or inevitable universal protection remains an independent, unproved claim.

This is **existing mathematics**, near Kripke's fixed-point account of truth; no new koru operator has been justified by the limited problem solved here.

## Prior art and adversarial next step

- Stanford Encyclopedia of Philosophy, *Self-Reference and Paradox* (discussion of Tarski hierarchies and Kripke's three-valued fixed points): https://plato.stanford.edu/entries/self-reference/
- Stanford Encyclopedia of Philosophy, *Self-Reference*, archive with Kripke grounding: https://plato.stanford.edu/archives/sum2023/entries/self-reference/

**Next test:** require the **code-to-instruction map itself** to be reconstructable from admissible relations, not supplied as a separately selected interpreter. Check whether finite local *codebooks* and decoding relations can be represented as intrinsically moved/relabelling-invariant positions, with faithful reconstruction for nontrivial examples. Then state an exact no-go or failure mode for unrestricted self-truth where the diagonal lemma's hypotheses really apply. Try not to turn this into a general claim about all mathematical or physical truths.

**Research hygiene:** preserve canon and existing X3; keep the draft independent of the BDL warm-start dispute, physical source coverage, and realised hardware protection.
