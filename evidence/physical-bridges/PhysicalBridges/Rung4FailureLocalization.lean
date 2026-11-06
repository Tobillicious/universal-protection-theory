/-
RUNG 4 — ADVERSARIAL HOLDING FAILURE LOCALISATION (2026-11-03)

AdversarialHolding proves empty holding-failure sets under all-world
compliance. This module strengthens the operational boundary without
assuming all-world compliance: EACH holding failure is necessarily an
uncovered meter-compliance event, provided the per-compliant-world
deficit certificate, capacity margin, and pool split are true.

This is constructive deterministic logic. It does not claim that a
sensor/controller physically enforces compliance on every event.
-/
import PhysicalBridges.AdversarialHolding

namespace PhysicalBridges.Rung4FailureLocalization

/-- At any particular compliant world, the margin protects holding;
no premise that every world complies is needed for this result. -/
theorem compliant_world_holds {Ω : Type} (C H Δ : Int)
    (hMargin : C - Δ ≥ H)
    (D : Ω → Int) (Compliant : Ω → Prop)
    (hCert : ∀ ω, Compliant ω → D ω ≤ Δ)
    (ω : Ω) (hc : Compliant ω) :
    C - D ω ≥ H := by
  have hb := hCert ω hc
  omega

/-- If a particular world violates the holding threshold, it cannot
also be compliant with the certified upper deficit limit. This locates
a physical-test target even when all-world compliance is unproved. -/
theorem failure_requires_noncompliance {Ω : Type} (C H Δ : Int)
    (hMargin : C - Δ ≥ H)
    (D : Ω → Int) (Compliant : Ω → Prop)
    (hCert : ∀ ω, Compliant ω → D ω ≤ Δ)
    (ω : Ω) (hFail : C - D ω < H) :
    ¬ Compliant ω := by
  intro hc
  have hh := compliant_world_holds
    C H Δ hMargin D Compliant hCert ω hc
  omega

/-- Pooled form. Bookkeeping plus compliance implies holding at the
chosen world, even if other worlds are not certified compliant. -/
theorem pooled_compliant_world_holds {Ω : Type} (Ctot H Δ : Int)
    (hMargin : Ctot - Δ ≥ H)
    (Qtot Dtot : Ω → Int)
    (hSplit : ∀ ω, Qtot ω + Dtot ω = Ctot)
    (Compliant : Ω → Prop)
    (hCert : ∀ ω, Compliant ω → Dtot ω ≤ Δ)
    (ω : Ω) (hc : Compliant ω) :
    Qtot ω ≥ H := by
  have hs := hSplit ω
  have hb := hCert ω hc
  omega

/-- For a pooled holding failure, the ACTUAL total deficit must
exceed the stated compliance limit. This does not assume that the
noncompliant world is seen by the sensor; coverage is still open. -/
theorem pooled_failure_exceeds_deficit_limit {Ω : Type}
    (Ctot H Δ : Int)
    (hMargin : Ctot - Δ ≥ H)
    (Qtot Dtot : Ω → Int)
    (hSplit : ∀ ω, Qtot ω + Dtot ω = Ctot)
    (ω : Ω) (hFail : Qtot ω < H) :
    Δ < Dtot ω := by
  have hs := hSplit ω
  omega

/-- Pooled holding failure is therefore an explicit noncompliance
witness under the meter certificate. -/
theorem pooled_failure_requires_noncompliance {Ω : Type}
    (Ctot H Δ : Int)
    (hMargin : Ctot - Δ ≥ H)
    (Qtot Dtot : Ω → Int)
    (hSplit : ∀ ω, Qtot ω + Dtot ω = Ctot)
    (Compliant : Ω → Prop)
    (hCert : ∀ ω, Compliant ω → Dtot ω ≤ Δ)
    (ω : Ω) (hFail : Qtot ω < H) :
    ¬ Compliant ω := by
  intro hc
  have hBound := hCert ω hc
  have hOver := pooled_failure_exceeds_deficit_limit
    Ctot H Δ hMargin Qtot Dtot hSplit ω hFail
  omega

/-- Explicit negative control: a partial (only-on-compliance) meter
certificate alone does not force global holding. This counterexample
has a compliant good world and an unobserved, noncompliant bad world.
A proof that assumes all-world compliance without evidence would miss it. -/
theorem local_meter_certificate_not_universal_holding :
    ¬ (∀ (D : Bool → Int) (Compliant : Bool → Prop),
      (∀ b, Compliant b → D b ≤ 0) →
      ∀ b, (1 : Int) - D b ≥ 1) := by
  intro h
  let D : Bool → Int := fun b => if b then 0 else 1
  let Compliant : Bool → Prop := fun b => b = true
  have hCert : ∀ b, Compliant b → D b ≤ 0 := by
    intro b hb
    cases b with
    | false => cases hb
    | true => decide
  have hBad := h D Compliant hCert false
  change (1 : Int) - 1 ≥ 1 at hBad
  omega

#print axioms compliant_world_holds
#print axioms failure_requires_noncompliance
#print axioms pooled_compliant_world_holds
#print axioms pooled_failure_exceeds_deficit_limit
#print axioms pooled_failure_requires_noncompliance
#print axioms local_meter_certificate_not_universal_holding

end PhysicalBridges.Rung4FailureLocalization
