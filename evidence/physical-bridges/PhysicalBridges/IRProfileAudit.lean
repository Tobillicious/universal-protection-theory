/-
Finite retention-profile feasibility certificate for IR-17 / selected IR-10.
The full original outcome space may be infinite.  A finite list of
faithful retention profiles and explicit stagewise obstruction witnesses
is enough to exclude every strict improvement over the selected outcome.

Crucially, NO enumeration of the original full-feasible outcomes is
assumed, no change to the canonical UPT order is made, and a profile's
soundness and full-feasible coverage are explicit verification obligations.
-/
import PhysicalBridges.IRSelectedMaximality

namespace PhysicalBridges.IRProfileAudit
universe u v w
variable {P : Type u} {O : Type v} {C : Type w}

/-- At the current priority stage, exhibit a protected particular that
the alternative loses; OR show equivalence at this stage and continue
to the next original priority stage. The empty suffix cannot improve. -/
def Obstructs : List (O → P → Prop) → O → O → Prop
  | [], _, _ => True
  | k :: ks, selected, other =>
      (∃ p, k selected p ∧ ¬ k other p) ∨
      (UPTExist.Equiv (k selected) (k other) ∧
        Obstructs ks selected other)

/-- A checkable stagewise loss/equality certificate rules out a strict
improvement under the EXACT original UPT lexicographic order. -/
theorem obstruction_blocks_improvement
    (keys : List (O → P → Prop)) (selected other : O)
    (h : Obstructs keys selected other) :
    ¬ UPTExist.LexBetter keys selected other := by
  induction keys with
  | nil =>
      exact fun hBetter => hBetter
  | cons k ks ih =>
      change (∃ p, k selected p ∧ ¬ k other p) ∨
        (UPTExist.Equiv (k selected) (k other) ∧
          Obstructs ks selected other) at h
      intro hBetter
      change UPTExist.SSub (k selected) (k other) ∨
        (UPTExist.Equiv (k selected) (k other) ∧
          UPTExist.LexBetter ks selected other) at hBetter
      rcases h with ⟨p, hp, hMissing⟩ | ⟨hEqual, hRest⟩
      · rcases hBetter with hStrict | hTail
        · exact hMissing (hStrict.1 p hp)
        · exact hMissing (hTail.1.1 p hp)
      · rcases hBetter with hStrict | hTail
        · exact hStrict.2 hEqual.2
        · exact ih hRest hTail.2

/-- If an outcome and a representative have identical retention sets at
EACH original priority stage, any alleged improvement by the outcome
would be an improvement by its representative. No feasibility filtering
or altered comparator is involved. -/
theorem improvement_transfers_to_faithful_profile :
    ∀ (keys : List (O → P → Prop)) (selected actual proxy : O),
      (∀ k, k ∈ keys → ∀ p, k actual p ↔ k proxy p) →
      UPTExist.LexBetter keys selected actual →
      UPTExist.LexBetter keys selected proxy := by
  intro keys
  induction keys with
  | nil =>
      intro selected actual proxy _ hBetter
      exact hBetter
  | cons k ks ih =>
      intro selected actual proxy hMatch hBetter
      have hKey : k actual = k proxy := by
        funext p
        exact propext (hMatch k (by simp) p)
      have hTail : ∀ j, j ∈ ks → ∀ p, j actual p ↔ j proxy p := by
        intro j hj p
        exact hMatch j (by simp [hj]) p
      change UPTExist.SSub (k selected) (k actual) ∨
        (UPTExist.Equiv (k selected) (k actual) ∧
          UPTExist.LexBetter ks selected actual) at hBetter
      change UPTExist.SSub (k selected) (k proxy) ∨
        (UPTExist.Equiv (k selected) (k proxy) ∧
          UPTExist.LexBetter ks selected proxy)
      rcases hBetter with hStrict | ⟨hEqual, hLater⟩
      · exact Or.inl (by simpa only [hKey] using hStrict)
      · exact Or.inr
          ⟨by simpa only [hKey] using hEqual,
           ih selected actual proxy hTail hLater⟩

/-- Finite *profile* certificate, not a finite-original-world assumption.
Every full-feasible outcome is covered by a verified profile; the profile
preserves ALL original priority-stage retention sets; every listed profile
has a stagewise loss/equality obstruction to strictly improving the choice.
This DERIVES (rather than assumes) IR-17's no-excluded-improver premise. -/
theorem audited_no_excluded_improver
    (keys : List (O → P → Prop))
    (full : O → Prop) (safe : List O) (selected : O)
    (code : O → C) (representative : C → O) (profiles : List C)
    (hCovers : ∀ o, full o → code o ∈ profiles)
    (hFaithful : ∀ o, full o →
      ∀ k, k ∈ keys → ∀ p,
        k o p ↔ k (representative (code o)) p)
    (hObstructions : ∀ c, c ∈ profiles →
      Obstructs keys selected (representative c)) :
    IRSelectedMaximality.NoExcludedImprover keys full safe selected := by
  intro other hFull _ hBetter
  have hListed := hCovers other hFull
  have hRepresentativeBetter :=
    improvement_transfers_to_faithful_profile
      keys selected other (representative (code other))
      (hFaithful other hFull) hBetter
  exact (obstruction_blocks_improvement keys selected
    (representative (code other))
    (hObstructions (code other) hListed)) hRepresentativeBetter

/-- Plug the *derived* IR-17 condition into full original-UPT maximality.
The safe subset must still contain the selected full-feasible outcome. -/
theorem audited_selected_global_maximal
    (keys : List (O → P → Prop))
    (full : O → Prop) (safe : List O) (selected : O)
    (hIncluded : ∀ o, o ∈ safe → full o)
    (hLocal : UPTExist.LexAlignedL (fun o => o ∈ safe) keys selected)
    (code : O → C) (representative : C → O) (profiles : List C)
    (hCovers : ∀ o, full o → code o ∈ profiles)
    (hFaithful : ∀ o, full o →
      ∀ k, k ∈ keys → ∀ p,
        k o p ↔ k (representative (code o)) p)
    (hObstructions : ∀ c, c ∈ profiles →
      Obstructs keys selected (representative c)) :
    UPTExist.LexAlignedL full keys selected := by
  exact IRSelectedMaximality.selected_safety_maximal_lifts_globally
    keys full safe hIncluded selected hLocal
    (audited_no_excluded_improver keys full safe selected
      code representative profiles hCovers hFaithful hObstructions)

namespace InfiniteExample

/-- Infinitely many outcomes (a Boolean retention choice and unbounded
metadata). Two profiles suffice because only the Boolean changes the
retention set. The omitted other Boolean profile is incomparable. -/
abbrev Outcome := Bool × Nat
def key (o : Outcome) (p : Bool) : Prop := o.1 = p
def chosen : Outcome := (true, 0)
def full (_ : Outcome) : Prop := True
def menu : List Outcome := [chosen]
def code (o : Outcome) : Bool := o.1
def representative (b : Bool) : Outcome := (b, 0)

theorem full_coverage :
    ∀ o : Outcome, full o → code o ∈ ([true, false] : List Bool) := by
  intro o _
  cases h : o.1 <;> simp [code, h]

theorem faithful_profiles :
    ∀ o : Outcome, full o →
      ∀ k, k ∈ ([key] : List (Outcome → Bool → Prop)) →
        ∀ p, k o p ↔ k (representative (code o)) p := by
  intro o _ k hk p
  have hEq : k = key := by simpa using hk
  subst k
  rfl

theorem certified_obstructions :
    ∀ b : Bool, b ∈ ([true, false] : List Bool) →
      Obstructs ([key] : List (Outcome → Bool → Prop))
        chosen (representative b) := by
  intro b _
  cases b with
  | false =>
      exact Or.inl ⟨true, rfl, by
        intro h
        exact (by decide : false ≠ true) h⟩
  | true =>
      exact Or.inr
        ⟨⟨UPTExist.Sub.refl _, UPTExist.Sub.refl _⟩, trivial⟩

theorem local_choice :
    UPTExist.LexAlignedL
      (fun o : Outcome => o ∈ menu)
      ([key] : List (Outcome → Bool → Prop)) chosen := by
  constructor
  · simp [menu]
  · intro o ho
    have hEq : o = chosen := by simpa [menu] using ho
    subst o
    exact UPTExist.lex_irrefl _ chosen

/-- A genuine finite audit over the profiles proves original full-feasible
maximality even though the original feasible outcome type is infinite
and the safety menu has just one option. -/
theorem globally_maximal_without_cofinality :
    UPTExist.LexAlignedL full
      ([key] : List (Outcome → Bool → Prop)) chosen := by
  exact audited_selected_global_maximal
    ([key] : List (Outcome → Bool → Prop))
    full menu chosen (by intro o _; trivial)
    local_choice code representative [true, false]
    full_coverage faithful_profiles certified_obstructions

theorem full_options_all_n (n : Nat) :
    full (true, n) ∧ full (false, n) := ⟨trivial, trivial⟩

theorem omitted_incomparable_profile :
    (false, 12) ∉ menu := by
  simp [menu, chosen]

end InfiniteExample

namespace HostileControls
open PhysicalBridges.IRSelectedMaximality

/-- In this separate Boolean world, the omitted `true` strictly improves
the chosen `false`. An abstraction that falsely maps every outcome to
`false` could hide it unless profile faithfulness is verified. -/
theorem omitted_better_candidate :
    UPTExist.LexBetter
      ([dominates] : List (Bool → Bool → Prop)) false true := by
  apply Or.inl
  constructor
  · intro p hp
    exact False.elim ((by decide : false ≠ true) hp.1)
  · intro hBack
    have h := hBack true ⟨rfl, rfl⟩
    exact (by decide : false ≠ true) h.1

def badCode (_ : Bool) : Unit := ()
def badRepresentative (_ : Unit) : Bool := false

theorem bad_abstraction_covers :
    ∀ o : Bool, True → badCode o ∈ ([()] : List Unit) := by
  intro o _
  simp [badCode]

theorem bad_abstraction_passes_obstruction :
    ∀ c : Unit, c ∈ ([()] : List Unit) →
      Obstructs ([dominates] : List (Bool → Bool → Prop))
        false (badRepresentative c) := by
  intro c _
  cases c
  exact Or.inr
    ⟨⟨UPTExist.Sub.refl _, UPTExist.Sub.refl _⟩, trivial⟩

/-- Negative control: coverage + obstruction WITHOUT faithful profiles
fails to detect the genuine omitted strict improver. -/
theorem bad_abstraction_is_not_faithful :
    ¬ (∀ o : Bool, True →
      ∀ k, k ∈ ([dominates] : List (Bool → Bool → Prop)) →
        ∀ p, k o p ↔ k (badRepresentative (badCode o)) p) := by
  intro h
  have hEq := h true trivial dominates (by simp) true
  have hKept : dominates true true := ⟨rfl, rfl⟩
  have hWrong := hEq.mp hKept
  exact (by decide : false ≠ true) hWrong.1

/-- Negative control: omitting an actual feasible profile from the finite
list violates COVERAGE, even if every listed profile passes its checks. -/
theorem incomplete_profile_list_is_not_coverage :
    ¬ (∀ o : Bool, True → o ∈ ([false] : List Bool)) := by
  intro h
  exact (by decide : true ∉ ([false] : List Bool)) (h true trivial)

end HostileControls

#print axioms obstruction_blocks_improvement
#print axioms improvement_transfers_to_faithful_profile
#print axioms audited_no_excluded_improver
#print axioms audited_selected_global_maximal
#print axioms InfiniteExample.globally_maximal_without_cofinality
#print axioms HostileControls.omitted_better_candidate
#print axioms HostileControls.bad_abstraction_is_not_faithful
#print axioms HostileControls.incomplete_profile_list_is_not_coverage
end PhysicalBridges.IRProfileAudit
