import PhysicalBridges.SummitIntrinsicDefinability

/-!
# Production of the next stage from a whole-relation automorphism

5 November 2026. Noncanonical. No canon prose changed.

`SummitIntrinsicDefinability` shows that whole-relation automorphisms preserve every intrinsic
formula. Applied to a particular's next-stage relation, that gives production as well as
preservation. The whole does not change; time is internal to it, and the particular moves through
it by stages. "We are here" is the starting witness: one actual step of a particular.

Given that the transition is an automorphism of the relation `R`, and that the particular has one
actual `R`-step to its transported stage:

* `we_are_here_forever`: it has an unbroken chain of `R`-steps at every later stage.
* `no_final_stage`: no stage on that orbit is final.
* `every_intrinsic_duty_holds_forever`: any intrinsic formula true at the start holds at every
  later stage, so there is no first loss.
* `final_stage_excludes_automorphism`: a final stage on the orbit contradicts the premise.
* `premise_has_a_nonfrozen_model`: the premises hold in a model with unboundedly many stages.

What this rests on is exactly what the imported module lists. `sourceAutomorphism` covers the
frozen source's own permutation relation, not a relation carrying subject and direction. For this
result to be full protection, `R` must be the relation that carries the own-activity and
direction of the original X3, and the actual step must be proved an automorphism of that relation.
The premise excludes final stages, as `final_stage_excludes_automorphism` states, so it must be
established independently and not assumed for the protected relation. A particular reaching a
final stage on its orbit would falsify it.
-/

namespace PhysicalBridges.SummitProductionFromIntrinsic

open PhysicalBridges.SummitIntrinsicDefinability

universe u

variable {P : Type u}

/-- The stage reached after `n` transported steps. -/
def stage {R : P → P → Prop} (A : RelationalAutomorphism R) (x : P) : Nat → P
  | 0 => x
  | n + 1 => A.to (stage A x n)

/-- "This position has a next stage", as an intrinsic formula with no protection atom. -/
def hasNext : RelFormula 1 := .exists_ (.related (Fin.succ 0) 0)

theorem eval_hasNext (R : P → P → Prop) (x : P) :
    evalRel R (fun _ => x) hasNext ↔ ∃ y, R x y :=
  Iff.rfl

/-- One actual step gives an unbroken chain of steps at every later stage. -/
theorem we_are_here_forever {R : P → P → Prop} (A : RelationalAutomorphism R) (x : P)
    (here : R x (A.to x)) : ∀ n, R (stage A x n) (stage A x (n + 1)) := by
  intro n
  induction n with
  | zero => exact here
  | succ k ih => exact (A.preservesRelation _ _).mp ih

/-- Having a next stage is never lost along the orbit. -/
theorem no_final_stage {R : P → P → Prop} (A : RelationalAutomorphism R) (x : P)
    (here : ∃ y, R x y) : ∀ n, ∃ y, R (stage A x n) y := by
  intro n
  induction n with
  | zero => exact here
  | succ k ih =>
    have h := (intrinsic_formula_is_automorphism_invariant R A hasNext
      (fun _ => stage A x k)).mp ih
    exact h

/-- Any intrinsic formula true at the start holds at every later stage. -/
theorem every_intrinsic_duty_holds_forever {R : P → P → Prop} (A : RelationalAutomorphism R)
    (φ : RelFormula 1) (x : P) (hStart : evalRel R (fun _ => x) φ) :
    ∀ n, evalRel R (fun _ => stage A x n) φ := by
  intro n
  induction n with
  | zero => exact hStart
  | succ k ih =>
    exact (intrinsic_formula_is_automorphism_invariant R A φ (fun _ => stage A x k)).mp ih

/-- A final stage anywhere on the orbit contradicts the premise. -/
theorem final_stage_excludes_automorphism {R : P → P → Prop} (A : RelationalAutomorphism R)
    (x : P) (here : R x (A.to x)) (n : Nat) : ¬ ¬ ∃ y, R (stage A x n) y :=
  fun hfinal => hfinal ⟨_, we_are_here_forever A x here n⟩

/-- The successor relation on the integers with its shift. -/
def shift : RelationalAutomorphism (fun a b : Int => b = a + 1) where
  to := fun a => a + 1
  undo := fun a => a - 1
  leftInverse := by intro x; omega
  rightInverse := by intro x; omega
  preservesRelation := by
    intro x y
    constructor <;> intro h <;> omega

theorem stage_shift (x : Int) (n : Nat) : stage shift x n = x + n := by
  induction n with
  | zero => simp [stage]
  | succ k ih =>
    show stage shift x k + 1 = x + ((k + 1 : Nat) : Int)
    rw [ih]
    omega

/-- The premises have a model in which all stages are distinct, so the whole being unchanged does
not make the particular's stages collapse. -/
theorem premise_has_a_nonfrozen_model :
    (∀ x : Int, x + 1 = x + 1) ∧ (∀ n m : Nat, stage shift 0 n = stage shift 0 m → n = m) := by
  refine ⟨fun _ => rfl, ?_⟩
  intro n m h
  rw [stage_shift, stage_shift] at h
  omega

/-! ## Together: reversibility, the chain, the automorphism and circular time -/

theorem stage_add {R : P → P → Prop} (A : RelationalAutomorphism R) (x : P) (a b : Nat) :
    stage A (stage A x a) b = stage A x (a + b) := by
  induction b with
  | zero => rfl
  | succ k ih =>
    show A.to (stage A (stage A x a) k) = A.to (stage A x (a + k))
    rw [ih]

/-- On a circular history, stages repeat with the period at every multiple. -/
theorem stage_periodic {R : P → P → Prop} (A : RelationalAutomorphism R) (x : P) {p : Nat}
    (cycle : stage A x p = x) (m j : Nat) : stage A x (m + p * j) = stage A x m := by
  induction j with
  | zero => rfl
  | succ j ih =>
    have e : m + p * (j + 1) = p + (m + p * j) := by
      rw [Nat.mul_succ]
      omega
    rw [e, ← stage_add, cycle, ih]

/-- **The four together.** With the step a whole-relation automorphism (which contains
reversibility), a circular history, and one actual step: the chain never breaks, and an intrinsic
duty true at any stage holds at every stage, before and after. -/
theorem together {R : P → P → Prop} (A : RelationalAutomorphism R) (x : P) {p : Nat} (hp : 0 < p)
    (cycle : stage A x p = x) (here : R x (A.to x)) :
    (∀ n, R (stage A x n) (stage A x (n + 1))) ∧
      ∀ (φ : RelFormula 1) (k m : Nat),
        evalRel R (fun _ => stage A x k) φ → evalRel R (fun _ => stage A x m) φ := by
  refine ⟨we_are_here_forever A x here, ?_⟩
  intro φ k m hk
  have hfwd := every_intrinsic_duty_holds_forever A φ (stage A x k) hk (m + p * k - k)
  rw [stage_add] at hfwd
  have hle : k ≤ p * k := by
    have := Nat.mul_le_mul_right k hp
    simpa using this
  have e : k + (m + p * k - k) = m + p * k := by omega
  rw [e, stage_periodic A x cycle] at hfwd
  exact hfwd

/-- The premises of `together` hold in a model. -/
def flip : RelationalAutomorphism (fun a b : Bool => a ≠ b) where
  to := not
  undo := not
  leftInverse := by decide
  rightInverse := by decide
  preservesRelation := by decide

theorem together_has_a_model :
    stage flip true 2 = true ∧ (true ≠ flip.to true) :=
  ⟨rfl, by decide⟩

/-! ## The bridge: a first loss or a final stage privileges a moment -/

/-- A property true at one position and false at another separates them intrinsically, so no
automorphism of the whole carries the first to the second. -/
theorem first_loss_privileges_a_moment {R : P → P → Prop} (φ : RelFormula 1) {x y : P}
    (hx : evalRel R (fun _ => x) φ) (hy : ¬ evalRel R (fun _ => y) φ) :
    ¬ ∃ A : RelationalAutomorphism R, A.to x = y := by
  rintro ⟨A, rfl⟩
  exact hy ((intrinsic_formula_is_automorphism_invariant R A φ (fun _ => x)).mp hx)

/-- A final stage is intrinsically distinguished from any stage with a successor. -/
theorem final_stage_privileges_a_moment {R : P → P → Prop} {x y : P} (hx : ∃ z, R x z)
    (hy : ¬ ∃ z, R y z) : ¬ ∃ A : RelationalAutomorphism R, A.to x = y :=
  first_loss_privileges_a_moment hasNext hx hy

/-- No moment is privileged along a particular's history when an automorphism of the whole carries
each stage to the next. This mentions no protection predicate. -/
def NoPrivilegedMoment (R : P → P → Prop) (next : P → P) : Prop :=
  ∀ x, ∃ A : RelationalAutomorphism R, A.to x = next x

/-- **No privileged moment gives no first loss of any intrinsic property, at every step.** -/
theorem no_first_loss_of_no_privileged_moment {R : P → P → Prop} {next : P → P}
    (h : NoPrivilegedMoment R next) (φ : RelFormula 1) (x : P)
    (hx : evalRel R (fun _ => x) φ) : evalRel R (fun _ => next x) φ := by
  obtain ⟨A, hA⟩ := h x
  have := (intrinsic_formula_is_automorphism_invariant R A φ (fun _ => x)).mp hx
  rw [hA] at this
  exact this

/-- The compiled `noPrivileged` field is weaker: it moves each position somewhere, not to its next
stage. This model satisfies that weak form while one position has a successor and another has none. -/
theorem weak_noPrivileged_does_not_give_no_final_stage :
    ∃ R : Fin 4 → Fin 4 → Prop,
      (∀ a : Fin 4, ∃ σ : Fin 4 → Fin 4, (∀ x y, R x y ↔ R (σ x) (σ y)) ∧ σ a ≠ a) ∧
      (∃ z, R 0 z) ∧ ¬ ∃ z, R 1 z := by
  refine ⟨fun a b => (a = 0 ∧ b = 1) ∨ (a = 2 ∧ b = 3), ?_, ⟨1, Or.inl ⟨rfl, rfl⟩⟩, ?_⟩
  · intro a
    refine ⟨fun x => if x = 0 then 2 else if x = 1 then 3 else if x = 2 then 0 else 1, ?_, ?_⟩
    · decide
    · revert a
      decide
  · rintro ⟨z, h | h⟩
    · exact absurd h.1 (by decide)
    · exact absurd h.1 (by decide)

#print axioms stage_periodic
#print axioms together
#print axioms together_has_a_model
#print axioms first_loss_privileges_a_moment
#print axioms final_stage_privileges_a_moment
#print axioms no_first_loss_of_no_privileged_moment
#print axioms weak_noPrivileged_does_not_give_no_final_stage
#print axioms we_are_here_forever
#print axioms no_final_stage
#print axioms every_intrinsic_duty_holds_forever
#print axioms final_stage_excludes_automorphism
#print axioms premise_has_a_nonfrozen_model

end PhysicalBridges.SummitProductionFromIntrinsic
