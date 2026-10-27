/-
IR-56: The original infinite chainKey family does not have a finite
faithful retention quotient. The finite-profile audit remains a valid
conditional theorem, not an unrestricted existence theorem.
-/
import PhysicalBridges.IRProfileAudit

namespace PhysicalBridges.IRFiniteProfileObstruction
universe u

/-- An explicit bound above every value in a finite list. -/
def aboveEvery : List Nat → Nat
  | [] => 0
  | n :: rest => n + aboveEvery rest + 1

theorem aboveEvery_gt_mem :
    ∀ (values : List Nat) (n : Nat),
      n ∈ values → n < aboveEvery values := by
  intro values
  induction values with
  | nil =>
      intro n hn
      cases hn
  | cons head tail ih =>
      intro n hn
      simp only [List.mem_cons] at hn
      rcases hn with heq | hm
      · subst n
        simp only [aboveEvery]
        omega
      · have ht := ih n hm
        simp only [aboveEvery]
        omega

/-- Faithfulness on ALL original retention facts identifies the actual
Nat outcome: a profile cannot collapse two unequal chain indices. -/
theorem faithful_chain_rep_is_exact
    {Code : Type u} (encode : Nat → Code) (represent : Code → Nat)
    (hFaithful : ∀ n p : Nat,
      (UPTExist.chainKey n p ↔
        UPTExist.chainKey (represent (encode n)) p)) :
    ∀ n, represent (encode n) = n := by
  intro n
  have hForward : n ≤ represent (encode n) :=
    (hFaithful n n).mp (Nat.le_refl n)
  have hBackward : represent (encode n) ≤ n :=
    (hFaithful n (represent (encode n))).mpr
      (Nat.le_refl (represent (encode n)))
  omega

/-- No finite set of codes covers every original chain outcome while
retaining all its original priority facts. -/
theorem no_finite_faithful_chain_profiles
    {Code : Type u} (profiles : List Code)
    (encode : Nat → Code) (represent : Code → Nat)
    (hCovers : ∀ n : Nat, encode n ∈ profiles)
    (hFaithful : ∀ n p : Nat,
      (UPTExist.chainKey n p ↔
        UPTExist.chainKey (represent (encode n)) p)) :
    False := by
  let n := aboveEvery (profiles.map represent)
  have hMember : represent (encode n) ∈ profiles.map represent :=
    List.mem_map_of_mem represent (hCovers n)
  have hBelow : represent (encode n) < n :=
    aboveEvery_gt_mem (profiles.map represent)
      (represent (encode n)) hMember
  have hExact : represent (encode n) = n :=
    faithful_chain_rep_is_exact encode represent hFaithful n
  omega

theorem impossible_finite_profile_audit_for_original_chain
    {Code : Type u} (profiles : List Code) :
    ¬ ∃ (encode : Nat → Code) (represent : Code → Nat),
      (∀ n : Nat, encode n ∈ profiles) ∧
      (∀ n p : Nat,
        UPTExist.chainKey n p ↔
        UPTExist.chainKey (represent (encode n)) p) := by
  rintro ⟨encode, represent, hCover, hFaithful⟩
  exact no_finite_faithful_chain_profiles
    profiles encode represent hCover hFaithful

/-- Source original already proves that the unbounded chain has no
global maximal outcome. This conclusion is not inferred merely
from the finite-profile failure. -/
theorem unbounded_chain_lacks_global_maximum :
    ∀ n, ¬ UPTExist.Aligned (fun _ : Nat => True)
      UPTExist.chainKey n :=
  UPTExist.infinite_family_has_no_aligned_option

#print axioms aboveEvery_gt_mem
#print axioms faithful_chain_rep_is_exact
#print axioms no_finite_faithful_chain_profiles
#print axioms impossible_finite_profile_audit_for_original_chain
#print axioms unbounded_chain_lacks_global_maximum
end PhysicalBridges.IRFiniteProfileObstruction
