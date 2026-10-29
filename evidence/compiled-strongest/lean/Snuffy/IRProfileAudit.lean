import Snuffy.IRSelectedMaximality

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRProfileAudit.lean` at main `740abbb` (sha256 `e4aaaaa9e7d871dd02e8a81b4a50187a58a3aba611bf9deb80b336881ec794a7`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
Finite retention-profile feasibility certificate for IR-17 / selected IR-10.
The full original outcome space may be infinite.  A finite list of
faithful retention profiles and explicit stagewise obstruction witnesses
is enough to exclude every strict improvement over the selected outcome.

Crucially, NO enumeration of the original full-feasible outcomes is
assumed, no change to the canonical UPT order is made, and a profile's
soundness and full-feasible coverage are explicit verification obligations.
-/

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
      (Snuffy.Book.UPTExistence.Equiv (k selected) (k other) ∧
        Obstructs ks selected other)

/-- A checkable stagewise loss/equality certificate rules out a strict
improvement under the EXACT original UPT lexicographic order. -/
theorem obstruction_blocks_improvement
    (keys : List (O → P → Prop)) (selected other : O)
    (h : Obstructs keys selected other) :
    ¬ Snuffy.Book.UPTExistence.LexBetter keys selected other := by
  induction keys with
  | nil =>
      exact fun hBetter => hBetter
  | cons k ks ih =>
      change (∃ p, k selected p ∧ ¬ k other p) ∨
        (Snuffy.Book.UPTExistence.Equiv (k selected) (k other) ∧
          Obstructs ks selected other) at h
      intro hBetter
      change Snuffy.Book.UPTExistence.SSub (k selected) (k other) ∨
        (Snuffy.Book.UPTExistence.Equiv (k selected) (k other) ∧
          Snuffy.Book.UPTExistence.LexBetter ks selected other) at hBetter
      rcases h with ⟨p, hp, hMissing⟩ | ⟨hEqual, hRest⟩
      · rcases hBetter with hStrict | hTail
        · exact hMissing (hStrict.1 p hp)
        · exact hMissing (hTail.1.1 p hp)
      · rcases hBetter with hStrict | hTail
        · exact hStrict.2 hEqual.2
        · exact ih hRest hTail.2

/-- Completeness of the obstruction-witness calculus: if an option is
NOT strictly better in the original lexicographic order, classical logic
supplies either an explicit lost particular at the current stage or
stage equality and a certificate for the remaining stages. -/
theorem no_improvement_has_obstruction
    (keys : List (O → P → Prop)) (selected other : O)
    (hNo : ¬ Snuffy.Book.UPTExistence.LexBetter keys selected other) :
    Obstructs keys selected other := by
  classical
  induction keys with
  | nil =>
      trivial
  | cons k ks ih =>
      by_cases hWitness : ∃ p, k selected p ∧ ¬ k other p
      · exact Or.inl hWitness
      · have hForward : Snuffy.Book.UPTExistence.Sub (k selected) (k other) := by
          intro p hp
          by_cases hKeep : k other p
          · exact hKeep
          · exact False.elim (hWitness ⟨p, hp, hKeep⟩)
        have hBack : Snuffy.Book.UPTExistence.Sub (k other) (k selected) := by
          by_cases hReverse : Snuffy.Book.UPTExistence.Sub (k other) (k selected)
          · exact hReverse
          · exact False.elim (hNo (Or.inl ⟨hForward, hReverse⟩))
        have hTail : ¬ Snuffy.Book.UPTExistence.LexBetter ks selected other := by
          intro hBetter
          exact hNo (Or.inr ⟨⟨hForward, hBack⟩, hBetter⟩)
        exact Or.inr ⟨⟨hForward, hBack⟩, ih hTail⟩

/-- The stagewise obstruction is an EXACT reformulation of no strict
improvement, not an alternative order or a weakened objective. It can
be checked by explicit witnesses when a real model permits doing so. -/
theorem obstruction_iff_not_better
    (keys : List (O → P → Prop)) (selected other : O) :
    Obstructs keys selected other ↔
      ¬ Snuffy.Book.UPTExistence.LexBetter keys selected other :=
  ⟨obstruction_blocks_improvement keys selected other,
    no_improvement_has_obstruction keys selected other⟩

/-- If an outcome and a representative have identical retention sets at
EACH original priority stage, any alleged improvement by the outcome
would be an improvement by its representative. No feasibility filtering
or altered comparator is involved. -/
theorem improvement_transfers_to_faithful_profile :
    ∀ (keys : List (O → P → Prop)) (selected actual proxy : O),
      (∀ k, k ∈ keys → ∀ p, k actual p ↔ k proxy p) →
      Snuffy.Book.UPTExistence.LexBetter keys selected actual →
      Snuffy.Book.UPTExistence.LexBetter keys selected proxy := by
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
      change Snuffy.Book.UPTExistence.SSub (k selected) (k actual) ∨
        (Snuffy.Book.UPTExistence.Equiv (k selected) (k actual) ∧
          Snuffy.Book.UPTExistence.LexBetter ks selected actual) at hBetter
      change Snuffy.Book.UPTExistence.SSub (k selected) (k proxy) ∨
        (Snuffy.Book.UPTExistence.Equiv (k selected) (k proxy) ∧
          Snuffy.Book.UPTExistence.LexBetter ks selected proxy)
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

/-- Hostile-audit diagnosis: if a claimed improving actual outcome
exists and all listed representatives have valid obstruction witnesses,
then EITHER the actual profile is absent from the advertised coverage
OR some original priority-stage retention fact differs from its proxy.
This identifies precisely which two interfaces to investigate. -/
theorem alleged_improver_exposes_bad_audit
    (keys : List (O → P → Prop))
    (selected actual : O)
    (code : O → C) (representative : C → O) (profiles : List C)
    (hObstructions : ∀ c, c ∈ profiles →
      Obstructs keys selected (representative c))
    (hBetter : Snuffy.Book.UPTExistence.LexBetter keys selected actual) :
    code actual ∉ profiles ∨
      ∃ k, k ∈ keys ∧
        ∃ p, ¬ (k actual p ↔ k (representative (code actual)) p) := by
  classical
  by_cases hListed : code actual ∈ profiles
  · by_cases hBad : ∃ k, k ∈ keys ∧
        ∃ p, ¬ (k actual p ↔ k (representative (code actual)) p)
    · exact Or.inr hBad
    · have hSame : ∀ k, k ∈ keys → ∀ p,
          k actual p ↔ k (representative (code actual)) p := by
        intro k hk p
        by_cases hMatch : k actual p ↔
            k (representative (code actual)) p
        · exact hMatch
        · exact False.elim (hBad ⟨k, hk, p, hMatch⟩)
      exact False.elim ((obstruction_blocks_improvement keys selected
        (representative (code actual))
        (hObstructions (code actual) hListed))
        (improvement_transfers_to_faithful_profile keys
          selected actual (representative (code actual)) hSame hBetter))
  · exact Or.inl hListed

/-- Plug the *derived* IR-17 condition into full original-UPT maximality.
The safe subset must still contain the selected full-feasible outcome. -/
theorem audited_selected_global_maximal
    (keys : List (O → P → Prop))
    (full : O → Prop) (safe : List O) (selected : O)
    (hIncluded : ∀ o, o ∈ safe → full o)
    (hLocal : Snuffy.Book.UPTExistence.LexAlignedL (fun o => o ∈ safe) keys selected)
    (code : O → C) (representative : C → O) (profiles : List C)
    (hCovers : ∀ o, full o → code o ∈ profiles)
    (hFaithful : ∀ o, full o →
      ∀ k, k ∈ keys → ∀ p,
        k o p ↔ k (representative (code o)) p)
    (hObstructions : ∀ c, c ∈ profiles →
      Obstructs keys selected (representative c)) :
    Snuffy.Book.UPTExistence.LexAlignedL full keys selected := by
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
        ⟨⟨Snuffy.Book.UPTExistence.Sub.refl _, Snuffy.Book.UPTExistence.Sub.refl _⟩, trivial⟩

theorem local_choice :
    Snuffy.Book.UPTExistence.LexAlignedL
      (fun o : Outcome => o ∈ menu)
      ([key] : List (Outcome → Bool → Prop)) chosen := by
  constructor
  · simp [menu]
  · intro o ho
    have hEq : o = chosen := by simpa [menu] using ho
    subst o
    exact Snuffy.Book.UPTExistence.lex_irrefl _ chosen

/-- A genuine finite audit over the profiles proves original full-feasible
maximality even though the original feasible outcome type is infinite
and the safety menu has just one option. -/
theorem globally_maximal_without_cofinality :
    Snuffy.Book.UPTExistence.LexAlignedL full
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
    Snuffy.Book.UPTExistence.LexBetter
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
    ⟨⟨Snuffy.Book.UPTExistence.Sub.refl _, Snuffy.Book.UPTExistence.Sub.refl _⟩, trivial⟩

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

end PhysicalBridges.IRProfileAudit
