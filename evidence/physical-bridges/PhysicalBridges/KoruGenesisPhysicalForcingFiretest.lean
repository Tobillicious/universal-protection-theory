import PhysicalBridges.KoruCyclicGenesisForwardJoin

/-!
# The fire test at the right-pointing summit flag:
# exactly what would FORCE physical genesis at an epoch terminus?

6 November 2026. Additive research stone stacked on #351.
No historical summit, six-X3 definition, or canon was changed.

The previously verified #351 proof combines an *independently
specified exact frozen W* source and Tenzing's older forward-genesis
model. But its genesis arrow is defined as an admissible transition,
not deduced to be physically realised at actual heat death.

We now expose the remaining PHYSICAL premise as a precise theorem:

Given any independently supplied physical event relation P,
(i) every physical event is constrained by the independently
    specified combined W + Tenzing forward-genesis dynamics, and
(ii) no valid physical state is terminal (every such state has
     at least one PHYSICALLY realised successor),
THEN the physical event relation coincides with the canonical
source event relation, at EVERY valid state, because that
source dynamics has at most one successor per state.

In particular, at an epoch's arrow-maximum M, actual physical
progress forces exactly genesis to the next epoch, right-handed
and forward, carrying the same complete W source relations.
The original Cathedral's reachable-forward-continuation proof
then lifts to physical paths with nontrivial original Koru.

The hostile control builds a strictly forward, right-handed,
W-consistent, Koru-preserving and NONTRIVIAL physical event system
which nevertheless STOPS at the heat-death terminus. This proves
that objective W recurrence, retained operator relations and a
right-pointing arrow do NOT, by themselves, force physical
continuation. The added no-terminal premise is indispensable in
this model class (or a stronger independent physical law).

This is a mathematical source-forcing criterion and a sharp
counterexample. It is NOT evidence that the actual universe obeys
this no-stalling premise, nor a complete BCRD theory of gravity,
nor a proof of repeated cosmological genesis, lived subjective
continuation, or any original six-X3 duty. The source model is
finite and the physical relation is an explicit new variable.

Original Koru and Tenzing/Hilz summit stones are reused verbatim.
-/

namespace PhysicalBridges.KoruGenesisPhysicalForcingFiretest

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruDirectorNontrivialSector
open PhysicalBridges.KoruWholeUDirectedAgency
open PhysicalBridges.KoruSourceCycleContinuation
open PhysicalBridges.KoruCyclicGenesisForwardJoin

abbrev SourceRelation := Combined → Combined → Prop

/-- The physical relation may be specified independently.
Only actual physical events must refine the banked forward-genesis
model with the independently defined whole-source W transport. -/
def RespectsCanonicalSource (M : Nat) (physical : SourceRelation) : Prop :=
  ∀ s t : Combined, physical s t → combinedStep M s t

/-- Independent physically sourced no-stalling/progress premise.
Without it, no transition has to occur at heat death. This
premise is NOT inferred from W, Koru or causal orientation. -/
def NoTerminalPhysicalState (M : Nat) (physical : SourceRelation) : Prop :=
  ∀ s : Combined,
    PhysicalBridges.CyclicGenesisBoundary.localRank s.1 ≤ M →
      ∃ t : Combined, physical s t

/-- The model's own combined dynamics is DETERMINISTIC.
Every state has at most one allowed successor. This is proved
from the definitions of local step, genesis and whole W; no
physical progress is assumed or built into this lemma. -/
theorem canonical_combined_successor_unique
    (M : Nat) (s t u : Combined)
    (ht : combinedStep M s t) (hu : combinedStep M s u) :
    t = u := by
  apply Prod.ext
  · rcases ht.1 with htl | htg
    · rcases hu.1 with hul | hug
      · exact htl.2.trans hul.2.symm
      · have hlt := htl.1
        have heq := hug.1
        omega
    · rcases hu.1 with hul | hug
      · have hlt := hul.1
        have heq := htg.1
        omega
      · exact htg.2.trans hug.2.symm
  · exact ht.2.trans hu.2.symm

/-- Any physically admitted successor of an actual arrow-maximum
has precisely the old summit's forward-genesis target; it cannot
be a mirror, an earlier epoch, or an interior local step. -/
theorem any_compatible_terminus_successor_is_genesis
    (M e : Nat) (o : Bool) (U : FiniteObjectiveU)
    (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (t : Combined)
    (hPhysical : physical ((e, M, o), U) t) :
    t = ((e + 1, 0, o), objectiveStep U) := by
  have h := hRef _ _ hPhysical
  apply Prod.ext
  · rcases h.1 with hlocal | hgen
    · have hlt : M < M := hlocal.1
      exact False.elim ((Nat.lt_irrefl M) hlt)
    · simpa [PhysicalBridges.CyclicGenesisBoundary.epoch,
        PhysicalBridges.CyclicGenesisBoundary.orient] using hgen.2
  · exact h.2

/-- EXACT minimal terminal criterion, relative to the source
refinement: a physical successor EXISTS at heat death iff the
specific forward-handed GENESIS transition is physically present.
No amount of algebraic reversibility silently asserts either. -/
theorem terminal_progress_iff_realised_genesis
    (M e : Nat) (o : Bool) (U : FiniteObjectiveU)
    (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical) :
    (∃ t : Combined, physical ((e, M, o), U) t) ↔
      physical ((e, M, o), U)
        ((e + 1, 0, o), objectiveStep U) := by
  constructor
  · rintro ⟨t, ht⟩
    have hEq :=
      any_compatible_terminus_successor_is_genesis
        M e o U physical hRef t ht
    rwa [hEq] at ht
  · intro h
    exact ⟨_, h⟩

/-- Stronger physical non-stalling plus independently constrained
dynamics FORCES exactly the original right-pointing genesis
at every modeled heat-death boundary. -/
theorem physical_no_terminal_forces_genesis
    (M e : Nat) (o : Bool) (U : FiniteObjectiveU)
    (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical) :
    physical ((e, M, o), U)
      ((e + 1, 0, o), objectiveStep U) := by
  apply (terminal_progress_iff_realised_genesis
    M e o U physical hRef).mp
  exact hTotal _ (by simp [PhysicalBridges.CyclicGenesisBoundary.localRank])

/-- The canonical combined source relation itself has no valid
terminal state, including arbitrary heat-death crossings. This
is an internal model fact, NOT a physical cosmology certificate. -/
theorem canonical_source_is_total_on_valid_states
    (M : Nat) : NoTerminalPhysicalState M (combinedStep M) := by
  intro s hs
  by_cases hlt : PhysicalBridges.CyclicGenesisBoundary.localRank s.1 < M
  · refine ⟨((PhysicalBridges.CyclicGenesisBoundary.epoch s.1,
      PhysicalBridges.CyclicGenesisBoundary.localRank s.1 + 1,
      PhysicalBridges.CyclicGenesisBoundary.orient s.1),
        objectiveStep s.2), ?_⟩
    exact ⟨Or.inl ⟨hlt, rfl⟩, rfl⟩
  · have heq : PhysicalBridges.CyclicGenesisBoundary.localRank s.1 = M := by
      omega
    refine ⟨((PhysicalBridges.CyclicGenesisBoundary.epoch s.1 + 1,
      0, PhysicalBridges.CyclicGenesisBoundary.orient s.1),
        objectiveStep s.2), ?_⟩
    exact ⟨Or.inr ⟨heq, rfl⟩, rfl⟩

/-- A complete, independently given physical relation whose events
are compatible with the source and which never stalls on valid
states MUST realise EVERY canonical event, not just one genesis.
The deterministic W+interior source eliminates any other choice. -/
theorem physical_progress_forces_every_canonical_step
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical) :
    ∀ s t : Combined, combinedStep M s t → physical s t := by
  intro s t hModel
  have hs : PhysicalBridges.CyclicGenesisBoundary.localRank s.1 ≤ M := by
    rcases hModel.1 with hl | hg
    · exact Nat.le_of_lt hl.1
    · have heq := hg.1
      omega
  obtain ⟨u, hu⟩ := hTotal s hs
  have heq : t = u :=
    canonical_combined_successor_unique M s t u hModel
      (hRef s u hu)
  simpa only [heq] using hu

/-- Fire-test forcing equivalence: under source compatibility
and independent non-stalling, ALL physically executable steps
are exactly those admitted by the frozen W + Tenzing source.
This is not a derivation of non-stalling from gravity. -/
theorem physical_source_step_iff_canonical
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical) :
    ∀ s t : Combined, physical s t ↔ combinedStep M s t := by
  intro s t
  exact ⟨hRef s t,
    physical_progress_forces_every_canonical_step
      M physical hRef hTotal s t⟩

/-- Reachability under an independently specified physical
transition relation, rather than a chosen canonical witness. -/
inductive PhysicalReach (physical : SourceRelation) :
    Combined → Combined → Prop
  | refl (s : Combined) : PhysicalReach physical s s
  | step {s t u : Combined} :
      physical s t →
      PhysicalReach physical t u →
      PhysicalReach physical s u

/-- The independent physical premises suffice to lift ALL banked
forward-genesis paths to actual *modelled* physical steps, not
merely assert a distant endpoint exists. -/
theorem all_canonical_paths_are_physical
    (M : Nat) (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical)
    {s t : Combined}
    (hPath : CombinedReach M s t) :
    PhysicalReach physical s t := by
  have hEq := physical_source_step_iff_canonical
    M physical hRef hTotal
  induction hPath with
  | refl => exact PhysicalReach.refl _
  | @step s t u hFirst hRest ih =>
      exact PhysicalReach.step ((hEq s t).mpr hFirst) ih

/-- Sharpened summit: IF the actual physical law independently
enforces both forward-source admissibility and non-stalling at
every valid state, then arbitrary forward horizons are actually
reachable while retaining the same source Koru sector/handedness.
We do NOT assert these premises hold in the real universe. -/
theorem physically_forced_genesis_has_cofinal_Koru_histories
    (M e l : Nat) (o : Bool) (U : FiniteObjectiveU)
    (physical : SourceRelation)
    (hRef : RespectsCanonicalSource M physical)
    (hTotal : NoTerminalPhysicalState M physical)
    (hl : l ≤ M) (hKoru : WholeHasIntrinsicKoru U) :
    ∀ N : Nat, ∃ t : Combined,
      PhysicalReach physical ((e, l, o), U) t ∧
      N ≤ combinedCausal M t ∧
      combinedHandedness t = o ∧
      WholeHasIntrinsicKoru t.2 := by
  intro N
  obtain ⟨t, hReach, hRank, hHand, hKeep⟩ :=
    forward_genesis_reaches_arbitrarily_far_with_Koru
      M e l o U hl hKoru N
  exact ⟨t,
    all_canonical_paths_are_physical M physical hRef hTotal hReach,
    hRank, hHand, hKeep⟩

/-! ## Hostile: reversible whole W and unflipped arrow are NOT enough.

Construct an independently specified physical relation allowing
only actual interior local steps and W, with NO epoch transition.
It has one nontrivial event, strictly advances the causal order,
never flips orientation, preserves Koru; yet the terminus has no
physical successor. This directly falsifies the implication
W-cyclicity + right-handedness + Koru preservation => genesis.
-/

/-- A real source step with interior-only motion: same exact W
update but NO permission for genesis at the arrow maximum. -/
def interiorOnlyPhysical (M : Nat) : SourceRelation :=
  fun s t =>
    PhysicalBridges.CyclicGenesisBoundary.localStep M s.1 t.1 ∧
    t.2 = objectiveStep s.2

theorem interior_only_refines_canonical (M : Nat) :
    RespectsCanonicalSource M (interiorOnlyPhysical M) := by
  intro s t h
  exact ⟨Or.inl h.1, h.2⟩

/-- The hostile relation is NOT the empty event set. -/
theorem interior_only_has_a_genuine_forward_W_event :
    interiorOnlyPhysical 1
      ((0, 0, true), ordinaryObjective)
      ((0, 1, true), objectiveStep ordinaryObjective) := by
  exact ⟨⟨by decide, rfl⟩, rfl⟩

/-- Every permitted hostile physical event strictly advances the
same historical causal rank. It is not a backward-time cheat. -/
theorem interior_only_is_causally_forward
    (M : Nat) (s t : Combined)
    (h : interiorOnlyPhysical M s t) :
    combinedCausal M s < combinedCausal M t :=
  each_combined_event_is_causally_forward M s t
    (interior_only_refines_canonical M s t h)

/-- No mirror at all: the hostile model preserves the same
right-pointing handedness under all its actual events. -/
theorem interior_only_preserves_handedness
    (M : Nat) (s t : Combined)
    (h : interiorOnlyPhysical M s t) :
    combinedHandedness t = combinedHandedness s :=
  each_combined_event_preserves_right_handedness M s t
    (interior_only_refines_canonical M s t h)

/-- The independent original-Koru source property is exact along
every permitted hostile physical event. -/
theorem interior_only_preserves_original_Koru
    (M : Nat) (s t : Combined)
    (h : interiorOnlyPhysical M s t) :
    WholeHasIntrinsicKoru t.2 ↔ WholeHasIntrinsicKoru s.2 :=
  each_combined_event_preserves_original_Koru M s t
    (interior_only_refines_canonical M s t h)

/-- Yet at an epoch's heat-death terminus no physical successor
exists in this otherwise lawful, forward, whole-W/Koru-preserving
model. This is a *genuine finite dead end*, not time reversal. -/
theorem interior_only_really_stops_at_terminus
    (M e : Nat) (o : Bool) (U : FiniteObjectiveU) :
    ¬ ∃ t : Combined, interiorOnlyPhysical M ((e, M, o), U) t := by
  rintro ⟨t, h⟩
  have hlt : M < M := h.1.1
  exact (Nat.lt_irrefl M) hlt

/-- The constructed physical relation REFUTES the claim that
whole W recurrence, original Koru, forward causal arrow and
unflipped handedness imply non-stalling at the terminus. -/
theorem source_recurrence_and_right_hand_do_not_force_genesis :
    WholeHasIntrinsicKoru ordinaryObjective ∧
    objectiveStep (objectiveStep ordinaryObjective) = ordinaryObjective ∧
    (∀ s t : Combined, interiorOnlyPhysical 1 s t →
      combinedCausal 1 s < combinedCausal 1 t ∧
      combinedHandedness t = combinedHandedness s ∧
      (WholeHasIntrinsicKoru t.2 ↔ WholeHasIntrinsicKoru s.2)) ∧
    interiorOnlyPhysical 1
      ((0, 0, true), ordinaryObjective)
      ((0, 1, true), objectiveStep ordinaryObjective) ∧
    ¬ ∃ t : Combined,
      interiorOnlyPhysical 1 ((0, 1, true), ordinaryObjective) t := by
  refine ⟨ordinary_source_world_has_nontrivial_Koru,
    objective_W_is_an_involution ordinaryObjective,
    ?_, interior_only_has_a_genuine_forward_W_event,
    interior_only_really_stops_at_terminus 1 0 true ordinaryObjective⟩
  intro s t h
  exact ⟨interior_only_is_causally_forward 1 s t h,
    interior_only_preserves_handedness 1 s t h,
    interior_only_preserves_original_Koru 1 s t h⟩

/-- In particular, SOURCE refinability alone cannot derive
the nonterminal physical premise; the hostile model supplies
the exact same source-W transport and Koru relations. -/
theorem source_refinement_does_not_force_physical_nonstalling :
    RespectsCanonicalSource 1 (interiorOnlyPhysical 1) ∧
      ¬ NoTerminalPhysicalState 1 (interiorOnlyPhysical 1) := by
  constructor
  · exact interior_only_refines_canonical 1
  · intro hTotal
    have hValid :
      PhysicalBridges.CyclicGenesisBoundary.localRank
        ((0, 1, true) : Interior) ≤ 1 := by decide
    exact interior_only_really_stops_at_terminus
      1 0 true ordinaryObjective (hTotal _ hValid)

#print axioms canonical_combined_successor_unique
#print axioms any_compatible_terminus_successor_is_genesis
#print axioms terminal_progress_iff_realised_genesis
#print axioms physical_no_terminal_forces_genesis
#print axioms canonical_source_is_total_on_valid_states
#print axioms physical_progress_forces_every_canonical_step
#print axioms physical_source_step_iff_canonical
#print axioms all_canonical_paths_are_physical
#print axioms physically_forced_genesis_has_cofinal_Koru_histories
#print axioms interior_only_has_a_genuine_forward_W_event
#print axioms interior_only_is_causally_forward
#print axioms interior_only_preserves_handedness
#print axioms interior_only_preserves_original_Koru
#print axioms interior_only_really_stops_at_terminus
#print axioms source_recurrence_and_right_hand_do_not_force_genesis
#print axioms source_refinement_does_not_force_physical_nonstalling

end PhysicalBridges.KoruGenesisPhysicalForcingFiretest
