import PhysicalBridges.RouteBOriginalSixFirstViolation
import PhysicalBridges.IntrinsicSixSourceForcing
import PhysicalBridges.AllIsDynamicRelationalTransport
import PhysicalBridges.IR96DisturbanceSimulation

/-!
# Route B's six-source first-loss obstruction, DERIVED from the full frozen-W whole U

6 November 2026 · noncanonical additive stone stacked on #353.
Frozen historical summit, full six original X3, routes A/B, and main untouched.

The existing physically independent frozen W source evolves the ENTIRE
six-position operator-expression U and calculates its intrinsic web.
The old bank KoruObjectiveWholeU.complete_objective_link_carriage
already proves covariance of that *actual operator-derived web*,
not a web relabelled by assumption. Combined with the genuinely
strong first-order logic transport theorem (negation/quantifiers
included), this yields an explicit all-six first-source-loss
impossibility across every physical step refining #352.

The six source-duty FORMULAS are separately chosen in the language
of the full source relation, NOT named primitive guardian/X3 atoms.
Their content and the independent subject-semantic interpretation
are NOT supplied here. This is a rigorous positive candidate for
Route B's physical-structure half, not yet the full original X3.

We then connect to #353's exact original six-X3/three-group target
using separately stated NEGATIVE reflection obligations: a failure
in an original identity, agency, or stewardship group must be
detectable as an after-step failure of this actual intrinsic
source report. An independently established before-step report
is also required. These premises are not proved from actual
consciousness, gravity, or ALL IS by this file. They are not
hidden in the definition of a permitted physical step.

A fully sourced first-order source formula cannot lose truth across
the actual whole-W step, without invoking a guardian action,
X3 premise, artificial no-first-loss axiom or a vacuous freeze.
The exact semantic bridge to the original six remains testable.
-/

namespace PhysicalBridges.RouteBWholeUSixSourceFirstLoss

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.AllIsDynamicRelationalTransport
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.RouteBOriginalSixFirstViolation
open PhysicalBridges.CathedralFullX3Assembly

/-- Exact whole-source W relational evolution, not a postulated
abstract isomorphism. The before and after web relations are
BOTH independently computed from the full operator U.
The physical map is the banked frozen W source position map. -/
def objective_W_is_intrinsic_relational_evolution
    (U : FiniteObjectiveU) :
    RelationalEvolution (sourceWholeWeb U).link
      (sourceWholeWeb (objectiveStep U)).link where
  to := sourceTransport
  undo := sourceTransport
  leftInverse := source_transport_is_involution
  rightInverse := source_transport_is_involution
  preservesRel := by
    intro i j
    have h := complete_objective_link_carriage U i j 1
    change
      (sourceWholeWeb (objectiveStep U)).link
        (sourceTransport i) (sourceTransport j) ↔
      (sourceWholeWeb U).link i j at h
    exact h.symm

/-- Every first-order source formula over the ENTIRE operator web
(including quantified and negated formulas) is preserved AND
reflected by one independently specified actual whole-W stage.
This does not mean subjective X3 interpretations are first-order
definable in the present restricted source language. -/
theorem every_intrinsic_whole_U_formula_is_exact_under_W
    (U : FiniteObjectiveU)
    {n : Nat} (phi : RelFormula n) (env : Fin n → Index) :
    evalRel (sourceWholeWeb U).link env phi ↔
      evalRel (sourceWholeWeb (objectiveStep U)).link
        (fun i => sourceTransport (env i)) phi := by
  exact every_intrinsic_formula_transports
    (sourceWholeWeb U).link
    (sourceWholeWeb (objectiveStep U)).link
    (objective_W_is_intrinsic_relational_evolution U)
    phi env

/-- Six independent source reports, each containing an arbitrary
intrinsic first-order formula; the only primitive relation is
the one COMPUTED from the whole operator source U. -/
def SourceSixAt
    (U : FiniteObjectiveU) (d : SixRelationalDuties)
    (env : Fin 4 → Index) : Prop :=
  SourceSixHold (sourceWholeWeb U).link d env

/-- All role indices are transported by the same physical source
map. An index here is a candidate source slot, NOT itself an
authenticated experiencing particular. -/
def transportRoles (env : Fin 4 → Index) : Fin 4 → Index :=
  fun i => sourceTransport (env i)

/-- The independent WHOLE source dynamical law protects all six
separate intrinsic first-order reports simultaneously. This is
a biconditional for ANY six formulas, not a one-sided safe
transition defined by satisfying the result. -/
theorem all_six_whole_source_reports_are_exact_under_W
    (U : FiniteObjectiveU) (d : SixRelationalDuties)
    (env : Fin 4 → Index) :
    SourceSixAt U d env ↔
      SourceSixAt (objectiveStep U) d (transportRoles env) := by
  have h (phi : RelFormula 4) :=
    every_intrinsic_whole_U_formula_is_exact_under_W U phi env
  constructor
  · rintro ⟨hc,ha,hf,hr,hm,hp⟩
    exact ⟨(h d.continuity).mp hc,
      (h d.authorization).mp ha,
      (h d.freedom).mp hf,
      (h d.restraint).mp hr,
      (h d.maximality).mp hm,
      (h d.provenance).mp hp⟩
  · rintro ⟨hc,ha,hf,hr,hm,hp⟩
    exact ⟨(h d.continuity).mpr hc,
      (h d.authorization).mpr ha,
      (h d.freedom).mpr hf,
      (h d.restraint).mpr hr,
      (h d.maximality).mpr hm,
      (h d.provenance).mpr hp⟩

/-- Concrete #352-style physical events are independent of X3.
Any physical event which respects the source W/forward-genesis
generator preserves all six intrinsically definable source reports.
No no-stalling premise is needed for local first-loss exclusion. -/
theorem actual_source_compatible_event_preserves_six_reports
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (s t : Combined) (hPhysical : physical s t)
    (d : SixRelationalDuties) (env : Fin 4 → Index) :
    SourceSixAt s.2 d env ↔
      SourceSixAt t.2 d (transportRoles env) := by
  have hStep := hRef s t hPhysical
  rw [hStep.2]
  exact all_six_whole_source_reports_are_exact_under_W s.2 d env

/-- A first-source-loss witness would be an ACTUAL event whose
six source formulas are true before and false after, with their
physical source roles properly transported. This is NOT defined
in terms of original X3. -/
def FirstSixSourceLoss
    (physical : SourceRelation) (d : SixRelationalDuties) : Prop :=
  ∃ s t : Combined, ∃ env : Fin 4 → Index,
    physical s t ∧
    SourceSixAt s.2 d env ∧
    ¬ SourceSixAt t.2 d (transportRoles env)

/-- **Route B positive source theorem.** The frozen-W operator web
itself excludes ANY first loss of six intrinsic relational reports
on actual source-compatible steps. This is derived from W
covariance, not assumed as a protection axiom or action filter. -/
theorem no_first_six_source_loss_from_physical_W
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (d : SixRelationalDuties) :
    ¬ FirstSixSourceLoss physical d := by
  rintro ⟨s,t,env,hStep,hBefore,hAfterBad⟩
  have hPreserve :=
    (actual_source_compatible_event_preserves_six_reports
      M physical hRef s t hStep d env).mp hBefore
  exact hAfterBad hPreserve

/-- Tracked physical event + physical source transport of all four
role slots. This augmented event is independently constrained
by the actual physical relation; no safety condition appears. -/
abbrev TrackedActual := Combined × (Fin 4 → Index)

def trackedPhysicalStep
    (physical : SourceRelation) (s t : TrackedActual) : Prop :=
  physical s.1 t.1 ∧ t.2 = transportRoles s.2

/-- Every actual traced source event faithfully transports all
six intrinsic relational truths. -/
theorem every_tracked_physical_step_preserves_six_source_reports
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (s t : TrackedActual)
    (hStep : trackedPhysicalStep physical s t)
    (d : SixRelationalDuties) :
    SourceSixAt s.1.2 d s.2 ↔ SourceSixAt t.1.2 d t.2 := by
  obtain ⟨hPhysical,hRoles⟩ := hStep
  rw [hRoles]
  exact actual_source_compatible_event_preserves_six_reports
    M physical hRef s.1 t.1 hPhysical d s.2

/-- No first source loss at ANY event of ANY finite actual trace,
not merely the periodic endpoints. All six source formulas
retain the same physical operator-W witness at each microstep. -/
theorem every_finite_physical_trace_retains_all_six_source_reports
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (d : SixRelationalDuties)
    {s t : TrackedActual}
    (trace : PhysicalBridges.IR96.Reach
      (trackedPhysicalStep physical) s t)
    (hSourceOrigin : SourceSixAt s.1.2 d s.2) :
    SourceSixAt t.1.2 d t.2 := by
  induction trace with
  | refl => exact hSourceOrigin
  | tail before last ih =>
      exact (every_tracked_physical_step_preserves_six_source_reports
        M physical hRef _ _ last d).mp ih

/-! ## Route B: the three exact original-X3 failure-reflection joins.

The OLD route A semantic bridge is NOT discharged by a source
position retaining its operator relation. Unlike the earlier
positive reflection formulation, the three explicit NEGATIVE
bridges ask what ORIGINAL violations would physically imply
about source formula truth at the affected positions. These
must be established independently for actual subjects and every
within-event effect. No 'protection by name' is inferred. -/

/-- A particular's map to four physical source roles is provided
independently; no such map is claimed to be validated for any
actual subject by this definition. -/
structure ThreeFirstFailureReflections
    {P : Type}
    (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties)
    (roles : P → Fin 4 → Index) : Prop where
  identity : ∀ s t p, physical s t → owed s t p →
      ¬ IdentityAndProvenance r s t p →
      ¬ SourceSixAt t.2 d (transportRoles (roles p))
  agency : ∀ s t p, physical s t → owed s t p →
      ¬ AgencyAndFreedom r s t p →
      ¬ SourceSixAt t.2 d (transportRoles (roles p))
  stewardship : ∀ s t p, physical s t → owed s t p →
      ¬ RestraintAndMaximality r s t p →
      ¬ SourceSixAt t.2 d (transportRoles (roles p))

/-- If an independently validated source/subject interpretation
says FIRST failure of *identity+provenance* would cause an
observable source-level loss, the complete source W theorem
excludes that first failure. -/
theorem source_W_excludes_first_identity_violation
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hRef : RespectsCanonicalSource M physical)
    (hSourceBefore : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hMeaning : ThreeFirstFailureReflections
      physical owed r d roles) :
    ¬ FirstIdentityFailure physical owed r := by
  rintro ⟨s,t,p,hPhysical,hOwed,hBad⟩
  have hBefore := hSourceBefore s t p hPhysical hOwed
  have hAfter := (actual_source_compatible_event_preserves_six_reports
    M physical hRef s t hPhysical d (roles p)).mp hBefore
  exact hMeaning.identity s t p hPhysical hOwed hBad hAfter

/-- Source-W exclusion of the agency/freedom first-violation case:
the independent authentic-authorization reflection is a
VISIBLE premise, not a synonym of whole relational covariance. -/
theorem source_W_excludes_first_agency_violation
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hRef : RespectsCanonicalSource M physical)
    (hSourceBefore : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hMeaning : ThreeFirstFailureReflections
      physical owed r d roles) :
    ¬ FirstAgencyFailure physical owed r := by
  rintro ⟨s,t,p,hPhysical,hOwed,hBad⟩
  have hBefore := hSourceBefore s t p hPhysical hOwed
  have hAfter := (actual_source_compatible_event_preserves_six_reports
    M physical hRef s t hPhysical d (roles p)).mp hBefore
  exact hMeaning.agency s t p hPhysical hOwed hBad hAfter

/-- Source-W exclusion of the restraint/maximality first-violation
case, with that third group still separately physically owed. -/
theorem source_W_excludes_first_stewardship_violation
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hRef : RespectsCanonicalSource M physical)
    (hSourceBefore : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hMeaning : ThreeFirstFailureReflections
      physical owed r d roles) :
    ¬ FirstStewardshipFailure physical owed r := by
  rintro ⟨s,t,p,hPhysical,hOwed,hBad⟩
  have hBefore := hSourceBefore s t p hPhysical hOwed
  have hAfter := (actual_source_compatible_event_preserves_six_reports
    M physical hRef s t hPhysical d (roles p)).mp hBefore
  exact hMeaning.stewardship s t p hPhysical hOwed hBad hAfter

/-- Route B's source-first-loss method now meets the SAME full
all-owed six-X3 target from Route A. No original duty is
redefined; three separate negative source/subject reflections
are assumed EXPLICITLY and required to come from independent
physically verified meanings, not from this result's name. -/
theorem route_B_actual_W_and_three_failure_reflections_force_original_six
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hRef : RespectsCanonicalSource M physical)
    (hSourceBefore : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hMeaning : ThreeFirstFailureReflections
      physical owed r d roles) :
    ∀ s t p, physical s t → owed s t p →
      OriginalSixAt r s t p := by
  apply (route_B_three_first_failure_exclusions_iff_original_six
    physical owed r).mp
  exact ⟨source_W_excludes_first_identity_violation
      M physical owed r d roles hRef hSourceBefore hMeaning,
    source_W_excludes_first_agency_violation
      M physical owed r d roles hRef hSourceBefore hMeaning,
    source_W_excludes_first_stewardship_violation
      M physical owed r d roles hRef hSourceBefore hMeaning⟩

/-- The complete ROUTE B × #352 right-hand-flag joining theorem.
Physical non-stalling forces actual modeled genesis; actual W
dynamics prevents six-source-first-loss; three INDEPENDENT
original-X3 failure reflections lift that source obstruction
to all six actual duties, for every owed particular.
It does NOT derive the still-open semantic/physical premises. -/
theorem right_hand_genesis_and_route_B_reflections_force_original_six
    {P : Type} (M : Nat) (physical : SourceRelation)
    (owed : Combined → Combined → P → Prop)
    (r : ParticularRelations Combined P)
    (d : SixRelationalDuties) (roles : P → Fin 4 → Index)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical)
    (hSourceBefore : ∀ s t p, physical s t → owed s t p →
      SourceSixAt s.2 d (roles p))
    (hMeaning : ThreeFirstFailureReflections
      physical owed r d roles) :
    (∀ s t p, physical s t → owed s t p →
      OriginalSixAt r s t p) ∧
    (∀ e : Nat, ∀ o : Bool, ∀ U : FiniteObjectiveU,
      physical ((e,M,o),U) ((e+1,0,o),objectiveStep U)) := by
  exact ⟨route_B_actual_W_and_three_failure_reflections_force_original_six
      M physical owed r d roles hRef hSourceBefore hMeaning,
    fun e o U => physical_no_terminal_forces_genesis
      M e o U physical hRef hTotal⟩

/-- Witness of NONTRIVIALITY: this no-first-source-loss theorem
also holds for a modeled actual whole with a GENUINE original
Koru pair, not merely a degenerate relation or frozen source. -/
theorem actual_nontrivial_whole_Koru_and_six_source_exactness
    (d : SixRelationalDuties) (env : Fin 4 → Index) :
    WholeHasIntrinsicKoru KoruWitnessObjective ∧
    (SourceSixAt KoruWitnessObjective d env ↔
      SourceSixAt (objectiveStep KoruWitnessObjective)
        d (transportRoles env)) := by
  constructor
  · exact ⟨2,3,genuine_objective_koru_distinction⟩
  · exact all_six_whole_source_reports_are_exact_under_W
      KoruWitnessObjective d env

#print axioms objective_W_is_intrinsic_relational_evolution
#print axioms every_intrinsic_whole_U_formula_is_exact_under_W
#print axioms all_six_whole_source_reports_are_exact_under_W
#print axioms actual_source_compatible_event_preserves_six_reports
#print axioms no_first_six_source_loss_from_physical_W
#print axioms every_tracked_physical_step_preserves_six_source_reports
#print axioms every_finite_physical_trace_retains_all_six_source_reports
#print axioms source_W_excludes_first_identity_violation
#print axioms source_W_excludes_first_agency_violation
#print axioms source_W_excludes_first_stewardship_violation
#print axioms route_B_actual_W_and_three_failure_reflections_force_original_six
#print axioms right_hand_genesis_and_route_B_reflections_force_original_six
#print axioms actual_nontrivial_whole_Koru_and_six_source_exactness

end PhysicalBridges.RouteBWholeUSixSourceFirstLoss
