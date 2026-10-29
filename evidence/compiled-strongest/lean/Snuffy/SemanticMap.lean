import Mathlib.Basic.Real.Basic
import Mathlib.Tactic.Ring

/-! Lossless physical coding is invariant under relabeling. An actual
grounding reference can remove the ambiguity; an information bound alone
does not select between these two bijections. -/
namespace GeminiThirteenSemantics

def flipped (b : Bool) : Bool := !b

theorem identity_is_bijective : Function.Bijective (fun b : Bool => b) :=
  ⟨fun _ _ h => h,fun b => ⟨b,rfl⟩⟩

theorem flipped_is_bijective : Function.Bijective flipped := by
  constructor
  · intro a b same
    cases a <;> cases b <;> simp [flipped] at same ⊢
  · intro b
    refine ⟨!b,?_⟩
    cases b <;> rfl

theorem two_distinct_lossless_maps : (fun b : Bool => b) ≠ flipped := by
  intro same
  have impossible : (false:Bool)=true := congrFun same false
  cases impossible

theorem calibrated_reference_fixes_binary_mapping (mapping : Bool → Bool)
    (injective : Function.Injective mapping) (calibrated : mapping false=false) :
    mapping=(fun b => b) := by
  funext b
  cases b with
  | false => exact calibrated
  | true =>
      cases actual : mapping true with
      | false =>
          have impossible : (true:Bool)=false := injective (actual.trans calibrated.symm)
          cases impossible
      | true => rfl

end GeminiThirteenSemantics

