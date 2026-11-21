import Snuffy.AnchorPledgeForfeiture
import Snuffy.EnergyFounding
import Mathlib.Data.Finset.Sort

/-!
Lemma F' joined to the executable failure-settlement controller.

The original complete activation bill is itemised into the already charged
part and the reserved complete service charges. Refundable incoming pledges
are not bonus income. Every actual contributor subset is funded by the same
preposted anchor stock; the source then settles under every adaptive request
policy. Physical quantisation, custody, mediation and fee completeness remain
the standing source/installation obligations.
-/

namespace Snuffy.FoundingEscrowBridge

open Finset PhysicalBridges.AnchorPledgeForfeiture

def claimOf (pledge bonus fee : Nat → Nat) (i : Nat) : Claim :=
  ⟨i, pledge i, bonus i, fee i⟩

def claimsOf (S : Finset Nat) (pledge bonus fee : Nat → Nat) : List Claim :=
  S.sort.map (claimOf pledge bonus fee)

theorem claimsOf_recipients (S : Finset Nat) (pledge bonus fee : Nat → Nat) :
    (claimsOf S pledge bonus fee).map Claim.recipient = S.sort := by
  simp [claimsOf, List.map_map, Function.comp_def, claimOf]

theorem claimsOf_no_duplicate_recipients (S : Finset Nat) (pledge bonus fee : Nat → Nat) :
    ((claimsOf S pledge bonus fee).map Claim.recipient).Nodup := by
  rw [claimsOf_recipients]
  exact S.sort_nodup (· ≤ ·)

theorem refundTotal_claimsOf (S : Finset Nat) (pledge bonus fee : Nat → Nat) :
    refundTotal (claimsOf S pledge bonus fee) = ∑ i ∈ S, pledge i := by
  have h : ∀ xs : List Nat,
      refundTotal (xs.map (claimOf pledge bonus fee)) = (xs.map pledge).sum := by
    intro xs
    induction xs with
    | nil => rfl
    | cons i xs ih => simp only [List.map_cons, refundTotal, claimOf, List.sum_cons, ih]
  rw [claimsOf, h]
  calc
    _ = (S.toList.map pledge).sum := ((S.sort_perm_toList (· ≤ ·)).map pledge).sum_eq
    _ = ∑ i ∈ S, pledge i := Finset.sum_map_toList S pledge

theorem bonusTotal_claimsOf (S : Finset Nat) (pledge bonus fee : Nat → Nat) :
    bonusTotal (claimsOf S pledge bonus fee) = ∑ i ∈ S, bonus i := by
  have h : ∀ xs : List Nat,
      bonusTotal (xs.map (claimOf pledge bonus fee)) = (xs.map bonus).sum := by
    intro xs
    induction xs with
    | nil => rfl
    | cons i xs ih => simp only [List.map_cons, bonusTotal, claimOf, List.sum_cons, ih]
  rw [claimsOf, h]
  calc
    _ = (S.toList.map bonus).sum := ((S.sort_perm_toList (· ≤ ·)).map bonus).sum_eq
    _ = ∑ i ∈ S, bonus i := Finset.sum_map_toList S bonus

theorem workTotal_claimsOf (S : Finset Nat) (pledge bonus fee : Nat → Nat) :
    workTotal (claimsOf S pledge bonus fee) = ∑ i ∈ S, fee i := by
  have h : ∀ xs : List Nat,
      workTotal (xs.map (claimOf pledge bonus fee)) = (xs.map fee).sum := by
    intro xs
    induction xs with
    | nil => rfl
    | cons i xs ih => simp only [List.map_cons, workTotal, claimOf, List.sum_cons, ih]
  rw [claimsOf, h]
  calc
    _ = (S.toList.map fee).sum := ((S.sort_perm_toList (· ≤ ·)).map fee).sum_eq
    _ = ∑ i ∈ S, fee i := Finset.sum_map_toList S fee

theorem cashTotal_claimsOf (S : Finset Nat) (pledge bonus fee : Nat → Nat) :
    cashTotal (claimsOf S pledge bonus fee) =
      (∑ i ∈ S, pledge i) + ∑ i ∈ S, bonus i := by
  rw [cashTotal, refundTotal_claimsOf, bonusTotal_claimsOf]

theorem every_paid_prefix_has_unique_recipients
    (S : Finset Nat) (pledge bonus fee : Nat → Nat) (available bond : Nat)
    (policy : Nat → State → Request) (n : Nat) :
    ((run policy (fundedState available bond (claimsOf S pledge bonus fee)) n).paid.map
      Claim.recipient).Nodup := by
  have h := run_inventory policy (fundedState available bond (claimsOf S pledge bonus fee)) n
  have hAll :
      (((run policy (fundedState available bond (claimsOf S pledge bonus fee)) n).paid ++
        (run policy (fundedState available bond (claimsOf S pledge bonus fee)) n).pending).map
        Claim.recipient).Nodup := by
    rw [h]
    simpa only [fundedState, List.nil_append] using
      claimsOf_no_duplicate_recipients S pledge bonus fee
  rw [List.map_append] at hAll
  exact hAll.of_append_left

/-- This is an itemisation of the existing complete activation bill. It does
not create an additional budget or silently set controller work to zero. -/
theorem complete_activation_funds_service (N : Finset Nat) (bonus fee : Nat → Nat)
    (anchorStock bond activation completeActivation : Nat)
    (hBill : bond + completeActivation + (∑ i ∈ N, bonus i) ≤ anchorStock)
    (hCosts : completeActivation = activation + ∑ i ∈ N, fee i) :
    bond + activation + (∑ i ∈ N, bonus i) + (∑ i ∈ N, fee i) ≤ anchorStock := by
  omega

/-- The accepted source retains every ticket, reserves its complete payment
and service bill, conserves every prefix, and pays every full ticket under
arbitrary requests depending on the current state and time. -/
def SourceGuarantee (S : Finset Nat) (pledge bonus fee : Nat → Nat)
    (anchorStock bond activation : Nat) : Prop :=
  ∃ start : State,
    commit (anchorStock + (∑ i ∈ S, pledge i) - activation) bond
      (claimsOf S pledge bonus fee) = some start ∧
    start.pending = claimsOf S pledge bonus fee ∧ start.paid = [] ∧
    Ready start ∧
    stock start = anchorStock + (∑ i ∈ S, pledge i) - activation ∧
    (∀ policy n, Ready (run policy start n) ∧ stock (run policy start n) = stock start) ∧
    (∀ policy,
      (run policy start start.pending.length).pending = [] ∧
      (run policy start start.pending.length).paid = claimsOf S pledge bonus fee)

theorem funded_failure_source_guarantee
    (N S : Finset Nat) (pledge bonus fee : Nat → Nat)
    (anchorStock bond activation : Nat) (hS : S ⊆ N)
    (hBudget : bond + activation + (∑ i ∈ N, bonus i) +
      (∑ i ∈ N, fee i) ≤ anchorStock) :
    SourceGuarantee S pledge bonus fee anchorStock bond activation := by
  have hBonus : (∑ i ∈ S, bonus i) ≤ ∑ i ∈ N, bonus i :=
    Finset.sum_le_sum_of_subset_of_nonneg hS (fun i _ _ => Nat.zero_le (bonus i))
  have hFees : (∑ i ∈ S, fee i) ≤ ∑ i ∈ N, fee i :=
    Finset.sum_le_sum_of_subset_of_nonneg hS (fun i _ _ => Nat.zero_le (fee i))
  let claims := claimsOf S pledge bonus fee
  let available := anchorStock + (∑ i ∈ S, pledge i) - activation
  have hReady : bond + cashTotal claims + workTotal claims ≤ available := by
    dsimp [claims, available]
    rw [cashTotal_claimsOf, workTotal_claimsOf]
    omega
  let start := fundedState available bond claims
  have hStart : Ready start := fundedState_ready available bond claims
  refine ⟨start, commit_accepts_funded available bond claims hReady, rfl, rfl,
    hStart, fundedState_stock available bond claims hReady, ?_, ?_⟩
  · intro policy n
    exact ⟨run_ready policy start hStart n, run_stock policy start n⟩
  · intro policy
    have h := funded_failure_settles_every_claim policy start hStart
    simpa only [start, fundedState, List.nil_append] using h

/-- The same committed complete bill funds every contributor subset. -/
theorem every_subset_has_source_guarantee
    (N : Finset Nat) (pledge bonus fee : Nat → Nat)
    (anchorStock bond activation completeActivation : Nat)
    (hBill : bond + completeActivation + (∑ i ∈ N, bonus i) ≤ anchorStock)
    (hCosts : completeActivation = activation + ∑ i ∈ N, fee i) :
    ∀ S, S ⊆ N → SourceGuarantee S pledge bonus fee anchorStock bond activation := by
  intro S hS
  exact funded_failure_source_guarantee N S pledge bonus fee anchorStock bond activation hS
    (complete_activation_funds_service N bonus fee anchorStock bond activation completeActivation
      hBill hCosts)

/-- Lemma F' with the source-backed refund/bonus promise. Positive ordinary
pledges, positive failure bonus and the pivotal margin are exactly the
established all-necessary mechanism's premises; the already-funded public-good
case is never introduced. The escrow theorem requires no anchor cooperation. -/
theorem collateral_backed_all_necessary
    (N : Finset Nat) (pledge bonus fee : Nat → Nat)
    (hPledge : ∀ j ∈ N, 0 < pledge j)
    (i : Nat) (hi : i ∈ N) (T : Finset Nat) (hT : T ⊆ N.erase i)
    (anchorStock bond activation completeActivation : Nat)
    (hBill : bond + completeActivation + (∑ j ∈ N, bonus j) ≤ anchorStock)
    (hCosts : completeActivation = activation + ∑ j ∈ N, fee j)
    (q bpiv bfund : ℝ) (hq : 0 < q) (hBonus : 0 < bonus i)
    (hPivotal : q * (pledge i : ℝ) < bpiv) :
    0 < Snuffy.FoundingDominance.advantage
      (q * (bond : ℝ) + ∑ j ∈ N, q * (pledge j : ℝ))
      (q * (pledge i : ℝ)) (q * (bonus i : ℝ)) bpiv bfund
      (q * (bond : ℝ) + ∑ j ∈ T, q * (pledge j : ℝ)) ∧
    (∀ S, S ⊆ N → SourceGuarantee S pledge bonus fee anchorStock bond activation) := by
  constructor
  · apply Snuffy.EnergyFounding.energy_all_necessary_dominant
    · intro j hj
      apply mul_pos hq
      exact_mod_cast hPledge j hj
    · exact hi
    · exact hT
    · apply mul_pos hq
      exact_mod_cast hBonus
    · exact hPivotal
  · exact every_subset_has_source_guarantee N pledge bonus fee anchorStock bond activation
      completeActivation hBill hCosts

end Snuffy.FoundingEscrowBridge
