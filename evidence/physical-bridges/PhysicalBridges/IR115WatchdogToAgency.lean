import PhysicalBridges.IR110WatchdogRobustObservation
import PhysicalBridges.IR112RobustContinuityOptions
import PhysicalBridges.IR113ObservationClassSelection

/-!
IR-115: physical watchdog reaction-window bounds to a robust
continuing-subject action with an executable future option.

The actual subject correspondence, physical actuator/effect semantics,
and post-window executable option are INDEPENDENT obligations. The
theorem must not be read as deriving them from the scalar threshold.
It is a source-contract composition, not a universal X3 proof.
-/
namespace PhysicalBridges.IR115

open IRWatchdogLatencyEffects
open IR112
open IR113

universe u v
variable {S : Type u} {A : Type v}

/-- A single named physical action is common to every compatible
observation class if uniformly certified watchdog bounds apply and
actual action effects preserve identity and future options. -/
theorem watchdog_contract_yields_common_protected_action
    (observe : S → Nat)
    (episode : S → Episode)
    (physical : S → Nat → Nat)
    (step : S → A → S → Prop)
    (emergency : A)
    (continuing : S → Prop) (executable : S → A → Prop)
    (detectDelay fenceDelay drainDelay sensorError risePerTick
      residualEffect threshold : Nat)
    (hTiming : ∀ s,
      TimingContract (episode s) detectDelay fenceDelay drainDelay)
    (hSensor : ∀ s,
      physical s (episode s).faultTick ≤ observe s + sensorError)
    (hEnvelope : ∀ s t,
      (episode s).faultTick ≤ t →
      t ≤ (episode s).quiescentTick →
      physical s t ≤ physical s (episode s).faultTick +
        (t - (episode s).faultTick) * risePerTick + residualEffect)
    (hMargin : ∀ s,
      observe s + sensorError +
        (detectDelay + fenceDelay + drainDelay) * risePerTick +
        residualEffect ≤ threshold)
    (hSemanticContinuity : ∀ s t,
      step s emergency t →
      physical s (episode s).quiescentTick ≤ threshold →
      continuing s → continuing t)
    (hFutureOption : ∀ s t,
      step s emergency t →
      physical s (episode s).quiescentTick ≤ threshold →
      ∃ a, executable t a) :
    ∀ o, ClassViableAction observe step
      (Protected continuing executable) o emergency := by
  intro o s hObserve hProtected t hStep
  have hQuiescenceAfterFault :
      (episode s).faultTick ≤ (episode s).quiescentTick := by
    rcases hTiming s with ⟨hFirst, _, hSecond, _, hThird, _⟩
    omega
  have hBound :=
    guarded_reaction_window_remains_below_threshold
      (episode s) detectDelay fenceDelay drainDelay
      (observe s) sensorError risePerTick residualEffect
      threshold (physical s)
      (hTiming s) (hSensor s) (hEnvelope s)
      (hMargin s)
      (episode s).quiescentTick hQuiescenceAfterFault (le_refl _)
  rcases hProtected with ⟨hContinuing, _⟩
  exact ⟨hSemanticContinuity s t hStep hBound hContinuing,
    hFutureOption s t hStep hBound⟩

/-- Finite-trace corollary: a uniform executable common-action
certificate yields continued subjecthood and a future option at every
reachable state. It does NOT entail X3 maximal freedom, consent, or
liveness of a permanently stalled hold. -/
theorem certified_action_preserves_continuity_and_options
    (observe : S → Nat)
    (episode : S → Episode)
    (physical : S → Nat → Nat)
    (step : S → A → S → Prop)
    (emergency : A)
    (continuing : S → Prop) (executable : S → A → Prop)
    (detectDelay fenceDelay drainDelay sensorError risePerTick
      residualEffect threshold : Nat)
    (hTiming : ∀ s,
      TimingContract (episode s) detectDelay fenceDelay drainDelay)
    (hSensor : ∀ s,
      physical s (episode s).faultTick ≤ observe s + sensorError)
    (hEnvelope : ∀ s t,
      (episode s).faultTick ≤ t →
      t ≤ (episode s).quiescentTick →
      physical s t ≤ physical s (episode s).faultTick +
        (t - (episode s).faultTick) * risePerTick + residualEffect)
    (hMargin : ∀ s,
      observe s + sensorError +
        (detectDelay + fenceDelay + drainDelay) * risePerTick +
        residualEffect ≤ threshold)
    (hSemanticContinuity : ∀ s t,
      step s emergency t →
      physical s (episode s).quiescentTick ≤ threshold →
      continuing s → continuing t)
    (hFutureOption : ∀ s t,
      step s emergency t →
      physical s (episode s).quiescentTick ≤ threshold →
      ∃ a, executable t a) :
    ∀ {initial final : S},
      IR109.PolicyReach step (fun _ => emergency) observe initial final →
      Protected continuing executable initial →
      Protected continuing executable final := by
  intro initial final hTrace hInitial
  have hRobust := watchdog_contract_yields_common_protected_action
    observe episode physical step emergency continuing executable
    detectDelay fenceDelay drainDelay sensorError risePerTick
    residualEffect threshold hTiming hSensor hEnvelope hMargin
    hSemanticContinuity hFutureOption
  exact IR109.robust_viability_all_finite_traces
    observe step (Protected continuing executable) (fun _ => emergency)
    (by
      intro o s hObs hViable t hStep
      exact hRobust o s hObs hViable t hStep)
    hTrace hInitial

end PhysicalBridges.IR115
