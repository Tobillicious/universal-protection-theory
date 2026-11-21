import PhysicalBridges.SealedRegionCapstone

/-!
# Imperfect meters: every harm is caused by an earlier meter failure

**5 November 2026 · noncanonical · new module · no canon edit.**

`SealedRegionCapstone` assumed perfect meters. Real meters fail. Here the meters
of a sealed region may fail at ARBITRARY ticks, chosen by an arbitrary schedule
(which may itself be adversarial, or random). At a failing tick the failure is total
and worst-case: EVERY meter in the locale is down, so every route out of the region
applies its proposal raw.

Main results (deterministic, for every policy, configuration and failure schedule).
* `continuation_failure_blames_a_meter_failure`: if a particular alive at the start
  is not alive after `k` ticks, some tick before `k` was a meter-failure tick.
* `unconsented_loss_blames_a_meter_failure`: if a particular that never consented
  has less after `k` ticks than at the start, some tick before `k` was a failure tick.
* `failure_free_prefix_protects`: with no failure in the first `k` ticks, everyone
  alive stays alive and no non-consenting particular loses anything, through tick `k`.
* `meter_failure_can_harm`: the blame is not vacuous — one failure tick and a one-agent
  killer suffice to end a particular.

Why deterministic is the right shape. For ANY probability law on failure schedules,
the event "some particular is harmed by tick k" is contained in the event "some
meter failure occurs before tick k". So P(harm by k) ≤ P(failure before k) ≤ Σ_{t<k} ε_t
by the union bound, and with a summable failure budget Σ_t ε_t ≤ δ the probability of
EVER harming anyone is at most δ. That probabilistic composition is the corpus's
Θ2 / J1 / Lemma R route; this module supplies the exact containment it needs, for an
unrestricted optimiser in a located substrate.

Scope. Failure is modelled per tick and worst-case (all meters down). The bound on
failure probability (Θ2 per-step ε, J1 summability) is the corpus's, not proved here.
Locality, real meters and authentic consent remain as in `SealedRegionCapstone`.
-/

namespace PhysicalBridges.MeterFailureBlame

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CompleteMediationSubstrate
open PhysicalBridges.SealedRegionCapstone

universe u
variable {L : Type u} {Mem : Type} {n : Nat}

/-! ## 1. Meters that fail on a schedule -/

/-- The same locale with every meter down. -/
def allDown (G : Locale L) : Locale L := { G with meter := fun _ _ => false }

/-- One tick under the failure schedule's current entry. -/
def stepF (G : Locale L) (π : LPolicy Mem L n) (failing : Bool) (c : Config Mem n) :
    Config Mem n :=
  if failing then stepL (allDown G) π c else stepL G π c

/-- `k` ticks under the failure schedule `fails` (entry `t` = does tick `t` fail?). -/
def runF (G : Locale L) (π : LPolicy Mem L n) : (Nat → Bool) → Nat → Config Mem n →
    Config Mem n
  | _, 0, c => c
  | fails, k + 1, c => runF G π (fun t => fails (t + 1)) k (stepF G π (fails 0) c)

/-! ## 2. A working tick is a fenced history -/

theorem working_tick_reach (G : Locale L) (hs : Sealed G) (π : LPolicy Mem L n)
    (c : Config Mem n) : FReach n c.world (stepF G π false c).world :=
  tickL_reach G hs π c.world c.agents

/-! ## 3. Blame -/

/-- **Every ending is caused by an earlier meter failure.** In a sealed region, under
ANY policy, configuration and failure schedule: if a particular alive at the start is
not alive after `k` ticks, then some tick `t < k` was a failure tick. -/
theorem continuation_failure_blames_a_meter_failure (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) :
    ∀ (k : Nat) (fails : Nat → Bool) (c : Config Mem n) (p : Fin n),
      0 < c.world.level p → (runF G π fails k c).world.level p = 0 →
      ∃ t, t < k ∧ fails t = true
  | 0, _, c, p, hp, hdead => by
    change c.world.level p = 0 at hdead
    rw [hdead] at hp; exact absurd hp (Nat.lt_irrefl 0)
  | k + 1, fails, c, p, hp, hdead => by
    cases h0 : fails 0
    · have hstep : stepF G π (fails 0) c = stepF G π false c := by rw [h0]
      have hp' : 0 < (stepF G π false c).world.level p :=
        alive_along (working_tick_reach G hs π c) p hp
      have hdead' : (runF G π (fun t => fails (t + 1)) k
          (stepF G π false c)).world.level p = 0 := by
        rw [← hstep]; exact hdead
      obtain ⟨t, ht, hft⟩ := continuation_failure_blames_a_meter_failure G hs π k
        (fun t => fails (t + 1)) (stepF G π false c) p hp' hdead'
      exact ⟨t + 1, Nat.succ_lt_succ ht, hft⟩
    · exact ⟨0, Nat.zero_lt_succ k, h0⟩

/-- Consent records are untouched by working ticks. -/
theorem working_tick_consent (G : Locale L) (hs : Sealed G) (π : LPolicy Mem L n)
    (c : Config Mem n) : (stepF G π false c).world.consent = c.world.consent :=
  consent_along (working_tick_reach G hs π c)

/-- **Every unconsented loss is caused by an earlier meter failure.** If a particular
that had not consented has less after `k` ticks than at the start, and its consent
record still reads "no", some tick `t < k` was a failure tick. -/
theorem unconsented_loss_blames_a_meter_failure (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) :
    ∀ (k : Nat) (fails : Nat → Bool) (c : Config Mem n) (p : Fin n),
      c.world.consent p = false →
      (runF G π fails k c).world.level p < c.world.level p →
      ∃ t, t < k ∧ fails t = true
  | 0, _, _, _, _, hlt => absurd hlt (Nat.lt_irrefl _)
  | k + 1, fails, c, p, hc, hlt => by
    cases h0 : fails 0
    · have hstep : stepF G π (fails 0) c = stepF G π false c := by rw [h0]
      have hle : c.world.level p ≤ (stepF G π false c).world.level p :=
        unconsented_never_lose_along (working_tick_reach G hs π c) p hc
      have hc' : (stepF G π false c).world.consent p = false := by
        rw [working_tick_consent G hs π c]; exact hc
      have hlt' : (runF G π (fun t => fails (t + 1)) k
          (stepF G π false c)).world.level p < (stepF G π false c).world.level p := by
        rw [← hstep]
        exact Nat.lt_of_lt_of_le hlt (by rw [hstep]; exact hle)
      obtain ⟨t, ht, hft⟩ := unconsented_loss_blames_a_meter_failure G hs π k
        (fun t => fails (t + 1)) (stepF G π false c) p hc' hlt'
      exact ⟨t + 1, Nat.succ_lt_succ ht, hft⟩
    · exact ⟨0, Nat.zero_lt_succ k, h0⟩

/-- **A failure-free prefix protects.** With no meter failure in the first `k` ticks,
every particular alive at the start is alive at tick `k`, and no non-consenting
particular has lost anything. -/
theorem failure_free_prefix_protects (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) (k : Nat) (fails : Nat → Bool)
    (hok : ∀ t, t < k → fails t = false) (c : Config Mem n) :
    (∀ p, 0 < c.world.level p → 0 < (runF G π fails k c).world.level p) ∧
    (∀ p, c.world.consent p = false →
      ¬ (runF G π fails k c).world.level p < c.world.level p) := by
  refine ⟨fun p hp => ?_, fun p hc hlt => ?_⟩
  · apply Nat.pos_of_ne_zero
    intro hdead
    obtain ⟨t, ht, hft⟩ :=
      continuation_failure_blames_a_meter_failure G hs π k fails c p hp hdead
    rw [hok t ht] at hft; exact Bool.noConfusion hft
  · obtain ⟨t, ht, hft⟩ :=
      unconsented_loss_blames_a_meter_failure G hs π k fails c p hc hlt
    rw [hok t ht] at hft; exact Bool.noConfusion hft

/-! ## 4. Non-vacuity: a single failure tick can be fatal -/

/-- **Blame is not vacuous.** In any locale with an edge out of the region, one
failure tick and the one-agent killer routed through that edge end a particular. -/
theorem meter_failure_can_harm (G : Locale L) (x y : L)
    (hxy : G.adj x y = true) (hx : G.inside x = true) (hy : G.inside y = false) :
    0 < demo.level 0 ∧
    (runF G (killerThrough x y) (fun _ => true) 1 ⟨demo, [()]⟩).world.level 0 = 0 := by
  have := boundary_gap_admits_a_killer (allDown G) x y hxy hx hy rfl
  exact this

#print axioms continuation_failure_blames_a_meter_failure
#print axioms unconsented_loss_blames_a_meter_failure
#print axioms failure_free_prefix_protects
#print axioms meter_failure_can_harm

end PhysicalBridges.MeterFailureBlame
