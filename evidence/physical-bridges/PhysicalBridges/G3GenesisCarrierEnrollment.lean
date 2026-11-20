import PhysicalBridges.G3DecoderVersusTransport
import PhysicalBridges.G3SixDutyRenewal
import PhysicalBridges.BCRDParticularCarrierCriterion
import PhysicalBridges.G3InductiveCompleteness

/-!
# Pre-QG Genesis: preserve old identities and enroll genuinely new carriers

The existing BCRD carrier theorem assumes an initially injective candidate
carrier. This module takes the necessary next step for a growing Genesis
population. Initial injectivity alone does not control a newly arriving
particular, while a transport automorphism alone does not assign it a
distinct physical source position.

The carrier assignments below are independent data; they are NEVER
defined via original-X3, safety or consent. The temporal induction uses
local enrolment checks, not a fresh global injectivity assumption at every
stage:
  * every previously owed particular remains owed;
  * existing assignments cannot be rewritten;
  * every new assignment differs from every old assignment;
  * two distinct newly arriving particulars receive different assignments.

This obtains injectivity on all owed candidate particulars at all stages
and transports that identity distinction along any finite W track. It
also composes with the unchanged six-X3 renewal theorem, keeping ALL
authentic five-duty, maximality-frontier and semantic-meaning obligations
separate, explicit and unproved unless independently warranted.

Because BCRD has only SIX source slots, these enrollment conditions
restrict which candidate populations can fit; they DO NOT prove that
all real subjects can be mapped to the six-slot frozen model. In
particular we DO NOT claim unconditional complete-world coverage,
new-person recognition, subjective identity or quantum gravity.

Adversarial control: an initially distinct old subject can be assigned
the SAME carrier as an arriving new subject if fresh-vs-old checks are
omitted; faithful W transport cannot repair this collision.
-/

namespace PhysicalBridges.G3GenesisCarrierEnrollment

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDParticularCarrierCriterion
open PhysicalBridges.BCRDTransportedParticularMarker
open PhysicalBridges.BCRDSourceHistoryProvenance
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.G3SixDutyRenewal
open PhysicalBridges.G3FeasibleMaximalityRenewal

variable {P A : Type}

/-- Registration is a stage-indexed candidate source-carrier assignment;
    it does not declare any candidate an authentic experiencing subject. -/
def RegisteredInjective
    (owed : Nat → P → Prop) (carrier : Nat → P → Index) (n : Nat) : Prop :=
  ∀ p q, owed n p → owed n q → carrier n p = carrier n q → p = q

/-- Newly owed at the successor stage, rather than already owed at
the predecessor stage. The membership criterion remains independent. -/
def NewlyOwed (owed : Nat → P → Prop) (n : Nat) (p : P) : Prop :=
  owed (n + 1) p ∧ ¬ owed n p

/-- The local registration rules test *actual changes* to the candidate
domain. There is no assumed stagewise injectivity or ethical outcome. -/
structure EnrollmentRules
    (owed : Nat → P → Prop) (carrier : Nat → P → Index) : Prop where
  persists : ∀ n p, owed n p → owed (n + 1) p
  retainedCarrier : ∀ n p, owed n p →
    carrier (n + 1) p = carrier n p
  freshVsOld : ∀ n p q, NewlyOwed owed n p → owed n q →
    carrier (n + 1) p ≠ carrier (n + 1) q
  freshVsFresh : ∀ n p q, NewlyOwed owed n p →
    NewlyOwed owed n q → p ≠ q →
    carrier (n + 1) p ≠ carrier (n + 1) q

/-- A *single* registration transition preserves injectivity of all
owed candidate carriers, provided the new registrations pass both
noncollision checks. No global injectivity is assumed at n+1. -/
theorem enrollment_step_preserves_injectivity
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (n : Nat) (hOld : RegisteredInjective owed carrier n) :
    RegisteredInjective owed carrier (n + 1) := by
  intro p q hp hq hEqual
  by_cases hpPrev : owed n p
  · by_cases hqPrev : owed n q
    · apply hOld p q hpPrev hqPrev
      calc
        carrier n p = carrier (n + 1) p :=
          (hRules.retainedCarrier n p hpPrev).symm
        _ = carrier (n + 1) q := hEqual
        _ = carrier n q := hRules.retainedCarrier n q hqPrev
    · have hFresh : NewlyOwed owed n q := ⟨hq, hqPrev⟩
      exact False.elim ((hRules.freshVsOld n q p hFresh hpPrev)
        hEqual.symm)
  · have hFreshP : NewlyOwed owed n p := ⟨hp, hpPrev⟩
    by_cases hqPrev : owed n q
    · exact False.elim ((hRules.freshVsOld n p q hFreshP hqPrev)
        hEqual)
    · have hFreshQ : NewlyOwed owed n q := ⟨hq, hqPrev⟩
      by_cases hpq : p = q
      · exact hpq
      · exact False.elim ((hRules.freshVsFresh n p q hFreshP
          hFreshQ hpq) hEqual)

/-- Inductive historical-carrier identity, including fresh arrivals.
Initial injectivity plus independently checkable enrollment rules
suffices at EVERY subsequent stage. -/
theorem every_generated_registration_remains_injective
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (hOrigin : RegisteredInjective owed carrier 0) :
    ∀ n, RegisteredInjective owed carrier n := by
  intro n
  induction n with
  | zero => exact hOrigin
  | succ n ih =>
      exact enrollment_step_preserves_injectivity owed carrier hRules n ih

/-- The BCRD physical source permutation cannot merge distinct
registered candidates at any later finite stage of a source track.
The enrollment and W results are both required. -/
theorem carried_registered_subjects_never_merge
    (owed : Nat → P → Prop) (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (hOrigin : RegisteredInjective owed carrier 0) :
    ∀ n k p q, owed n p → owed n q →
      CarrierAt (carrier n) k p = CarrierAt (carrier n) k q →
      p = q := by
  intro n k p q hp hq heq
  have hOriginInject :=
    every_generated_registration_remains_injective owed carrier
      hRules hOrigin n
  exact hOriginInject p q hp hq
    ((tracked_basis_positions_do_not_merge k) heq)

/-- Actual source-generated finite traces and faithful source records
exist for each registered candidate: this provides source evidence,
not empirical subject identity or consent. -/
theorem every_registered_candidate_has_a_faithful_source_history
    (owed : Nat → P → Prop) (carrier : Nat → P → Index) :
    ∀ n p, owed n p →
      ∀ k,
        PhysicalBridges.IR96.Reach ActualPositionStep
          (carrier n p) (CarrierAt (carrier n) k p) ∧
        PhysicalBridges.IRHistoryProvenance.Faithful
          (fun e : PhysicalBridges.BCRDSourceHistoryProvenance.SlotEvent => e)
          (PhysicalBridges.BCRDSourceHistoryProvenance.sourcePhysicalHistory
            (carrier n p) k)
          (PhysicalBridges.BCRDSourceHistoryProvenance.sourceRecordedHistory
            (carrier n p) k) := by
  intro n p _ k
  exact ⟨candidate_carrier_has_exact_source_path (carrier n) p k,
    candidate_carrier_has_faithful_finite_history (carrier n) p k⟩

/-- Exact combined pre-QG result: new-particular identity does NOT
replace six authentic duties. Registration safety is derived by
induction while the original-six duties are derived independently
from the previously established five-duty plus maximality-frontier
renewal theorem, with all its authentic premises visible. -/
theorem identified_arrivals_and_original_six_renew_together
    (owed : Nat → P → Prop)
    (carrier : Nat → P → Index)
    (hRules : EnrollmentRules owed carrier)
    (hOrigin : RegisteredInjective owed carrier 0)
    (F : FeasibleOrder P A)
    (r : ParticularRelations Nat P)
    (hFiveInitial : ∀ p, owed 0 p → FiveAt r 0 p)
    (hFiveRetained : ∀ n p, owed (n + 1) p → owed n p →
      FiveAt r n p → FiveAt r (n + 1) p)
    (hFiveNew : ∀ n p, owed (n + 1) p → ¬ owed n p →
      FiveAt r (n + 1) p)
    (hMaxInitial : ∀ p, owed 0 p → MaximalAt F 0 p)
    (hSame : ∀ n p, owed (n+1) p → owed n p →
      F.selected (n+1) p = F.selected n p)
    (hFeasible : ∀ n p, owed (n+1) p → owed n p →
      F.feasible (n+1) p (F.selected n p))
    (hFrontier : ∀ n p, owed (n+1) p → owed n p →
      NoNewSuperiorAlternative F n p)
    (hMaxNew : ∀ n p, owed (n+1) p → ¬ owed n p →
      MaximalAt F (n+1) p)
    (hMeaning : MaximalityMeaning F r owed) :
    ∀ n,
      RegisteredInjective owed carrier n ∧
      (∀ p, owed n p →
        OriginalX3 r.continues r.authorized r.free
          r.restrained r.maximal r.provenanced n (n + 1) p) := by
  have hIdent := every_generated_registration_remains_injective
    owed carrier hRules hOrigin
  have hSix := original_six_from_five_and_maximality_renewal
    F r owed hFiveInitial hFiveRetained hFiveNew hMaxInitial
    hSame hFeasible hFrontier hMaxNew hMeaning
  exact fun n => ⟨hIdent n, hSix n⟩

/-- Negative control: previous registration may be noncolliding,
yet arrival at the next epoch can reuse its carrier. All histories
remain legitimate W-source histories, so source transport by itself
does not provide a new-subject distinctness check. -/
theorem a_new_arrival_can_collide_with_the_retained_carrier :
    ∃ c0 c1 : Bool → Index,
      (∀ p q, p = false → q = false →
        c0 p = c0 q → p = q) ∧
      c1 false = c0 false ∧
      c1 false = c1 true ∧
      false ≠ true := by
  refine ⟨(fun _ => 2), (fun _ => 2), ?_, rfl, rfl, ?_⟩
  · intro p q hp hq _
    exact hp.trans hq.symm
  · decide

#print axioms enrollment_step_preserves_injectivity
#print axioms every_generated_registration_remains_injective
#print axioms carried_registered_subjects_never_merge
#print axioms every_registered_candidate_has_a_faithful_source_history
#print axioms identified_arrivals_and_original_six_renew_together
#print axioms a_new_arrival_can_collide_with_the_retained_carrier

end PhysicalBridges.G3GenesisCarrierEnrollment
