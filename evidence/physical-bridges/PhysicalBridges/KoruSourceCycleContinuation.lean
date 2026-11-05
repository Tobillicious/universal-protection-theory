import PhysicalBridges.KoruDirectorNontrivialSector
import PhysicalBridges.CathedralSummitCyclicContinuation
import PhysicalBridges.CathedralSummitPremiseNecessity

/-!
# Independent frozen-W objective-U cycle and the continuation boundary

6 November 2026. An additive source-generated cyclicity rung, stacked
on #349. The Cathedral, original summit and six X3 definitions remain
unchanged.

We do NOT assume a periodic history: the real source `W` operator
acts on the WHOLE six-position `FiniteObjectiveU` (all nested
operator expressions) and is already kernel-proved involutive in
#347. This creates an independently defined 2-cycle for EVERY
finite modeled source context. We instantiate the existing
CathedralSummitCyclicContinuation.CyclicHistory theorem with it.

Positive:
* the entire objective operator context returns at every two
  source steps (not merely one scalar or local event);
* an actual original-Koru relational distinction in the whole
  remains true at each intermediate W step, including the
  physically moving source-position indices;
* if that Koru property is initially true, it recurs at arbitrarily
  late source stages, with no final Koru-bearing stage.
  Concrete original-Koru witnesses from #349 make this nonvacuous.

Negative/semantics boundary:
* a cyclic complete source and its nontrivial Koru do NOT on
  their own imply continuing EXPE-RIENCING of an independently
  interpreted subject. The historical finite-worldline control
  provides a witness: whole physical source is 2-cyclic, but an
  unconstrained subjective predicate may cease after any stage.
* a genuine physical source-to-particular reflection, not a
  choice of names, is required before the positive cycle may
  be called historical continuity or any original-X3 guarantee.

These are PROOFS in the exact finite frozen-W source model. They
are not physical evidence of an actually cyclic cosmos,
the multiverse, prior universe iterations, authentic subject
continuity, or an unconditional universal protection law.
-/

namespace PhysicalBridges.KoruSourceCycleContinuation

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.Koru
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruDirectorNontrivialSector
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.CathedralSummitCyclicContinuation
open PhysicalBridges.CathedralSummitPremiseNecessity

/-- The ACTUAL frozen W source realizes a 2-cycle on the entire
objective operator-expression world, for every U and every
finite source-stage n, with no assumed CyclicHistory premise. -/
theorem objective_W_is_two_periodic
    (U : FiniteObjectiveU) (n : Nat) :
    objectiveAt U (n + 2) = objectiveAt U n := by
  have hn : n + 2 = (n + 1) + 1 := by omega
  rw [hn]
  change objectiveStep (objectiveStep (objectiveAt U n)) =
    objectiveAt U n
  exact objective_W_is_an_involution _

/-- The existing Cathedral's cyclic source hypothesis now has
a concrete inhabitant DERIVED from frozen W, rather than being
postulated as a generic periodicity assumption. -/
def actual_W_source_cycle
    (U : FiniteObjectiveU) : CyclicHistory FiniteObjectiveU where
  stage := objectiveAt U
  period := 2
  period_pos := by decide
  periodic := objective_W_is_two_periodic U

/-- Every two SOURCE steps return the entire nested-operator
context. This does not mean every particular or conscious event
has undergone another lived experience. -/
theorem complete_objective_source_recurs_every_two_steps
    (U : FiniteObjectiveU) (n : Nat) :
    objectiveAt U (n * 2) = U := by
  have h :=
    recurs_each_period (actual_W_source_cycle U) n
  change objectiveAt U (n * 2) = U at h
  exact h

/-- The original Koru relational distinction is retained at
every source microstep, with BOTH distinguished positions carried
by the actual source generator, not fixed at old coordinates. -/
theorem original_Koru_pair_persists_at_every_source_stage
    (U : FiniteObjectiveU) (i j : Index)
    (hKoru : koru (sourceWholeWeb U) i j) :
    ∀ n : Nat,
      koru (sourceWholeWeb (objectiveAt U n))
        (trackedPosition i n) (trackedPosition j n) := by
  intro n
  exact (objective_Koru_is_exact_under_W U i j n).mpr hKoru

/-- Every complete W cycle returns the SAME INITIAL operator
whole and its original internal Koru pair, not merely an
isomorphic but differently labelled event projection. -/
theorem original_Koru_pair_recurs_at_every_full_cycle
    (U : FiniteObjectiveU) (i j : Index)
    (hKoru : koru (sourceWholeWeb U) i j) :
    ∀ n : Nat,
      koru (sourceWholeWeb (objectiveAt U (n * 2))) i j := by
  intro n
  rw [complete_objective_source_recurs_every_two_steps]
  exact hKoru

/-- Reuse the ORIGINAL Cathedral cyclic continuation proof with
the independently derived W-cycle. The protected predicate is
the genuinely nontrivial original Koru sector, NOT a tautology
and NOT any of the six authentic original-X3 subject duties. -/
theorem source_whole_Koru_has_no_final_W_stage
    (U : FiniteObjectiveU)
    (hKoru : WholeHasIntrinsicKoru U) :
    ∀ N : Nat, ∃ k : Nat, N ≤ k ∧
      WholeHasIntrinsicKoru (objectiveAt U k) := by
  have h :=
    no_final_protected_stage
      (actual_W_source_cycle U)
      WholeHasIntrinsicKoru hKoru
  change ∀ N : Nat, ∃ k : Nat, N ≤ k ∧
    WholeHasIntrinsicKoru (objectiveAt U k) at h
  exact h

/-- The earlier specific ordinary and director-edge source
contexts are both concretely Koru-bearing and cofinal through
actual source W; this proves nonvacuity for two physically
different exact modeled operator worlds. -/
theorem both_distinct_source_wholes_recur_with_Koru :
    (∀ N : Nat, ∃ k : Nat, N ≤ k ∧
        WholeHasIntrinsicKoru (objectiveAt ordinaryObjective k)) ∧
    (∀ N : Nat, ∃ k : Nat, N ≤ k ∧
        WholeHasIntrinsicKoru (objectiveAt directorEdgeObjective k)) := by
  exact ⟨source_whole_Koru_has_no_final_W_stage ordinaryObjective
      ordinary_source_world_has_nontrivial_Koru,
    source_whole_Koru_has_no_final_W_stage directorEdgeObjective
      director_edge_source_world_has_nontrivial_Koru⟩

/-- The exact source Koru PAIR has no final tracked occurrence.
The pair itself stays distinct through source microhistory.
This is still relational individuation of matrix positions,
not an independently validated mind or lived continuation. -/
theorem original_Koru_pair_has_no_final_tracked_source_stage
    (U : FiniteObjectiveU) (i j : Index)
    (hKoru : koru (sourceWholeWeb U) i j) :
    ∀ N : Nat, ∃ k : Nat, N ≤ k ∧
      koru (sourceWholeWeb (objectiveAt U k))
        (trackedPosition i k) (trackedPosition j k) := by
  intro N
  exact ⟨N, Nat.le_refl N,
    original_Koru_pair_persists_at_every_source_stage U i j hKoru N⟩

/-- No-source-assumptions **countercontrol to an ontological leap**:
even for an actual 2-cyclic W operator context containing original
Koru distinctions at every source stage, a separately interpreted
"experiences" relation MAY stop at any finite stage. It therefore
cannot be identified with the SOURCE Koru predicate without an
independently justified subject-semantic correspondence.

The two assertions are on the SAME source-stage index; this is
a semantic independence test, NOT a physical claim that real
subjects cease during the frozen W update. -/
theorem cyclic_Koru_source_does_not_determine_lived_continuation
    (last : Nat) :
    (∀ n : Nat,
      objectiveAt ordinaryObjective (n + 2) =
        objectiveAt ordinaryObjective n) ∧
    (∀ n : Nat, WholeHasIntrinsicKoru
      (objectiveAt ordinaryObjective n)) ∧
    experiences last last ∧
    (∀ k : Nat, last < k → ¬ experiences last k) := by
  refine ⟨objective_W_is_two_periodic ordinaryObjective,
    ?_, Nat.le_refl last, ?_⟩
  · intro n
    exact (whole_Koru_existence_is_exact (objectiveAt ordinaryObjective n)).mpr
      (by
        induction n with
        | zero => exact ordinary_source_world_has_nontrivial_Koru
        | succ n ih =>
            exact (whole_Koru_existence_is_exact
              (objectiveAt ordinaryObjective n)).mpr ih)
  · intro k hk hle
    exact (Nat.not_lt.mpr hle) hk

/-- An explicit source-semantic REFLECTION (which must be established
independently for real subjects) suffices to transport the positive
cofinal source fact to no-final-stage lived continuation.
This theorem does NOT prove that reflection premise, and may not be
called an unconditional subject or original-X3 proof. -/
theorem authenticated_subject_reflection_would_transfer_source_cycle
    (U : FiniteObjectiveU)
    (hKoru : WholeHasIntrinsicKoru U)
    (live : Nat → Prop)
    (hReflection : ∀ n, WholeHasIntrinsicKoru (objectiveAt U n) →
      live n) :
    ∀ N : Nat, ∃ k : Nat, N ≤ k ∧ live k := by
  intro N
  obtain ⟨k, hk, hSource⟩ :=
    source_whole_Koru_has_no_final_W_stage U hKoru N
  exact ⟨k, hk, hReflection k hSource⟩

#print axioms objective_W_is_two_periodic
#print axioms actual_W_source_cycle
#print axioms complete_objective_source_recurs_every_two_steps
#print axioms original_Koru_pair_persists_at_every_source_stage
#print axioms original_Koru_pair_recurs_at_every_full_cycle
#print axioms source_whole_Koru_has_no_final_W_stage
#print axioms both_distinct_source_wholes_recur_with_Koru
#print axioms original_Koru_pair_has_no_final_tracked_source_stage
#print axioms cyclic_Koru_source_does_not_determine_lived_continuation
#print axioms authenticated_subject_reflection_would_transfer_source_cycle

end PhysicalBridges.KoruSourceCycleContinuation
