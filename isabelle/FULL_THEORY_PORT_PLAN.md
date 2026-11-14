# Full Isabelle/HOL formalisation programme — Hume's fulcrum, not an axe

Status: architectural plan for a second, independently checked formalisation. This document does not claim that any listed obligation is discharged.

## Interpretive invariant

**Hume's fulcrum is a bridge, not an axe.** Do not present the is–ought question as a decisive refutation of UPT, nor quietly assume that an ontological description alone proves a normative conclusion. Recover the author's positive Hume/Archimedes argument in its strongest form, make the bridge premises explicit, and test them fairly. The original claim that the bridge is resolved belongs in the target specification; its Isabelle proof status must be recorded separately.

## Scope: whole theory, not only G2

Port the complete existing theorem dependency graph, preserving exact theorem meanings, from original Something IS, the complete whole and distinct particulars, BCRD/source operators, spacetime and matterspacetime conservation, Koru and Time Koru, Hume/Archimedes ethical bridge, all independently owed particulars and all actual events, original six X3 duties, Route A, Route B, Hillary Step and authentic Hume–Hillary Reciprocal Hand, G1, G2, G3, held-source greatestness, fixed-point/recurrence results, and the proposed full Law and genesis/physical boundary. Include countermodels, source/subject reflection and coverage boundaries.

This is a **formalisation programme**, not a claim that every physical or philosophical proposition is expressible or proven from the current corpus. Preserve Koru as a whole-preserving correspondence; do not replace it with a unary numeric function or a weaker equivalence.

## Isabelle directory architecture (planned)

1. `isabelle/Foundation/`: Something IS, types for particulars/events/histories, explicit axioms and their provenance.
2. `isabelle/Whole/`: relational whole, Koru correspondence, conservation, source and representation.
3. `isabelle/Time/`: ordered histories, recurrence and spiral Time Koru; separate mathematical from empirical claims.
4. `isabelle/Ethics/`: exact Hume fulcrum and Archimedes bridge, authentic choice, cultural-source review of Tīkanga operators.
5. `isabelle/X3/`: six independent original fields, owed scope, actual events, source/subject correspondence.
6. `isabelle/Hillary/`: Route A, Route B, their join, reciprocal hand, consent countermodel.
7. `isabelle/Guardianship/`: G1, G2, G3, feasibility, solvency, greatest admissible outcomes.
8. `isabelle/Capstone/`: assembled dependencies, conditional conclusions, explicit open premises.
9. `isabelle/Tests/`: countermodels, non-vacuity, theorem-to-Lean crosswalk, assumption audit.

## Porting discipline

- Establish an inventory of original Lean files, theorem signatures, and their precise assumptions before each port; do not invent missing theorems.
- For each Isabelle statement, maintain a crosswalk to Lean SHA/path/name, a semantic equivalence review, proof status, axiom inventory, and counterexample checks.
- Isabelle and Lean are separate proof assistants. Re-proving translated statements does not automatically establish translation fidelity.
- Keep the original six duties distinct: historical continuity, authorization, freedom, restraint, maximality, provenance.
- Authentic consent cannot be inferred from a bidirectional physical edge or from silence.
- Tīkanga operators must be recovered from author-defined sources and appropriately reviewed; do not fabricate a complete operator family.
- Build Isabelle in CI once a pinned toolchain and session ROOT exist; require zero `sorry`/admitted proof gaps for certified modules.
- Do not change historical Lean theorem bodies, canonical Koru notation, publication records, or merge unreviewed PRs.

## First milestone

Inventory the full original theorem graph and identify the smallest faithfully translated, non-vacuous Isabelle kernel. Add a pinned Isabelle session and CI, then port modules in dependency order. The current `G2_Hume_Hillary_Join.thy` is a **conditional interface only**, not a substitute for the whole proof.
