import PhysicalBridges.KoruWholeEventEnactment
import PhysicalBridges.Koru

/-!
# Objective U is the object: the Koru lives in the whole, not a local triple

6 November 2026. Exact frozen-W research model only, not full physical U.
Author correction: an event cannot be completed by a detachable
(subject, action, effect) triple. The object is the whole actuality U;
the Koru is intrinsic to that whole and retains genuine distinctions.

This additive module constructs the WHOLE represented operator context
for the six physical W source positions. Subject, action and effect
are then derived from that one objective object, not invented as
independent unlinked event inputs.

It proves a genuine commutative square for all finite frozen-W stages:
  deriveEvent(U_n, transported roles) = W^n(deriveEvent(U_0, roles)).
It also shows EVERY intrinsic whole-web relation, and the original
(nonreflexive, distinction-preserving) Koru itself, transport under W.

A nontrivial negative control demonstrates that two different objective
wholes can yield IDENTICAL local subject/action/effect event readouts.
Thus the local triple cannot reconstruct the whole U. The source
evolution retains their difference; no identification of partial
and total actuality is permitted.

The complete physical universe is NOT proven to be this finite
Index -> Expr Matrix6 WOperator model. Calling it FiniteObjectiveU
is intentional. Koru is the existing intrinsic distinction operator
from Koru.lean, NOT redefined as plain equality, nor an axiom
imposing X3. An actual authorization-forcing theorem remains open.
-/

namespace PhysicalBridges.KoruObjectiveWholeU

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruFullOperatorSignature
open PhysicalBridges.BCRDOperatorSubjectEventJoin
open PhysicalBridges.KoruWholeEventEnactment
open PhysicalBridges.Koru

/-- The finite OBJECTIVE context of this frozen-W source: every
source position has a complete arbitrary operator-expression tree.
This is a total source model, NOT an identification with cosmic U. -/
abbrev FiniteObjectiveU := Index → Expr Matrix6 WOperator

/-- The independently specified physical W step transports BOTH
the full operator expression at each site and the entire position
indexing. No guardian, X3, permission, or protected-transition filter. -/
def objectiveStep (U : FiniteObjectiveU) : FiniteObjectiveU :=
  fun i => mapAtoms evolve (U (sourceTransport i))

/-- The complete objective source after all finite physically generated
W stages; n is an event index, not an external cosmological clock. -/
def objectiveAt (U : FiniteObjectiveU) : Nat → FiniteObjectiveU
  | 0 => U
  | n + 1 => objectiveStep (objectiveAt U n)

/-- The physical position transport commutes with the source's own
one-step permutation, an exact consequence of the frozen W generator. -/
theorem tracked_position_commutes_with_W
    (i : Index) (n : Nat) :
    trackedPosition (sourceTransport i) n =
      sourceTransport (trackedPosition i n) := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change
        sourceTransport (trackedPosition (sourceTransport i) n) =
          sourceTransport (sourceTransport (trackedPosition i n))
      rw [ih]

/-- Crucial: the whole basis-position history is two-sided at every
finite W stage. Its inverse is the SAME W history (the frozen 2-cycle).
This is not a claim for arbitrary physical time evolution. -/
theorem tracked_position_involution_at_stage
    (i : Index) (n : Nat) :
    trackedPosition (trackedPosition i n) n = i := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change
        sourceTransport
          (trackedPosition
            (sourceTransport (trackedPosition i n)) n) = i
      rw [tracked_position_commutes_with_W]
      rw [ih]
      exact source_transport_is_involution i

/-- WHOLE physical context and ALL its operator terms move with the
same independent W generator. No subject/action/effect readout is
needed as a premise; this is source-level entire-U carriage. -/
theorem objective_operator_at_tracked_site
    (U : FiniteObjectiveU) (i : Index) (n : Nat) :
    objectiveAt U n (trackedPosition i n) =
      mapAtoms (frozenWIter n) (U i) := by
  induction n with
  | zero =>
      change U i = mapAtoms (fun A : Matrix6 => A) (U i)
      exact (mapAtoms_id (U i)).symm
  | succ n ih =>
      change
        mapAtoms evolve
          (objectiveAt U n
            (sourceTransport
              (sourceTransport (trackedPosition i n)))) =
        mapAtoms (fun A => evolve (frozenWIter n A)) (U i)
      rw [source_transport_is_involution, ih]
      exact mapAtoms_comp (frozenWIter n) evolve (U i)

/-- No loss of the objective source, including context NOT visible
from any selected local event. Every finite W history is injective
on WHOLE six-position operator contexts, not only on their triples. -/
theorem objective_wholes_do_not_merge
    (n : Nat) :
    Function.Injective (fun U : FiniteObjectiveU => objectiveAt U n) := by
  intro U V h
  funext i
  have hAt := congrFun h (trackedPosition i n)
  change objectiveAt U n (trackedPosition i n) =
    objectiveAt V n (trackedPosition i n) at hAt
  rw [objective_operator_at_tracked_site U i n,
      objective_operator_at_tracked_site V i n] at hAt
  exact (frozen_W_expression_histories_do_not_merge n) hAt

/-- Every binary intrinsic source relation is calculated from the
complete operator expression at the first position of the pair.
No source relation is separately assigned an authority/consent bit. -/
def sourceWholeWeb (U : FiniteObjectiveU) : Web Index where
  link := fun i j => operatorEventLink (U i) i j

/-- The WHOLE operator-derived relation transports exactly with
both physical positions at every represented W stage. -/
theorem complete_objective_link_carriage
    (U : FiniteObjectiveU) (i j : Index) (n : Nat) :
    (sourceWholeWeb (objectiveAt U n)).link
      (trackedPosition i n) (trackedPosition j n) ↔
    (sourceWholeWeb U).link i j := by
  change
    operatorEventLink
      (objectiveAt U n (trackedPosition i n))
      (trackedPosition i n) (trackedPosition j n) ↔
    operatorEventLink (U i) i j
  rw [objective_operator_at_tracked_site]
  exact evolved_operator_link_is_intrinsic (U i) i j n

/-- A genuinely two-sided reindexing of all six physical source
positions, derived from W and its actual involution. -/
def trackedWholeReindex (n : Nat) : Reindex Index where
  to := fun i => trackedPosition i n
  inv := fun i => trackedPosition i n
  left := fun i => tracked_position_involution_at_stage i n
  right := fun i => tracked_position_involution_at_stage i n

/-- Every link in the evolved whole is literally a reindexing of
the original complete operator-derived web, not a source-independent
replacement of the relation. -/
theorem evolved_whole_web_is_reindexed
    (U : FiniteObjectiveU) (n : Nat) :
    sourceWholeWeb (objectiveAt U n) =
      reindexWeb (trackedWholeReindex n) (sourceWholeWeb U) := by
  unfold sourceWholeWeb reindexWeb
  congr 1
  funext a b
  apply propext
  have h := complete_objective_link_carriage U
    (trackedPosition a n) (trackedPosition b n) n
  simpa only [tracked_position_involution_at_stage,
    sourceWholeWeb, trackedWholeReindex] using h

/-- The EXISTING KORU (an internal relational distinction, NOT an
ordinary equals sign) is preserved AND reflected when the OBJECT U
and all its operators evolve together. No special subject chosen. -/
theorem objective_Koru_is_exact_under_W
    (U : FiniteObjectiveU) (i j : Index) (n : Nat) :
    koru (sourceWholeWeb (objectiveAt U n))
      (trackedPosition i n) (trackedPosition j n) ↔
    koru (sourceWholeWeb U) i j := by
  rw [evolved_whole_web_is_reindexed]
  exact koru_reindex_invariant
    (trackedWholeReindex n) (sourceWholeWeb U) i j

/-- The local subject/action/effect view is DERIVED FROM THE WHOLE U.
The output fields are the same exact WholeOperatorEvent from #343,
but their source has now been linked to one common objective world. -/
def eventViewedInObjective
    (U : FiniteObjectiveU)
    (subjectRole actionRole effectRole : Index) : WholeOperatorEvent where
  subject := U subjectRole
  action := U actionRole
  effect := U effectRole
  subjectRole := subjectRole
  actionRole := actionRole

/-- The key commutative-square theorem:
 deriving the local event from the PHYSICALLY EVOLVED objective U is
 identical to evolving that entire local event with the same source W.
 Neither the whole nor the event is defined by an X3 predicate. -/
theorem event_view_commutes_with_objective_W
    (U : FiniteObjectiveU)
    (subjectRole actionRole effectRole : Index) (n : Nat) :
    eventViewedInObjective
      (objectiveAt U n)
      (trackedPosition subjectRole n)
      (trackedPosition actionRole n)
      (trackedPosition effectRole n) =
    wholeEventAt n
      (eventViewedInObjective U subjectRole actionRole effectRole) := by
  simp only [eventViewedInObjective, wholeEventAt,
    objective_operator_at_tracked_site]

/-- Local algebraic event coherence is preserved AND reflected, now
for an event whose subject, action and effect were all selected FROM
one objective whole U rather than attached as independent inputs. -/
theorem objective_anchored_event_coherence_is_exact
    (U : FiniteObjectiveU)
    (subjectRole actionRole effectRole : Index) (n : Nat) :
    EnactmentCoherent
      (eventViewedInObjective (objectiveAt U n)
        (trackedPosition subjectRole n)
        (trackedPosition actionRole n)
        (trackedPosition effectRole n)) ↔
    EnactmentCoherent
      (eventViewedInObjective U subjectRole actionRole effectRole) := by
  rw [event_view_commutes_with_objective_W]
  exact whole_event_enactment_coherence_is_exact
    (eventViewedInObjective U subjectRole actionRole effectRole) n

/-- A NONTRIVIAL actual whole-source Koru distinction. This is
the existing no-collapse koru law, witnessed by a directional
operator-source edge in a complete six-position context. -/
def KoruWitnessObjective : FiniteObjectiveU :=
  fun _ => .atom (matrixUnit 2 3)

theorem genuine_objective_koru_distinction :
    koru (sourceWholeWeb KoruWitnessObjective) 2 3 := by
  refine ⟨by decide, 3, ?_⟩
  change
    ((matrixUnit (2 : Index) 3 2 3 ≠ 0) : Prop) ≠
      ((matrixUnit (2 : Index) 3 3 3 ≠ 0) : Prop)
  intro h
  have hYes : matrixUnit (2 : Index) 3 2 3 ≠ 0 := by decide
  have hNo : ¬ (matrixUnit (2 : Index) 3 3 3 ≠ 0) := by decide
  rw [h] at hYes
  exact hNo hYes

/-- The objectively articulated difference persists at EVERY
represented W stage, for the actual moved pair of source positions. -/
theorem genuine_Koru_distinction_survives_entire_W_history
    (n : Nat) :
    koru (sourceWholeWeb (objectiveAt KoruWitnessObjective n))
      (trackedPosition 2 n) (trackedPosition 3 n) :=
  (objective_Koru_is_exact_under_W KoruWitnessObjective 2 3 n).mpr
    genuine_objective_koru_distinction

/-! ## Decisive projection-control: the part is not the objective U

Two distinct complete source contexts AGREE on every field of a
selected local subject/action/effect event, but differ at an
unselected source position. This is the precise mathematical version
of the user's correction: the local event is a projection of U,
not the whole U itself. Global source dynamics does not erase the
unobserved distinction.
-/

def uniformObjective : FiniteObjectiveU :=
  fun _ => .atom identityMatrix

def changedElsewhereObjective : FiniteObjectiveU :=
  fun i => if i = (5 : Index) then
    .atom (matrixUnit 2 3) else .atom identityMatrix

/-- Exact local agreement and exact global inequality. An event
triple cannot reconstruct the whole objective source context. -/
theorem local_event_cannot_be_identified_with_objective_U :
    eventViewedInObjective uniformObjective 0 1 2 =
      eventViewedInObjective changedElsewhereObjective 0 1 2 ∧
    uniformObjective ≠ changedElsewhereObjective := by
  constructor
  · rfl
  · intro hU
    have hAt5 := congrFun hU (5 : Index)
    change (Expr.atom identityMatrix : Expr Matrix6 WOperator) =
      .atom (matrixUnit 2 3) at hAt5
    have hMatrix := congrArg (evaluate matrixOperationalWeb) hAt5
    change identityMatrix = matrixUnit (2 : Index) 3 at hMatrix
    have hEntry := congrFun (congrFun hMatrix (2 : Index)) (3 : Index)
    have hL : identityMatrix (2 : Index) 3 = 0 := by decide
    have hR : matrixUnit (2 : Index) 3 2 3 = 1 := by decide
    rw [hL, hR] at hEntry
    exact (by decide : (0 : Int) ≠ 1) hEntry

/-- Even where the local observer's projection is incomplete, the
independently specified actual W generator does not collapse the
distinct complete objectives into one. Local identity is not U. -/
theorem omitted_global_context_remains_distinct_under_W
    (n : Nat) :
    objectiveAt uniformObjective n ≠
      objectiveAt changedElsewhereObjective n := by
  intro h
  exact local_event_cannot_be_identified_with_objective_U.2
    ((objective_wholes_do_not_merge n) h)

#print axioms tracked_position_commutes_with_W
#print axioms tracked_position_involution_at_stage
#print axioms objective_operator_at_tracked_site
#print axioms objective_wholes_do_not_merge
#print axioms complete_objective_link_carriage
#print axioms evolved_whole_web_is_reindexed
#print axioms objective_Koru_is_exact_under_W
#print axioms event_view_commutes_with_objective_W
#print axioms objective_anchored_event_coherence_is_exact
#print axioms genuine_objective_koru_distinction
#print axioms genuine_Koru_distinction_survives_entire_W_history
#print axioms local_event_cannot_be_identified_with_objective_U
#print axioms omitted_global_context_remains_distinct_under_W

end PhysicalBridges.KoruObjectiveWholeU
