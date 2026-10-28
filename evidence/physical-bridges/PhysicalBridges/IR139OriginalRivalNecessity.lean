/-
IR-139: a full-original-order counterexample certificate, not a weaker
definition of X3 and not a guarantee that every physical loss is
preventable.

A physically executable rival that strictly expands one ORIGINAL
preservation stage without losing any higher-stage particular is a
constructive falsifier of a claimed globally maximal selected outcome.
Conversely, a globally maximal selection forces every such feasible
strict rival to lose some explicitly identifiable higher-stage
particular. Lower-stage losses cannot cancel a higher-stage gain.

The real-world source/identity/feasible-family correspondence still
requires independent proof. IR-139 does not prove a universal guardian.
-/
import PhysicalBridges.IR134SourceExtractedOutcome

namespace PhysicalBridges.IR139
universe u v w x y
variable {P : Type u} {R : Type v}

/-- A real strictly greater set of retained particulars; this is the
same strict-inclusion predicate used by original UPTExist. -/
def Gain (stage : R → P → Prop) (chosen rival : R) : Prop :=
  UPTExist.SSub (stage chosen) (stage rival)

/-- A concrete witnessed higher-priority loss (one named particular
and one precise original stage) that the proposed rival would incur.
The result says MORE than "not a strict improvement" by isolating an
actual retention loss among the higher stages. -/
def HigherPriorityLoss
    (above : List (R → P → Prop)) (chosen rival : R) : Prop :=
  ∃ stage, stage ∈ above ∧
    ∃ particular, stage chosen particular ∧
      ¬ stage rival particular

/-- A repair that is nondecreasing at ALL higher stages and strictly
increases retention at the target stage is a strict UPT improvement.
Any losses at LOWER priorities are irrelevant under the exact original
four-stage lexicographic priority order.

The higher stages may themselves strictly IMPROVE: we must not impose
equivalence of higher priorities when it is unnecessary. -/
theorem nondecreasing_ancestors_strict_gain_improves
    (above : List (R → P → Prop))
    (stage : R → P → Prop)
    (below : List (R → P → Prop))
    (chosen rival : R)
    (hAbove : ∀ k, k ∈ above →
      UPTExist.Sub (k chosen) (k rival))
    (hGain : Gain stage chosen rival) :
    UPTExist.LexBetter (above ++ stage :: below) chosen rival := by
  induction above with
  | nil =>
      change UPTExist.SSub (stage chosen) (stage rival) ∨ _
      exact Or.inl hGain
  | cons k rest ih =>
      have hForward : UPTExist.Sub (k chosen) (k rival) :=
        hAbove k (by simp)
      have hRest : ∀ j, j ∈ rest →
          UPTExist.Sub (j chosen) (j rival) := by
        intro j hj
        exact hAbove j (by simp [hj])
      change UPTExist.SSub (k chosen) (k rival) ∨
        (UPTExist.Equiv (k chosen) (k rival) ∧
          UPTExist.LexBetter (rest ++ stage :: below)
            chosen rival)
      by_cases hReverse : UPTExist.Sub (k rival) (k chosen)
      · exact Or.inr ⟨⟨hForward, hReverse⟩, ih hRest⟩
      · exact Or.inl ⟨hForward, hReverse⟩

/-- Strong NECESSARY consequence of original global maximality:
Every FULLY FEASIBLE strict gain at a given stage MUST have a named,
higher-priority particular that the rival loses.

In particular, at the FIRST priority stage this condition is
impossible: no full-feasible strict existing-continuation gain can
coexist with global maximality.

No safe-menu filtering is allowed here. -/
theorem global_maximal_forces_a_specific_higher_loss
    (above : List (R → P → Prop))
    (stage : R → P → Prop)
    (below : List (R → P → Prop))
    (full : R → Prop) (chosen rival : R)
    (hMax : UPTExist.LexAlignedL full
      (above ++ stage :: below) chosen)
    (hRival : full rival)
    (hGain : Gain stage chosen rival) :
    HigherPriorityLoss above chosen rival := by
  classical
  by_contra hNoLoss
  have hAbove : ∀ k, k ∈ above →
      UPTExist.Sub (k chosen) (k rival) := by
    intro k hk p hKept
    by_contra hMissed
    exact hNoLoss ⟨k, hk, p, hKept, hMissed⟩
  exact hMax.2 rival hRival
    (nondecreasing_ancestors_strict_gain_improves
      above stage below chosen rival hAbove hGain)

/-- Constructive negative audit: any real feasible improvement in
existing continuation refutes maximality, even if the rival harms the
lower-priority freedoms/new histories. -/
theorem original_first_stage_rescue_refutes_maximality
    (existingLife existingFreedom newLife newFreedom :
      R → P → Prop)
    (full : R → Prop) (chosen rival : R)
    (hFeasible : full rival)
    (hGain : Gain existingLife chosen rival) :
    ¬ UPTExist.LexAlignedL full
       [existingLife, existingFreedom, newLife, newFreedom]
       chosen := by
  intro hMax
  have hHigher :=
    global_maximal_forces_a_specific_higher_loss
      ([] : List (R → P → Prop))
      existingLife [existingFreedom, newLife, newFreedom]
      full chosen rival hMax hFeasible hGain
  rcases hHigher with ⟨stage, impossible, _⟩
  simp at impossible

/-- The "strongest feasible" theorem does not automatically assert
perfect physical immortality. If the entire true feasible family has
no surviving original (and hence NO physically feasible rescue),
a maximiser still exists. This is a hostile control against
smuggling universal physical protection out of the ordering alone. -/
def noOriginalSurvives (_ : Unit) (_ : Unit) : Prop := False

theorem complete_maximality_does_not_imply_physical_survival :
    UPTExist.LexAlignedL (fun _ : Unit => True)
      ([noOriginalSurvives] : List (Unit → Unit → Prop)) () ∧
    ¬ noOriginalSurvives () () := by
  constructor
  · constructor
    · trivial
    · intro rival hFeasible hBetter
      cases rival
      exact UPTExist.lex_irrefl [noOriginalSurvives] () hBetter
  · intro h
    exact h

/-- The original four priorities are used UNCHANGED, in one explicitly
causally defined action-responsive physical model. Unlike an
uninterpreted 'realises' relation, the challenging outcome is the
actual source trace induced by a single challenger policy.

The theorem is a powerful hostile REFUTATION certificate, not a proof
that the source includes every real physical alternative. -/
theorem same_world_executable_rival_exposes_higher_priority_cost
    {S : Type w} {O : Type x} {A D : Type y}
    (next : S → A → D → S)
    (observe : S → O)
    (world : S → A → D)
    (initial : S) (horizon : Nat)
    (selected challenger : O → A)
    (above : List (List S → P → Prop))
    (stage : List S → P → Prop)
    (below : List (List S → P → Prop))
    (hMax : UPTExist.LexAlignedL
      (IR134.ExecutedInWorld next observe world initial horizon)
      (above ++ stage :: below)
      (IR134.runReactiveHistory next observe world selected
        initial horizon))
    (hGain : Gain stage
      (IR134.runReactiveHistory next observe world selected
        initial horizon)
      (IR134.runReactiveHistory next observe world challenger
        initial horizon)) :
    HigherPriorityLoss above
      (IR134.runReactiveHistory next observe world selected
        initial horizon)
      (IR134.runReactiveHistory next observe world challenger
        initial horizon) := by
  exact global_maximal_forces_a_specific_higher_loss
    above stage below
    (IR134.ExecutedInWorld next observe world initial horizon)
    (IR134.runReactiveHistory next observe world selected
      initial horizon)
    (IR134.runReactiveHistory next observe world challenger
      initial horizon)
    hMax ⟨challenger, rfl⟩ hGain

/-- The strongest physically available first-stage rescue immediately
defeats any claimed global maximality under the FULL original
four-stage order, without enumerating other rivals or assuming finite
retention profiles. An independent physical trace witness for one
rival is sufficient to REFUTE a universal maximality claim. -/
theorem one_executed_first_stage_rescue_refutes_x3_maximality
    {S : Type w} {O : Type x} {A D : Type y}
    (next : S → A → D → S)
    (observe : S → O)
    (world : S → A → D)
    (initial : S) (horizon : Nat)
    (selected challenger : O → A)
    (existingLife existingFreedom newLife newFreedom :
      List S → P → Prop)
    (hGain : Gain existingLife
      (IR134.runReactiveHistory next observe world selected
        initial horizon)
      (IR134.runReactiveHistory next observe world challenger
        initial horizon)) :
    ¬ UPTExist.LexAlignedL
      (IR134.ExecutedInWorld next observe world initial horizon)
      (IR134.fourOriginalKeys
        existingLife existingFreedom newLife newFreedom)
      (IR134.runReactiveHistory next observe world selected
        initial horizon) := by
  apply original_first_stage_rescue_refutes_maximality
    existingLife existingFreedom newLife newFreedom
    (IR134.ExecutedInWorld next observe world initial horizon)
    (IR134.runReactiveHistory next observe world selected
      initial horizon)
    (IR134.runReactiveHistory next observe world challenger
      initial horizon)
  · exact ⟨challenger, rfl⟩
  · exact hGain

#print axioms nondecreasing_ancestors_strict_gain_improves
#print axioms global_maximal_forces_a_specific_higher_loss
#print axioms original_first_stage_rescue_refutes_maximality
#print axioms complete_maximality_does_not_imply_physical_survival
#print axioms same_world_executable_rival_exposes_higher_priority_cost
#print axioms one_executed_first_stage_rescue_refutes_x3_maximality

end PhysicalBridges.IR139
