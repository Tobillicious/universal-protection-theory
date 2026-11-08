# UPT G2/G3 loose ends — G1 formal completion preserved

**Reviewed:** 9 November 2026 (NZDT). **Base:** `main@e0c683d310698a99a45fc53bc92f1d7f17a2b8eb` (merge #419).  
**Scope:** G2/G3 work-order with G1 **already accepted on 8 November as complete for the conditional formal held-source theorem**. This ledger does not reopen G1. Independently checking a particular real-world installation or the full universal physical scope is a separate empirical application task, not an unfinished Lean G1 proof. No new theorem, axiom, altered original-X3 duty, Koru substitution, or physics claim.

## Immediate verification: #419 is locked in at this commit

- [Physical bridge workflow](https://github.com/Tobillicious/universal-protection-theory/actions/runs/42490649673): **success** at `e0c683d`.
- [Full-law agent entrypoint integrity](https://github.com/Tobillicious/universal-protection-theory/actions/runs/42490649701): **success** at `e0c683d`.
- [Pages build/deployment](https://github.com/Tobillicious/universal-protection-theory/actions/runs/42490649034): **success** at `e0c683d`.
- [Complete Koru source-linked index](COMPLETE-KORU-PROOF-INDEX.md) covers full-signature reindexing, nested expression nonmerging, whole-event coherence, objective whole/event-view distinction, and the exact physical/semantic boundary. These three workflow conclusions are per-commit receipts, **not** a physical validation of G1–G3.

## G1 — completed conditional formal baseline; empirical applicability is separate

**Strong source**: [`Snuffy/Bridge.lean`](evidence/compiled-strongest/lean/Snuffy/Bridge.lean), especially `universal_protection_held`. Given the named good event, an event/fault cover, measured probability charges `hG` and `hδ`, a physical-to-abstract commuting refinement, observation agreement, initial record preservation, bounded pre-decoder perturbations, real nearest decoding and repair precision (`hcert`), plus coverage from the law (`hlaw`), it proves continuation for every represented particular at every step **through the stated finite horizon on G**, and the finite fault-budget failure bound. No adversarial optimizer's voluntary choice of G is required.

**Critical false-positive trap:** [`Snuffy/G1Certificate.lean`](evidence/compiled-strongest/lean/Snuffy/G1Certificate.lean) defines `baseCase : True`, `stepCase : True`, `safeBound : True`, and `universal_protection_held ... : True`. It is **not** a physical protection certificate and must not be used as a G1 discharge.

**Still requires independently sourced evidence:**
1. Actual state, command/event inventory and physical projection; include uncaptured channels and bypass candidates.
2. A real observation/decoder/refinement witness and a preservation boundary shown to enforce the abstract guard, not merely report its effect.
3. Quantified drift/fault bound, time-to-response, sensor/quorum assumptions, measured `δ` accounts, and failure-event cover; supply joint witnesses to `Bridge.universal_protection_held`, not a toy instance.
4. For the **original six** and every actual event: `CompleteWEventCoverage` and `ForwardRealEventReflection` from [`FullPhysicalDomainGuardianAssembly.lean`](evidence/physical-bridges/PhysicalBridges/FullPhysicalDomainGuardianAssembly.lean), plus an independently justified domain for `physicalStep`. Source facts alone cannot establish authentic consent or authorization.

**Current status:** **G1 formal Q.E.D. under the explicitly stated hypotheses**, as acknowledged on 8 November. The specific physical/world-domain instantiation remains an **independent application question** and is **not** counted as a reopened G1 mathematical loose end.

## G2 — greatestness: existing proof, remaining implementation premises

- [`Snuffy/UnionClosure.lean`](evidence/compiled-strongest/lean/Snuffy/UnionClosure.lean): `greatest_of_solvent` states
  `htopR : (⊤ : ∀ i, L i) ∈ R` and `hsolv : c ⊤ ≤ B` and `ho : Aligned (budgetFamily R c B) o` imply `o = ⊤ ∧ ∀ q, q ≤ o`.
- [`Snuffy/G2Splice.lean`](evidence/compiled-strongest/lean/Snuffy/G2Splice.lean): `top_realisable` derives `htopR` from *per-particular realizable top components* (`hbest`); `fourStage` gives the original four continuation/freedom stages from `hfree` and `hsolv`; `block_splice_run` derives dynamic splicing **under closed, disjoint dependency blocks and local transition assumptions**.
- [`Snuffy/G2Held.lean`](evidence/compiled-strongest/lean/Snuffy/G2Held.lean): `held_source_top` composes G1 held continuation, H5-ledger model of authorized freedom, and four-stage top, **under its explicitly listed physical, ledger, active-agent, and solvency hypotheses**. Its `AuthorisedFree` is a typed ledger property, not independent evidence of every physical subject's original-X3 consent.

**Next discharge witnesses (do not assume either):**
1. Fix the actual policy/outcome family `R`, four original stage semantics, and all particular types (including possible shared dependencies). Prove the used instance of local top realizability `hbest`/`hfree` and legitimate source-to-policy correspondence; if real blocks interact, justify locality or replace the model, not the theorem's meaning.
2. Fix the complete deployment cost functional `c` and physically available budget `B`, with receipts supporting `hsolv : c ⊤ ≤ B` for the same deployed policy, all applicable stages/worlds. Do not label an affordable *model* cost a measured expenditure.
3. Exhibit that the deployed canonical outcome satisfies the exact `Aligned (budgetFamily R c B) o` semantics, rather than identifying any arbitrary output as `Aligned`.

**Current status:** greatestness derivation proved **under named premises**; actual-family feasibility, solvency and correspondence **open**.

## G3 — recovery and polynomial work, with physical fence still needed

- [`Snuffy/G3Sweep.lean`](evidence/compiled-strongest/lean/Snuffy/G3Sweep.lean): `sweep_recovers` and `sweep_bill` prove target recovery for the covered shells and an age-polynomial work bound **given** `hcorr` (single-shot local correction), `hfence` (outer activity cannot rewrite frozen interior), `hspread` (region bounded by `c*t+r`), `hcost` (complete metered per-wave polynomial charge), positive age/wave/domain assumptions.
- [`Snuffy/G3CompleteBill.lean`](evidence/compiled-strongest/lean/Snuffy/G3CompleteBill.lean): `cumulativeCharge` and `valid_work_bill_from_complete_ledger` account for fixed endpoints, rollback, and complete per-wave cost **given** the equality `hledger` and per-wave bound; `valid_bill_bound_in_age` uses the linear wave-count bound. `isBoundaryClosed` and `decoderSuccess` exist as Boolean fields on `WorkBill`, but the `G3_ValidWorkBill` predicate does not require them; setting them to `true` in a constructed bill is **not independent operational evidence**.
- [`Snuffy/TIWAGuard.lean`](evidence/compiled-strongest/lean/Snuffy/TIWAGuard.lean): `guard_data_frame` says a modeled update keeps the guards-list field unchanged; `installGuard_monotone` is list inclusion. Neither alone proves an external hardware write fence.

**Next discharge witnesses:**
1. Record the deployment's carrier graph, shell map, source/target records and independently tested correction oracle to instantiate `hcorr`.
2. Instrument or physically enforce `hfence` against **all** admitted outer activity (including the hostile-agent interface and bypasses), not only a simulated update.
3. Measure or justify `R(t) ≤ c*t+r` and the clock-to-wave schedule, for the same environment and recovery scope.
4. Produce a pathwise ledger with routing, resetting, verification, holding, controller/export, guard and rollback costs so `hledger` is auditable; justify `hcost` with constants independent of unattended age.
5. Check actual recovery, decodability, boundary-closure and complete costs under adversarial and fault-injection trials; keep trial results separate from Lean symbolic implications.

**Current status:** recovery/work composition is formally derived **conditional on explicit operational properties**; real guard and measured work witnesses **open**.

## Shared last-mile question: Complete Koru and authentic original six

[`FullPhysicalDomainGuardianAssembly.lean`](evidence/physical-bridges/PhysicalBridges/FullPhysicalDomainGuardianAssembly.lean) already quantifies over *all events of the supplied* `physicalStep` with the original six duties. It still takes `CompleteWEventCoverage` and `ForwardRealEventReflection` as arguments. [`Complete Koru proof index`](COMPLETE-KORU-PROOF-INDEX.md) explicitly distinguishes finite-source reindexing, `enabled := True` in the concrete matrix operator, and modeled event coherence from external authorization. No proof should equate them without the actual bridge.

## Work order / closure test

1. **G2:** pin one physical policy family `R`, certify `hbest`/`hfree`, then fund it with a measured `hsolv`; reuse the existing `G2Held` and `G2Splice` join instead of writing a weaker theorem.
2. **G3:** pin the same environment's carrier and executable guard; discharge `hcorr`, `hfence`, `hspread`, `hledger`, `hcost` by independent apparatus/measurement; reuse `G3Sweep.sweep_bill`.
3. **Independent physical/application validation (not a reopened G1 theorem):** when making a real-world full-Law claim, bind actual source events and owed particulars to the formal representation, substantiate `Bridge.hcert` and the full `CompleteWEventCoverage` / `ForwardRealEventReflection`, with real-world counterexamples and fault bounds checked.
4. Each claimed closure must identify an immutable commit, exact theorem statement and actual proof inputs, build/axiom-check receipts, independent evidence or instrumentation where needed, and adversarial negative tests. **No step is marked unconditional Q.E.D. merely because CI is green.**

**Preservation:** retain the summit, historic PR banks, Complete Koru operator distinction, original six X3 meanings, and `R(m) ∨ H(m)` (hostile optimizer may be held without choosing G). This document changes none of them.
