import PhysicalBridges.WholeSourceSemanticVisibility
import PhysicalBridges.G3ActualOnlyReflection

/-!
# Actual-event thermodynamic semantic visibility
Reuse the existing exact fibre criterion on the subtype of actual owed
event/particular triples. Observation fidelity and positivity are separate:
neither is inferred from thermodynamic conservation alone.
-/
namespace PhysicalBridges.GPTThermodynamicActualSix

open PhysicalBridges.WholeSourceSemanticVisibility
open PhysicalBridges.OriginalX3Full

def ActualOwed (S P : Type) (actual : S → S → Prop)
    (owed : S → S → P → Prop) :=
  { e : S × S × P // actual e.1 e.2.1 ∧ owed e.1 e.2.1 e.2.2 }

theorem actual_duty_visibility_iff
    {S P O : Type} {actual : S → S → Prop} {owed : S → S → P → Prop}
    (observe : ActualOwed S P actual owed → O)
    (duty : S → S → P → Prop) :
    (∃ readout : O → Prop, ∀ e, readout (observe e) ↔ duty e.val.1 e.val.2.1 e.val.2.2) ↔
    (∀ x y, observe x = observe y →
      (duty x.val.1 x.val.2.1 x.val.2.2 ↔ duty y.val.1 y.val.2.1 y.val.2.2)) :=
  semantic_factors_through_observation_iff_fibre_constant observe
    (fun e => duty e.val.1 e.val.2.1 e.val.2.2)

/-- Six independently faithful AND positive readouts suffice, with
no obligation on ghost modeled transitions. -/
theorem actual_positive_readouts_yield_original_six
    {S P O : Type} {actual : S → S → Prop} {owed : S → S → P → Prop}
    (observe : ActualOwed S P actual owed → O)
    (c a f r m p : S → S → P → Prop)
    (rc ra rf rr rm rp : O → Prop)
    (hc : ∀ e, rc (observe e) ↔ c e.val.1 e.val.2.1 e.val.2.2)
    (ha : ∀ e, ra (observe e) ↔ a e.val.1 e.val.2.1 e.val.2.2)
    (hf : ∀ e, rf (observe e) ↔ f e.val.1 e.val.2.1 e.val.2.2)
    (hr : ∀ e, rr (observe e) ↔ r e.val.1 e.val.2.1 e.val.2.2)
    (hm : ∀ e, rm (observe e) ↔ m e.val.1 e.val.2.1 e.val.2.2)
    (hp : ∀ e, rp (observe e) ↔ p e.val.1 e.val.2.1 e.val.2.2)
    (positive : ∀ e, rc (observe e) ∧ ra (observe e) ∧ rf (observe e) ∧
      rr (observe e) ∧ rm (observe e) ∧ rp (observe e)) :
    ∀ s t x, actual s t → owed s t x → OriginalX3 c a f r m p s t x := by
  intro s t x ht hx
  let e : ActualOwed S P actual owed := ⟨(s, t, x), ht, hx⟩
  obtain ⟨pc, pa, pf, pr, pm, pp⟩ := positive e
  exact ⟨(hc e).mp pc, (ha e).mp pa, (hf e).mp pf,
    (hr e).mp pr, (hm e).mp pm, (hp e).mp pp⟩

#print axioms actual_duty_visibility_iff
#print axioms actual_positive_readouts_yield_original_six

end PhysicalBridges.GPTThermodynamicActualSix
