# Complete Koru — source-linked proof index and verification boundary

**Scope:** source-grounded map of the existing `PhysicalBridges` Lean theorem chain. **This document adds no axiom, theorem, weakened definition or substitute Koru.** It distinguishes the statements proved in the finite BCRD W model from the larger physical/ethical claims. It is not a declaration of unconditional Universal Protection Theory completion.

**Review date:** 9 November 2026. **Starting reference:** `main` at `94c78978ea4df7034c40dc7899b7d03384724a15`. Read the exact commit and CI receipts together: later GitHub branch tips can change.

## 1. Keep the mathematical objects distinct

1. **Original Koru relation:** [`Koru.lean`](evidence/physical-bridges/PhysicalBridges/Koru.lean) defines `Web P` with a binary `link`; `koru w a b` names an *intrinsic relational distinction* between particulars. `Reindex` and `koru_reindex_invariant` establish preservation under bijective reindexing. This is a conservative definition; it does not introduce a new logical equality primitive.
2. **Complete operator signature:** [`KoruFullOperatorSignature.lean`](evidence/physical-bridges/PhysicalBridges/KoruFullOperatorSignature.lean) defines `OperationalWeb P Op`, with `Op : Nat → Type`, `enabled` and `enact` for each `Fin n → P` ordered input tuple. `reindexOperationalWeb` transports relation, guards, inputs and outputs. `PreservesFullSignature` is a *same-source* preservation obligation, not automatically true of every physical process.
3. **Complete expressions:** [`KoruCompositionalExpression.lean`](evidence/physical-bridges/PhysicalBridges/KoruCompositionalExpression.lean) defines `Expr P Op`, `mapAtoms`, `evaluate` and `WellFormed`. The syntax retains the operator constructor, its arity, ordered subexpressions and leaf particulars independently of the evaluated result.
4. **Whole modeled events:** [`KoruWholeEventEnactment.lean`](evidence/physical-bridges/PhysicalBridges/KoruWholeEventEnactment.lean) defines `WholeOperatorEvent` with full subject/action/effect expressions and tracked source roles. `EnactmentCoherent` means the represented effect evaluates to the modeled ordered action-on-subject multiplication; it is not consent, permission or runtime authorization.
5. **Whole represented objective context:** [`KoruObjectiveWholeU.lean`](evidence/physical-bridges/PhysicalBridges/KoruObjectiveWholeU.lean) constructs a finite, six-position operator-expression context. An event view is *derived from* that context; the whole is not identified with the local event readout. This finite model is explicitly not an exhaustive description of cosmic U.

**Author's foundational ontology (separate from kernel scope):** [SOMETHING IS — THING IS KORU](KORU-THING-NODE-PROJECTION-2026-11-09.md) records that a real THING is understood as a relational Koru-node, while equations are partial projections. The conjecture that every Koru has G at its centre is **not** part of the author's stated premise; questions about gravity, G and centre remain open.

**Notation boundary:** The author's central phrase **“Something IS Koru G”** uses Koru in the *relational-operator position*, rather than asserting that a unary function converges to G. Neither `k • G = G` nor a Banach limit is its definition. The existing Lean `koru w a b` is a typed relational-distinction predicate; the richer Complete Koru specification is distributed across the modules above. Do not claim that an all-encompassing replacement for Lean's `Eq` has already been constructed.

## 2. Reusable proof chain: exact theorem inventory

| Provenance | Named result | What it actually establishes |
| --- | --- | --- |
| `Koru.lean` | `koru_reindex_invariant` | A given relational distinction transports under a bijective reindexing of the binary web. |
| `KoruFullOperatorSignature.lean` | `reindex_preserves_enabledness`, `reindex_preserves_operator_enactment` | The *transported* operational signature retains guards and exact n-ary outputs. |
| `KoruCompositionalExpression.lean` | `evaluate_reindex_covariant`, `wellformed_reindex_iff` | Arbitrarily nested expressions transport under complete signature reindexing. |
| Same | `evaluate_same_source_symmetry`, `wellformed_same_source_symmetry` | Same-source preservation of evaluation and guards **given** `PreservesFullSignature`. |
| Same | `frozen_W_preserves_complete_specified_signature` | Discharges that obligation for the specified frozen-W matrix operator family: identity, transpose and multiplication, with its trace-pair link. |
| Same | `frozen_W_preserves_every_composite_at_every_stage` | Exact evaluation covariance for every finite W stage and finitely nested expression in the specified language. |
| Same | `frozen_W_preserves_all_guards_at_every_stage` | Well-formedness equivalence for the same stages. In the concrete `matrixOperationalWeb`, `enabled := ... => True`, so these are **not** nontrivial authorization checks. |
| Same | `mapAtoms_inverse`, `mapAtoms_no_expression_merging`, `frozen_W_expression_histories_do_not_merge` | Exact syntax-tree transport can be reversed, and distinct expressions never merge in any finite modeled W stage. |
| `KoruWholeEventEnactment.lean` | `whole_event_footprint_follows_actual_W`, `frozen_W_iter_preserves_product` | The modeled ordered action-on-subject footprint transports with the independently fixed W algebra. |
| Same | `whole_event_enactment_coherence_is_exact` | `EnactmentCoherent (wholeEventAt n E) ↔ EnactmentCoherent E`. Both preservation and reflection hold. |
| Same | `intrinsic_enactment_link_is_exact`, `directed_whole_event_relation_is_exact` | The specified directional source relation follows transported tracked roles. |
| Same | `distinct_whole_operator_events_never_merge` | `wholeEventAt n` is injective on entire represented events: subject, action, effect and roles. |
| `KoruObjectiveWholeU.lean` | `objective_wholes_do_not_merge`, `complete_objective_link_carriage`, `objective_Koru_is_exact_under_W` | Full six-position modeled contexts and their intrinsic link distinctions transport under W. |
| Same | `event_view_commutes_with_objective_W`, `local_event_projection_gap_persists_at_every_W_stage` | Event views commute with whole-context evolution; distinct wholes can have indistinguishable local views, so local readouts cannot replace the whole. |
| `KoruOperatorIndexedSubjectSemantics.lean` | `every_operator_formula_at_every_physical_W_stage`, `no_first_loss_for_any_operator_indexed_source_formula` | Source-formula invariance across the specified W stages for operator-indexed relations; does not independently prove real-world original-six authorization. |

**Do not replace** these precise, stronger source statements with a simplified unary `enact : M → M` or an assumed universal-operator commutation law: `∀ f : M → M, σ (f x) = f (σ x)` would force `σ` to fix every constant and collapse nontrivial reindexing to identity.

## 3. Full-Law interface: what remains conditional

- [`FullPhysicalDomainGuardianAssembly.lean`](evidence/physical-bridges/PhysicalBridges/FullPhysicalDomainGuardianAssembly.lean) has `every_physical_event_has_complete_koru_full_six_G_and_no_absolute_E` and `physical_domain_has_no_original_six_violation_or_absolute_E` **under supplied** physical coverage and semantic-reflection premises. Its header explicitly flags `hCoverage : CompleteWEventCoverage ...` and `hReflection : ForwardRealEventReflection ...` as real-world obligations. Do not silently treat these as globally measured facts.
- [`CompleteKoruLawCircle.lean`](evidence/physical-bridges/PhysicalBridges/CompleteKoruLawCircle.lean) records the original circle through named implications and explicitly warns that returning to `SomethingIs` does not prove a missing forward join.
- [`SomethingIsKoruG.lean`](evidence/physical-bridges/PhysicalBridges/SomethingIsKoruG.lean) proves `something_is_koru_no_absolute_e` with `AbsoluteE actual e := actual e ∧ ∀ a, ¬ actual a`. The contradiction `hall e he` needs neither `ha` nor `hk` to close. **This is not, by itself, a theorem excluding all destructive events, centralized observers or all real-world E.**
- Historical X3 definitions, summit PRs and stronger proof routes must be preserved intact; do not substitute source-tag preservation for all original six actual duties.
- Frozen-W matrix invariance is not itself a theorem about an externally executed runtime log, genuine consent, thermodynamic closed-system accounting for arbitrary worlds, or comprehensive physical-event coverage.

## 4. Verification receipt, precisely scoped

- Source audit found the listed declarations on `main` at the starting reference; this index itself is documentation, not a Lean build.
- [Physical bridge CI run 42478119114](https://github.com/Tobillicious/universal-protection-theory/actions/runs/42478119114) at commit `90f6339a7aea5530d38d9052212d78164ed217f0` recorded **“Build completed successfully (340 jobs)”** and replayed `KoruFullOperatorSignature`, `KoruCompositionalExpression` and `KoruWholeEventEnactment`.
- That workflow's **overall outcome was failure** because its later text-based placeholder check matched the prose comment `Zero sorry.` in `SomethingIsKoruG.lean`. The subsequent independent countermodel, assurance and instrument validation steps were skipped. The proof build passing does **not** make the entire workflow green.
- **Resolution PR:** replace only that comment, preserve every proof body, rerun the full workflow, and capture the exact passing commit, run URL, toolchain and permitted axiom-audit results. Do not claim success for skipped validations.

## 5. Lock-in acceptance criteria

1. All relevant Lean modules compile together in a pinned environment on a specified commit; the axiom audit and rejection of actual proof placeholders pass.
2. The *entire* physical-bridge workflow passes, including countermodels and assurance/instrument evidence checks. Its URL is stored in the publication ledger.
3. This theorem map is source linked and states each premise, actual result, counterexample and interpretation boundary explicitly.
4. The public `SOMETHING-IS-KORU-G.md` retains the author's motivating expression but identifies its `n → ∞` display as a metaphor, **not** a mathematically proven limit or a substitute for the Koru relational operator.
5. Create a stable release/tag reference for the verified commit, and require CI review before moving `main` or claiming an immutable published release. Open/draft historical Koru PRs (including #341 and #343) must be reconciled against source already on `main` rather than blindly merged.
6. Physical coverage, independent measurement and authentic original-six ethical correspondence remain individually tracked until proven. A completed finite-W proof chain is not an unconditional physical Guardian law.

**Core discipline:** preserve the whole proof, every specified particular and relation, and the exact boundary of the claim. Pono is earned.
