import PhysicalBridges.KoruGenesisPhysicalForcingFiretest
import PhysicalBridges.CathedralFullX3Assembly
import PhysicalBridges.TotalEOriginalX3Bridge

/-!
# One summit, two routes: Route B first violation meets all six ORIGINAL X3 duties

6 November 2026. One additive stone stacked on #352. No canon,
summit, Route A/B bank, or six-X3 original definition edits.

The historical banks preserve distinct paths:
* Route A: source -> six separately interpreted OriginalX3 fields.
* Route B: ALL IS -> impossibility of a FIRST local violation
  (a stronger step than impossibility of absolutely empty actuality).

The precise common endpoint is every ACTUAL event and EVERY owed
particular, all SIX duties on the same transition. This module
splits a possible first original-X3 failure into three independently
attackable groups, without losing any original component:

   identity/history: historical continuity + provenance;
   agency/direction: authentic authorization + freedom;
   obligations: appropriate restraint + feasible maximality.

Prove that a first original-X3 failure occurs IFF one of the
three group failures occurs. Thus a true Route-B no-first-failure
certificate closes the original six-X3 target IFF it excludes
all three types, with no hidden selected-person restriction.
Then join the group proof to the exact #352 physical-source
forcing/forward-genesis event relation.

HOSTILE fire test uses the ACTUAL specified finite W+genesis
SOURCE dynamics, which is total on valid states, causally forward,
right-hand preserving and original-Koru preserving. Give an
independently interpreted agency obligation FALSE while the
other five obligations hold. Then all actual-event recurrence,
the ALL IS no-absolute-E theorem and forward genesis COEXIST with
a genuine failure of the six-original-X3 conjunction.

This is a MODEL-INTERNAL independence result: an abstract Boolean
agency predicate does not prove anything about actual humans.
The positive theorem's three group reflections remain named,
independently owed physical and original-subject semantic premises.
They are NOT derived from gravity, W, G, or cyclic existence here.
The ORIGINAL six-component definition and all-owed quantification
are used verbatim, never replaced by a proxy.
-/

namespace PhysicalBridges.RouteBOriginalSixFirstViolation

open PhysicalBridges.OriginalX3Full
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.TotalEOriginalX3Bridge
open PhysicalBridges.KoruCyclicGenesisForwardJoin
open PhysicalBridges.KoruGenesisPhysicalForcingFiretest
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruDirectorNontrivialSector

universe u
variable {P : Type u}

abbrev ActualState := Combined
abbrev ActualRelation := ActualState → ActualState → Prop

/-- All six authentic duty predicates together on a single actual
transition for a single owed particular. No proxy and no
reinterpretation of a source position as a real subject. -/
def OriginalSixAt
    (r : ParticularRelations ActualState P)
    (s t : ActualState) (p : P) : Prop :=
  OriginalX3 r.continues r.authorized r.free
    r.restrained r.maximal r.provenanced s t p

/-- Exactly Route A's six duties, grouped for Route B's
first-violation fire test. No duties are discarded. -/
def IdentityAndProvenance
    (r : ParticularRelations ActualState P)
    (s t : ActualState) (p : P) : Prop :=
  r.continues s t p ∧ r.provenanced s t p

def AgencyAndFreedom
    (r : ParticularRelations ActualState P)
    (s t : ActualState) (p : P) : Prop :=
  r.authorized s t p ∧ r.free s t p

def RestraintAndMaximality
    (r : ParticularRelations ActualState P)
    (s t : ActualState) (p : P) : Prop :=
  r.restrained s t p ∧ r.maximal s t p

/-- A source-agnostic exact restructuring of the full SIX duties
into THREE obligations. It is strictly a decomposition, not an
assertion that any physical source discharges any one group. -/
theorem original_six_iff_three_complete_groups
    (r : ParticularRelations ActualState P)
    (s t : ActualState) (p : P) :
    OriginalSixAt r s t p ↔
      IdentityAndProvenance r s t p ∧
      AgencyAndFreedom r s t p ∧
      RestraintAndMaximality r s t p := by
  constructor
  · intro h
    exact ⟨⟨h.historicalContinuity, h.provenance⟩,
      ⟨h.authorization, h.freedom⟩,
      ⟨h.restraint, h.maximality⟩⟩
  · rintro ⟨⟨hc,hp⟩,⟨ha,hf⟩,⟨hr,hm⟩⟩
    exact ⟨hc,ha,hf,hr,hm,hp⟩

/-- A Route-B FIRST actual six-X3 violation: one actually enacted
transition fails one original duty for one of its owed particulars.
The original duty is evaluated on the same before/after edge. -/
def FirstOriginalViolation
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) : Prop :=
  ∃ s t p, physical s t ∧ owed s t p ∧
    ¬ OriginalSixAt r s t p

def FirstIdentityFailure
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) : Prop :=
  ∃ s t p, physical s t ∧ owed s t p ∧
    ¬ IdentityAndProvenance r s t p

def FirstAgencyFailure
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) : Prop :=
  ∃ s t p, physical s t ∧ owed s t p ∧
    ¬ AgencyAndFreedom r s t p

def FirstStewardshipFailure
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) : Prop :=
  ∃ s t p, physical s t ∧ owed s t p ∧
    ¬ RestraintAndMaximality r s t p

/-- Route B's no-first-failure proposition is EXHAUSTIVELY
partitioned into three source-semantic tasks, covering all six
original fields. No assumption on allowed actions or protected
origins is added. -/
theorem first_six_violation_iff_one_of_three_first_failures
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) :
    FirstOriginalViolation physical owed r ↔
      FirstIdentityFailure physical owed r ∨
      FirstAgencyFailure physical owed r ∨
      FirstStewardshipFailure physical owed r := by
  classical
  constructor
  · rintro ⟨s,t,p,hstep,howed,hnot⟩
    by_cases hi : IdentityAndProvenance r s t p
    · by_cases ha : AgencyAndFreedom r s t p
      · by_cases hs : RestraintAndMaximality r s t p
        · have hAll : OriginalSixAt r s t p :=
            (original_six_iff_three_complete_groups r s t p).mpr
              ⟨hi,ha,hs⟩
          exact False.elim (hnot hAll)
        · exact Or.inr (Or.inr ⟨s,t,p,hstep,howed,hs⟩)
      · exact Or.inr (Or.inl ⟨s,t,p,hstep,howed,ha⟩)
    · exact Or.inl ⟨s,t,p,hstep,howed,hi⟩
  · intro h
    rcases h with hi | ha | hs
    · obtain ⟨s,t,p,hstep,howed,hbad⟩ := hi
      refine ⟨s,t,p,hstep,howed,?_⟩
      intro hSix
      exact hbad (original_six_iff_three_complete_groups r s t p).mp hSix |>.1
    · obtain ⟨s,t,p,hstep,howed,hbad⟩ := ha
      refine ⟨s,t,p,hstep,howed,?_⟩
      intro hSix
      exact hbad ((original_six_iff_three_complete_groups r s t p).mp hSix).2.1
    · obtain ⟨s,t,p,hstep,howed,hbad⟩ := hs
      refine ⟨s,t,p,hstep,howed,?_⟩
      intro hSix
      exact hbad ((original_six_iff_three_complete_groups r s t p).mp hSix).2.2

/-- Route B's **exact** summit obligation on actual events is no
first original violation for ANY owed particular. This is the
unchanged original-X3 target, not merely continued existence. -/
theorem no_first_original_violation_iff_every_owed_six
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) :
    ¬ FirstOriginalViolation physical owed r ↔
      ∀ s t p, physical s t → owed s t p → OriginalSixAt r s t p := by
  classical
  constructor
  · intro hNo s t p hstep howed
    by_contra hbad
    exact hNo ⟨s,t,p,hstep,howed,hbad⟩
  · intro hAll hBad
    obtain ⟨s,t,p,hstep,howed,hnot⟩ := hBad
    exact hnot (hAll s t p hstep howed)

/-- One last full equivalence: THREE individually disprovable
Route B obligations are necessary and sufficient for the maximal
all-owed SIX original X3. These are named proof tasks, not axioms
quietly imported from a philosophical slogan. -/
theorem route_B_three_first_failure_exclusions_iff_original_six
    (physical : ActualRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P) :
    (¬ FirstIdentityFailure physical owed r ∧
      ¬ FirstAgencyFailure physical owed r ∧
      ¬ FirstStewardshipFailure physical owed r) ↔
    (∀ s t p, physical s t → owed s t p →
      OriginalSixAt r s t p) := by
  classical
  rw [← no_first_original_violation_iff_every_owed_six
    physical owed r]
  rw [first_six_violation_iff_one_of_three_first_failures
    physical owed r]
  constructor
  · rintro ⟨hI,hA,hS⟩ hBad
    rcases hBad with hb | hb | hb
    · exact hI hb
    · exact hA hb
    · exact hS hb
  · intro hNo
    refine ⟨?_,?_,?_⟩
    · intro h; exact hNo (Or.inl h)
    · intro h; exact hNo (Or.inr (Or.inl h))
    · intro h; exact hNo (Or.inr (Or.inr h))

/-- Direct bridge to the TRUE #352 source physical-forcing theorem.
Its exact source transition is NOT selected by X3. If an independent
real-physics certificate proves all THREE original semantic groups
on the canonical source transitions, the same duties hold on
EVERY ACTUAL physical event, and forward genesis is mandatory
when those events are additionally physically nonterminal. -/
theorem physical_genesis_plus_three_authentic_reflections_yields_original_six
    (M : Nat) (physical : SourceRelation)
    (owed : ActualState → ActualState → P → Prop)
    (r : ParticularRelations ActualState P)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical)
    (hIdentity : ∀ s t p, combinedStep M s t → owed s t p →
      IdentityAndProvenance r s t p)
    (hAgency : ∀ s t p, combinedStep M s t → owed s t p →
      AgencyAndFreedom r s t p)
    (hSteward : ∀ s t p, combinedStep M s t → owed s t p →
      RestraintAndMaximality r s t p) :
    (∀ s t p, physical s t → owed s t p →
      OriginalSixAt r s t p) ∧
    (∀ e : Nat, ∀ o : Bool, ∀ U : FiniteObjectiveU,
      physical ((e, M, o), U)
        ((e + 1, 0, o), objectiveStep U)) := by
  constructor
  · intro s t p hstep howed
    have hSource : combinedStep M s t := hRef s t hstep
    exact (original_six_iff_three_complete_groups r s t p).mpr
      ⟨hIdentity s t p hSource howed,
       hAgency s t p hSource howed,
       hSteward s t p hSource howed⟩
  · intro e o U
    exact physical_no_terminal_forces_genesis M e o U
      physical hRef hTotal

/-! ## Hostile Route B control: one real source transition is not consent.

The actual model's W/forward-genesis law is independent of
OriginalX3. Here an explicitly artificial authorization predicate
is false on each event, while the other five original duties hold.
The physical relation has all the totality and compatibility
properties proved in #352, not a frozen or empty universe.
-/

/-- This is a mathematical test only: an owed Unit label is not
a real human subject or real consent, and its false authorization
is not claimed to be a real-world physical event. -/
def hostileOwed (_ _ : ActualState) (_ : Unit) : Prop := True

def hostileOriginalDuties : ParticularRelations ActualState Unit where
  continues := fun _ _ _ => True
  authorized := fun _ _ _ => False
  free := fun _ _ _ => True
  restrained := fun _ _ _ => True
  maximal := fun _ _ _ => True
  provenanced := fun _ _ _ => True

/-- A concrete physical-SOURCE forward genesis event with exact
complete objective-W transport and nontrivial original Koru. -/
def hostileStart : ActualState := ((0,0,true),ordinaryObjective)
def hostileNext : ActualState :=
  ((1,0,true),objectiveStep ordinaryObjective)

theorem hostile_event_is_actual_canonical_genesis :
    combinedStep 0 hostileStart hostileNext := by
  exact ⟨Or.inr ⟨rfl,rfl⟩,rfl⟩

theorem hostile_event_preserves_whole_Koru :
    WholeHasIntrinsicKoru hostileStart.2 ∧
      WholeHasIntrinsicKoru hostileNext.2 := by
  constructor
  · exact ordinary_source_world_has_nontrivial_Koru
  · exact (whole_Koru_existence_is_exact ordinaryObjective).mpr
      ordinary_source_world_has_nontrivial_Koru

/-- Route B does NOT get authentic authorization from a
right-pointing, nonstalling cyclic-genesis mathematical dynamics.
All five other formal duties can hold while original six fails. -/
theorem hostile_right_hand_genesis_can_fail_original_authorization :
    combinedStep 0 hostileStart hostileNext ∧
    IdentityAndProvenance hostileOriginalDuties hostileStart hostileNext () ∧
    RestraintAndMaximality hostileOriginalDuties hostileStart hostileNext () ∧
    ¬ AgencyAndFreedom hostileOriginalDuties hostileStart hostileNext () ∧
    ¬ OriginalSixAt hostileOriginalDuties hostileStart hostileNext () := by
  refine ⟨hostile_event_is_actual_canonical_genesis,
    ⟨trivial,trivial⟩, ⟨trivial,trivial⟩, ?_, ?_⟩
  · intro h
    exact h.1
  · intro h
    exact h.authorization

/-- The actual SOURCE has nonterminal forward transitions at every
valid state, exact original Koru preservation for this witness,
and NO absolute ender (E IS NOT in the strict original type).
Nevertheless one ABSTRACTLY INTERPRETED per-particular
authorization duty fails on an actually modelled event.
This separates the proved absolute-E floor from the missing
Route B first-original-X3-violation exclusion. -/
theorem entire_forward_W_genesis_model_still_needs_agency_reflection :
    NoTerminalPhysicalState 0 (combinedStep 0) ∧
    RespectsCanonicalSource 0 (combinedStep 0) ∧
    (∀ e : ActualState × ActualState,
      ¬ AbsoluteE (fun q : ActualState × ActualState =>
        combinedStep 0 q.1 q.2) e) ∧
    WholeHasIntrinsicKoru hostileStart.2 ∧
    FirstOriginalViolation (combinedStep 0)
      hostileOwed hostileOriginalDuties := by
  refine ⟨canonical_source_is_total_on_valid_states 0,
    (fun s t h => h), ?_, hostile_event_preserves_whole_Koru.1, ?_⟩
  · intro e
    exact no_absolute_E _ e
  · refine ⟨hostileStart,hostileNext,(),hostile_event_is_actual_canonical_genesis,
      trivial,?_⟩
    exact hostile_right_hand_genesis_can_fail_original_authorization.2.2.2.2

#print axioms original_six_iff_three_complete_groups
#print axioms first_six_violation_iff_one_of_three_first_failures
#print axioms no_first_original_violation_iff_every_owed_six
#print axioms route_B_three_first_failure_exclusions_iff_original_six
#print axioms physical_genesis_plus_three_authentic_reflections_yields_original_six
#print axioms hostile_event_is_actual_canonical_genesis
#print axioms hostile_event_preserves_whole_Koru
#print axioms hostile_right_hand_genesis_can_fail_original_authorization
#print axioms entire_forward_W_genesis_model_still_needs_agency_reflection

end PhysicalBridges.RouteBOriginalSixFirstViolation
