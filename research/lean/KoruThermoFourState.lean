import Mathlib

/-!
# Four-state Koru thermodynamics witness (draft Lean formalization)

This file is a *proposed* kernel-checkable starting point. It has not yet
been compiled in the repository CI. It does not prove a universal physical
Koru law. Its finite-state calculations use exact rational probabilities.
-/

namespace KoruThermoFourState

def step : Fin 4 ≃ Fin 4 where
  toFun := fun i => ⟨(i.val + 1) % 4, Nat.mod_lt _ (by omega)⟩
  invFun := fun i => ⟨(i.val + 3) % 4, Nat.mod_lt _ (by omega)⟩
  left_inv := by
    intro i
    apply Fin.ext
    fin_cases i <;> decide
  right_inv := by
    intro i
    apply Fin.ext
    fin_cases i <;> decide

def initial : Fin 4 → ℚ
  | 0 => 1 / 2
  | 1 => 1 / 2
  | _ => 0

def evolved : Fin 4 → ℚ := fun i => initial (step.symm i)

def coarse (p : Fin 4 → ℚ) : Fin 4 → ℚ := fun i =>
  if i.val < 2 then (p 0 + p 1) / 2 else (p 2 + p 3) / 2

theorem initial_normalized : (∑ i : Fin 4, initial i) = 1 := by
  decide

theorem evolved_normalized : (∑ i : Fin 4, evolved i) = 1 := by
  decide

theorem coarse_initial : coarse initial = initial := by
  funext i
  fin_cases i <;> decide

theorem evolved_values :
    evolved 0 = 0 ∧ evolved 1 = 1 / 2 ∧
    evolved 2 = 1 / 2 ∧ evolved 3 = 0 := by
  decide

theorem coarse_evolved_uniform :
    coarse evolved = fun _ : Fin 4 => (1 / 4 : ℚ) := by
  funext i
  fin_cases i <;> decide

theorem step_injective : Function.Injective step := step.injective

/-!
Next: define Gibbs entropy with Real.log and prove
  S(evolved) = S(initial)
  S(coarse evolved) - S(coarse initial) = kB * Real.log 2 > 0.
The four-state algebra above deliberately does not claim those theorems
until they are checked. A further generalization needs Jensen's inequality.
-/

end KoruThermoFourState
