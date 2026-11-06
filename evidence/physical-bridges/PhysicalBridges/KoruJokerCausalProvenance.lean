import PhysicalBridges.KoruWholeUSubjectSixJoin
import PhysicalBridges.KoruWActionFixedSymmetry

/-!
# Joker: source-to-genesis causal dependence and the provenance obstruction

This is an exact, positive, AND adversarial test of the outstanding
"complete theory creates the next universe" claim. The existing
BCRD operator whole U supplies physically computed, not freely
provided, duty-shaped relation values. The original W generator
conserves them, but never CONSULTS their meaning to choose its step.

We therefore examine a separate candidate genesis selector whose
input is a specific relation computed from the SAME objective U.
It is NOT the original physical W law; no assertion is made that
actual physics implements this selector or that the source relation
authenticates a subject's consent. The selector is not a protection
certificate.

The result is two-sided:

POSITIVE: A truth value sourced internally from the actual complete
W operator whole can make a nontrivial difference to a model successor
rule, without adding a detached ethical bit. The rule transports the
original intrinsic whole-Koru property on both possible branches.

HOSTILE: The simplest such gate can MERGE two objectively distinct
parents into exactly one child. Preserving the Koru predicate alone
is not protecting complete per-particular provenance. Explicit
history-carrying data repairs this *mathematical* merge, not the
unproven real-world bridge.

FACTORISATION: Any next-physics law that factors through U alone
cannot respond to two detached ethical interpretations of the SAME U.
Conversely, full independence of such valuations is equivalent
to factorization. Enacting ethics in physics therefore needs
(1) genuine grounding of ethics in U or
(2) an independently sourced extended physical state and law.

No theorem here derives ALL ethics from Something IS, a globally
admissible action, a real multiverse, or authentic original six X3.
-/

namespace PhysicalBridges.KoruJokerCausalProvenance

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.KoruWholeUSixDutyWebJoin
open PhysicalBridges.KoruWActionFixedSymmetry
open PhysicalBridges.KoruWholeUDirectedAgency

/-- One authorization-SHAPED SOURCE question in the one complete
operator U: is the directed operator link 2 -> 3 present?
The role naming does NOT make this genuine consent. -/
def authorizationProbeRoles : SourceDutyRoles :=
  fun _ tag =>
    if tag = .authorization then ((2 : Index), (3 : Index))
    else ((3 : Index), (2 : Index))

def sourceAuthorizationProbe (U : FiniteObjectiveU) : Prop :=
  wholeSourceDutyAt U authorizationProbeRoles 0 (0 : Index)
    .authorization

/-- The probe is calculated from the actual operator-derived U.
It is not a detachable Boolean "safe"/"G"/"authorized" input. -/
theorem source_probe_is_intrinsic_operator_relation
    (U : FiniteObjectiveU) :
    sourceAuthorizationProbe U ↔
      (sourceWholeWeb U).link (2 : Index) (3 : Index) :=
  Iff.rfl

/-- Concrete positive intrinsic relation from the SAME nontrivial
complete-W Koru source used by merged #376 and #380. -/
theorem source_probe_true_at_Koru_witness :
    sourceAuthorizationProbe KoruWitnessObjective := by
  change (sourceWholeWeb KoruWitnessObjective).link
    (2 : Index) (3 : Index)
  exact (same_whole_has_positive_link_but_no_reverse
    0 (0 : Index)).1

/-- The physically generated actual W step transports the directed
relation to its opposite fixed slots: this source probe is now FALSE.
It is the fixed-location question that changes, not any lost
whole-Koru source fact. -/
theorem source_probe_false_after_actual_W :
    ¬ sourceAuthorizationProbe
      (objectiveStep KoruWitnessObjective) := by
  have hReverse :
      ¬ (sourceWholeWeb KoruWitnessObjective).link
        (3 : Index) (2 : Index) := by
    exact (same_whole_has_positive_link_but_no_reverse
      0 (0 : Index)).2
  have hCarried :=
    complete_objective_link_carriage
      KoruWitnessObjective (3 : Index) (2 : Index) 1
  have h32 : trackedPosition (3 : Index) 1 =
      (2 : Index) := by decide
  have h23 : trackedPosition (2 : Index) 1 =
      (3 : Index) := by decide
  have hExact :
      (sourceWholeWeb (objectiveStep KoruWitnessObjective)).link
        (2 : Index) (3 : Index) ↔
      (sourceWholeWeb KoruWitnessObjective).link
        (3 : Index) (2 : Index) := by
    simpa [objectiveAt, h32, h23] using hCarried
  intro hPresent
  have hForward :
      (sourceWholeWeb (objectiveStep KoruWitnessObjective)).link
        (2 : Index) (3 : Index) :=
    (source_probe_is_intrinsic_operator_relation
      (objectiveStep KoruWitnessObjective)).mp hPresent
  exact hReverse (hExact.mp hForward)

/-- This physical W pulse is genuinely non-identity, witnessed
by a change in one fixed-location source question. -/
theorem source_witness_actual_W_nonidentity :
    objectiveStep KoruWitnessObjective ≠ KoruWitnessObjective := by
  intro hEqual
  apply source_probe_false_after_actual_W
  rw [hEqual]
  exact source_probe_true_at_Koru_witness

/-- Candidate causal selector: physically computed source relation
chooses W or identity. This is a new MATHEMATICAL hypothesis, not
the independently derived frozen-W dynamics; both candidate maps
are already available in the exact source model. -/
noncomputable def sourceSelectedNext (U : FiniteObjectiveU) :
    FiniteObjectiveU := by
  classical
  exact if sourceAuthorizationProbe U then objectiveStep U else U

/-- The source truth genuinely triggers a nontrivial W update on
the original Koru-bearing witness. -/
theorem source_truth_selects_real_W :
    sourceSelectedNext KoruWitnessObjective =
      objectiveStep KoruWitnessObjective := by
  classical
  simp [sourceSelectedNext, source_probe_true_at_Koru_witness]

/-- Its actual evolved successor has a false fixed-location probe,
so the same candidate law now chooses a stationary whole. -/
theorem source_false_selects_identity :
    sourceSelectedNext (objectiveStep KoruWitnessObjective) =
      objectiveStep KoruWitnessObjective := by
  classical
  simp [sourceSelectedNext, source_probe_false_after_actual_W]

/-- Both mathematical choices preserve the ORIGINAL intrinsic
Koru property. This invariant is much weaker than full histories,
consent, six-X3 protection or physical enactment. -/
theorem source_selected_always_preserves_intrinsic_Koru
    (U : FiniteObjectiveU) :
    WholeHasIntrinsicKoru (sourceSelectedNext U) ↔
      WholeHasIntrinsicKoru U := by
  classical
  by_cases h : sourceAuthorizationProbe U
  · simpa [sourceSelectedNext, h] using
      (whole_Koru_existence_is_exact U)
  · simp [sourceSelectedNext, h]

/-- The positive model is NOT just syntactic: source status changes
the choice between a nontrivial W pulse and a stationary successor.
The original Koru of the complete source survives. -/
theorem sourced_causal_choice_is_nontrivial_and_Koru_persistent :
    sourceSelectedNext KoruWitnessObjective ≠
      KoruWitnessObjective ∧
    WholeHasIntrinsicKoru
      (sourceSelectedNext KoruWitnessObjective) := by
  constructor
  · rw [source_truth_selects_real_W]
    exact source_witness_actual_W_nonidentity
  · exact
      (source_selected_always_preserves_intrinsic_Koru
        KoruWitnessObjective).mpr
          real_source_Koru_witness_is_in_the_sector

/-- HOSTILE: despite source-dependent action selection and Koru
preservation, two distinct complete operator worlds can generate
exactly the SAME successor U, losing which parent occurred. -/
theorem source_gate_merges_distinct_parent_wholes :
    ∃ U V : FiniteObjectiveU,
      U ≠ V ∧ sourceSelectedNext U = sourceSelectedNext V := by
  refine ⟨KoruWitnessObjective,
    objectiveStep KoruWitnessObjective,
    source_witness_actual_W_nonidentity.symm, ?_⟩
  exact source_truth_selects_real_W.trans
    source_false_selects_identity.symm

/-- Thus source-sensitive generation is not automatically
injective or provenance-safe, even in this full-source test. -/
theorem sourced_selection_is_not_injective :
    ¬ Function.Injective sourceSelectedNext := by
  intro hInj
  obtain ⟨U, V, hNe, hEq⟩ :=
    source_gate_merges_distinct_parent_wholes
  exact hNe (hInj hEq)

/-- Minimal actual parent-to-child RECORD, deliberately retaining
the entire parent objective U alongside the successor. -/
noncomputable def parentAndChild (U : FiniteObjectiveU) :
    FiniteObjectiveU × FiniteObjectiveU :=
  (U, sourceSelectedNext U)

/-- A whole-parent provenance record repairs THIS information
loss. It does not prove experienced continuity or the original
six-X3 duties; those require independent semantic fidelity. -/
theorem parent_child_record_does_not_merge :
    Function.Injective parentAndChild := by
  intro U V h
  exact congrArg Prod.fst h

theorem child_only_loses_parent_but_full_record_preserves_it :
    (parentAndChild KoruWitnessObjective).2 =
      (parentAndChild (objectiveStep KoruWitnessObjective)).2 ∧
    (parentAndChild KoruWitnessObjective).1 ≠
      (parentAndChild (objectiveStep KoruWitnessObjective)).1 := by
  exact ⟨source_truth_selects_real_W.trans
      source_false_selects_identity.symm,
    source_witness_actual_W_nonidentity.symm⟩

/-! ## A SMALLER provenance repair: one intrinsic branch tag.

The parent-and-child full record is sufficient, but stores the ENTIRE
parent. Because our particular gate only distinguishes the two
branches (W and identity), a single bool recording which branch
was enacted is sufficient for this model's source injectivity.
This remains a model control, not a physical information-capacity
theorem about real universes.
-/

/-- The one-bit branch label is calculated from the SAME intrinsic
operator source. No user-supplied "guardian" or ethical truth bit. -/
noncomputable def sourceBranchTag (U : FiniteObjectiveU) : Bool := by
  classical
  exact if sourceAuthorizationProbe U then true else false

/-- Store the derived choice together with the next complete
physical source, NOT a verbatim copy of the whole parent U. -/
noncomputable def branchTaggedNext (U : FiniteObjectiveU) :
    Bool × FiniteObjectiveU :=
  (sourceBranchTag U, sourceSelectedNext U)

/-- Unlike the child-only selector, (actual branch, complete
successor source) is injective for EVERY modeled U. Within the
W branch, this is grounded in independently proved W injectivity;
within identity it follows directly; cross-branch collisions
are excluded by the genuine recorded branch distinction.

This is exact nonmerging at the OPERATOR-SOURCE level, not
continuous life, authentic consent or six-X3 proof. -/
theorem one_source_branch_bit_restores_injectivity :
    Function.Injective branchTaggedNext := by
  intro U V h
  have hTag : sourceBranchTag U = sourceBranchTag V :=
    congrArg Prod.fst h
  have hChild : sourceSelectedNext U = sourceSelectedNext V :=
    congrArg Prod.snd h
  classical
  by_cases hU : sourceAuthorizationProbe U
  · by_cases hV : sourceAuthorizationProbe V
    · apply objective_W_is_injective
      simpa [sourceSelectedNext, hU, hV] using hChild
    · have hImpossible : (true : Bool) = false := by
        simpa [sourceBranchTag, hU, hV] using hTag
      cases hImpossible
  · by_cases hV : sourceAuthorizationProbe V
    · have hImpossible : (false : Bool) = true := by
        simpa [sourceBranchTag, hU, hV] using hTag
      cases hImpossible
    · simpa [sourceSelectedNext, hU, hV] using hChild

theorem branch_bit_distinguishes_merged_complete_wholes :
    branchTaggedNext KoruWitnessObjective ≠
      branchTaggedNext (objectiveStep KoruWitnessObjective) := by
  intro h
  have hSame := one_source_branch_bit_restores_injectivity h
  exact source_witness_actual_W_nonidentity hSame.symm

/-- If we drop that single branch label again, the same source
parent collision returns. It is a genuine information difference
between the richer child and its untagged projection. -/
theorem forgetting_branch_bit_again_loses_provenance :
    ¬ Function.Injective
      (fun U : FiniteObjectiveU => (branchTaggedNext U).2) := by
  change ¬ Function.Injective sourceSelectedNext
  exact sourced_selection_is_not_injective

/-- A genealogy step whose child actually retains the enacted
source branch has an identifiable predecessor: two candidate
parents cannot generate the very same whole tagged successor. -/
abbrev TaggedCandidateWorld :=
  Int × (Bool × FiniteObjectiveU)

def branchTaggedGenesis
    (s : Int × FiniteObjectiveU)
    (t : TaggedCandidateWorld) : Prop :=
  t.1 = s.1 + 1 ∧ t.2 = branchTaggedNext s.2

theorem complete_tagged_successor_has_unique_parent
    (s r : Int × FiniteObjectiveU) (t : TaggedCandidateWorld)
    (hs : branchTaggedGenesis s t)
    (hr : branchTaggedGenesis r t) :
    s = r := by
  have hRank : s.1 = r.1 := by
    have hsRank : t.1 = s.1 + 1 := hs.1
    have hrRank : t.1 = r.1 + 1 := hr.1
    omega
  have hWhole : s.2 = r.2 :=
    one_source_branch_bit_restores_injectivity
      (hs.2.symm.trans hr.2)
  exact Prod.ext hRank hWhole

theorem branch_tagged_genesis_preserves_source_Koru
    (s : Int × FiniteObjectiveU) (t : TaggedCandidateWorld)
    (h : branchTaggedGenesis s t) :
    WholeHasIntrinsicKoru t.2.2 ↔
      WholeHasIntrinsicKoru s.2 := by
  rw [h.2]
  exact source_selected_always_preserves_intrinsic_Koru s.2

/-! ## All ethics and exact physical causal-dependence criterion.

EthicalValuation E may represent arbitrarily many ethical claims.
Its truth values are passed independently of U, specifically to
test whether they can influence a U-only physical law.
-/

abbrev EthicalValuation (E : Type) := E → Prop

def FactorsThroughObjectiveU {E : Type}
    (next : FiniteObjectiveU → EthicalValuation E →
      FiniteObjectiveU) : Prop :=
  ∃ F : FiniteObjectiveU → FiniteObjectiveU,
    ∀ U v, next U v = F U

def DetachedEthicsIrrelevant {E : Type}
    (next : FiniteObjectiveU → EthicalValuation E →
      FiniteObjectiveU) : Prop :=
  ∀ U v w, next U v = next U w

/-- Exact criterion: a physical successor ignores ALL independent
ethical valuations if and only if it factors through objective U.
The candidate ethical-claim domain E is completely arbitrary.
This is a FACTORIZATION theorem, not an assertion that ethics
is objectively arbitrary. -/
theorem physical_factorization_iff_detached_ethics_irrelevant
    {E : Type}
    (next : FiniteObjectiveU → EthicalValuation E →
      FiniteObjectiveU) :
    FactorsThroughObjectiveU next ↔ DetachedEthicsIrrelevant next := by
  constructor
  · rintro ⟨F, h⟩ U v w
    calc
      next U v = F U := h U v
      _ = next U w := (h U w).symm
  · intro h
    refine ⟨fun U => next U (fun _ => True), ?_⟩
    intro U v
    exact h U v (fun _ => True)

/-- Frozen W source evolution is determined by the existing
complete source itself, independent of a detached moral ledger.
This is why simply CARRYING E→Prop in a seed does not make it
physically causative. -/
def originalWWithDetachedEthics {E : Type}
    (U : FiniteObjectiveU) (_ : EthicalValuation E) :
    FiniteObjectiveU := objectiveStep U

theorem canonical_W_ignores_detached_ethics {E : Type} :
    DetachedEthicsIrrelevant
      (originalWWithDetachedEthics (E := E)) := by
  intro U v w
  rfl

/-- A detached moral flag CAN be made to affect a constructed
successor law—but only by introducing NEW physical enactment
semantics. This is a positive mathematical witness to causal
dependence, not proof the universe uses the rule. -/
noncomputable def detachedFlagControlledNext
    (U : FiniteObjectiveU) (v : EthicalValuation Unit) :
    FiniteObjectiveU := by
  classical
  exact if v () then objectiveStep U else U

theorem detached_flag_has_genuine_successor_effect :
    detachedFlagControlledNext KoruWitnessObjective
        (fun _ => True) ≠
      detachedFlagControlledNext KoruWitnessObjective
        (fun _ => False) := by
  classical
  simpa [detachedFlagControlledNext] using
    source_witness_actual_W_nonidentity

theorem valuation_sensitive_successor_cannot_factor_via_U :
    ¬ FactorsThroughObjectiveU detachedFlagControlledNext := by
  intro hFactors
  have hEq :=
    (physical_factorization_iff_detached_ethics_irrelevant
      detachedFlagControlledNext).mp hFactors
  exact detached_flag_has_genuine_successor_effect
    (hEq KoruWitnessObjective
      (fun _ => True) (fun _ => False))

/-- Conversely, an operator-INTERNAL gate factors through U,
because its value is actually calculated from U, not from a
freestanding ethical report. It STILL must be physically sourced
and authenticated before anyone calls it an ethical mechanism. -/
noncomputable def sourceInternalNextWithEthics {E : Type}
    (U : FiniteObjectiveU) (_ : EthicalValuation E) :
    FiniteObjectiveU := sourceSelectedNext U

theorem internally_sourced_gate_factors_through_whole {E : Type} :
    FactorsThroughObjectiveU
      (sourceInternalNextWithEthics (E := E)) := by
  refine ⟨sourceSelectedNext, ?_⟩
  intro U v
  rfl

/-! ## Forward-only modeled genesis with a source-sensitive choice. -/

abbrev CandidateWorld := Int × FiniteObjectiveU

def candidateGenesis (s t : CandidateWorld) : Prop :=
  t.1 = s.1 + 1 ∧ t.2 = sourceSelectedNext s.2

theorem candidate_genesis_has_forward_successor (s : CandidateWorld) :
    ∃ t : CandidateWorld, candidateGenesis s t := by
  exact ⟨(s.1 + 1, sourceSelectedNext s.2), rfl, rfl⟩

theorem candidate_genesis_is_strictly_forward
    {s t : CandidateWorld} (h : candidateGenesis s t) :
    s.1 < t.1 := by
  have hRank : t.1 = s.1 + 1 := h.1
  omega

theorem candidate_genesis_preserves_source_Koru
    {s t : CandidateWorld} (h : candidateGenesis s t) :
    WholeHasIntrinsicKoru t.2 ↔ WholeHasIntrinsicKoru s.2 := by
  rw [h.2]
  exact source_selected_always_preserves_intrinsic_Koru s.2

/-- The same child at epoch 1 is generated by TWO different
whole-source parents at epoch 0. Even right-handed forward
time and a persistent Koru do not repair lost provenance. -/
theorem two_distinct_operators_generate_one_candidate_child :
    ∃ s t c : CandidateWorld,
      s ≠ t ∧ candidateGenesis s c ∧ candidateGenesis t c := by
  let s : CandidateWorld := (0, KoruWitnessObjective)
  let t : CandidateWorld := (0, objectiveStep KoruWitnessObjective)
  let c : CandidateWorld := (1, objectiveStep KoruWitnessObjective)
  refine ⟨s, t, c, ?_, ?_, ?_⟩
  · intro h
    apply source_witness_actual_W_nonidentity
    exact congrArg Prod.snd h |>.symm
  · exact ⟨rfl, source_truth_selects_real_W.symm⟩
  · exact ⟨rfl, source_false_selects_identity.symm⟩

#print axioms source_probe_true_at_Koru_witness
#print axioms source_probe_false_after_actual_W
#print axioms source_witness_actual_W_nonidentity
#print axioms sourced_causal_choice_is_nontrivial_and_Koru_persistent
#print axioms source_gate_merges_distinct_parent_wholes
#print axioms parent_child_record_does_not_merge
#print axioms child_only_loses_parent_but_full_record_preserves_it
#print axioms one_source_branch_bit_restores_injectivity
#print axioms branch_bit_distinguishes_merged_complete_wholes
#print axioms forgetting_branch_bit_again_loses_provenance
#print axioms complete_tagged_successor_has_unique_parent
#print axioms branch_tagged_genesis_preserves_source_Koru
#print axioms physical_factorization_iff_detached_ethics_irrelevant
#print axioms canonical_W_ignores_detached_ethics
#print axioms valuation_sensitive_successor_cannot_factor_via_U
#print axioms internally_sourced_gate_factors_through_whole
#print axioms candidate_genesis_preserves_source_Koru
#print axioms two_distinct_operators_generate_one_candidate_child

end PhysicalBridges.KoruJokerCausalProvenance
