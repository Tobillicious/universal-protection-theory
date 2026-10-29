import Mathlib.Data.Fintype.Card
import Mathlib.Data.Finset.Card
import Mathlib.Tactic.Choose

/-! A constructive mathematical foundation for Gemini's E9 target. A declared
finite fault budget cannot hit every one of more disjoint certified routes.
The deadline theorem charges detection, reconfiguration and service on one clock.
Route/measurement fidelity and the physical fault budget are application witnesses.
-/
namespace UPTEpistemicRoutes

theorem surviving_disjoint_route {V : Type} [DecidableEq V] (faultBudget : Nat)
    (routes : Fin (faultBudget+1) → Finset V) (faults : Finset V)
    (separate : ∀ i j, i ≠ j → Disjoint (routes i) (routes j))
    (bounded : faults.card ≤ faultBudget) :
    ∃ i, Disjoint (routes i) faults := by
  classical
  by_contra none
  have hit : ∀ i, ∃ v, v ∈ routes i ∧ v ∈ faults := by
    intro i
    by_contra absent
    apply none
    refine ⟨i, Finset.disjoint_left.mpr ?_⟩
    intro v hv hf
    exact absent ⟨v,hv,hf⟩
  choose node inRoute inFaults using hit
  let selection : Fin (faultBudget+1) → ↥faults := fun i => ⟨node i, inFaults i⟩
  have injective : Function.Injective selection := by
    intro i j equality
    by_contra different
    have same : node i = node j := congrArg Subtype.val equality
    exact (Finset.disjoint_left.mp (separate i j different))
      (inRoute i) (by rw [same]; exact inRoute j)
  have cardinal := Fintype.card_le_of_injective selection injective
  simp only [Fintype.card_fin, Fintype.card_coe] at cardinal
  omega

theorem certified_repair_meets_deadline {V : Type} [DecidableEq V] (faultBudget : Nat)
    (routes : Fin (faultBudget+1) → Finset V) (faults : Finset V)
    (separate : ∀ i j, i ≠ j → Disjoint (routes i) (routes j))
    (bounded : faults.card ≤ faultBudget)
    (detection repair service : Fin (faultBudget+1) → Nat)
    (detectBound repairBound serviceBound deadline : Nat)
    (timing : ∀ i, Disjoint (routes i) faults →
      detection i ≤ detectBound ∧ repair i ≤ repairBound ∧ service i ≤ serviceBound)
    (fits : detectBound+repairBound+serviceBound ≤ deadline) :
    ∃ i, Disjoint (routes i) faults ∧ detection i+repair i+service i ≤ deadline := by
  obtain ⟨i,unhit⟩ := surviving_disjoint_route faultBudget routes faults separate bounded
  have bounds := timing i unhit
  refine ⟨i,unhit,?_⟩
  omega

end UPTEpistemicRoutes

