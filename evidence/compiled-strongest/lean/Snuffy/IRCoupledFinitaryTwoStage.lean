import Snuffy.IRTwoStageInfiniteLex

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRCoupledFinitaryTwoStage.lean` at main `740abbb` (sha256 `1cf89a1f40b8380282fdacb966ee10e3c9df7e9051456dac13914978dbd57b03`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-68: generic COUPLED two-stage infinite full-feasible maximality.

All outcomes are pairs of countably infinite retention sets, encoded
as Bool × Nat → Prop. Arbitrary forbidden FINITE PATTERNS may mix
facts from BOTH priorities, so unlike IR-67 NO stage-independence
hypothesis is used.

Phase 0 greedily maximizes the higher-priority facts; phase 1
maximizes the lower-priority facts without changing phase 0.
Finite-obstruction feasibility makes both infinite limit unions
feasible. The final outcome is LexAlignedL in the exact original
Snuffy.Book.UPTExistence.LexBetter order across the FULL feasible universe.

NOT a proof of finite-obstruction character of real X3 outcomes,
nor arbitrary original stages, actual policy realization, or
physically delivered historical preservation.
-/

namespace PhysicalBridges.IRCoupledFinitaryTwoStage

abbrev Fact := Bool × Nat
abbrev Outcome := Fact → Prop

def Feasible (forbidden : List Fact → Prop) (s : Outcome) : Prop :=
  ∀ pattern, forbidden pattern →
    ¬ (∀ fact, fact ∈ pattern → s fact)

def firstKey (s : Outcome) (k : Nat) : Prop := s (false,k)
def secondKey (s : Outcome) (k : Nat) : Prop := s (true,k)

/-- Finite-pattern feasible families are downward closed even when
patterns couple the two distinct priority layers. -/
theorem feasible_downward
    (forbidden : List Fact → Prop) (larger smaller : Outcome)
    (hLarge : Feasible forbidden larger)
    (hSub : Snuffy.Book.UPTExistence.Sub smaller larger) :
    Feasible forbidden smaller := by
  intro pattern hForbidden hAll
  exact (hLarge pattern hForbidden)
    (by intro fact hf; exact hSub fact (hAll fact hf))

noncomputable def chooseStep
    (forbidden : List Fact → Prop)
    (s : Outcome) (side : Bool) (n : Nat) : Outcome := by
  classical
  exact if Feasible forbidden (fun fact => s fact ∨ fact = (side,n)) then
    (fun fact => s fact ∨ fact = (side,n))
  else s

theorem chooseStep_extends
    (forbidden : List Fact → Prop)
    (s : Outcome) (side : Bool) (n : Nat) :
    Snuffy.Book.UPTExistence.Sub s (chooseStep forbidden s side n) := by
  classical
  intro fact hf
  by_cases hc : Feasible forbidden
      (fun fact => s fact ∨ fact = (side,n))
  · simpa [chooseStep,hc] using
      (Or.inl hf : s fact ∨ fact = (side,n))
  · simpa [chooseStep,hc] using hf

theorem chooseStep_feasible
    (forbidden : List Fact → Prop)
    (s : Outcome) (side : Bool) (n : Nat)
    (h : Feasible forbidden s) :
    Feasible forbidden (chooseStep forbidden s side n) := by
  classical
  by_cases hc : Feasible forbidden
      (fun fact => s fact ∨ fact = (side,n))
  · simpa [chooseStep,hc] using hc
  · simpa [chooseStep,hc] using h

theorem chooseStep_adds
    (forbidden : List Fact → Prop)
    (s : Outcome) (side : Bool) (n : Nat)
    (h : Feasible forbidden (fun fact =>
      s fact ∨ fact = (side,n))) :
    chooseStep forbidden s side n (side,n) := by
  classical
  simp [chooseStep,h]

noncomputable def phase
    (forbidden : List Fact → Prop) (base : Outcome) (side : Bool) :
    Nat → Outcome
  | 0 => base
  | n+1 => chooseStep forbidden (phase forbidden base side n) side n

theorem phase_increasing
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool) (n : Nat) :
    Snuffy.Book.UPTExistence.Sub (phase forbidden base side n)
      (phase forbidden base side (n+1)) := by
  simpa only [phase] using chooseStep_extends forbidden
    (phase forbidden base side n) side n

theorem phase_monotone
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool) :
    ∀ i j, i ≤ j →
      Snuffy.Book.UPTExistence.Sub (phase forbidden base side i)
        (phase forbidden base side j) := by
  intro i j
  induction j with
  | zero =>
      intro hij
      have hi : i=0 := by omega
      subst i
      exact Snuffy.Book.UPTExistence.Sub.refl _
  | succ j ih =>
      intro hij
      by_cases hi : i=j+1
      · subst i
        exact Snuffy.Book.UPTExistence.Sub.refl _
      · have hij' : i≤j := by omega
        exact Snuffy.Book.UPTExistence.Sub.trans (ih hij')
          (phase_increasing forbidden base side j)

theorem phase_feasible
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool)
    (hBase : Feasible forbidden base) :
    ∀ n, Feasible forbidden (phase forbidden base side n) := by
  intro n
  induction n with
  | zero => exact hBase
  | succ n ih =>
      change Feasible forbidden (chooseStep forbidden
        (phase forbidden base side n) side n)
      exact chooseStep_feasible forbidden
        (phase forbidden base side n) side n ih

noncomputable def phaseLimit
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool) (fact : Fact) : Prop :=
  ∃ n, phase forbidden base side n fact

theorem phaseLimit_contains_base
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool) :
    Snuffy.Book.UPTExistence.Sub base (phaseLimit forbidden base side) := by
  intro fact hf
  exact ⟨0,hf⟩

theorem finite_phase_capture
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool) :
    ∀ (xs : List Fact),
      (∀ fact, fact ∈ xs →
        phaseLimit forbidden base side fact) →
      ∃ n, ∀ fact, fact ∈ xs →
        phase forbidden base side n fact := by
  intro xs
  induction xs with
  | nil =>
      intro _
      exact ⟨0,by intro fact h; cases h⟩
  | cons first rest ih =>
      intro h
      obtain ⟨ni, hi⟩ := h first List.mem_cons_self
      obtain ⟨nj, hj⟩ := ih (by
        intro fact hf
        exact h fact (List.mem_cons_of_mem first hf))
      refine ⟨max ni nj, ?_⟩
      intro fact hf
      rcases List.mem_cons.mp hf with heq | hRest
      · subst fact
        exact phase_monotone forbidden base side ni
          (max ni nj) (Nat.le_max_left _ _) first hi
      · exact phase_monotone forbidden base side nj
          (max ni nj) (Nat.le_max_right _ _) fact
          (hj fact hRest)

theorem phaseLimit_feasible
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool)
    (hBase : Feasible forbidden base) :
    Feasible forbidden (phaseLimit forbidden base side) := by
  intro pattern hForbidden hAll
  obtain ⟨n, hStage⟩ :=
    finite_phase_capture forbidden base side pattern
      (by intro fact hf; exact hAll fact hf)
  exact (phase_feasible forbidden base side hBase n
    pattern hForbidden) hStage

/-- Only facts of the selected priority side can be added to a
previously feasible base. The other priority is unchanged EXACTLY. -/
theorem phaseLimit_no_cross
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool)
    (fact : Fact) (hOtherSide : fact.1 ≠ side)
    (h : phaseLimit forbidden base side fact) :
    base fact := by
  have hAll : ∀ n, phase forbidden base side n fact → base fact := by
    intro n
    induction n with
    | zero =>
        intro hStage
        exact hStage
    | succ n ih =>
        intro hStage
        by_cases hc : Feasible forbidden
            (fun f => phase forbidden base side n f ∨ f = (side,n))
        · have hChoice :
              phase forbidden base side n fact ∨
                fact = (side,n) := by
            simpa [phase,chooseStep,hc] using hStage
          rcases hChoice with hOld | hEq
          · exact ih hOld
          · have hSide : fact.1 = side := congrArg Prod.fst hEq
            exact False.elim (hOtherSide hSide)
        · have hOld : phase forbidden base side n fact := by
            simpa [phase,chooseStep,hc] using hStage
          exact ih hOld
  obtain ⟨n,hn⟩ := h
  exact hAll n hn

/-- Exhaustive greedy scanning of any ONE side is maximal with
respect to adding that side's facts, even under completely
cross-coupled forbidden finite patterns. -/
theorem phase_cannot_add_missing
    (forbidden : List Fact → Prop)
    (base : Outcome) (side : Bool) (k : Nat)
    (hCandidate : Feasible forbidden (fun fact =>
      phaseLimit forbidden base side fact ∨ fact = (side,k))) :
    phaseLimit forbidden base side (side,k) := by
  have hSubset :
      Snuffy.Book.UPTExistence.Sub
        (fun fact => phase forbidden base side k fact ∨ fact = (side,k))
        (fun fact => phaseLimit forbidden base side fact ∨
          fact = (side,k)) := by
    intro fact hf
    rcases hf with hs | hEq
    · exact Or.inl ⟨k,hs⟩
    · exact Or.inr hEq
  have hAtStage := feasible_downward forbidden
    (fun fact => phaseLimit forbidden base side fact ∨ fact = (side,k))
    (fun fact => phase forbidden base side k fact ∨ fact = (side,k))
    hCandidate hSubset
  have hAdds := chooseStep_adds forbidden
    (phase forbidden base side k) side k hAtStage
  exact ⟨k+1,by simpa only [phase] using hAdds⟩

noncomputable def firstChoice (forbidden : List Fact → Prop) : Outcome :=
  phaseLimit forbidden (fun _ => False) false

noncomputable def fullChoice (forbidden : List Fact → Prop) : Outcome :=
  phaseLimit forbidden (firstChoice forbidden) true

theorem firstChoice_feasible
    (forbidden : List Fact → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    Feasible forbidden (firstChoice forbidden) := by
  exact phaseLimit_feasible forbidden (fun _ => False) false hEmpty

theorem fullChoice_feasible
    (forbidden : List Fact → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    Feasible forbidden (fullChoice forbidden) := by
  exact phaseLimit_feasible forbidden (firstChoice forbidden) true
    (firstChoice_feasible forbidden hEmpty)

/-- Nothing except higher-priority facts can enter phase one. -/
theorem firstChoice_only_higher
    (forbidden : List Fact → Prop) (fact : Fact)
    (h : firstChoice forbidden fact) :
    fact.1 = false := by
  by_cases hb : fact.1 = false
  · exact hb
  · have hFalse : (fun _ : Fact => False) fact :=
      phaseLimit_no_cross forbidden (fun _ => False)
        false fact hb h
    exact False.elim hFalse

theorem fullChoice_first_iff
    (forbidden : List Fact → Prop) (k : Nat) :
    fullChoice forbidden (false,k) ↔
      firstChoice forbidden (false,k) := by
  constructor
  · exact phaseLimit_no_cross forbidden
      (firstChoice forbidden) true (false,k) (by simp)
  · exact phaseLimit_contains_base forbidden
      (firstChoice forbidden) true (false,k)

/-- If any feasible outcome improves the first-stage retention set,
the single missed fact would have been admitted already in the first
phase. Its LOWER-priority side effects cannot reverse hereditary
finite-pattern infeasibility. -/
theorem no_first_stage_strict_improver
    (forbidden : List Fact → Prop)
    (other : Outcome) (hOther : Feasible forbidden other)
    (hStrict : Snuffy.Book.UPTExistence.SSub
      (firstKey (fullChoice forbidden)) (firstKey other)) :
    False := by
  apply hStrict.2
  intro k hk
  by_cases hChosen : fullChoice forbidden (false,k)
  · exact hChosen
  · have hCandidate :
        Feasible forbidden (fun fact =>
          firstChoice forbidden fact ∨ fact = (false,k)) := by
      apply feasible_downward forbidden other
        (fun fact => firstChoice forbidden fact ∨ fact = (false,k))
        hOther
      intro fact hf
      rcases hf with hBase | heq
      · cases fact with
        | mk b n =>
            have hb : b = false :=
              firstChoice_only_higher forbidden (b,n) hBase
            subst b
            exact hStrict.1 n
              ((fullChoice_first_iff forbidden n).2 hBase)
      · subst fact
        exact hk
    have hMust := phase_cannot_add_missing forbidden
      (fun _ => False) false k hCandidate
    exact False.elim (hChosen
      ((fullChoice_first_iff forbidden k).2 hMust))

/-- Once higher-priority retention is FIXED, no feasible outcome
can strictly improve lower-priority retention. The candidate
fullChoice ∪{lower k} must be a subset of that feasible challenger. -/
theorem no_second_stage_strict_improver
    (forbidden : List Fact → Prop)
    (other : Outcome) (hOther : Feasible forbidden other)
    (hFirstEqual : Snuffy.Book.UPTExistence.Equiv
      (firstKey (fullChoice forbidden)) (firstKey other))
    (hSecondStrict : Snuffy.Book.UPTExistence.SSub
      (secondKey (fullChoice forbidden)) (secondKey other)) :
    False := by
  apply hSecondStrict.2
  intro k hk
  by_cases hChosen : fullChoice forbidden (true,k)
  · exact hChosen
  · have hCandidate :
        Feasible forbidden (fun fact =>
          fullChoice forbidden fact ∨ fact = (true,k)) := by
      apply feasible_downward forbidden other
        (fun fact => fullChoice forbidden fact ∨ fact = (true,k))
        hOther
      intro fact hf
      rcases hf with hBase | heq
      · cases fact with
        | mk b n =>
            cases b with
            | false =>
                exact hFirstEqual.1 n hBase
            | true =>
                exact hSecondStrict.1 n hBase
      · subst fact
        exact hk
    have hMust := phase_cannot_add_missing forbidden
      (firstChoice forbidden) true k hCandidate
    exact False.elim (hChosen hMust)

/-- GENERAL COUPLED TWO-STAGE THEOREM. The actual original
Snuffy.Book.UPTExistence.LexAlignedL is established over ALL feasible pairs of
infinite retention sets for ANY finite forbidden cross-stage
patterns, provided empty retention is feasible. -/
theorem coupled_two_stage_full_feasible_lex_maximal
    (forbidden : List Fact → Prop)
    (hEmpty : Feasible forbidden (fun _ => False)) :
    Snuffy.Book.UPTExistence.LexAlignedL (Feasible forbidden)
      ([firstKey,secondKey] : List (Outcome → Nat → Prop))
      (fullChoice forbidden) := by
  refine ⟨fullChoice_feasible forbidden hEmpty, ?_⟩
  intro other hOther hBetter
  change
    Snuffy.Book.UPTExistence.SSub (firstKey (fullChoice forbidden)) (firstKey other) ∨
    (Snuffy.Book.UPTExistence.Equiv
      (firstKey (fullChoice forbidden)) (firstKey other) ∧
      (Snuffy.Book.UPTExistence.SSub (secondKey (fullChoice forbidden))
        (secondKey other) ∨
        (Snuffy.Book.UPTExistence.Equiv (secondKey (fullChoice forbidden))
          (secondKey other) ∧ False))) at hBetter
  rcases hBetter with hFirst | ⟨hFirstEq,hLater⟩
  · exact no_first_stage_strict_improver
      forbidden other hOther hFirst
  · rcases hLater with hSecond | ⟨_,hImpossible⟩
    · exact no_second_stage_strict_improver
        forbidden other hOther hFirstEq hSecond
    · exact hImpossible

end PhysicalBridges.IRCoupledFinitaryTwoStage
