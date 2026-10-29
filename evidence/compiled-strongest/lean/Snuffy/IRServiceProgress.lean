import Snuffy.IRBeliefTrace

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRServiceProgress.lean` at main `740abbb` (sha256 `894c1810813e02238080bc6eb1c2827d876e4d3b61d23e234ad2f78e6f64ffc1`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-37: Maintaining an indefinitely safe controlled state alone does
not prove any wanted service is ever delivered. Prove a separate,
adversarially robust bounded-service theorem under strictly decreasing
non-goal rank, goal persistence, and an invariant.
This is conditional mathematics, not empirical deployment evidence.
-/

namespace PhysicalBridges.IRServiceProgress
universe u v
variable {T : Type u} {D : Type v}

/-- Generic finite-trace progress under all possible disturbance sequences.
Nonempty D is essential: otherwise there might be no physical steps. -/
theorem ranked_trace_reaches_goal [Nonempty D]
    (step : T → D → T)
    (Inv Goal : T → Prop) (rank : T → Nat)
    (hInv : ∀ s d, Inv s → Inv (step s d))
    (hAbsorb : ∀ s d, Inv s → Goal s → Goal (step s d))
    (hDecrease : ∀ s d, Inv s → ¬ Goal s →
      rank (step s d) < rank s) :
    ∀ (trace : List D) s,
      Inv s → rank s ≤ trace.length →
      Goal (trace.foldl step s) := by
  have zeroGoal : ∀ s, Inv s → rank s = 0 → Goal s := by
    intro s hi hr
    by_cases hs : Goal s
    · exact hs
    · obtain ⟨d⟩ := (inferInstance : Nonempty D)
      have bad : rank (step s d) < 0 := by
        calc
          rank (step s d) < rank s := hDecrease s d hi hs
          _ = 0 := hr
      exact False.elim ((Nat.not_lt_zero _) bad)
  have remains : ∀ trace : List D, ∀ s, Inv s → Goal s →
      Goal (trace.foldl step s) := by
    intro trace
    induction trace with
    | nil => intro s _ hs; exact hs
    | cons d ds ih =>
        intro s hi hs
        exact ih (step s d) (hInv s d hi) (hAbsorb s d hi hs)
  have bounded : ∀ n : Nat, ∀ trace : List D, ∀ s,
      trace.length = n → Inv s → rank s ≤ n →
      Goal (trace.foldl step s) := by
    intro n
    induction n with
    | zero =>
        intro trace s hLength hi hRank
        cases trace with
        | nil => exact zeroGoal s hi (Nat.eq_zero_of_le_zero hRank)
        | cons d ds => cases hLength
    | succ n ih =>
        intro trace s hLength hi hRank
        cases trace with
        | nil => cases hLength
        | cons d ds =>
            have hTail : ds.length = n := by
              simp only [List.length_cons] at hLength
              omega
            by_cases hs : Goal s
            · exact remains (d :: ds) s hi hs
            · have hStepInv := hInv s d hi
              have hStepRank : rank (step s d) ≤ n := by
                have hDecrease' := hDecrease s d hi hs
                omega
              exact ih ds (step s d) hTail hStepInv hStepRank
  intro trace s hi hBound
  exact bounded trace.length trace s rfl hi hBound

/-- In a finite-state hold-only controller, safety can be trivially true
while useful service never occurs. This is an exact negative witness. -/
def frozenStep (_ : Unit) (_ : Unit) : Unit := ()

theorem infinite_hold_is_safe_but_never_serves :
    (∀ trace : List Unit, (trace.foldl frozenStep ()) = ()) ∧
      (∀ trace : List Unit, ¬ False) := by
  constructor
  · intro trace
    cases (trace.foldl frozenStep ())
    rfl
  · intro trace hn
    exact hn

/-- The presence of a favourable disturbance is not a robust liveness
guarantee: an adversary can select the non-progress branch. -/
def unfairNext (_ : Nat) (d : Bool) : Nat :=
  if d then 0 else 1

theorem favourable_transition_not_sufficient :
    unfairNext 1 true = 0 ∧ unfairNext 1 false = 1 :=
  ⟨rfl, rfl⟩

end PhysicalBridges.IRServiceProgress
