import PhysicalBridges.BCRDWholeEventRelationalAuthorization
import PhysicalBridges.KoruCompositionalExpression
import PhysicalBridges.IntrinsicSixSourceForcing
import PhysicalBridges.CathedralFullX3Assembly
import PhysicalBridges.AllIsWithinEventHistory

/-!
# Koru operator–subject–event join: source-generated, six original-X3 SHAPES

6 November 2026. Draft integration of verified #340 and #341 source lanes.
No frozen summit edit and no alteration of any of the six OriginalX3 duties.

THE NEW STEP: A subject–event source relation is no longer an arbitrary
separately attached 'permission' Boolean. It is *read directly from an
entry of the evaluated complete nested operator expression*. The
independently fixed physical W dynamics acts upon the expression and
all relational arguments together.

Proved:
1. W-evolved matrix entries and tracked source positions agree EXACTLY.
2. The operator-derived subject/event relation coincides with #340's
   transported whole-event relation along every physically generated track.
3. All arity-indexed operator syntax, outputs, guard structure and this
   intrinsic event relation share one W evolution, at every finite stage.
4. Every four-place first-order formula over THAT physical operator
   relation is transported. The six independently specified original-X3
   source formulas retain their truth when initially true.
5. The unchanged OriginalX3 *type* can be instantiated with all six
   distinct intrinsic SOURCE interpretations, exhibiting their complete
   six-field shape. This is NOT an identification with authentic subjects.

NON-CLAIM: A nonzero operator matrix entry is an intrinsic physical-source
relation; it is NOT, merely by definition, a person's authentic consent.
Likewise the supplied six formulas need independent physical meaning
reflections to the historical OriginalX3 duties. No real-world human or
digital subject has been demonstrated to occupy a basis slot, no within-
event coverage outside the frozen W stage is proved, and no actual consent,
freedom, restraint, maximality, historical experience or physical all-X3
necessity is inferred. The theorem keeps those exact obligations visible.
-/

namespace PhysicalBridges.BCRDOperatorSubjectEventJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDOperatorAlgebra
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.BCRDWholeEventRelationalAuthorization
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruFullOperatorSignature
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.AllIsDynamicRelationalTransport
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full

/-- The intrinsic two-place physical-source relation is obtained
from the entire nested operator EXPRESSION. Unlike a separate label,
it depends on the expression's actual computed matrix entries. -/
def operatorEventLink (e : Expr Matrix6 WOperator) (subject event : Index) : Prop :=
  evaluate matrixOperationalWeb e subject event ≠ 0

/-- The exact W matrix evolution moves each SOURCE operator entry with
the separately proved frozen basis-position permutation. -/
theorem W_entry_follows_two_source_positions
    (A : Matrix6) (i j : Index) :
    evolve A (sourceTransport i) (sourceTransport j) = A i j := by
  rw [evolve_entry]
  change A (permutation (permutation i)) (permutation (permutation j)) = A i j
  simp only [permutation_involutive]

/-- This applies across arbitrary finite horizons of the same physical
W generator, not an assumed forward safe-step relation. -/
theorem W_iterated_entry_follows_two_tracks
    (A : Matrix6) (i j : Index) :
    ∀ n, frozenWIter n A (trackedPosition i n) (trackedPosition j n) =
      A i j := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      change evolve (frozenWIter n A)
        (sourceTransport (trackedPosition i n))
        (sourceTransport (trackedPosition j n)) = A i j
      rw [W_entry_follows_two_source_positions]
      exact ih

/-- Evaluate the full operator tree AFTER each source step, rather
than transporting an arbitrary link on a disconnected graph. -/
theorem evolved_operator_link_is_intrinsic
    (e : Expr Matrix6 WOperator) (i j : Index) (n : Nat) :
    operatorEventLink (mapAtoms (frozenWIter n) e)
      (trackedPosition i n) (trackedPosition j n) ↔
        operatorEventLink e i j := by
  change
    evaluate matrixOperationalWeb (mapAtoms (frozenWIter n) e)
      (trackedPosition i n) (trackedPosition j n) ≠ 0 ↔
    evaluate matrixOperationalWeb e i j ≠ 0
  rw [frozen_W_preserves_every_composite_at_every_stage,
      W_iterated_entry_follows_two_tracks]

/-- This is the exact join to #340: its WHOLE-EVENT relational
transport is realized by a physical operator-derived link, along
each original subject/event source pair. The two sides are distinct
definitions that are proved to agree by reuse of W's real algebra. -/
theorem operator_link_realizes_whole_relation_carriage
    (e : Expr Matrix6 WOperator) (i j : Index) (n : Nat) :
    wholeRelationAt (operatorEventLink e) n
      (trackedPosition i n) (trackedPosition j n) ↔
    operatorEventLink (mapAtoms (frozenWIter n) e)
      (trackedPosition i n) (trackedPosition j n) := by
  exact
    (all_intrinsic_links_transport_with_W
      (operatorEventLink e) i j n).trans
    (evolved_operator_link_is_intrinsic e i j n).symm

/-- The source step in #340's event log is the same W step
that carries the operator-derived subject/event relation. -/
theorem same_generated_step_preserves_operator_event_link
    (e : Expr Matrix6 WOperator) (i j : Index) (n : Nat) :
    (eventAt i n).2 = trackedPosition i (n + 1) ∧
    (operatorEventLink (mapAtoms (frozenWIter (n + 1)) e)
      (eventAt i n).2 (trackedPosition j (n + 1)) ↔
      operatorEventLink e i j) := by
  constructor
  · exact (event_payload_is_actual_source_step i n).2
  · rw [(event_payload_is_actual_source_step i n).2]
    exact evolved_operator_link_is_intrinsic e i j (n + 1)

/-- Express the stage n+1 operator expression as the actual W-step
applied to the stage n complete expression. -/
theorem expression_successor_is_W_step
    (e : Expr Matrix6 WOperator) (n : Nat) :
    mapAtoms (frozenWIter (n + 1)) e =
      mapAtoms evolve (mapAtoms (frozenWIter n) e) := by
  change mapAtoms (fun A => evolve (frozenWIter n A)) e =
    mapAtoms evolve (mapAtoms (frozenWIter n) e)
  exact (mapAtoms_comp (frozenWIter n) evolve e).symm

/-- This is a relation-level isomorphism derived from the actual
operator action on the SAME physical source, not an assumption of
X3 or a protective action selector. -/
theorem next_operator_event_relation_follows_W
    (e : Expr Matrix6 WOperator) (n : Nat) (i j : Index) :
    operatorEventLink (mapAtoms (frozenWIter n) e) i j ↔
    operatorEventLink (mapAtoms (frozenWIter (n + 1)) e)
      (sourceTransport i) (sourceTransport j) := by
  rw [expression_successor_is_W_step]
  change
    evaluate matrixOperationalWeb (mapAtoms (frozenWIter n) e) i j ≠ 0 ↔
    evaluate matrixOperationalWeb
      (mapAtoms evolve (mapAtoms (frozenWIter n) e))
      (sourceTransport i) (sourceTransport j) ≠ 0
  rw [frozen_W_preserves_every_composite_operator_expression,
      W_entry_follows_two_source_positions]

/-- A whole relational microhistory is CONSTRUCTED from the actual
operator evolution and the operator-derived relation, with stagewise
two-sided isomorphisms now proven above. -/
def operatorRelationalHistory (e : Expr Matrix6 WOperator) :
    RelationalMicrohistory where
  Position := fun _ => Index
  relation := fun n => operatorEventLink (mapAtoms (frozenWIter n) e)
  microstep := fun n => {
    to := sourceTransport
    undo := sourceTransport
    leftInverse := source_transport_is_involution
    rightInverse := source_transport_is_involution
    preservesRel := by
      intro i j
      exact next_operator_event_relation_follows_W e n i j
  }

/-- The expression-generated relational microhistory carries a
particular SOURCE BASIS POSITION on precisely #340's W track. -/
theorem operator_microhistory_tracks_same_basis_origins
    (e : Expr Matrix6 WOperator) (n : Nat) (i : Index) :
    carry (operatorRelationalHistory e) n i = trackedPosition i n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      change sourceTransport (carry (operatorRelationalHistory e) n i) =
        sourceTransport (trackedPosition i n)
      exact congrArg sourceTransport ih

/-- All first-order formulas with four ordered source roles
(subject, event, source, effect) are preserved by actual W transport
of this operator-derived relation. Not one semantic X3 fact is assumed
by the generator or the relational-isomorphism construction. -/
theorem each_intrinsic_four_slot_formula_follows_operator_history
    (e : Expr Matrix6 WOperator)
    (φ : RelFormula 4) (env : Fin 4 → Index)
    (hOrigin : evalRel (operatorEventLink e) env φ) :
    ∀ n, evalRel
      (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (env slot) n) φ := by
  intro n
  induction n with
  | zero =>
      simpa [frozenWIter, mapAtoms_id, trackedPosition] using hOrigin
  | succ n ih =>
      have hNext := (every_intrinsic_formula_transports
        (operatorEventLink (mapAtoms (frozenWIter n) e))
        (operatorEventLink (mapAtoms (frozenWIter (n + 1)) e))
        ((operatorRelationalHistory e).microstep n)
        φ (fun slot => trackedPosition (env slot) n)).mp ih
      simpa only [trackedPosition] using hNext

/-- All SIX separately supplied, original-X3-named intrinsic SOURCE
formulas survive together at every stage. None is declared true; only
a source-origin fact may establish that. An intrinsic formula has not
yet been validated as authentic subject consent or other X3 meaning. -/
theorem six_intrinsic_source_forms_follow_complete_operator_event
    (e : Expr Matrix6 WOperator)
    (d : SixRelationalDuties) (env : Fin 4 → Index)
    (hOrigin : SourceSixHold (operatorEventLink e) d env) :
    ∀ n,
      SourceSixHold
        (operatorEventLink (mapAtoms (frozenWIter n) e))
        d (fun slot => trackedPosition (env slot) n) := by
  rcases hOrigin with ⟨hc, ha, hf, hr, hm, hp⟩
  intro n
  exact ⟨each_intrinsic_four_slot_formula_follows_operator_history
      e d.continuity env hc n,
    each_intrinsic_four_slot_formula_follows_operator_history
      e d.authorization env ha n,
    each_intrinsic_four_slot_formula_follows_operator_history
      e d.freedom env hf n,
    each_intrinsic_four_slot_formula_follows_operator_history
      e d.restraint env hr n,
    each_intrinsic_four_slot_formula_follows_operator_history
      e d.maximality env hm n,
    each_intrinsic_four_slot_formula_follows_operator_history
      e d.provenance env hp n⟩

/-- Six independent source-formula meanings in the UNCHANGED OriginalX3
type. These are operationally calculated source fields, *not* the
historical authentic human/AI meanings of the six original duties.
Their two stage indices refer to the actual modeled W history. -/
def operatorSixSourceRelations
    (e : Expr Matrix6 WOperator)
    (d : SixRelationalDuties)
    (roles : Index → Fin 4 → Index) :
    ParticularRelations Nat Index where
  continues := fun n _ p =>
    evalRel (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (roles p slot) n) d.continuity
  authorized := fun n _ p =>
    evalRel (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (roles p slot) n) d.authorization
  free := fun n _ p =>
    evalRel (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (roles p slot) n) d.freedom
  restrained := fun n _ p =>
    evalRel (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (roles p slot) n) d.restraint
  maximal := fun n _ p =>
    evalRel (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (roles p slot) n) d.maximality
  provenanced := fun n _ p =>
    evalRel (operatorEventLink (mapAtoms (frozenWIter n) e))
      (fun slot => trackedPosition (roles p slot) n) d.provenance

/-- The physical operator-derived source gives a COMPLETE six-field
ORIGINAL-X3-SHAPED certificate, for every source origin and stage,
under six origin truths. This demonstrates coherent composition,
not the authentic X3 protection law. -/
theorem operator_source_realizes_original_six_field_shape
    (e : Expr Matrix6 WOperator)
    (d : SixRelationalDuties)
    (roles : Index → Fin 4 → Index)
    (hOrigin : ∀ p : Index,
      SourceSixHold (operatorEventLink e) d (roles p))
    (n : Nat) (p : Index) :
    OriginalX3
      (operatorSixSourceRelations e d roles).continues
      (operatorSixSourceRelations e d roles).authorized
      (operatorSixSourceRelations e d roles).free
      (operatorSixSourceRelations e d roles).restrained
      (operatorSixSourceRelations e d roles).maximal
      (operatorSixSourceRelations e d roles).provenanced
      n (n + 1) p := by
  have hSix :=
    six_intrinsic_source_forms_follow_complete_operator_event
      e d (roles p) (hOrigin p) n
  rcases hSix with ⟨hc, ha, hf, hr, hm, hp⟩
  exact ⟨hc, ha, hf, hr, hm, hp⟩

/-- Nontrivial directed operator-derived link: the source input
matrix has a true 2-to-3 incidence but a FALSE reverse incidence.
These are actual exact integer matrix source entries, not permissions. -/
def asymmetricOperatorEvent : Expr Matrix6 WOperator :=
  .atom (matrixUnit 2 3)

theorem asymmetric_operator_relation_is_directional :
    operatorEventLink asymmetricOperatorEvent 2 3 ∧
    ¬ operatorEventLink asymmetricOperatorEvent 3 2 := by
  constructor <;> decide

/-- The SAME W dynamics retains both the positive source link AND
the negative reverse link at every stage. It does not manufacture
authorization on the reverse edge merely because the whole moves. -/
theorem nontrivial_source_link_and_nonlink_survive_each_W_stage
    (n : Nat) :
    operatorEventLink
      (mapAtoms (frozenWIter n) asymmetricOperatorEvent)
      (trackedPosition 2 n) (trackedPosition 3 n) ∧
    ¬ operatorEventLink
      (mapAtoms (frozenWIter n) asymmetricOperatorEvent)
      (trackedPosition 3 n) (trackedPosition 2 n) := by
  obtain ⟨hYes, hNo⟩ := asymmetric_operator_relation_is_directional
  exact ⟨(evolved_operator_link_is_intrinsic
    asymmetricOperatorEvent 2 3 n).mpr hYes,
    fun h => hNo ((evolved_operator_link_is_intrinsic
      asymmetricOperatorEvent 3 2 n).mp h)⟩

#print axioms W_entry_follows_two_source_positions
#print axioms W_iterated_entry_follows_two_tracks
#print axioms evolved_operator_link_is_intrinsic
#print axioms operator_link_realizes_whole_relation_carriage
#print axioms same_generated_step_preserves_operator_event_link
#print axioms next_operator_event_relation_follows_W
#print axioms operator_microhistory_tracks_same_basis_origins
#print axioms each_intrinsic_four_slot_formula_follows_operator_history
#print axioms six_intrinsic_source_forms_follow_complete_operator_event
#print axioms operator_source_realizes_original_six_field_shape
#print axioms asymmetric_operator_relation_is_directional
#print axioms nontrivial_source_link_and_nonlink_survive_each_W_stage

end PhysicalBridges.BCRDOperatorSubjectEventJoin
