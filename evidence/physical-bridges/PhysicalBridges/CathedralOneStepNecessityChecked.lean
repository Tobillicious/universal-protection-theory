import PhysicalBridges.IR96DisturbanceSimulation
import PhysicalBridges.IR128EquivariantProcessEmbedding

/-!
Core-compatible port of original #203: `Function.Bijective` expanded
into `Function.Injective ∧ Function.Surjective`, identical proposition.
The original uncompiled candidate remains unchanged.
-/

/-!
CATHEDRAL BCRD — one-step necessity and information-preserving ender
countercontrol (research theorem candidate).

No Hamiltonians, Hilbert spaces or substituted UPT/X3 definitions.
This file explicitly distinguishes:
  - pure mathematical consistency of an internal transition,
  - an injective/equivariant BCRD source representation,
  - preservation of an independently specified physical predicate,
  - actual exhaustive physical-source refinement.

The new Lean candidate is UNCOMPILED here. Existing IR96, IR128, and
original UPT proofs have not been rewritten or replaced.
-/

namespace PhysicalBridges.CathedralOneStepNecessityChecked

universe u v
variable {S : Type u}

/-- An independently defined predicate is stable under each actual
    admitted transition. Do NOT define the source transition relation
    to be only P-preserving transitions without independent physics. -/
def StepPreserves (step : S → S → Prop) (P : S → Prop) : Prop :=
  ∀ a b, step a b → P a → P b

/-- All FINITE admitted paths preserve P, starting from a P-state.
    IR96.Reach comes directly from the previously checked source. -/
def EveryFiniteTracePreserves
    (step : S → S → Prop) (P : S → Prop) : Prop :=
  ∀ a b, IR96.Reach step a b → P a → P b

/-- Necessary AND sufficient one-step proof obligation:
    universal finite execution safety is exactly closure of the
    source-defined transition relation. This reduces infinitely
    many finite traces to ONE uniform actual-source step contract. -/
theorem all_finite_traces_iff_each_step
    (step : S → S → Prop) (P : S → Prop) :
    EveryFiniteTracePreserves step P ↔ StepPreserves step P := by
  constructor
  · intro h a b hab ha
    exact h a b
      (IR96.Reach.tail (IR96.Reach.refl a) hab) ha
  · intro h a b trace ha
    induction trace with
    | refl => exact ha
    | tail earlier edge ih =>
      exact h _ _ edge ih

/-- Exact hostile control: an invertible internal map may turn an
    explicitly marked active Boolean into an inactive Boolean.
    Mathematical reversibility is NOT subjective survival. -/
theorem invertible_map_can_change_activity :
    ∃ f : Bool → Bool,
      (Function.Injective f ∧ Function.Surjective f) ∧
      (∀ x : Bool, f (f x) = x) ∧
      f true = false := by
  refine ⟨Bool.not, ?_, ?_, rfl⟩
  · constructor
    · intro a b h
      cases a <;> cases b <;> simp_all
    · intro b
      exact ⟨Bool.not b, by cases b <;> rfl⟩
  · intro x
    cases x <;> rfl

/-- An injective, generator-equivariant map preserving all state
    distinctions can still fail the retained-live field of IR128's
    actual historical embedding certificate. That field is separate,
    and requires physical source evidence. -/
theorem injective_equivariance_does_not_force_live_retention :
    ∃ (p : IR128.Process Bool) (f : Bool → Bool),
      Function.Injective f ∧
      (∀ x, f (p.generator x) = p.generator (f x)) ∧
      (∃ x, p.live x ∧ ¬ p.live (f x)) := by
  let p : IR128.Process Bool := {
    live := fun b => b = true
    parent := fun _ _ => False
    generator := id
  }
  refine ⟨p, Bool.not, ?_, ?_, ?_⟩
  · intro a b h
    cases a <;> cases b <;> simp_all
  · intro x
    rfl
  · refine ⟨true, rfl, ?_⟩
    change ¬ ((false : Bool) = true)
    decide

/-- An actual physical source-to-execution join, *delegated* to the
    existing IR96 robust simulation theorem. Any purported full X3
    physical meaning must independently supply the predicates and
    the source/physical correspondence. -/
theorem admitted_physical_trace_inherits_source_predicate
    {Physical : Type v}
    (relate : S → Physical → Prop)
    (sourceStep : S → S → Prop)
    (physicalStep : Physical → Physical → Prop)
    (sourceP : S → Prop)
    (physicalP : Physical → Prop)
    (hCoverage : ∀ w p q,
       relate w p → physicalStep p q →
       ∃ w', sourceStep w w' ∧ relate w' q)
    (hPreservation : StepPreserves sourceStep sourceP)
    (hPhysicalReflect : ∀ w p,
       relate w p → sourceP w → physicalP p)
    (w : S) (p q : Physical)
    (hRelate : relate w p)
    (hInitially : sourceP w)
    (hTrace : IR96.Reach physicalStep p q) :
    physicalP q := by
  obtain ⟨_, _, _, hPhys⟩ :=
    IR96.robust_reach
      relate sourceStep physicalStep
      hCoverage sourceP physicalP hPreservation hPhysicalReflect
      w p q hRelate hInitially hTrace
  exact hPhys

end PhysicalBridges.CathedralOneStepNecessityChecked
