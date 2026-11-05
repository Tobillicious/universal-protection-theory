import PhysicalBridges.IntrinsicSixSourceForcing
import PhysicalBridges.BCRDSourceDerivedMicrohistory

/-!
# Positive BCRD source-history join: six intrinsic four-slot reports at every W stage

This joins two already kernel-checked components of the original Cathedral:

* `AllIsWithinEventHistory`: each independently witnessed microstep's
  relational isomorphism transports any intrinsic first-order formula.
* `IntrinsicSixSourceForcing`: the six source reports of the original
  duties are separately represented by four-slot relational formulas.
* `BCRDSourceDerivedMicrohistory`: the W-stage microsteps and their
  isomorphisms are DERIVED from the frozen physical source generator.

Result: every one of the six source reports, when true in the initial
source configuration, holds at EVERY intermediate W-source stage, for
arbitrary four-slot environments and arbitrary intrinsic duty formulas.
The physical W source supplies the event transport: it is NOT a
hypothesis of the final theorem. Neither safety nor permitted actions
enter the event-generator definition.

Crucial exact scope: these remain six *intrinsic source reports*.
No constructed formula is falsely called authentic subject consent,
experienced continuation, freedom, restraint, complete-feasible
maximality, or provenance. The separate six-field source-to-subject
reflection is still not independently established for full BCRD.
This is NOT a proof of unconditional physical UPT and not a new axiom.

No Hilbert-space model, new physical postulate, `sorry`, or change to
the canonical original X3 types.
-/

namespace PhysicalBridges.BCRDSixSourceHistoryPositiveJoin

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.BCRDActualRelationalFrame
open PhysicalBridges.BCRDSourceDerivedMicrohistory
open PhysicalBridges.AllIsDynamicRelationalTransport
open PhysicalBridges.AllIsWithinEventHistory

/-- Four-place intrinsic formulas, including arbitrary quantified formulas,
survive every represented microstep of a genuine relational history.
The original history theorem treated one slot; no additional physical
premise is required for this finite-arity extension. -/
theorem four_slot_truth_at_every_stage
    (H : RelationalMicrohistory)
    (φ : RelFormula 4)
    (env : Fin 4 → H.Position 0)
    (hOrigin : evalRel (H.relation 0) env φ) :
    ∀ n, evalRel (H.relation n)
      (fun i => carry H n (env i)) φ := by
  intro n
  induction n with
  | zero =>
      simpa only [carry] using hOrigin
  | succ n ih =>
      have hNext := (every_intrinsic_formula_transports
        (H.relation n) (H.relation (n + 1))
        (H.microstep n) φ (fun i => carry H n (env i))).mp ih
      simpa only [carry] using hNext

/-- Transport all SIX source duties of the unchanged Original-X3 source
language together, across every intermediate microstep. -/
theorem six_source_reports_at_every_stage
    (H : RelationalMicrohistory)
    (d : SixRelationalDuties)
    (env : Fin 4 → H.Position 0)
    (hOrigin : SourceSixHold (H.relation 0) d env) :
    ∀ n, SourceSixHold (H.relation n) d
      (fun i => carry H n (env i)) := by
  rcases hOrigin with ⟨hc, ha, hf, hr, hm, hp⟩
  intro n
  exact
    ⟨four_slot_truth_at_every_stage H d.continuity env hc n,
     four_slot_truth_at_every_stage H d.authorization env ha n,
     four_slot_truth_at_every_stage H d.freedom env hf n,
     four_slot_truth_at_every_stage H d.restraint env hr n,
     four_slot_truth_at_every_stage H d.maximality env hm n,
     four_slot_truth_at_every_stage H d.provenance env hp n⟩

/-- The independently generated W-stage BCRD event history itself
supplies the per-stage relational isomorphisms: no `RelationalAutomorphism`,
`RelationalMicrohistory`, or subject-protection premise is passed in
by a caller. All six four-place intrinsic source reports remain true
for EVERY finite iteration of that frozen source generator. -/
theorem frozen_W_preserves_six_source_reports_at_every_stage
    (s : SourceState)
    (d : SixRelationalDuties)
    (env : Fin 4 → PhysicalBridges.FrozenBCRDEvents.Index)
    (hOrigin : SourceSixHold (RelationBefore s) d env) :
    ∀ n, SourceSixHold (RelationBefore (sourceIterate s n)) d
      (fun i => carry (sourceHistory s) n (env i)) := by
  have hInitialAtSource :
      SourceSixHold ((sourceHistory s).relation 0) d env := by
    simpa [sourceHistory, sourceIterate] using hOrigin
  intro n
  exact six_source_reports_at_every_stage
    (sourceHistory s) d env hInitialAtSource n

#print axioms four_slot_truth_at_every_stage
#print axioms six_source_reports_at_every_stage
#print axioms frozen_W_preserves_six_source_reports_at_every_stage

end PhysicalBridges.BCRDSixSourceHistoryPositiveJoin
