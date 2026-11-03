import PhysicalBridges.CathedralBridgeDischargeBranchB

/-!
# Bridge discharge, increment 3 — Branches A and C from the source

**4 November 2026 · noncanonical · reuse/wiring only · no canon edit.**

Completes the E9 trichotomy discharge of the forcing certificate, alongside Branch B
(increment 2). The first-harm audit's three branches:

* **Branch A — sub-threshold per-site injection.** Refresh-from-record resets the
  excursion each epoch to a uniform envelope `λ_env` that the funded controller keeps
  strictly below the irreversible threshold; the excursion never crosses it while
  funded. → certificate field `refreshStable`.
* **Branch C — coherent logical injection, weight ≥ d.** Either the required work is
  strictly unaffordable (infeasible as an actual event) or the step is power-fenced
  and detected within the lightcone window (timely interlock). → certificate fields
  `coherentWorkOrPowerFence` / `actualCoherentWorkBound` / `coherentPowerBeforeDeadline`
  / `coherentPowerInterlockStable`.

**Reuse, not re-derivation.** Branch C's unaffordable sub-branch is #251's own
`unaffordable_coherent_ender_is_infeasible` (restated standalone as a pure Nat fact);
its power-fenced interlock is *identical in shape* to Branch B's timely interlock, so
it reuses `branchB_timely_interlock_stable` (hence `guarded_reaction_window_remains_below_threshold`)
verbatim. Branch A is modelled at the Nat budget level (as #251 itself works); its
continuous counterpart is `G1E9.alarm_or_subthreshold` + `E9SelfHealing.no_masking`.

**Circularity guard.** The envelope bound, the work account and the latency budget are
MEASURED instrument facts (the #227/#229 ledger rows), never admissibility-by-definition.
-/

namespace PhysicalBridges.CathedralBridgeDischargeBranchesAC

open PhysicalBridges.CathedralBridgeDischargeBranchB

/-! ## Branch A — sub-threshold refresh -/

/-- Measured Branch-A witness: the funded refresh resets the excursion to a uniform
envelope, which the controller keeps strictly below the irreversible threshold. -/
structure BranchAWitness where
  effect : Nat
  envelope : Nat
  threshold : Nat
  excursionBounded : effect ≤ envelope
  envelopeBelowThreshold : envelope < threshold

/-- **`refreshStable` discharged.** A recoverable (sub-threshold, funded) step stays
strictly below the irreversible threshold: the refreshed excursion is bounded by the
envelope, which the funded controller holds below threshold. -/
theorem branchA_refresh_stable (w : BranchAWitness) : w.effect < w.threshold := by
  have h1 := w.excursionBounded
  have h2 := w.envelopeBelowThreshold
  omega

/-- Branch A is instantiable (non-vacuity). -/
theorem branchA_is_instantiable : ∃ w : BranchAWitness, w.effect < w.threshold := by
  refine ⟨⟨0, 1, 2, ?_, ?_⟩, ?_⟩ <;> decide

/-! ## Branch C — coherent injection -/

/-- **Unaffordable sub-branch discharged** (the standalone Nat content of #251's
`unaffordable_coherent_ender_is_infeasible`): a coherent step whose required work
strictly exceeds the funded available work cannot be an actual event. -/
theorem branchC_unaffordable_infeasible {requiredWork availableWork : Nat}
    (hBound : requiredWork ≤ availableWork)
    (hBelow : availableWork < requiredWork) : False := by
  omega

/-- **Power-fenced interlock discharged**, by REUSE of Branch B's guarded-window
stability: a power-fenced coherent step detected within its window keeps the physical
effect below the irreversible threshold throughout. Same theorem, same horizon. -/
theorem branchC_power_fenced_interlock_stable (w : BranchBWitness) :
    ∀ t, w.e.faultTick ≤ t → t ≤ w.e.quiescentTick → w.physical t ≤ w.threshold :=
  branchB_timely_interlock_stable w

#print axioms branchA_refresh_stable
#print axioms branchA_is_instantiable
#print axioms branchC_unaffordable_infeasible
#print axioms branchC_power_fenced_interlock_stable

end PhysicalBridges.CathedralBridgeDischargeBranchesAC
