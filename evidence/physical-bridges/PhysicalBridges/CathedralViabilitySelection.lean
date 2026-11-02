import PhysicalBridges.IRInfiniteHistoryCompactness

/-!
CATHEDRAL-SELECT-01 — the existing IR-72 infinite robust-viability theorem
does NOT imply that all actual physical policies select its safe option.

This file is an UNCOMPILED Lean candidate. It imports, rather than
re-proves, the original IR-72 theorem. No Hamiltonians or Hilbert spaces,
no weakened X3, and no insertion of an original UPT protection axiom.
-/

namespace PhysicalBridges.CathedralViabilitySelection

open IRViability IRInfiniteHistoryCompactness

universe u v w
variable {S : Type u} {D : Type v} {Physical : Type w}

/-- POSITIVE source-to-physical join:
    IR-72 derives ONE robust policy from all finite horizons with Bool
    actions. If every modeled state on that policy's trajectory is
    matched to its real physical state, and source 'safe' correctly
    reflects to an independently grounded real physical predicate,
    then there exists one physically safe policy for all natural times.
    The physical correspondence and interpretation are obligations. -/
theorem extracted_policy_has_physical_safety_when_reflected
    (safeSource : S → Prop)
    (next : S → Bool → D → S)
    (initial : S)
    (hForever : ForeverViable safeSource next initial)
    (physicalAt : (S → Bool) → (Nat → D) → Nat → Physical)
    (relates : S → Physical → Prop)
    (physicalSafe : Physical → Prop)
    (hCorresponds : ∀ policy stream n,
      relates (stateAt next policy stream initial n)
        (physicalAt policy stream n))
    (hReflect : ∀ s p, relates s p →
       safeSource s → physicalSafe p) :
    ∃ policy : S → Bool,
      ∀ stream : Nat → D, ∀ n : Nat,
        physicalSafe (physicalAt policy stream n) := by
  obtain ⟨policy, hpolicy⟩ :=
    derived_infinite_robust_safe_history
      safeSource next initial hForever
  refine ⟨policy, ?_⟩
  intro stream n
  exact hReflect _ _ (hCorresponds policy stream n)
    (hpolicy stream n)

/-- Countermodel: safety is a physical-state predicate in this two-state
    toy, and the controller can choose 'keep' or 'halt'. -/
def toySafe (s : Bool) : Prop := s = true

def toyNext (s action : Bool) (_ : Unit) : Bool :=
  if action then false else s

/-- Even with an adverse-disturbance quantifier, every finite horizon
    is robustly viable in the explicit two-action source. -/
theorem toy_all_horizons_viable :
    ForeverViable toySafe toyNext true := by
  intro n
  induction n with
  | zero =>
      rfl
  | succ n ih =>
      change toySafe true ∧
        ∃ a : Bool, ∀ d : Unit,
          Viable toySafe toyNext n (toyNext true a d)
      refine ⟨rfl, false, ?_⟩
      intro d
      simpa [toyNext] using ih

/-- The alternative action is nevertheless mathematically available and
    takes an initially safe toy state to an unsafe one. Existence of a
    robustly safe policy is not a necessity law for actual selection. -/
theorem viable_but_violating_action_exists :
    ForeverViable toySafe toyNext true ∧
      ∃ action : Bool,
        ¬ toySafe (toyNext true action ()) := by
  refine ⟨toy_all_horizons_viable, true, ?_⟩
  simp [toySafe, toyNext]

/-- The sharp quantifier gap:
      (EXISTS policy, for all times safe)
    is TRUE, but
      (FOR ALL policies, for all times safe)
    is FALSE.
    No anti-mathematical action is involved in this source model. -/
theorem existence_of_infinite_safe_policy_not_compulsory :
    (∃ policy : Bool → Bool,
      ∀ stream : Nat → Unit, ∀ n : Nat,
        toySafe (stateAt toyNext policy stream true n)) ∧
    ¬ (∀ policy : Bool → Bool,
      ∀ stream : Nat → Unit, ∀ n : Nat,
        toySafe (stateAt toyNext policy stream true n)) := by
  constructor
  · exact derived_infinite_robust_safe_history
      toySafe toyNext true toy_all_horizons_viable
  · intro h
    have hBad :=
      h (fun _ => true) (fun _ => ()) 1
    simp [toySafe, toyNext, stateAt] at hBad

end PhysicalBridges.CathedralViabilitySelection
