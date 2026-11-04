/-
Select an original full-feasible maximal outcome from a complete finite
retention-profile cover. The selected outcome, its global maximality and
the obstruction certificates are OUTPUTS. No no-excluded-improver or
preselected-outcome obstruction hypothesis is consumed.

The protected particular type and the original outcome type are arbitrary.
Only the family of distinct represented retention profiles is finite.
The comparator is exactly UPTExist.LexBetter at the supplied original keys.

The finite comparison algorithm requires a decision procedure for that
original comparator. The existence corollaries use classical logic; they
do not claim an effective comparator for arbitrary predicates.
-/
import PhysicalBridges.IRProfileAudit

namespace PhysicalBridges.IRMaximalProfileSelection
universe u v w
variable {P : Type u} {O : Type v} {C : Type w}

/-- All original priority-stage retention facts agree, for every particular. -/
def SameRetentions (keys : List (O → P → Prop)) (a b : O) : Prop :=
  ∀ k, k ∈ keys → ∀ p, k a p ↔ k b p

/-- A finite comparison algorithm. Its only oracle is the decision procedure
for the original comparator, never a replacement score or altered scope. -/
def selectMax (keys : List (O → P → Prop))
    [DecidableRel (UPTExist.LexBetter keys)] : List O → O → O
  | [], seed => seed
  | x :: rest, seed =>
      let candidate := selectMax keys rest seed
      if UPTExist.LexBetter keys candidate x then x else candidate

/-- The algorithm returns the seed or a listed representative, and no listed
representative strictly improves it in the original order. -/
theorem selectMax_certificate (keys : List (O → P → Prop))
    [DecidableRel (UPTExist.LexBetter keys)] :
    ∀ (representatives : List O) (seed : O),
      (selectMax keys representatives seed = seed ∨
        selectMax keys representatives seed ∈ representatives) ∧
      ∀ other, other ∈ representatives →
        ¬ UPTExist.LexBetter keys (selectMax keys representatives seed) other := by
  intro representatives
  induction representatives with
  | nil =>
      intro seed
      exact ⟨Or.inl rfl, fun _ h => nomatch h⟩
  | cons x rest ih =>
      intro seed
      obtain ⟨hMember, hMax⟩ := ih seed
      let candidate := selectMax keys rest seed
      by_cases hBetter : UPTExist.LexBetter keys candidate x
      · have hResult : selectMax keys (x :: rest) seed = x := by
          simp only [selectMax, candidate, ite_eq_left hBetter]
        rw [hResult]
        refine ⟨Or.inr List.mem_cons_self, ?_⟩
        intro other hOther hImproves
        cases hOther with
        | head => exact UPTExist.lex_irrefl keys x hImproves
        | tail _ hTail =>
            exact hMax other hTail
              (UPTExist.lex_trans keys candidate x other hBetter hImproves)
      · have hResult : selectMax keys (x :: rest) seed = candidate := by
          simp only [selectMax, candidate, ite_eq_right hBetter]
        rw [hResult]
        refine ⟨?_, ?_⟩
        · cases hMember with
          | inl h => exact Or.inl h
          | inr h => exact Or.inr (List.mem_cons_of_mem x h)
        · intro other hOther hImproves
          cases hOther with
          | head => exact hBetter hImproves
          | tail _ hTail => exact hMax other hTail hImproves

/-- Complete faithful coverage and feasible representatives lift the selected
representative to the FULL original family. Neither the family nor the
particular population is enumerated. -/
theorem selected_is_globally_aligned
    (keys : List (O → P → Prop))
    [DecidableRel (UPTExist.LexBetter keys)]
    (full : O → Prop) (representatives : List O)
    (seed : O) (hSeed : seed ∈ representatives)
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r) :
    UPTExist.LexAlignedL full keys (selectMax keys representatives seed) := by
  obtain ⟨hMember, hMax⟩ := selectMax_certificate keys representatives seed
  have hSelected : selectMax keys representatives seed ∈ representatives := by
    cases hMember with
    | inl h => exact (congrArg (fun o => o ∈ representatives) h).mpr hSeed
    | inr h => exact h
  refine ⟨hFeasible _ hSelected, ?_⟩
  intro actual hFull hImproves
  obtain ⟨r, hListed, hFaithful⟩ := hCover actual hFull
  exact hMax r hListed
    (IRProfileAudit.improvement_transfers_to_faithful_profile
      keys (selectMax keys representatives seed) actual r hFaithful hImproves)

/-- Existence, feasibility and EVERY full-family obstruction are derived after
selection. Compared with IR-25, no obstruction certificate for a preselected
choice is assumed. Classical existence supplies no arbitrary-predicate
comparison algorithm for a physical implementation. -/
theorem exists_global_maximal_of_finite_faithful_cover
    (keys : List (O → P → Prop)) (full : O → Prop)
    (representatives : List O)
    (hNonempty : ∃ r, r ∈ representatives)
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r) :
    ∃ selected, selected ∈ representatives ∧
      UPTExist.LexAlignedL full keys selected ∧
      ∀ actual, full actual → IRProfileAudit.Obstructs keys selected actual := by
  classical
  obtain ⟨seed, hSeed⟩ := hNonempty
  let selected := selectMax keys representatives seed
  have hAligned : UPTExist.LexAlignedL full keys selected :=
    selected_is_globally_aligned keys full representatives seed hSeed hFeasible hCover
  obtain ⟨hMember, _⟩ := selectMax_certificate keys representatives seed
  have hSelected : selected ∈ representatives := by
    cases hMember with
    | inl h => exact (congrArg (fun o => o ∈ representatives) h).mpr hSeed
    | inr h => exact h
  exact ⟨selected, hSelected, hAligned, fun actual hFull =>
    IRProfileAudit.no_improvement_has_obstruction keys selected actual
      (hAligned.2 actual hFull)⟩

/-- A representative is chosen from each inhabited ACTUAL feasible code fibre.
Feasibility of representatives is proved from the fibre witness, not assumed
of an arbitrary proxy. Nonemptiness supplies the unused outside-list default. -/
theorem representatives_from_inhabited_fibres
    (full : O → Prop) (code : O → C) (profiles : List C)
    (hNonempty : ∃ o, full o)
    (hInhabited : ∀ c, c ∈ profiles → ∃ o, full o ∧ code o = c) :
    ∃ representative : C → O,
      ∀ c, c ∈ profiles → full (representative c) ∧ code (representative c) = c := by
  classical
  obtain ⟨initial, hInitial⟩ := hNonempty
  let representative : C → O := fun c =>
    if h : c ∈ profiles then Classical.choose (hInhabited c h) else initial
  refine ⟨representative, ?_⟩
  intro c hListed
  simpa only [representative, dite_eq_left hListed] using
    Classical.choose_spec (hInhabited c hListed)

/-- Complete finite code image plus retention-constant feasible fibres constructs
an original full-feasible maximal outcome. The finite list covers CODES, not
all original outcomes. Obstructions are a conclusion of this construction. -/
theorem exists_global_maximal_of_inhabited_code_fibres
    (keys : List (O → P → Prop)) (full : O → Prop)
    (code : O → C) (profiles : List C)
    (hNonempty : ∃ o, full o)
    (hCodes : ∀ actual, full actual → code actual ∈ profiles)
    (hInhabited : ∀ c, c ∈ profiles → ∃ o, full o ∧ code o = c)
    (hConstant : ∀ a b, full a → full b → code a = code b →
      SameRetentions keys a b) :
    ∃ selected, UPTExist.LexAlignedL full keys selected ∧
      code selected ∈ profiles ∧
      ∀ actual, full actual → IRProfileAudit.Obstructs keys selected actual := by
  classical
  obtain ⟨representative, hRepresentative⟩ :=
    representatives_from_inhabited_fibres full code profiles hNonempty hInhabited
  let representatives := profiles.map representative
  have hFeasible : ∀ r, r ∈ representatives → full r := by
    intro r hListed
    obtain ⟨c, hCode, hEqual⟩ := List.mem_map.mp hListed
    rw [← hEqual]
    exact (hRepresentative c hCode).1
  have hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r := by
    intro actual hFull
    have hListed := hCodes actual hFull
    have hRep := hRepresentative (code actual) hListed
    exact ⟨representative (code actual),
      List.mem_map.mpr ⟨code actual, hListed, rfl⟩,
      hConstant actual (representative (code actual)) hFull hRep.1 hRep.2.symm⟩
  obtain ⟨initial, hInitial⟩ := hNonempty
  obtain ⟨seed, hSeed, _⟩ := hCover initial hInitial
  obtain ⟨selected, _, hAligned, hObstructions⟩ :=
    exists_global_maximal_of_finite_faithful_cover keys full representatives
      ⟨seed, hSeed⟩ hFeasible hCover
  exact ⟨selected, hAligned, hCodes selected hAligned.1, hObstructions⟩

namespace InfiniteChain

/-- In the original Nat-chain countermodel, equal full retention profiles
identify the outcome exactly. No finite lossless profile compression exists. -/
theorem profiles_separate (n m : Nat)
    (h : SameRetentions [UPTExist.chainKey] n m) : n = m := by
  have hForward := (h UPTExist.chainKey (by simp) n).mp (Nat.le_refl n)
  have hBackward := (h UPTExist.chainKey (by simp) m).mpr (Nat.le_refl m)
  exact Nat.le_antisymm hForward hBackward

private def listMaximum : List Nat → Nat
  | [] => 0
  | n :: rest => max n (listMaximum rest)

private theorem member_le_listMaximum : ∀ (items : List Nat) n,
    n ∈ items → n ≤ listMaximum items := by
  intro items
  induction items with
  | nil => intro _ h; nomatch h
  | cons x rest ih =>
      intro n h
      cases h with
      | head => exact Nat.le_max_left _ _
      | tail _ hTail =>
          exact Nat.le_trans (ih n hTail) (Nat.le_max_right _ _)

/-- New obstruction for the finite-profile ROUTE: the original infinite-chain
model cannot have a finite complete faithful list of retention representatives.
The original UPTExistence module already proves absence of a maximal option;
this does not claim a new counterexample to the full UPT target. -/
theorem no_finite_faithful_cover (representatives : List Nat) :
    ¬ (∀ n : Nat, ∃ r, r ∈ representatives ∧
      SameRetentions [UPTExist.chainKey] n r) := by
  intro hCover
  obtain ⟨r, hListed, hSame⟩ := hCover (listMaximum representatives + 1)
  have hEqual := profiles_separate (listMaximum representatives + 1) r hSame
  have hBound := member_le_listMaximum representatives r hListed
  rw [← hEqual] at hBound
  exact Nat.not_succ_le_self (listMaximum representatives) hBound

/-- No finite coding with exact fidelity at every original stage can hide
the infinitely many distinct profiles of that same original countermodel. -/
theorem no_finite_code_audit (code : Nat → C) (representative : C → Nat)
    (profiles : List C) :
    ¬ ((∀ n : Nat, code n ∈ profiles) ∧
      ∀ n : Nat, SameRetentions [UPTExist.chainKey] n (representative (code n))) := by
  intro h
  apply no_finite_faithful_cover (profiles.map representative)
  intro n
  exact ⟨representative (code n),
    List.mem_map.mpr ⟨code n, h.1 n, rfl⟩, h.2 n⟩

end InfiniteChain

namespace InfiniteOutcomeExample

/-- Infinitely many original particulars, infinitely many feasible outcomes,
and three retention profiles. All particulars live; freedom may cover the
even or odd particulars, or none. The last two stages have no new particulars. -/
abbrev Outcome := Option Bool × Nat
def full (_ : Outcome) : Prop := True
def life (_ : Outcome) (_ : Nat) : Prop := True
def freedom (o : Outcome) (p : Nat) : Prop :=
  match o.1 with
  | none => False
  | some false => p % 2 = 0
  | some true => p % 2 = 1
def newLife (_ : Outcome) (_ : Nat) : Prop := False
def newFreedom (_ : Outcome) (_ : Nat) : Prop := False
def keys : List (Outcome → Nat → Prop) := [life, freedom, newLife, newFreedom]
def code (o : Outcome) : Option Bool := o.1
def profiles : List (Option Bool) := [none, some false, some true]

theorem complete_code_image : ∀ o : Outcome, full o → code o ∈ profiles := by
  intro o _
  cases h : o.1 with
  | none => simp [code, profiles, h]
  | some b => cases b <;> simp [code, profiles, h]

theorem inhabited_fibres : ∀ c, c ∈ profiles →
    ∃ o : Outcome, full o ∧ code o = c := by
  intro c _
  exact ⟨(c, 0), trivial, rfl⟩

theorem constant_retention_fibres : ∀ a b : Outcome,
    full a → full b → code a = code b → SameRetentions keys a b := by
  intro a b _ _ hCode k hKey p
  change a.1 = b.1 at hCode
  simp only [keys, List.mem_cons] at hKey
  rcases hKey with rfl | rfl | rfl | rfl | hNone
  · rfl
  · simp only [freedom, hCode]
  · rfl
  · rfl
  · cases hNone

/-- The generic construction selects a genuine full-family maximal outcome
without any supplied no-improver or stagewise obstruction certificates. -/
theorem maximal_outcome_is_constructed :
    ∃ selected : Outcome, UPTExist.LexAlignedL full keys selected ∧
      code selected ∈ profiles ∧
      ∀ actual, full actual → IRProfileAudit.Obstructs keys selected actual := by
  exact exists_global_maximal_of_inhabited_code_fibres keys full code profiles
    ⟨(none, 0), trivial⟩ complete_code_image inhabited_fibres constant_retention_fibres

/-- Both outcome metadata and the protected particular type remain unbounded. -/
theorem full_outcomes_for_every_metadata (c : Option Bool) (n : Nat) : full (c, n) :=
  trivial

/-- The example has no outcome granting both parity classes every freedom.
The selection theorem does not replace maximality with a greatest/top witness. -/
theorem no_outcome_grants_every_freedom (o : Outcome) :
    ¬ (∀ p : Nat, freedom o p) := by
  intro hAll
  cases h : o.1 with
  | none => exact (by simpa [freedom, h] using hAll 0)
  | some b =>
      cases b with
      | false => exact (by simpa [freedom, h] using hAll 1)
      | true => exact (by simpa [freedom, h] using hAll 0)

end InfiniteOutcomeExample

#print axioms selectMax_certificate
#print axioms selected_is_globally_aligned
#print axioms exists_global_maximal_of_finite_faithful_cover
#print axioms representatives_from_inhabited_fibres
#print axioms exists_global_maximal_of_inhabited_code_fibres
#print axioms InfiniteChain.profiles_separate
#print axioms InfiniteChain.no_finite_faithful_cover
#print axioms InfiniteChain.no_finite_code_audit
#print axioms InfiniteOutcomeExample.complete_code_image
#print axioms InfiniteOutcomeExample.inhabited_fibres
#print axioms InfiniteOutcomeExample.constant_retention_fibres
#print axioms InfiniteOutcomeExample.maximal_outcome_is_constructed
#print axioms InfiniteOutcomeExample.full_outcomes_for_every_metadata
#print axioms InfiniteOutcomeExample.no_outcome_grants_every_freedom
end PhysicalBridges.IRMaximalProfileSelection
