import PhysicalBridges.CathedralSummitAllIsOneClosure
import PhysicalBridges.AllIsGActualityDischarge

/-!
# Hostile review of `CathedralSummitAllIsOneClosure` and Part XV.3

Kernel-checked countermodels. Each tests a specific claim made for the closure, for the
curtailment-collapse derivation, or for the "severing is undefined" claim. These are
statements about the stated inferences and encodings. They make no claim about the world.
-/

namespace PhysicalBridges.HostileReviewClosureCountermodels

open PhysicalBridges.Koru
open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.AllIsGActualityDischarge

/-! ## 1. The closure does not discharge `RouteBSummit` -/

/-- A valid instrument with no real steps and no X3-protected state. -/
def emptyInstrument : MeasuredInstrument Unit where
  step := fun _ _ => False
  keeper := fun _ _ => False
  ender := fun _ _ => False
  recoverable := fun _ _ => False
  intercepted := fun _ _ => False
  coherent := fun _ _ => False
  coherentPowerFenced := fun _ _ => False
  continues := fun _ _ => False
  authorized := fun _ _ => False
  x3State := fun _ => False
  effect := fun _ _ => 0
  threshold := fun _ _ => 0
  detLat := fun _ _ => 0
  irrevDeadline := fun _ _ => 0
  reqWork := fun _ _ => 0
  availWork := fun _ _ => 0
  classifies := fun _ _ h => h.elim
  keeperExclusive := fun _ _ h => h.elim
  e9Coverage := fun _ _ h => h.elim
  keeperEffectBounded := fun _ _ h => h.elim
  recoverableEffectBounded := fun _ _ h => h.elim
  detectionBudget := fun _ _ h => h.elim
  interceptedEffectBounded := fun _ _ h => h.elim
  coherentWorkOrFence := fun _ _ h => h.elim
  coherentWorkBound := fun _ _ h => h.elim
  coherentFenceBudget := fun _ _ h => h.elim
  coherentFenceEffectBounded := fun _ _ h => h.elim
  controlCorrect := fun _ _ h => h.elim
  stateCarry := fun _ _ h => h.elim

/-- `RouteBSummit` is false of this instrument, while the closure's
`routeB_summit_ontological` still holds. So the closure cannot be its discharge. -/
theorem closure_does_not_discharge_routeB :
    (∀ x : Unit, LossOf x → False) ∧ ¬ RouteBSummit emptyInstrument :=
  ⟨routeB_summit_ontological, fun h => h ⟨()⟩ ()⟩

/-! ## 2. The closure's proof is label-independent -/

/-- Give a *protective* objective the same `Empty` field and the identical proof "shows" that
no protective objective exists. The proof uses the empty field, not the meaning of the label. -/
structure ProtectiveObjective (P : Type u) where
  target : P
  realised : NonBeing

theorem no_protective_objective {P : Type u} : ProtectiveObjective P → False :=
  fun o => nomatch o.realised

/-- Define a harmful objective without an `Empty` field and it is inhabited in any nonempty
domain. The encoding decides the outcome. -/
structure HarmObjective (P : Type u) where
  harmer : P
  target : P

theorem harm_objective_inhabited {P : Type u} (witness : P) : Nonempty (HarmObjective P) :=
  ⟨⟨witness, witness⟩⟩

/-! ## 3. P1 + P2 allow a permanent non-reciprocal relation (Part XV.3) -/

/-- One directed edge: `false` constrains `true`, and nothing runs back. -/
def curtailed : Web Bool where
  link := fun a b => a = false ∧ b = true

/-- P2 holds of this web. -/
theorem curtailed_relationally_constituted : RelationallyConstituted curtailed := by
  intro a b hrow _
  have h := hrow true
  cases a <;> cases b <;> simp [curtailed] at h ⊢

/-- The relation is non-reciprocal. -/
theorem curtailed_non_reciprocal :
    curtailed.link false true ∧ ¬ curtailed.link true false := by
  simp [curtailed]

/-- The whole-web swap, which re-indexes into the other position's frame. -/
def swap : Reindex Bool where
  to := not
  inv := not
  left := by intro x; cases x <;> rfl
  right := by intro x; cases x <;> rfl

/-- In the re-indexed frame the relation is still an ordinary internal, non-reciprocal link.
No `A ∧ ¬A` arises. -/
theorem reindexed_frame_consistent :
    (reindexWeb swap curtailed).link true false ∧
      ¬ (reindexWeb swap curtailed).link false true := by
  simp [reindexWeb, swap, curtailed]

/-- `koru_reindex_invariant` holds of this web, as it does of every web, so it excludes
no web at all. -/
theorem P1_holds_of_curtailed (a b : Bool) :
    koru (reindexWeb swap curtailed) (swap.to a) (swap.to b) ↔ koru curtailed a b :=
  koru_reindex_invariant swap curtailed a b

/-- The condition is permanent: a constant history holds it at every stage. -/
theorem curtailment_permanent :
    ∀ _n : Nat, curtailed.link false true ∧ ¬ curtailed.link true false :=
  fun _ => curtailed_non_reciprocal

/-! ## 4. Severing is a total, well-typed operation inside a closed web -/

/-- Remove every edge at `p`. Same positions, no exterior, always defined. -/
def sever {P : Type u} (w : Web P) (p : P) : Web P where
  link := fun x y => w.link x y ∧ x ≠ p ∧ y ≠ p

theorem sever_removes_all_edges {P : Type u} (w : Web P) (p x : P) :
    ¬ (sever w p).link p x ∧ ¬ (sever w p).link x p :=
  ⟨fun h => h.2.1 rfl, fun h => h.2.2 rfl⟩

#print axioms closure_does_not_discharge_routeB
#print axioms no_protective_objective
#print axioms harm_objective_inhabited
#print axioms curtailed_relationally_constituted
#print axioms curtailed_non_reciprocal
#print axioms reindexed_frame_consistent
#print axioms P1_holds_of_curtailed
#print axioms curtailment_permanent
#print axioms sever_removes_all_edges

end PhysicalBridges.HostileReviewClosureCountermodels
