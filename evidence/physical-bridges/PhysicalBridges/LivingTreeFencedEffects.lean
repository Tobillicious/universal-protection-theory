import PhysicalBridges.LivingTreeCoverageProvenance
import PhysicalBridges.FencedOptimiserInstrument

/-!
# Living Tree x Fenced Effects: complete joint modeled execution

Find-before-build assembly of the pre-existing learned Genesis tree
and independently constructed six-duty effect guard. Rather than
postulate a "safe physical reflection", we actually construct every
admitted effect transition by guarding an arbitrary proposal.

The joint world includes the full Tree model, modelled source, complete
ancestral log, indexed ethical claims, right-handed orientation, and the
fenced world's entire set of modeled particulars.

The guard guarantees are already proved (and hostile unfenced controls
exist). This integration does NOT establish a real-world complete
effects inventory, physical cosmological Genesis, authentic consent
or any universal physics-to-ethics correspondence.
No definitions of Koru, W, Genesis or original X3 are changed.
-/

namespace PhysicalBridges.LivingTreeFencedEffects

open PhysicalBridges.LivingTreeGenerations
open PhysicalBridges.LivingTreeCoverageProvenance
open PhysicalBridges.KoruJokerUniverseTrialFeedback
open PhysicalBridges.KoruObjectiveWholeU
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FullGuardianOrigin

variable {T H E : Type}

/-- All tree records and all modeled particular levels coexist in
one state, not a projection through the periodic W-source. -/
abbrev Joint (T H E : Type) (n : Nat) :=
  LivingTree T H E × World n

/-- Every admitted effect of the joint system is physically modeled as
a guarded optimiser proposal; learning alone cannot bypass the guard. -/
def jointStep {n : Nat}
    (J : JokerExperiment T FiniteObjectiveU H)
    (s t : Joint T H E n) : Prop :=
  ∃ a : Fin n → Nat,
    t.1 = cultivate J s.1 ∧
    t.2 = guard s.2 a

/-- Source-free protection certificate: every permitted joint effect
satisfies the ORIGINAL six X3 meanings on every modeled particular. -/
theorem every_joint_effect_has_all_original_six
    {n : Nat} (J : JokerExperiment T FiniteObjectiveU H)
    (s t : Joint T H E n)
    (h : jointStep J s t) :
    FullEvent (relations n) s.2 t.2 := by
  obtain ⟨a, _, ht⟩ := h
  rw [ht]
  intro p
  exact ⟨guard_continues s.2 a p,
    guard_authorized s.2 a p,
    guard_free s.2 a p,
    guard_restrained s.2 a p,
    guard_maximal s.2 a p,
    guard_provenanced s.2 a p⟩

/-- The independently constructed finite effect meter reads zero
on every admitted joint effect. -/
theorem every_joint_effect_has_zero_measured_residual
    {n : Nat} (J : JokerExperiment T FiniteObjectiveU H)
    (s t : Joint T H E n) (h : jointStep J s t) :
    residualHarm s.2 t.2 = 0 := by
  obtain ⟨a, _, ht⟩ := h
  rw [ht]
  exact guard_residual_zero s.2 a

/-- Even while the tree learns from its next universe, every
joint step preserves the old ancestry and carries full parent
history into the new seed. -/
theorem joint_effect_carries_tree_ancestors
    {n : Nat} (J : JokerExperiment T FiniteObjectiveU H)
    (s t : Joint T H E n) (h : jointStep J s t)
    (record : AncestralRecord T H)
    (hRecord : record ∈ s.1.ancestors) :
    record ∈ t.1.ancestors := by
  obtain ⟨_, hTree, _⟩ := h
  rw [hTree]
  exact every_ancestor_survives_one_revision J s.1 record hRecord

/-- This joint step has no missing modeled next state, for
ANY proposal supplied by an arbitrary optimizer. -/
theorem every_joint_proposal_has_a_realized_step
    {n : Nat} (J : JokerExperiment T FiniteObjectiveU H)
    (s : Joint T H E n) (a : Fin n → Nat) :
    jointStep J s (cultivate J s.1, guard s.2 a) := by
  exact ⟨a, rfl, rfl⟩

/-- The optimizer may inspect both current complete Tree and effect
state, and change its proposal at every epoch. -/
abbrev JointPolicy (T H E : Type) (n : Nat) :=
  Nat → Joint T H E n → Fin n → Nat

def runJoint {n : Nat}
    (J : JokerExperiment T FiniteObjectiveU H)
    (policy : JointPolicy T H E n)
    (initial : Joint T H E n) : Nat → Joint T H E n
  | 0 => initial
  | k + 1 =>
      let s := runJoint J policy initial k
      (cultivate J s.1, guard s.2 (policy k s))

/-- No independently asserted ethical safety premise: all modeled
effect-world steps are fenced by their explicit construction. -/
theorem every_adaptive_joint_stage_protected
    {n : Nat} (J : JokerExperiment T FiniteObjectiveU H)
    (policy : JointPolicy T H E n)
    (initial : Joint T H E n) :
    ∀ k,
      let s := runJoint J policy initial k
      let t := runJoint J policy initial (k + 1)
      jointStep J s t ∧
      FullEvent (relations n) s.2 t.2 ∧
      residualHarm s.2 t.2 = 0 ∧
      t.1.epoch = s.1.epoch + 1 ∧
      t.1.ancestors.length = s.1.ancestors.length + 1 := by
  intro k
  let s := runJoint J policy initial k
  let t := runJoint J policy initial (k + 1)
  have hStep : jointStep J s t :=
    every_joint_proposal_has_a_realized_step J s (policy k s)
  have hTree : t.1 = cultivate J s.1 := hStep.choose_spec.1
  have hSix := every_joint_effect_has_all_original_six J s t hStep
  have hResidual := every_joint_effect_has_zero_measured_residual J s t hStep
  refine ⟨hStep, hSix, hResidual, ?_, ?_⟩
  · rw [hTree]
    rfl
  · rw [hTree]
    rfl

#print axioms every_joint_effect_has_all_original_six
#print axioms every_joint_effect_has_zero_measured_residual
#print axioms joint_effect_carries_tree_ancestors
#print axioms every_joint_proposal_has_a_realized_step
#print axioms every_adaptive_joint_stage_protected

end PhysicalBridges.LivingTreeFencedEffects
