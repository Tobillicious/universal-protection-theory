/-
Select an IMPLEMENTABLE global maximum of the unchanged original UPT order.
An arbitrary maximal tie can be unimplementable. This module instead tests
global profile maximality against the complete feasible representative family
and searches only then for a candidate whose implementation is witnessed.

There is no all-menu implementation premise, no preselected no-improver
premise, no greatest/top requirement and no finite original population or
outcome assumption. Exact implementation invariance under the full retention
profile is the explicit completeness interface; soundness of a found answer
does not need that additional invariance.
-/
import PhysicalBridges.IRMaximalProfileSelection

namespace PhysicalBridges.IRImplementableProfileSelection
open IRMaximalProfileSelection
universe u v
variable {P : Type u} {O : Type v}

/-- Retention equality transports BOTH arguments of the exact original
comparator, rather than only an alleged improving alternative. -/
theorem comparison_iff_of_same_retentions :
    ∀ (keys : List (O → P → Prop)) (a a' b b' : O),
      SameRetentions keys a a' → SameRetentions keys b b' →
      (UPTExist.LexBetter keys a b ↔ UPTExist.LexBetter keys a' b') := by
  intro keys
  induction keys with
  | nil => intro _ _ _ _ _ _; rfl
  | cons k rest ih =>
      intro a a' b b' hA hB
      have hKeyA : k a = k a' := by
        funext p
        exact propext (hA k (by simp) p)
      have hKeyB : k b = k b' := by
        funext p
        exact propext (hB k (by simp) p)
      have hTailA : SameRetentions rest a a' :=
        fun j hj p => hA j (List.mem_cons_of_mem k hj) p
      have hTailB : SameRetentions rest b b' :=
        fun j hj p => hB j (List.mem_cons_of_mem k hj) p
      change
        (UPTExist.SSub (k a) (k b) ∨
          (UPTExist.Equiv (k a) (k b) ∧ UPTExist.LexBetter rest a b)) ↔
        (UPTExist.SSub (k a') (k b') ∨
          (UPTExist.Equiv (k a') (k b') ∧ UPTExist.LexBetter rest a' b'))
      rw [hKeyA, hKeyB, ih a a' b b' hTailA hTailB]

/-- A listed representative maximal among a COMPLETE faithful feasible cover
is globally maximal in the original full feasible family. -/
theorem representative_maximal_lifts
    (keys : List (O → P → Prop)) (full : O → Prop)
    (representatives : List O)
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r)
    (selected : O) (hSelected : selected ∈ representatives)
    (hMax : ∀ q, q ∈ representatives → ¬ UPTExist.LexBetter keys selected q) :
    UPTExist.LexAlignedL full keys selected := by
  refine ⟨hFeasible selected hSelected, ?_⟩
  intro actual hActual hBetter
  obtain ⟨r, hListed, hSame⟩ := hCover actual hActual
  exact hMax r hListed
    (IRProfileAudit.improvement_transfers_to_faithful_profile
      keys selected actual r hSame hBetter)

/-- EXACT finite criterion for an implementable original global maximum.
Only the eventual selected maximal representative must be implementable.
Implementation of all representatives is neither assumed nor concluded. -/
theorem implementable_global_maximal_iff_finite_audit
    (keys : List (O → P → Prop)) (full : O → Prop)
    (representatives : List O) (Implements : O → Prop)
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r)
    (hImplementsInvariant : ∀ a b, full a → full b →
      SameRetentions keys a b → (Implements a ↔ Implements b)) :
    (∃ o, UPTExist.LexAlignedL full keys o ∧ Implements o) ↔
      ∃ r, r ∈ representatives ∧
        (∀ q, q ∈ representatives → ¬ UPTExist.LexBetter keys r q) ∧
        Implements r := by
  constructor
  · rintro ⟨o, hAligned, hImplements⟩
    obtain ⟨r, hListed, hSame⟩ := hCover o hAligned.1
    have hRepFeasible := hFeasible r hListed
    refine ⟨r, hListed, ?_,
      (hImplementsInvariant o r hAligned.1 hRepFeasible hSame).mp hImplements⟩
    intro q hQ hImproves
    have hReflexive : SameRetentions keys q q := fun _ _ _ => Iff.rfl
    exact hAligned.2 q (hFeasible q hQ)
      ((comparison_iff_of_same_retentions keys o r q q hSame hReflexive).mpr hImproves)
  · rintro ⟨r, hListed, hMax, hImplements⟩
    exact ⟨r, representative_maximal_lifts keys full representatives
      hFeasible hCover r hListed hMax, hImplements⟩

/-- The finite Boolean test keeps the original comparator. It first checks
the candidate against EVERY representative, including unimplementable ones. -/
def passesAudit (keys : List (O → P → Prop)) (representatives : List O)
    (Implements : O → Prop) [DecidableRel (UPTExist.LexBetter keys)]
    [DecidablePred Implements] (candidate : O) : Bool :=
  representatives.all (fun other => !(decide (UPTExist.LexBetter keys candidate other))) &&
    decide (Implements candidate)

theorem passesAudit_iff
    (keys : List (O → P → Prop)) (representatives : List O)
    (Implements : O → Prop) [DecidableRel (UPTExist.LexBetter keys)]
    [DecidablePred Implements] (candidate : O) :
    passesAudit keys representatives Implements candidate = true ↔
      (∀ q, q ∈ representatives → ¬ UPTExist.LexBetter keys candidate q) ∧
      Implements candidate := by
  simp [passesAudit, List.all_eq_true]

/-- Search the FULL maximal profile set for an implementable member. Finding
the best member of the implementable subset alone would give a weaker result. -/
def findImplementableMax (keys : List (O → P → Prop)) (representatives : List O)
    (Implements : O → Prop) [DecidableRel (UPTExist.LexBetter keys)]
    [DecidablePred Implements] : Option O :=
  representatives.find? (passesAudit keys representatives Implements)

theorem search_sound
    (keys : List (O → P → Prop)) (representatives : List O)
    (Implements : O → Prop) [DecidableRel (UPTExist.LexBetter keys)]
    [DecidablePred Implements] (selected : O)
    (hFound : findImplementableMax keys representatives Implements = some selected) :
    selected ∈ representatives ∧
      (∀ q, q ∈ representatives → ¬ UPTExist.LexBetter keys selected q) ∧
      Implements selected := by
  exact ⟨List.mem_of_find?_eq_some hFound,
    (passesAudit_iff keys representatives Implements selected).mp
      (List.find?_some hFound)⟩

theorem search_none_iff_no_audited_candidate
    (keys : List (O → P → Prop)) (representatives : List O)
    (Implements : O → Prop) [DecidableRel (UPTExist.LexBetter keys)]
    [DecidablePred Implements] :
    findImplementableMax keys representatives Implements = none ↔
      ¬ (∃ r, r ∈ representatives ∧
        (∀ q, q ∈ representatives → ¬ UPTExist.LexBetter keys r q) ∧
        Implements r) := by
  constructor
  · intro hNone
    rintro ⟨r, hListed, hMax, hImplements⟩
    exact (List.find?_eq_none.mp hNone) r hListed
      ((passesAudit_iff keys representatives Implements r).mpr ⟨hMax, hImplements⟩)
  · intro hNoCandidate
    apply List.find?_eq_none.mpr
    intro r hListed hPass
    exact hNoCandidate ⟨r, hListed,
      (passesAudit_iff keys representatives Implements r).mp hPass⟩

/-- Soundness of an actual returned candidate needs no profile invariance
of implementation: its own implementation witness is already checked. -/
theorem found_is_implementable_global_maximal
    (keys : List (O → P → Prop)) (full : O → Prop)
    (representatives : List O) (Implements : O → Prop)
    [DecidableRel (UPTExist.LexBetter keys)] [DecidablePred Implements]
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r)
    (selected : O)
    (hFound : findImplementableMax keys representatives Implements = some selected) :
    UPTExist.LexAlignedL full keys selected ∧ Implements selected := by
  obtain ⟨hListed, hMax, hImplements⟩ :=
    search_sound keys representatives Implements selected hFound
  exact ⟨representative_maximal_lifts keys full representatives hFeasible hCover
    selected hListed hMax, hImplements⟩

/-- A negative search result is COMPLETE over the original full family under
the exact implementation-invariance interface. No original feasible outcome
is silently dropped because its representative was difficult to implement. -/
theorem search_none_iff_no_implementable_global_maximal
    (keys : List (O → P → Prop)) (full : O → Prop)
    (representatives : List O) (Implements : O → Prop)
    [DecidableRel (UPTExist.LexBetter keys)] [DecidablePred Implements]
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r)
    (hImplementsInvariant : ∀ a b, full a → full b →
      SameRetentions keys a b → (Implements a ↔ Implements b)) :
    findImplementableMax keys representatives Implements = none ↔
      ¬ (∃ o, UPTExist.LexAlignedL full keys o ∧ Implements o) := by
  rw [search_none_iff_no_audited_candidate]
  exact not_congr (implementable_global_maximal_iff_finite_audit
    keys full representatives Implements hFeasible hCover hImplementsInvariant).symm

/-- Success returns the actual selected implementable global maximum, and
occurs exactly when such an outcome exists in the original full family. -/
theorem search_success_iff_implementable_global_maximal
    (keys : List (O → P → Prop)) (full : O → Prop)
    (representatives : List O) (Implements : O → Prop)
    [DecidableRel (UPTExist.LexBetter keys)] [DecidablePred Implements]
    (hFeasible : ∀ r, r ∈ representatives → full r)
    (hCover : ∀ actual, full actual →
      ∃ r, r ∈ representatives ∧ SameRetentions keys actual r)
    (hImplementsInvariant : ∀ a b, full a → full b →
      SameRetentions keys a b → (Implements a ↔ Implements b)) :
    (∃ selected, findImplementableMax keys representatives Implements = some selected ∧
      UPTExist.LexAlignedL full keys selected ∧ Implements selected) ↔
      ∃ o, UPTExist.LexAlignedL full keys o ∧ Implements o := by
  constructor
  · rintro ⟨selected, _, hAligned, hImplements⟩
    exact ⟨selected, hAligned, hImplements⟩
  · intro hExists
    cases hResult : findImplementableMax keys representatives Implements with
    | none =>
        exact False.elim ((search_none_iff_no_implementable_global_maximal
          keys full representatives Implements hFeasible hCover hImplementsInvariant).mp
          hResult hExists)
    | some selected =>
        exact ⟨selected, rfl, found_is_implementable_global_maximal
          keys full representatives Implements hFeasible hCover selected hResult⟩

private theorem equal_head_iff (k : O → P → Prop) (rest : List (O → P → Prop))
    (a b : O) (hEqual : k a = k b) :
    UPTExist.LexBetter (k :: rest) a b ↔ UPTExist.LexBetter rest a b := by
  change (UPTExist.SSub (k a) (k b) ∨
    (UPTExist.Equiv (k a) (k b) ∧ UPTExist.LexBetter rest a b)) ↔ _
  rw [hEqual]
  constructor
  · rintro (hStrict | ⟨_, hLater⟩)
    · exact False.elim (hStrict.2 (UPTExist.Sub.refl _))
    · exact hLater
  · intro hLater
    exact Or.inr ⟨⟨UPTExist.Sub.refl _, UPTExist.Sub.refl _⟩, hLater⟩

namespace TieExample

def life (_ : Bool) (_ : Bool) : Prop := True
def freedom (choice particular : Bool) : Prop := choice = particular
def newLife (_ : Bool) (_ : Bool) : Prop := False
def newFreedom (_ : Bool) (_ : Bool) : Prop := False
def keys : List (Bool → Bool → Prop) := [life, freedom, newLife, newFreedom]
def Implements (choice : Bool) : Prop := choice = false

private theorem no_strict_improvement (a b : Bool) :
    ¬ UPTExist.LexBetter keys a b := by
  intro hBetter
  have hLater := (equal_head_iff life [freedom, newLife, newFreedom] a b rfl).mp hBetter
  rcases hLater with hStrict | ⟨_, hTail⟩
  · have hEqual : b = a := hStrict.1 a rfl
    apply hStrict.2
    rw [hEqual]
    exact UPTExist.Sub.refl _
  · have hLast := (equal_head_iff newLife [newFreedom] a b rfl).mp hTail
    exact (equal_head_iff newFreedom [] a b rfl).mp hLast

instance : DecidableRel (UPTExist.LexBetter keys) :=
  fun a b => isFalse (no_strict_improvement a b)
instance : DecidablePred Implements := fun choice => by
  change Decidable (choice = false)
  infer_instance

/-- An arbitrary maximal tie returned by the earlier selector can lack an
implementation, despite the presence of an implementable maximal peer. -/
theorem arbitrary_maximal_tie_misses_implementation :
    selectMax keys [true, false] true = true ∧ ¬ Implements true := by
  constructor <;> decide

/-- The new search finds the implementable peer while retaining the full
comparison menu. It does not require the other maximal peer to be implemented. -/
theorem search_recovers_implementable_tie :
    findImplementableMax keys [true, false] Implements = some false := by
  rfl

end TieExample

namespace DominatedImplementationExample

def life (_ : Bool) (_ : Bool) : Prop := True
def freedom (choice : Bool) (_ : Bool) : Prop := choice = true
def newLife (_ : Bool) (_ : Bool) : Prop := False
def newFreedom (_ : Bool) (_ : Bool) : Prop := False
def keys : List (Bool → Bool → Prop) := [life, freedom, newLife, newFreedom]
def full (_ : Bool) : Prop := True
def Implements (choice : Bool) : Prop := choice = false

theorem false_is_strictly_improvable : UPTExist.LexBetter keys false true := by
  apply Or.inr
  refine ⟨⟨fun _ _ => trivial, fun _ _ => trivial⟩, Or.inl ?_⟩
  constructor
  · intro _ _; rfl
  · intro hBack
    exact Bool.noConfusion (hBack false rfl)

private theorem true_not_improvable (other : Bool) :
    ¬ UPTExist.LexBetter keys true other := by
  intro hBetter
  have hLater :=
    (equal_head_iff life [freedom, newLife, newFreedom] true other rfl).mp hBetter
  have hForward : UPTExist.Sub (freedom true) (freedom other) := by
    rcases hLater with hStrict | ⟨hSame, _⟩
    · exact hStrict.1
    · exact hSame.1
  have hEqual : other = true := hForward false rfl
  rw [hEqual] at hBetter
  exact UPTExist.lex_irrefl keys true hBetter

instance : DecidableRel (UPTExist.LexBetter keys) := by
  intro a b
  cases a <;> cases b
  · exact isFalse (UPTExist.lex_irrefl keys false)
  · exact isTrue false_is_strictly_improvable
  · exact isFalse (true_not_improvable false)
  · exact isFalse (UPTExist.lex_irrefl keys true)
instance : DecidablePred Implements := fun choice => by
  change Decidable (choice = false)
  infer_instance

/-- A merely implementable option can be globally dominated. The search
correctly refuses to weaken the full-feasible comparator to that subset. -/
theorem search_rejects_dominated_implementation :
    findImplementableMax keys [false, true] Implements = none := by
  rfl

theorem implementation_exists_but_no_global_maximal_implementation :
    (∃ o, full o ∧ Implements o) ∧
      ¬ (∃ o, UPTExist.LexAlignedL full keys o ∧ Implements o) := by
  refine ⟨⟨false, trivial, rfl⟩, ?_⟩
  rintro ⟨o, hAligned, hImplements⟩
  change o = false at hImplements
  rw [hImplements] at hAligned
  exact hAligned.2 true trivial false_is_strictly_improvable

end DominatedImplementationExample

namespace MissingImplementationInvariant

def key (_ : Nat) (_ : Nat) : Prop := True
def keys : List (Nat → Nat → Prop) := [key, key, key, key]
def full (_ : Nat) : Prop := True
def Implements (outcome : Nat) : Prop := outcome = 0

private theorem same_profile (a b : Nat) : SameRetentions keys a b := by
  intro k hk p
  have hKey : k = key := by simpa [keys] using hk
  subst k
  rfl

private theorem no_strict_improvement (a b : Nat) :
    ¬ UPTExist.LexBetter keys a b := by
  simp [keys, key, UPTExist.LexBetter, UPTExist.SSub, UPTExist.Sub, UPTExist.Equiv]

/-- Faithful retention profiles alone can forget implementation-relevant
metadata. This is why the completeness theorem explicitly requires the
implementation relation to be invariant, or the profiles to be refined. -/
theorem faithful_cover_can_miss_implementable_maximum :
    (∀ r : Nat, r ∈ [1] → full r) ∧
      (∀ actual : Nat, full actual →
        ∃ r, r ∈ [1] ∧ SameRetentions keys actual r) ∧
      (∃ o, UPTExist.LexAlignedL full keys o ∧ Implements o) ∧
      ¬ (∃ r : Nat, r ∈ [1] ∧ Implements r) := by
  refine ⟨fun _ _ => trivial, ?_, ?_, ?_⟩
  · intro actual _
    exact ⟨1, by simp, same_profile actual 1⟩
  · exact ⟨0, ⟨trivial, fun other _ => no_strict_improvement 0 other⟩, rfl⟩
  · rintro ⟨r, hListed, hImplements⟩
    have hOne : r = 1 := by simpa using hListed
    change r = 0 at hImplements
    rw [hOne] at hImplements
    exact Nat.noConfusion hImplements

end MissingImplementationInvariant

#print axioms comparison_iff_of_same_retentions
#print axioms representative_maximal_lifts
#print axioms implementable_global_maximal_iff_finite_audit
#print axioms passesAudit_iff
#print axioms search_sound
#print axioms search_none_iff_no_audited_candidate
#print axioms found_is_implementable_global_maximal
#print axioms search_none_iff_no_implementable_global_maximal
#print axioms search_success_iff_implementable_global_maximal
#print axioms TieExample.arbitrary_maximal_tie_misses_implementation
#print axioms TieExample.search_recovers_implementable_tie
#print axioms DominatedImplementationExample.false_is_strictly_improvable
#print axioms DominatedImplementationExample.search_rejects_dominated_implementation
#print axioms DominatedImplementationExample.implementation_exists_but_no_global_maximal_implementation
#print axioms MissingImplementationInvariant.faithful_cover_can_miss_implementable_maximum
end PhysicalBridges.IRImplementableProfileSelection
