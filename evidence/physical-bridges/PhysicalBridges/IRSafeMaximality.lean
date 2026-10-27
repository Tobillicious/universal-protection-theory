/-
IR-7: A physical safety filter may change the feasible UPT problem.
A safety-maximal action is maximal for the FULL feasible set only if an
adequacy property, such as cofinality, has been supplied and proved.
Imports the exact existing UPTExistence.lean proof source in CI.
This changes no stage priority and does not weaken the UPT objective.
-/
import UPTExistence

namespace PhysicalBridges.IRSafeMaximality
universe u v
variable {P : Type u} {O : Type v}

/-- Every full-feasible option excluded by the safe list is dominated
by some option still in that list. This is STRONGER than saying each
option in the safe list is physically viable. -/
def Cofinal (full : O → Prop) (safe : List O)
    (keys : List (O → P → Prop)) : Prop :=
  ∀ p, full p → p ∉ safe →
    ∃ q, q ∈ safe ∧ UPTExist.LexBetter keys p q

/-- Existing Snuffy finite-existence theorem supplies a canonical maximal
choice within the physically admissible safe family, if it is nonempty. -/
theorem safe_maximal_exists
    (keys : List (O → P → Prop)) (safe : List O)
    (nonempty : ∃ o, o ∈ safe) :
    ∃ o, UPTExist.LexAlignedL (fun p => p ∈ safe) keys o :=
  UPTExist.lex_aligned_exists keys safe nonempty

/-- A choice maximal in a safe subset is globally UPT maximal if that subset
is contained in full feasibility and is cofinal for strict improvement.
Without cofinality only a relative maximality result follows. -/
theorem cofinal_safe_maximal_is_globally_maximal
    (keys : List (O → P → Prop)) (safe : List O)
    (full : O → Prop) (included : ∀ o, o ∈ safe → full o)
    (hCofinal : Cofinal full safe keys) (o : O)
    (hLocal : UPTExist.LexAlignedL (fun p => p ∈ safe) keys o) :
    UPTExist.LexAlignedL full keys o := by
  refine ⟨included o hLocal.1, ?_⟩
  intro p hp hBetter
  by_cases hIn : p ∈ safe
  · exact hLocal.2 p hIn hBetter
  · obtain ⟨q, hq, hpq⟩ := hCofinal p hp hIn
    have hoq : UPTExist.LexBetter keys o q :=
      UPTExist.lex_trans keys o p q hBetter hpq
    exact hLocal.2 q hq hoq

/-- Composition: there exists a globally maximal option satisfying
the safe-family feasibility certificate, given cofinality and a nonempty
safe family. This preserves every canonical lexicographic stage. -/
theorem cofinal_global_maximal_exists
    (keys : List (O → P → Prop)) (safe : List O)
    (full : O → Prop) (included : ∀ o, o ∈ safe → full o)
    (hCofinal : Cofinal full safe keys)
    (nonempty : ∃ o, o ∈ safe) :
    ∃ o, o ∈ safe ∧ UPTExist.LexAlignedL full keys o := by
  obtain ⟨o, h⟩ := safe_maximal_exists keys safe nonempty
  exact ⟨o, h.1, cofinal_safe_maximal_is_globally_maximal
    keys safe full included hCofinal o h⟩

/-- Full first-stage maximisation entails no needless loss there,
relative to the FULL feasible family (not just the safe subset). -/
theorem globally_maximal_first_stage_no_needless
    (first : O → P → Prop) (later : List (O → P → Prop))
    (full : O → Prop) (o : O)
    (global : UPTExist.LexAlignedL full (first :: later) o) :
    ∀ x, ¬ UPTExist.Needless full first o x := by
  intro x hn
  obtain ⟨hx, p, hp, hsub, hpx⟩ := hn
  have hstrict : UPTExist.SSub (first o) (first p) :=
    ⟨hsub, fun hback => hx (hback x hpx)⟩
  have hBetter : UPTExist.LexBetter (first :: later) o p :=
    Or.inl hstrict
  exact global.2 p hp hBetter

#print axioms safe_maximal_exists
#print axioms cofinal_safe_maximal_is_globally_maximal
#print axioms cofinal_global_maximal_exists
#print axioms globally_maximal_first_stage_no_needless
end PhysicalBridges.IRSafeMaximality
