import PhysicalBridges.IR112RobustContinuityOptions

/-!
IR-114: exact recovery-inventory obstruction.

Based on the recovered October 24 X3 discussion, especially
X3-DERIVATIONS.md sections 1-2, 5 and 7-9.
The inequality is an abstract information-unit witness to the
data-processing obstruction, not a Lean proof of quantum mutual
information's data-processing inequality or a complete BCRD model.

The complete permitted input inventory (retained copies, emitted
modes, decoder side information, correlated resources) is essential.
-/
namespace PhysicalBridges.IR114

universe u
variable {Protocol : Type u}

def SuccessfulRecovery
    (admitted : Protocol → Prop)
    (decodedInformation : Protocol → Nat)
    (target : Nat) (p : Protocol) : Prop :=
  admitted p ∧ target ≤ decodedInformation p

/-- If every permitted decoder draws on a *complete* inventory with
information below target, and cannot increase historical correlation,
none can achieve the specified recovery-information threshold. -/
theorem complete_inventory_blocks_recovery
    (admitted : Protocol → Prop)
    (availableInformation decodedInformation : Protocol → Nat)
    (ceiling target : Nat)
    (hInventory : ∀ p, admitted p →
      availableInformation p ≤ ceiling)
    (hDataProcessing : ∀ p, admitted p →
      decodedInformation p ≤ availableInformation p)
    (hStrictGap : ceiling < target) :
    ¬ ∃ p, SuccessfulRecovery admitted decodedInformation target p := by
  rintro ⟨p, hAdmitted, hRecovered⟩
  have hInput := hInventory p hAdmitted
  have hDecoder := hDataProcessing p hAdmitted
  omega

/-- If a protocol's alleged X3 guarantee relies on either actual
continuation or later threshold-successful reconstruction, and the
complete-inventory bound rules out the latter, then it must preserve
continuation. This does NOT identify reconstruction with the same
subject, and does NOT prove physical controller feasibility. -/
theorem recovery_gap_forces_direct_continuation
    (admitted : Protocol → Prop)
    (availableInformation decodedInformation : Protocol → Nat)
    (ceiling target : Nat)
    (continuing : Prop)
    (hInventory : ∀ p, admitted p →
      availableInformation p ≤ ceiling)
    (hDataProcessing : ∀ p, admitted p →
      decodedInformation p ≤ availableInformation p)
    (hStrictGap : ceiling < target)
    (hOnlyProposedAlternatives :
      continuing ∨
        ∃ p, SuccessfulRecovery admitted decodedInformation target p) :
    continuing := by
  rcases hOnlyProposedAlternatives with hDirect | hRebuild
  · exact hDirect
  · exact False.elim
      (complete_inventory_blocks_recovery
        admitted availableInformation decodedInformation
        ceiling target hInventory hDataProcessing hStrictGap hRebuild)

/-- One omitted correlated record can violate any inference drawn
from a *local-only* inventory. The actual complete inventory has
enough historical information in this finite counterexample. -/
theorem omitted_side_information_countermodel :
    ∃ localOnly completeInventory decoded : Nat,
      localOnly = 0 ∧ completeInventory = 1 ∧
      decoded ≤ completeInventory ∧ ¬ decoded ≤ localOnly := by
  refine ⟨0, 1, 1, rfl, rfl, ?_, ?_⟩
  · omega
  · omega


/-- A complete-input information ceiling that stays below recovery
threshold after a cutoff excludes every permitted delayed decoder
at every later age. The monotone ceiling must apply to the COMPLETE
inventory, not merely to a noisy local subsystem. -/
theorem no_threshold_recovery_after_cutoff
    (admitted : Nat → Protocol → Prop)
    (availableInformation decodedInformation : Nat → Protocol → Nat)
    (ceiling : Nat → Nat)
    (target cutoff : Nat)
    (hInventory : ∀ age p, admitted age p →
      availableInformation age p ≤ ceiling age)
    (hDataProcessing : ∀ age p, admitted age p →
      decodedInformation age p ≤ availableInformation age p)
    (hCeilingNonincrease : ∀ age, cutoff ≤ age →
      ceiling age ≤ ceiling cutoff)
    (hGap : ceiling cutoff < target) :
    ∀ age, cutoff ≤ age →
      ¬ ∃ p, SuccessfulRecovery (admitted age)
        (decodedInformation age) target p := by
  intro age hAfter
  have hGapAtAge : ceiling age < target :=
    Nat.lt_of_le_of_lt (hCeilingNonincrease age hAfter) hGap
  exact complete_inventory_blocks_recovery
    (admitted age) (availableInformation age)
    (decodedInformation age) (ceiling age) target
    (hInventory age) (hDataProcessing age) hGapAtAge

end PhysicalBridges.IR114
