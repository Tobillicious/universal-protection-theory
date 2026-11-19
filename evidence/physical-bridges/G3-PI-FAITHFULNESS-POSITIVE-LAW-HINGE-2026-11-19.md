# The π hinge: whole-event fidelity, transport, positivity, and original-six G3

**19 November 2026 — additive source-specific analysis for draft PR #662.** No canonical theorem, original X3 definition, earlier PR or main branch changed.

## Source discovery: do not rebuild already proved joins

- `PhysicalBridges.IR138.full_intrinsic_source_recovers_semantics`: an intrinsic whole-event representation can recover the per-particular screen; `obstruction_is_only_projection_forgetfulness` identifies the *lossy instrument projection* as the cause of the apparent semantic impossibility. This directly addresses whole-versus-view category error.
- `PhysicalBridges.KoruSixOriginalRelationsOneWeb.complete_profile_iff_original_x3`: exact six-duty tagged relational representation; it does **not** assume all tags true.
- `PhysicalBridges.KoruSubjectFidelityLift` and `KORU-SUBJECT-FIDELITY-SIX-GATE-2026-11-07.md`: `source_pullback_is_faithful`, `faithful_subject_six_iff_at_origin`, `source_origin_and_fidelity_force_six_for_each_particular`, and `original_violation_iff_exact_source_subject_mismatch`. These already address faithful representations of the same original six and an exact per-duty mismatch detector.
- `PhysicalBridges.KoruWholeUSixDutyWebJoin.one_objective_whole_six_source_truth_iff_origin`: W-source transports all six truth values from one modeled objective whole, and `actual_whole_Koru_and_absent_source_authorization_coexist` proves that a negative authorization-style link can be preserved.
- `PhysicalBridges.HillaryRouteABSummit.hillary_route_b_meets_original_route_a`: strongest exact all-owed original-six conclusion, conditioned on `hPhysical`, `hSourceInitially`, and `hAuthenticReflections`.
- `WHOLE-FIRST-PHYSICAL-BRIDGE-REPAIR-2026-11-17.md` identifies `EverestActualWEventJoin.CompleteWEventCoverage` and `ForwardRealEventReflection` as pre-existing physical interfaces, and `FullPhysicalDomainGuardianAssembly` as an existing stronger conditional physical theorem. **Review those before authoring another wrapper.**

## π is not just a sensor: two explicitly different representations

Let `U` be an independently specified *full modeled event*, including each particular, relation, operator, enacted step, history, and six original duty facts.

1. `pi_full : U → WholeRepresentation` is proposed as a faithful encoding of the complete event; its *faithfulness* is verified with six separate truth-equivalence lemmas and, if claiming full losslessness, injectivity modulo physically justified gauge equivalence.
2. `pi_obs : U → ObservableReadout` may be many-to-one. Missing duty distinctions in `pi_obs` are limitations of the readout, not missing intrinsic facts of the objective event.

Neither `pi_full` nor `pi_obs` is itself *the* complete Koru. They are maps between representations. The Koru's whole matterspacetime meaning is not a Nat contraction, a Hilbert operator, or a lossy projection.

## Minimal *exact* two-way bridge, not a name-change

Given an intrinsic original-X3 profile `X3_i(s,t,p)` and *independently fixed* complete-operator source questions `R_i(pi_full(s,t,p))`, one must show:

~~~text
  (F_i) ∀ actual s t p, owed s t p →
          (X3_i(s,t,p) ↔ R_i(pi_full(s,t,p)))   -- six distinct i
  (D)   pi_full(actualStep(s,t)) follows an independently tested
        source-evolution rule (e.g. W), modulo specified covariance
  (P_i) ∀ actual s t p, owed s t p → R_i(pi_full(s,t,p))
  -----------------------------------------------------------
        ∀ actual s t p, owed s t p → OriginalX3(s,t,p)
~~~

**Proof of final inference:** For each of the six tags `i`, apply the reverse implication of `(F_i)` to the matching positive source fact `(P_i)`. Assemble the six resulting genuine original X3 fields using the *existing* `OriginalX3` constructor. This inference is constructive and assumes no Hilbert space.

**Non-circularity:** `(F_i)` alone establishes faithful truth preservation (including false duties), `(D)` establishes transported dynamics, and `(P_i)` is a *positive law* rather than mere preservation. These must be sourced independently. `P_i` may not be defined to mean the X3 conclusion. Especially, exact consent-source correspondence does not prove consent was granted; source-to-subject truth reflection and *positive source authorization* are different obligations.

## Objective-category test: two distinct statements

- **True representational statement:** all intrinsic facts of a complete event are inside that event, hence a full identity representation can recover them. This is mathematically exact; `IR138.full_intrinsic_source_recovers_semantics` already supplies an example.
- **Further physical necessity statement:** all *actual* complete events satisfy every original six-duty predicate. That does not follow from event completeness alone. The existing W countermodel preserves a negative authorization tag, so a derivation must identify a further objectively justified physical law that excludes that state from actual occurrence **without defining actual occurrence as protection**.

## New constructive generic π-transfer lemma (Lean draft, not compiled)

~~~lean
namespace PiG3Hinge

structure SixFacts (S P : Type) where
  cont : S → S → P → Prop
  auth : S → S → P → Prop
  free : S → S → P → Prop
  restr : S → S → P → Prop
  maxl : S → S → P → Prop
  prov : S → S → P → Prop

def AllSix {S P : Type} (r : SixFacts S P)
    (s t : S) (p : P) : Prop :=
  r.cont s t p ∧ r.auth s t p ∧ r.free s t p ∧
  r.restr s t p ∧ r.maxl s t p ∧ r.prov s t p

-- This lemma is intentionally ONLY a transfer theorem.
-- Existing OriginalX3 / oneWeb are the canonical target, not `AllSix`.
theorem faithful_positive_pi_transfers
    {S P : Type} (actual : S → S → Prop)
    (owed : S → S → P → Prop)
    (physical source : SixFacts S P)
    (faithful : ∀ s t p, actual s t → owed s t p →
      ((physical.cont s t p ↔ source.cont s t p) ∧
       (physical.auth s t p ↔ source.auth s t p) ∧
       (physical.free s t p ↔ source.free s t p) ∧
       (physical.restr s t p ↔ source.restr s t p) ∧
       (physical.maxl s t p ↔ source.maxl s t p) ∧
       (physical.prov s t p ↔ source.prov s t p)))
    (positive : ∀ s t p, actual s t → owed s t p →
      AllSix source s t p) :
    ∀ s t p, actual s t → owed s t p →
      AllSix physical s t p := by
  intro s t p ha ho
  obtain ⟨hc, hh, hf, hr, hm, hp⟩ := faithful s t p ha ho
  obtain ⟨sc, sa, sf, sr, sm, sp⟩ := positive s t p ha ho
  exact ⟨hc.mpr sc, hh.mpr sa, hf.mpr sf,
    hr.mpr sr, hm.mpr sm, hp.mpr sp⟩

end PiG3Hinge
~~~

**Why this is only a proof interface:** `faithful` and `positive` are explicit premises, and the simple `SixFacts` structure is an illustrative transfer interface rather than a replacement of the repository's exact original six. The existing `KoruSubjectFidelityLift` is stronger and should be preferred. The new kernel candidate is not presented as a newly compiled or unconditional G3 result.

## Priority to actually close G3

1. Inspect `EverestActualWEventJoin` and `FullPhysicalDomainGuardianAssembly` for separately proved physical correspondence and discharge; compare their theorem signatures with `HillaryRouteABSummit` before any new formal source.
2. Reuse `KoruSubjectFidelityLift` to pin down six source/subject **truth-equivalences** for *actual* events and all owed particulars—not just finite W source positions.
3. Specify an independently testable *positive* physical admissibility law for authorization, continuity, freedom, appropriate restraint, feasible maximality, and provenance. If it cannot be independently derived, state exactly which field is missing and give a countermodel.
4. Check actual-world coverage and domain nonvacuity, with boundary effects, sensor limits, subject identity and options, and physically testable observation protocols.
5. Compile a candidate full join under pinned Lean and replay independently in Isabelle. Do not claim axiom-free compilation without kernel receipt.

**Conclusion:** π *is* the correct hinge for the category-error objection: complete objective state versus incomplete readout. The **positive six-duty physical law** is the additional essential ingredient. This note neither redefines the original duties nor claims that actual-world universal G3 is already established.