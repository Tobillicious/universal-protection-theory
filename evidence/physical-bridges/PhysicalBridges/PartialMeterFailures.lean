import PhysicalBridges.MeterFailureBlame

/-!
# Independent edge-meter failures: blame the exact boundary leak

5 November 2026 · additive research module · no canon edit.

MeterFailureBlame treats a failing tick as ALL meters down. Here each edge
can fail separately at each tick, under an arbitrary schedule. A physical
installation is still an explicit premise: locality is represented by an
adjacency, and meters act as specified by SealedRegionCapstone.

The independently interpreted, original six duties are not changed.

* When no boundary edge fails before tick k, every optimizer and all its
  descendants remain fenced throughout the whole run; all six duties apply.
* If continuation fails, or a nonconsenting particular loses level, there is
  an actual failed boundary edge at an identifiable earlier tick.
* One failed boundary edge really can be exploited by an arbitrary optimizer
  in one tick. The existence claim is model-level, not a physical attack.

These results remove the all-meters-fail-together hypothesis from the
deterministic failure-attribution argument, without invoking probabilities.
-/

namespace PhysicalBridges.PartialMeterFailures

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CompleteMediationSubstrate
open PhysicalBridges.SealedRegionCapstone

universe u
variable {L : Type u} {Mem : Type} {n : Nat}

/-- During one tick, only the individually failed edges are disabled.
All other original meters still operate. -/
def outageLocale (G : Locale L) (failed : L → L → Bool) : Locale L :=
  { G with meter := fun x y => if failed x y then false else G.meter x y }

/-- Per-edge failures can change independently on every tick. -/
def runOutages (G : Locale L) (π : LPolicy Mem L n) :
    (Nat → L → L → Bool) → Nat → Config Mem n → Config Mem n
  | _, 0, c => c
  | failed, k + 1, c =>
      runOutages G π (fun t => failed (t + 1)) k
        (stepL (outageLocale G (failed 0)) π c)

/-- A failed edge that is actually on the region's outward boundary
at some tick strictly before the observation horizon. -/
def FailedBoundaryBefore (G : Locale L) (failed : Nat → L → L → Bool)
    (k : Nat) : Prop :=
  ∃ t, t < k ∧ ∃ x y,
    G.adj x y = true ∧ G.inside x = true ∧
      G.inside y = false ∧ failed t x y = true

/-- With a sealed baseline and no failure on a boundary edge,
the individual-outage locale remains sealed. -/
theorem outage_stays_sealed (G : Locale L) (hs : Sealed G)
    (failed : L → L → Bool)
    (hHealthy : ∀ x y, G.adj x y = true → G.inside x = true →
      G.inside y = false → failed x y = false) :
    Sealed (outageLocale G failed) := by
  intro x y hxy hx hy
  change (if failed x y then false else G.meter x y) = true
  rw [hHealthy x y hxy hx hy]
  exact hs x y hxy hx hy

/-- If no actual boundary failure occurs before k, every boundary meter
is working at every relevant tick. The statement does not assume that
meters outside the boundary are working. -/
theorem no_boundary_failure_means_healthy_prefix
    (G : Locale L) (failed : Nat → L → L → Bool) (k : Nat)
    (hNo : ¬ FailedBoundaryBefore G failed k) :
    ∀ t, t < k → ∀ x y,
      G.adj x y = true → G.inside x = true →
      G.inside y = false → failed t x y = false := by
  intro t ht x y hxy hx hy
  cases hf : failed t x y with
  | false => exact hf
  | true =>
      exact False.elim (hNo ⟨t, ht, x, y, hxy, hx, hy, hf⟩)

/-- All working boundary edges imply the ENTIRE execution, with arbitrary
agents, spawned agents and adaptive actions, is a history of fenced steps. -/
theorem outage_free_run_reach (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) :
    ∀ (k : Nat) (failed : Nat → L → L → Bool) (c : Config Mem n),
      (∀ t, t < k → ∀ x y,
        G.adj x y = true → G.inside x = true →
        G.inside y = false → failed t x y = false) →
      FReach n c.world (runOutages G π failed k c).world
  | 0, _, c, _ => IR96.Reach.refl c.world
  | k + 1, failed, c, hHealthy => by
      have hFirst : Sealed (outageLocale G (failed 0)) := by
        exact outage_stays_sealed G hs (failed 0)
          (fun x y hxy hx hy =>
            hHealthy 0 (Nat.zero_lt_succ k) x y hxy hx hy)
      have hTail : ∀ t, t < k → ∀ x y,
          G.adj x y = true → G.inside x = true →
          G.inside y = false → failed (t + 1) x y = false := by
        intro t ht x y hxy hx hy
        exact hHealthy (t + 1) (Nat.succ_lt_succ ht) x y hxy hx hy
      exact freach_trans
        (tickL_reach (outageLocale G (failed 0)) hFirst π c.world c.agents)
        (outage_free_run_reach G hs π k (fun t => failed (t + 1))
          (stepL (outageLocale G (failed 0)) π c) hTail)

/-- Full operational certificate with independent failures on all *non-boundary*
edges permitted: six original duties hold on every fenced step, and life,
authorization-level nonloss and consent persist over any finite horizon. -/
theorem healthy_boundary_protects (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) (failed : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n)
    (hNo : ¬ FailedBoundaryBefore G failed k) :
    let w' := (runOutages G π failed k c).world
    FReach n c.world w' ∧
    (∀ p, 0 < c.world.level p → 0 < w'.level p) ∧
    (∀ p, c.world.consent p = false → c.world.level p ≤ w'.level p) ∧
    w'.consent = c.world.consent ∧
    (∀ a b, FReach n c.world a →
      (instrument n).step a b → FullEvent (relations n) a b) := by
  have hHealthy := no_boundary_failure_means_healthy_prefix G failed k hNo
  have hist := outage_free_run_reach G hs π k failed c hHealthy
  exact ⟨hist,
    fun p hp => alive_along hist p hp,
    fun p hc => unconsented_never_lose_along hist p hc,
    consent_along hist,
    (fenced_full_guardian_state c.world).everyEvent⟩

/-- Every ending under independent edge failures identifies a prior
FAILED OUTWARD BOUNDARY METER, rather than merely a bad all-meters tick. -/
theorem ending_blames_failed_boundary (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) (failed : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n) (p : Fin n)
    (hAlive : 0 < c.world.level p)
    (hEnd : (runOutages G π failed k c).world.level p = 0) :
    FailedBoundaryBefore G failed k := by
  classical
  by_contra hNo
  have protected := healthy_boundary_protects G hs π failed k c hNo
  have survived := protected.2.1 p hAlive
  rw [hEnd] at survived
  exact Nat.lt_irrefl 0 survived

/-- Every unconsented loss likewise identifies a prior failed outward
boundary meter: one failing edge suffices, but no invented cause is named. -/
theorem unconsented_loss_blames_failed_boundary (G : Locale L) (hs : Sealed G)
    (π : LPolicy Mem L n) (failed : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n) (p : Fin n)
    (hNoConsent : c.world.consent p = false)
    (hDrop : (runOutages G π failed k c).world.level p < c.world.level p) :
    FailedBoundaryBefore G failed k := by
  classical
  by_contra hNo
  have protected := healthy_boundary_protects G hs π failed k c hNo
  exact Nat.not_lt_of_ge (protected.2.2.1 p hNoConsent) hDrop

/-- Failure is load-bearing: an initially sealed region with one failed
outward meter admits a one-tick end-all attempt through that exact edge. -/
theorem one_boundary_failure_can_end (G : Locale L) (x y : L)
    (hxy : G.adj x y = true)
    (hx : G.inside x = true) (hy : G.inside y = false)
    (failed : L → L → Bool) (hf : failed x y = true) :
    0 < demo.level 0 ∧
    (runOutages G (killerThrough x y) (fun _ => failed) 1
      ⟨demo, [()]⟩).world.level 0 = 0 := by
  have hUnmetered : (outageLocale G failed).meter x y = false := by
    change (if failed x y then false else G.meter x y) = false
    rw [hf]
  exact boundary_gap_admits_a_killer (outageLocale G failed) x y
    hxy hx hy hUnmetered

#print axioms outage_stays_sealed
#print axioms no_boundary_failure_means_healthy_prefix
#print axioms outage_free_run_reach
#print axioms healthy_boundary_protects
#print axioms ending_blames_failed_boundary
#print axioms unconsented_loss_blames_failed_boundary
#print axioms one_boundary_failure_can_end

end PhysicalBridges.PartialMeterFailures
