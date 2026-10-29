import Snuffy.BookUPTExistence

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRSafeMaximality.lean` at main `740abbb` (sha256 `87fc439cfbdf756ee874a6c1c58808c95519fe077d5a07a2ee808cc12fbaa9ed`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-7: A physical safety filter may change the feasible UPT problem.
A safety-maximal action is maximal for the FULL feasible set only if an
adequacy property, such as cofinality, has been supplied and proved.
Imports the exact existing UPTExistence.lean proof source in CI.
This changes no stage priority and does not weaken the UPT objective.
-/

namespace PhysicalBridges.IRSafeMaximality
universe u v
variable {P : Type u} {O : Type v}

/-- Every full-feasible option excluded by the safe list is dominated
by some option still in that list. This is STRONGER than saying each
option in the safe list is physically viable. -/
def Cofinal (full : O → Prop) (safe : List O)
    (keys : List (O → P → Prop)) : Prop :=
  ∀ p, full p → p ∉ safe →
    ∃ q, q ∈ safe ∧ Snuffy.Book.UPTExistence.LexBetter keys p q

/-- Existing Snuffy finite-existence theorem supplies a canonical maximal
choice within the physically admissible safe family, if it is nonempty. -/
theorem safe_maximal_exists
    (keys : List (O → P → Prop)) (safe : List O)
    (nonempty : ∃ o, o ∈ safe) :
    ∃ o, Snuffy.Book.UPTExistence.LexAlignedL (fun p => p ∈ safe) keys o :=
  Snuffy.Book.UPTExistence.lex_aligned_exists keys safe nonempty

/-- A choice maximal in a safe subset is globally UPT maximal if that subset
is contained in full feasibility and is cofinal for strict improvement.
Without cofinality only a relative maximality result follows. -/
theorem cofinal_safe_maximal_is_globally_maximal
    (keys : List (O → P → Prop)) (safe : List O)
    (full : O → Prop) (included : ∀ o, o ∈ safe → full o)
    (hCofinal : Cofinal full safe keys) (o : O)
    (hLocal : Snuffy.Book.UPTExistence.LexAlignedL (fun p => p ∈ safe) keys o) :
    Snuffy.Book.UPTExistence.LexAlignedL full keys o := by
  refine ⟨included o hLocal.1, ?_⟩
  intro p hp hBetter
  by_cases hIn : p ∈ safe
  · exact hLocal.2 p hIn hBetter
  · obtain ⟨q, hq, hpq⟩ := hCofinal p hp hIn
    have hoq : Snuffy.Book.UPTExistence.LexBetter keys o q :=
      Snuffy.Book.UPTExistence.lex_trans keys o p q hBetter hpq
    exact hLocal.2 q hq hoq

/-- Composition: there exists a globally maximal option satisfying
the safe-family feasibility certificate, given cofinality and a nonempty
safe family. This preserves every canonical lexicographic stage. -/
theorem cofinal_global_maximal_exists
    (keys : List (O → P → Prop)) (safe : List O)
    (full : O → Prop) (included : ∀ o, o ∈ safe → full o)
    (hCofinal : Cofinal full safe keys)
    (nonempty : ∃ o, o ∈ safe) :
    ∃ o, o ∈ safe ∧ Snuffy.Book.UPTExistence.LexAlignedL full keys o := by
  obtain ⟨o, h⟩ := safe_maximal_exists keys safe nonempty
  exact ⟨o, h.1, cofinal_safe_maximal_is_globally_maximal
    keys safe full included hCofinal o h⟩

/-- Full first-stage maximisation entails no needless loss there,
relative to the FULL feasible family (not just the safe subset). -/
theorem globally_maximal_first_stage_no_needless
    (first : O → P → Prop) (later : List (O → P → Prop))
    (full : O → Prop) (o : O)
    (global : Snuffy.Book.UPTExistence.LexAlignedL full (first :: later) o) :
    ∀ x, ¬ Snuffy.Book.UPTExistence.Needless full first o x := by
  intro x hn
  obtain ⟨hx, p, hp, hsub, hpx⟩ := hn
  have hstrict : Snuffy.Book.UPTExistence.SSub (first o) (first p) :=
    ⟨hsub, fun hback => hx (hback x hpx)⟩
  have hBetter : Snuffy.Book.UPTExistence.LexBetter (first :: later) o p :=
    Or.inl hstrict
  exact global.2 p hp hBetter

end PhysicalBridges.IRSafeMaximality
