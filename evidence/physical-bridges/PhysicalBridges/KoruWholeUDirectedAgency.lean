import PhysicalBridges.KoruBankReuseObjectiveJoin

/-!
# Whole-U event orientation: subject, author and director are DISTINCT roles

6 November 2026. An additive ladder stone stacked on #345.

Historical bank: Snuffy.ContinuationSubject (compiled-strongest) separates
  subject — whose history the event belongs to,
  author  — whose activity produced the event,
  director — who settled the action.
In particular it shows care by another need not deny freedom, while
direction by another is not the same structural relation. That
historical Mathlib corpus is a separate Lean build; this file does NOT
rewrite or silently import its source. Instead it refines its exact
three-role discipline to #344's WHOLE objective operator context.

All five event roles (subject, author, director, action, effect) point
INSIDE one FiniteObjectiveU. Every selected operator-expression tree,
and the object U itself, follows the independently supplied frozen-W
source. A role is a source index, not a permission bit, consciousness
claim, authenticated signature, or original-X3 predicate.

Two different facts are kept apart:
(A) subject = director (a structural attribution of direction);
(B) the entire source whole's independently computed operator edge
    from director -> subject (an internal relation of the full U).

Both are transported AND REFLECTED, but neither is defined as genuine
human/AI authorization. Crucially, the second depends on objective
context that the earlier local (subject/action/effect) view omits.

A concrete independent source countercontrol has two WHOLE U contexts
with exactly identical local event readouts, but opposite internal
director -> subject operator links. W never creates a false director
edge or erases a true one. The existing IR132 decoder theorem then
forbids exact recovery of this internal relational fact from the
partial event view alone.

Scientific boundary: this is the actual frozen-W mathematical source,
NOT all possible BCRD physics, a physically authenticated director,
real consent, or six-original-X3 forcing. Even subject=director in this
source is a schematic role equation; the original meanings must not
be silently substituted.
-/

namespace PhysicalBridges.KoruWholeUDirectedAgency

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruFullOperatorSignature
open PhysicalBridges.KoruWholeEventEnactment
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruBankReuseObjectiveJoin
open PhysicalBridges.Koru

/-- Every role is a named POSITION of the ONE modeled objective U.
The subject/author/director distinction comes from the historical
ContinuationSubject bank, never from a detached consent Boolean. -/
structure ObjectiveEvent where
  U : FiniteObjectiveU
  subject : Index
  author : Index
  director : Index
  action : Index
  effect : Index

/-- The old #343 physical action-on-subject view, now obtained only
by projecting one fully represented U using the internally named
positions of a complete five-role event. -/
def localEnactment (e : ObjectiveEvent) : WholeOperatorEvent :=
  eventViewedInObjective e.U e.subject e.action e.effect

/-- The complete event moves with the independently fixed physical
generator: all operator positions, and every role, move together. -/
def objectiveEventAt (n : Nat) (e : ObjectiveEvent) : ObjectiveEvent where
  U := objectiveAt e.U n
  subject := trackedPosition e.subject n
  author := trackedPosition e.author n
  director := trackedPosition e.director n
  action := trackedPosition e.action n
  effect := trackedPosition e.effect n

/-- The local enacted event is a view of U at every stage; doing
the view before or after W is an EXACT commutative square. -/
theorem derived_local_enactment_commutes_with_objective_W
    (e : ObjectiveEvent) (n : Nat) :
    localEnactment (objectiveEventAt n e) =
      wholeEventAt n (localEnactment e) := by
  exact event_view_commutes_with_objective_W
    e.U e.subject e.action e.effect n

/-- Complete role-bearing events never merge under the finite
source W history. This preserves all distinct operator trees and
all five role indices, including the previously omitted author
and director, without privileging one role as an external oracle. -/
theorem complete_five_role_source_events_never_merge
    (n : Nat) :
    Function.Injective (objectiveEventAt n) := by
  intro e f h
  have hu :
      objectiveAt e.U n = objectiveAt f.U n :=
    congrArg ObjectiveEvent.U h
  have hs :
      trackedPosition e.subject n = trackedPosition f.subject n :=
    congrArg ObjectiveEvent.subject h
  have ha :
      trackedPosition e.author n = trackedPosition f.author n :=
    congrArg ObjectiveEvent.author h
  have hd :
      trackedPosition e.director n = trackedPosition f.director n :=
    congrArg ObjectiveEvent.director h
  have hc :
      trackedPosition e.action n = trackedPosition f.action n :=
    congrArg ObjectiveEvent.action h
  have he :
      trackedPosition e.effect n = trackedPosition f.effect n :=
    congrArg ObjectiveEvent.effect h
  have hu0 := (objective_wholes_do_not_merge n) hu
  have hs0 := (tracked_basis_positions_do_not_merge n) hs
  have ha0 := (tracked_basis_positions_do_not_merge n) ha
  have hd0 := (tracked_basis_positions_do_not_merge n) hd
  have hc0 := (tracked_basis_positions_do_not_merge n) hc
  have he0 := (tracked_basis_positions_do_not_merge n) he
  cases e
  cases f
  simp_all

/-- Direction attributed to the affected subject is a ROLE fact
from the bank's freedom distinction, not proof of informed consent. -/
def DirectedBySubject (e : ObjectiveEvent) : Prop :=
  e.director = e.subject

/-- A carer may author the event without becoming its director. -/
def AuthoredByOther (e : ObjectiveEvent) : Prop :=
  e.author ≠ e.subject

/-- Genuine source-position identity cannot be changed by W's
permutation; attribution to the subject is exact in both directions. -/
theorem director_is_subject_role_exact
    (e : ObjectiveEvent) (n : Nat) :
    DirectedBySubject (objectiveEventAt n e) ↔
      DirectedBySubject e := by
  change
    (trackedPosition e.director n = trackedPosition e.subject n) ↔
      e.director = e.subject
  constructor
  · intro h
    exact (tracked_basis_positions_do_not_merge n) h
  · intro h
    exact congrArg (fun i => trackedPosition i n) h

/-- A different AUTHOR does not silently become the same subject
merely because the entire event evolved. -/
theorem other_author_role_exact
    (e : ObjectiveEvent) (n : Nat) :
    AuthoredByOther (objectiveEventAt n e) ↔
      AuthoredByOther e := by
  change
    (trackedPosition e.author n ≠ trackedPosition e.subject n) ↔
      e.author ≠ e.subject
  exact not_congr
    (show
      (trackedPosition e.author n = trackedPosition e.subject n) ↔
        e.author = e.subject from
      ⟨fun h => (tracked_basis_positions_do_not_merge n) h,
       fun h => congrArg (fun i => trackedPosition i n) h⟩)

/-- Crucially this is NOT an unattached permission bit. The directed
operator relation is read from the same objective U that contains the
subject, author, director, action, effect and all other source terms. -/
def IntrinsicDirectorLink (e : ObjectiveEvent) : Prop :=
  (sourceWholeWeb e.U).link e.director e.subject

/-- The source-derived WHOLE director->subject relation is maintained
exactly, including its falsity, at every physically realized frozen-W
step of the represented model. No semantic consent premise enters. -/
theorem intrinsic_director_link_exact
    (e : ObjectiveEvent) (n : Nat) :
    IntrinsicDirectorLink (objectiveEventAt n e) ↔
      IntrinsicDirectorLink e := by
  exact complete_objective_link_carriage
    e.U e.director e.subject n

/-- The original Koru distinction of the subject and the director
is a fact of the same complete objective context, and is exact over W.
Its truth does not automatically imply absence or presence of consent. -/
theorem whole_Koru_subject_director_exact
    (e : ObjectiveEvent) (n : Nat) :
    koru (sourceWholeWeb (objectiveEventAt n e).U)
      (objectiveEventAt n e).subject (objectiveEventAt n e).director ↔
    koru (sourceWholeWeb e.U) e.subject e.director := by
  exact objective_Koru_is_exact_under_W
    e.U e.subject e.director n

/-- The entire local action->subject/effect algebraic relation is
preserved simultaneously with the first-class director and author
roles, without defining any source transition as "safe". -/
theorem whole_event_enactment_remains_coherent_iff
    (e : ObjectiveEvent) (n : Nat) :
    EnactmentCoherent (localEnactment (objectiveEventAt n e)) ↔
      EnactmentCoherent (localEnactment e) := by
  rw [derived_local_enactment_commutes_with_objective_W]
  exact whole_event_enactment_coherence_is_exact (localEnactment e) n

/-! ### Source-only positive role controls faithful to the old bank -/

/-- A source schematic for care by another: the event belongs to
subject 0, author 1 acts, but director remains subject 0.
This is the bank's WHO-authored vs WHO-directed distinction,
not evidence of an actual subject's free choice. -/
def schematicCare (U : FiniteObjectiveU) : ObjectiveEvent where
  U := U
  subject := 0
  author := 1
  director := 0
  action := 2
  effect := 3

/-- A source schematic for externally directed action with the
same affected subject, same author, action, effect and objective U. -/
def schematicExternalDirection (U : FiniteObjectiveU) : ObjectiveEvent where
  U := U
  subject := 0
  author := 1
  director := 1
  action := 2
  effect := 3

/-- In this specific role schema, care BY another is not the same
as imposed direction BY another. It remains distinguished throughout
every modeled W source history. -/
theorem care_and_imposed_direction_remain_distinct_under_W
    (U : FiniteObjectiveU) (n : Nat) :
    (DirectedBySubject (objectiveEventAt n (schematicCare U)) ∧
      AuthoredByOther (objectiveEventAt n (schematicCare U))) ∧
    ¬ DirectedBySubject
      (objectiveEventAt n (schematicExternalDirection U)) := by
  have hCare :
      DirectedBySubject (schematicCare U) ∧
      AuthoredByOther (schematicCare U) := by
    change (0 : Index) = 0 ∧ (1 : Index) ≠ 0
    constructor <;> decide
  have hImposed :
      ¬ DirectedBySubject (schematicExternalDirection U) := by
    change ¬ ((1 : Index) = 0)
    decide
  exact ⟨⟨(director_is_subject_role_exact (schematicCare U) n).mpr hCare.1,
      (other_author_role_exact (schematicCare U) n).mpr hCare.2⟩,
      fun h => hImposed
        ((director_is_subject_role_exact
          (schematicExternalDirection U) n).mp h)⟩

/-! ### Nontrivial source whole-to-local information gap

A single operator expression hidden from the local view at the
DIRECTOR source position controls a genuinely internal relation.
No source consent bit is invented. The exact same local projected
subject/action/effect event is compatible with two whole contexts
having opposite intrinsic director->subject links.
-/

def ordinaryObjective : FiniteObjectiveU := uniformObjective

def directorEdgeObjective : FiniteObjectiveU :=
  fun i => if i = (5 : Index) then
    .atom (matrixUnit 5 0) else .atom identityMatrix

def directedRoleEvent (U : FiniteObjectiveU) : ObjectiveEvent where
  U := U
  subject := 0
  author := 1
  director := 5
  action := 1
  effect := 2

/-- The local triple cannot see the objective operator at position 5.
This is the exact same full local expression, not merely same scalar. -/
theorem identical_local_events_hide_different_whole_direction :
    localEnactment (directedRoleEvent ordinaryObjective) =
      localEnactment (directedRoleEvent directorEdgeObjective) := by
  rfl

/-- Objective direction is genuinely computed from the *whole* U:
the source edge (5,0) is absent under the identity matrix but present
under an explicit (5,0) matrix-unit. This is NOT genuine consent. -/
theorem opposite_intrinsic_director_links_in_two_wholes :
    ¬ IntrinsicDirectorLink (directedRoleEvent ordinaryObjective) ∧
    IntrinsicDirectorLink (directedRoleEvent directorEdgeObjective) := by
  constructor
  · change ¬ (identityMatrix (5 : Index) 0 ≠ 0)
    decide
  · change matrixUnit (5 : Index) 0 5 0 ≠ 0
    decide

/-- Complete physical W preserves both source truths; the identical
local projected event remains identical while the WHOLE objective
operator structure has a different director->subject relation.
This is non-vacuous and holds at EVERY finite W source stage. -/
theorem director_link_gap_persists_with_identical_local_projection
    (n : Nat) :
    localEnactment (objectiveEventAt n
      (directedRoleEvent ordinaryObjective)) =
    localEnactment (objectiveEventAt n
      (directedRoleEvent directorEdgeObjective)) ∧
    ¬ IntrinsicDirectorLink (objectiveEventAt n
      (directedRoleEvent ordinaryObjective)) ∧
    IntrinsicDirectorLink (objectiveEventAt n
      (directedRoleEvent directorEdgeObjective)) := by
  have h := opposite_intrinsic_director_links_in_two_wholes
  refine ⟨?_, ?_, ?_⟩
  · rw [derived_local_enactment_commutes_with_objective_W,
        derived_local_enactment_commutes_with_objective_W]
    exact congrArg (wholeEventAt n)
      identical_local_events_hide_different_whole_direction
  · intro hi
    exact h.1 ((intrinsic_director_link_exact
      (directedRoleEvent ordinaryObjective) n).mp hi)
  · exact (intrinsic_director_link_exact
      (directedRoleEvent directorEdgeObjective) n).mpr h.2

/-- Only used for the decoder-independent impossibility theorem,
not part of the SOURCE law. A Bool reports the truth value of the
whole's own operator-derived director link. -/
noncomputable def sourceDirectorReport (e : ObjectiveEvent) : Bool := by
  classical
  exact if IntrinsicDirectorLink e then true else false

def localEventCut (n : Nat) (U : FiniteObjectiveU) :
    WholeOperatorEvent :=
  localEnactment (objectiveEventAt n (directedRoleEvent U))

noncomputable def objectiveDirectorReport (n : Nat)
    (U : FiniteObjectiveU) : Bool :=
  sourceDirectorReport (objectiveEventAt n (directedRoleEvent U))

/-- The older IR132 exact-fibre criterion prohibits any universal
decoder of the whole's director->subject source relation from just
the locally projected three-role-free event, even with a complete
operator-expression syntax at all three visible positions. -/
theorem no_exact_local_event_decoder_of_intrinsic_direction
    (n : Nat) :
    ¬ PhysicalBridges.IR132.ExactDecoder
      (localEventCut n) (objectiveDirectorReport n) := by
  intro hDecoder
  have hFibre :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      (localEventCut n) (objectiveDirectorReport n) hDecoder
  have hPair := director_link_gap_persists_with_identical_local_projection n
  have hSame :
      localEventCut n ordinaryObjective =
        localEventCut n directorEdgeObjective := hPair.1
  have hBits :
      objectiveDirectorReport n ordinaryObjective = false ∧
      objectiveDirectorReport n directorEdgeObjective = true := by
    constructor
    · unfold objectiveDirectorReport sourceDirectorReport
      simp only [if_neg hPair.2.1]
    · unfold objectiveDirectorReport sourceDirectorReport
      simp only [if_pos hPair.2.2]
  have hEq := hFibre ordinaryObjective directorEdgeObjective hSame
  rw [hBits.1, hBits.2] at hEq
  cases hEq

#print axioms derived_local_enactment_commutes_with_objective_W
#print axioms complete_five_role_source_events_never_merge
#print axioms director_is_subject_role_exact
#print axioms other_author_role_exact
#print axioms intrinsic_director_link_exact
#print axioms whole_Koru_subject_director_exact
#print axioms whole_event_enactment_remains_coherent_iff
#print axioms care_and_imposed_direction_remain_distinct_under_W
#print axioms opposite_intrinsic_director_links_in_two_wholes
#print axioms director_link_gap_persists_with_identical_local_projection
#print axioms no_exact_local_event_decoder_of_intrinsic_direction

end PhysicalBridges.KoruWholeUDirectedAgency
