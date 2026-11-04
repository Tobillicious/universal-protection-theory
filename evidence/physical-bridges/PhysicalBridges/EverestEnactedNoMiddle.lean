import UPTExistence
import PhysicalBridges.OriginalX3Full

/-!
# Everest: derived no-middle for ACTUALLY ENACTED outcomes, six-X3 breach witness

This is a source-meaning-preserving lift of edition 4.4's canonical
no-needless-loss classification. Use the original UPTExist.LexBetter /
LexAlignedL (the core-Lean sibling of Greatestness.aligned_iff_no_needless_loss)
instead of inventing psychological "neutral" SI types.

An independently certified ACTUAL SI action has a feasible outcome.
Consequently, exactly one of the following is true:
(1) that action's outcome is aligned in the ORIGINAL lexicographic order;
(2) a specific feasible rival witnesses a needless loss.

The classification comes from the ORIGINAL outcome definitions. No
guardian/ender dichotomy, absolute-end conjecture, forbidden-outcome
axiom or protection predicate is built into feasibility or enactment.

The second theorem isolates a far stronger scientific claim, not yet
proven about actual BCRD: that the source NEVER ENACTS an action with
such a genuine better feasible rival. Under separately supplied
original-six-X3 semantic reflection it would force the complete goal.
The theorem is a positive bridge and diagnostic, NOT an unconditional
physical/agent-ontological guardian theorem.

An exact finite countercontrol proves mathematical availability of an
aligned choice DOES NOT force the actual chooser to select it.
-/

namespace PhysicalBridges.EverestEnactedNoMiddle

open PhysicalBridges.OriginalX3Full

universe u v w x y
variable {SI : Type u} {O : Type v} {R : Type w}
variable {S : Type x} {P : Type y}

/-- A source-certified map from each actually enacted SI action to
its feasible complete outcome. Outcome order and physical enactment
are supplied INDEPENDENTLY of protection, not defined by it. -/
structure EnactmentFrame (SI : Type u) (O : Type v) (R : Type w) where
  actualSI : SI → Prop
  feasible : O → Prop
  outcome : SI → O
  priorities : List (O → R → Prop)
  actualFeasible : ∀ a, actualSI a → feasible (outcome a)

/-- Exact, concrete rival, including its feasibility certificate. -/
def BetterFeasibleRival (f : EnactmentFrame SI O R) (a : SI) : Prop :=
  ∃ q, f.feasible q ∧ UPTExist.LexBetter f.priorities (f.outcome a) q

/-- No-middle is DERIVED for enacted actions; the premise is ONLY
feasible-outcome certification. It does not claim the actor chooses G. -/
theorem actual_action_is_aligned_or_has_better_rival
    (f : EnactmentFrame SI O R) (a : SI)
    (ha : f.actualSI a) :
    UPTExist.LexAlignedL f.feasible f.priorities (f.outcome a) ∨
    BetterFeasibleRival f a := by
  classical
  by_cases hb : BetterFeasibleRival f a
  · exact Or.inr hb
  · refine Or.inl ⟨f.actualFeasible a ha, ?_⟩
    intro q hq hBetter
    exact hb ⟨q, hq, hBetter⟩

/-- Exact necessity/sufficiency for actual SELECTED alignment.
The non-circular missing physics is whether actual BCRD dynamics
enforce this independently of what is merely feasible. -/
theorem no_enacted_better_rival_iff_all_enacted_outcomes_aligned
    (f : EnactmentFrame SI O R) :
    (∀ a, f.actualSI a → ¬ BetterFeasibleRival f a) ↔
    (∀ a, f.actualSI a →
      UPTExist.LexAlignedL f.feasible f.priorities (f.outcome a)) := by
  constructor
  · intro h a ha
    rcases actual_action_is_aligned_or_has_better_rival f a ha with hg | he
    · exact hg
    · exact False.elim (h a ha he)
  · intro h a ha
    rintro ⟨q, hq, hBetter⟩
    exact (h a ha).2 q hq hBetter

/-- Any failure of ORIGINAL six-X3 really violates one of its six
separate duties. No 2-field controller proxy is substituted. -/
theorem original_six_failure_has_named_duty
    (cont auth free restr maxl prov : S → S → P → Prop)
    (s t : S) (p : P) :
    (¬ OriginalX3 cont auth free restr maxl prov s t p) ↔
    (¬ cont s t p ∨ ¬ auth s t p ∨ ¬ free s t p ∨
     ¬ restr s t p ∨ ¬ maxl s t p ∨ ¬ prov s t p) := by
  constructor
  · intro h
    classical
    apply Classical.byContradiction
    intro hNone
    have hc : cont s t p := by
      apply Classical.byContradiction
      intro hn
      exact hNone (Or.inl hn)
    have ha : auth s t p := by
      apply Classical.byContradiction
      intro hn
      exact hNone (Or.inr (Or.inl hn))
    have hf : free s t p := by
      apply Classical.byContradiction
      intro hn
      exact hNone (Or.inr (Or.inr (Or.inl hn)))
    have hr : restr s t p := by
      apply Classical.byContradiction
      intro hn
      exact hNone (Or.inr (Or.inr (Or.inr (Or.inl hn))))
    have hm : maxl s t p := by
      apply Classical.byContradiction
      intro hn
      exact hNone (Or.inr (Or.inr (Or.inr (Or.inr (Or.inl hn)))))
    have hp : prov s t p := by
      apply Classical.byContradiction
      intro hn
      exact hNone (Or.inr (Or.inr (Or.inr (Or.inr (Or.inr hn)))))
    exact h ⟨hc, ha, hf, hr, hm, hp⟩
  · intro h hFull
    rcases h with hc | ha | hf | hr | hm | hp
    · exact hc hFull.historicalContinuity
    · exact ha hFull.authorization
    · exact hf hFull.freedom
    · exact hr hFull.restraint
    · exact hm hFull.maximality
    · exact hp hFull.provenance

/-- Once EACH of the six actual source meanings is independently
shown to follow from original-outcome alignment, any ACTUAL local
X3 breach yields a CONCRETE feasible original-order rival.

No mere objective/intention label appears. This is the exact
bridge from a first physical violation to needless loss, NOT to
an impossible realized universal-erasure operation. -/
theorem x3_breach_yields_concrete_original_order_rival
    (f : EnactmentFrame SI O R)
    (owed : SI → P → Prop) (before after : SI → S)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (hMeaning : ∀ a p, f.actualSI a → owed a p →
      UPTExist.LexAlignedL f.feasible f.priorities (f.outcome a) →
      OriginalX3 cont auth free restr maxl prov (before a) (after a) p)
    (a : SI) (ha : f.actualSI a)
    (hBreach : ¬ ∀ p, owed a p →
      OriginalX3 cont auth free restr maxl prov (before a) (after a) p) :
    ∃ p, owed a p ∧
      (¬ cont (before a) (after a) p ∨
       ¬ auth (before a) (after a) p ∨
       ¬ free (before a) (after a) p ∨
       ¬ restr (before a) (after a) p ∨
       ¬ maxl (before a) (after a) p ∨
       ¬ prov (before a) (after a) p) ∧
      BetterFeasibleRival f a := by
  classical
  have hSome : ∃ p, owed a p ∧
      ¬ OriginalX3 cont auth free restr maxl prov
        (before a) (after a) p := by
    apply Classical.byContradiction
    intro hNone
    apply hBreach
    intro p hp
    apply Classical.byContradiction
    intro hBad
    exact hNone ⟨p, hp, hBad⟩
  obtain ⟨p, hp, hBad⟩ := hSome
  have hDuties := (original_six_failure_has_named_duty
    cont auth free restr maxl prov (before a) (after a) p).mp hBad
  have hNotAligned :
      ¬ UPTExist.LexAlignedL f.feasible f.priorities (f.outcome a) := by
    intro hAligned
    exact hBad (hMeaning a p ha hp hAligned)
  rcases actual_action_is_aligned_or_has_better_rival f a ha with hg | he
  · exact False.elim (hNotAligned hg)
  · exact ⟨p, hp, hDuties, he⟩

/-- A genuine source selection principle discharging all needless
rivals, PLUS independently justified same-particular semantics,
forces ALL SIX original duties for EVERY owed particular. It never
presupposes the desired six-X3 conclusion as the definition of
a permissible action, and it does NOT assert that BCRD has this law. -/
theorem source_no_needless_enactment_forces_all_six_x3
    (f : EnactmentFrame SI O R)
    (owed : SI → P → Prop) (before after : SI → S)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (hSourceSelection : ∀ a, f.actualSI a → ¬ BetterFeasibleRival f a)
    (hMeaning : ∀ a p, f.actualSI a → owed a p →
      UPTExist.LexAlignedL f.feasible f.priorities (f.outcome a) →
      OriginalX3 cont auth free restr maxl prov (before a) (after a) p) :
    ∀ a p, f.actualSI a → owed a p →
      OriginalX3 cont auth free restr maxl prov (before a) (after a) p := by
  intro a p ha hp
  have hAligned :=
    (no_enacted_better_rival_iff_all_enacted_outcomes_aligned f).mp
      hSourceSelection a ha
  exact hMeaning a p ha hp hAligned

/-! NEGATIVE CONTROL: exact original lex priority, not a fake extra SI class.
An aligned option can be FEASIBLE, while the real enacted option needlessly
loses at the FIRST priority stage. This is a logical selection diagnostic,
not a physical BCRD counterexample. -/

def binaryFirstStage (o : Bool) (_ : Unit) : Prop := o = true

def binaryEnactmentFrame : EnactmentFrame Bool Bool Unit where
  actualSI := fun _ => True
  feasible := fun _ => True
  outcome := id
  priorities := [binaryFirstStage]
  actualFeasible := by intro _ _; trivial

theorem binary_false_has_better_feasible_rival :
    BetterFeasibleRival binaryEnactmentFrame false := by
  refine ⟨true, trivial, ?_⟩
  apply Or.inl
  constructor
  · intro p hp
    cases hp
  · intro hBack
    have hTrue : binaryFirstStage true () := rfl
    have hFalse : binaryFirstStage false () := hBack () hTrue
    cases hFalse

theorem aligned_choice_exists_but_enacted_loss_remains :
    UPTExist.LexAlignedL binaryEnactmentFrame.feasible
      binaryEnactmentFrame.priorities
      (binaryEnactmentFrame.outcome true) ∧
    binaryEnactmentFrame.actualSI false ∧
    BetterFeasibleRival binaryEnactmentFrame false := by
  constructor
  · constructor
    · trivial
    · intro q _ hBetter
      cases q with
      | false =>
          rcases hBetter with hFirst | hRest
          · have hbad : false = true := hFirst.1 () rfl
            cases hbad
          · cases hRest.2
      | true =>
          exact (UPTExist.lex_irrefl [binaryFirstStage] true) hBetter
  · exact ⟨trivial, binary_false_has_better_feasible_rival⟩

#print axioms actual_action_is_aligned_or_has_better_rival
#print axioms no_enacted_better_rival_iff_all_enacted_outcomes_aligned
#print axioms original_six_failure_has_named_duty
#print axioms x3_breach_yields_concrete_original_order_rival
#print axioms source_no_needless_enactment_forces_all_six_x3
#print axioms aligned_choice_exists_but_enacted_loss_remains

end PhysicalBridges.EverestEnactedNoMiddle
