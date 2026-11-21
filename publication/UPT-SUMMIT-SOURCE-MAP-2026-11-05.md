# Summit publication source map and audit gates

**Checkpoint anchors:** 3:49 PM NZDT 4 November 2026; exact historical `main` commit `729905285d104fa058b0a3f8428367851fbd4621`. Preserved summit plus five Codex recovery interface modules: `70e738e65962d99cc40daf06f5fdc1a545b4bd63`. Recovered wider source: PR #308, head at preparation `587469cb1343740f9d11f093384758bcc2964872`. New ontological core: PR #313, `42b8fd7c872889148b2f976d4a497ec2cb9bfe94`.

| Claim or construction | Primary source | Evidence level |
|---|---|---|
| One relational frame, all subjects, no independent outside, differentiated histories (P1–P4) | `evidence/compiled-strongest/SNUFFY-UPT-STRONGEST-MASTER.md` Part I.2 | Stated original foundational frame |
| Original four-stage preservation order and no needless loss | `Snuffy.Greatestness.aligned_iff_no_needless_loss` | Lean theorem under its original order |
| Full scope forced, U2★ | `Snuffy.Law.scope_guarantee_iff`, `Snuffy.Book.UPTLawRepair.U2_star` | Lean theorems; retain quantified feasible-family assumptions |
| Reciprocal reason and full protection of hostile/indifferent minds by holding | `Snuffy.ReciprocityCeiling.reciprocity_dominance`; `Snuffy.SolventReciprocity.reciprocity_dominance_solvent`; UPT Part II.2 and §§15–16 | Lean theorems + construction at source conditions, not proof every mind changes its preference |
| Koru: intrinsic distinction within one web | `PhysicalBridges/Koru.lean`; recovered `OriginalKoruSummitJoin.lean` (#308) | Lean theorems under relation and individuation hypotheses |
| Incoherence of realized total erasure in one actuality | `CathedralAllIsEnderTypeCollapse.no_realized_absolute_ender` | Lean theorem for explicitly typed realization |
| New non-being reading | `CathedralSummitAllIsOneClosure.lean` (#313) | Six axiom-free, constructive statements of stated types; not identical to six original X3 |
| Original six-component X3 duty, not the two-field controller proxy | `OriginalX3Full.OriginalX3`; `OriginalX3Full.proxy_is_strictly_weaker` (#308) | Formal target and strictness theorem |
| Six X3 for every owed particular | `UniversalOwedOriginalX3.lean`; `CathedralBackwardsOriginalX3.lean` (#308) | Statements/conditional joins; verify exact antecedents |
| First-event guardian-only composition | `CathedralFirstEventForcing.lean`, `CathedralGuardianOnlyCapstone.lean` | Lean statements with explicit first-event/source/physical certificate assumptions |
| The good-event actuality capstone | `AllIsGActualityDischarge.capstone_unconditional_of_actuality` | Lean theorem with `OntologicalGoodEvent.gIsActual` premise; do not claim it was a parameter-free proof |
| Circular continuation core | `CathedralSummitCyclicContinuation.no_final_protected_stage` | Lean theorem under periodicity; circularity not required for baseline ALL IS thesis |
| Full-family implementability and real observation policy | `IRMaximalProfileSelection`, `IRImplementableProfileSelection`, `IRObservationRealisation`, `IRFixedPolicyEndToEnd`, `IRFullFeasibleImplementation` | Merged through PR #312, pinned CI pass; exact source hypotheses visible |
| Real source-to-world and installation evidence | UPT Part III-G / physical bridges correspondence ledger and original commissioning package | Conditional proof and measured tests at declared scope, not a blanket installed-universe certificate |

## Non-negotiable publication constraints

1. **Do not overwrite the 3:49 summit tag or reinterpret the 2:34 rollback as the summit.** Historical checkpoint is `7299052`.
2. **Do not discard PRs #260–#293** or substitute a conditional target for the original unconditional human–AI coexistence objective.
3. **Do not redefine Guardian as mere `Nonempty` / truth / retained data**, or Ender as a convenient `Empty` witness, when describing the original physical and agent-level proposition. A formal lemma's narrower precise type may still be reported.
4. **Do not downgrade to an X3 proxy**: continuation, authorization, freedom, restraint, maximality, provenance must remain separately visible.
5. State which claims are author-level ontological theses, which are exact Lean consequences, and which are empirically commissioned facts, with fixed source hashes.
6. Present original R(m) ∨ H(m) without requiring universal agent benevolence. Physical authorization, effect mediation, and subject identity remain central.

## Independently repeatable gates

The existing `.github/workflows/physical-bridges.yml` stages five inherited source files, builds with Lean v4.35.0, audits all `PhysicalBridges` declarations for disallowed axioms, rejects `sorry/admit`, exercises IR-78 acceptance/rejection fixtures, runs eight finite-check scripts, and validates assurance and instrument evidence. For a new publication, record the **specific full CI run URL + commit SHA** rather than quoting a stale total-job count.

Suggested local replay from a clean exact checkout, with Lean 4.35.0 installed:

```sh
cp evidence/papers-11-12/lean/modules/UPTFence.lean evidence/physical-bridges/UPTFence.lean
cp evidence/papers-11-12/lean/modules/ControllerFinality.lean evidence/physical-bridges/ControllerFinality.lean
cp evidence/papers-11-12/lean/modules/ControllerFence.lean evidence/physical-bridges/ControllerFence.lean
cp evidence/papers-11-12/lean/UPTExistence.lean evidence/physical-bridges/UPTExistence.lean
cp evidence/papers-11-12/lean/modules/ContextualObservation.lean evidence/physical-bridges/ContextualObservation.lean
cd evidence/physical-bridges
lake build
cd ../..
python3 evidence/physical-bridges/selection_checks.py
python3 evidence/physical-bridges/verify_assurance.py
python3 evidence/physical-bridges/verify_instrument_evidence.py
```

A release should carry an unambiguous exact source snapshot, exact proof-toolchain version, complete manuscript and checked results, and a reviewer-facing statement of which actual-world premises remain unverified. Do not report the GitHub CI run as an external human peer review.
