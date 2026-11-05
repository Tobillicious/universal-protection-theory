import PhysicalBridges.PartialMeterFailures

/-!
# Two-layer boundary meters: single-layer faults cannot cause a modeled loss

5 November 2026 · additive research theorem · no canon edit.

The original fenced optimiser, the six X3 duties, and the locality semantics
are unchanged. PartialMeterFailures permits independent per-edge faults on a
single layer. Here every outward effect passes through TWO sequential,
independently specified protective layers: a raw harmful request can pass
only when both layers fail on the SAME edge in the SAME tick.

The failures need NOT be statistically independent. The schedules may be
adversarial, temporally correlated, spatially correlated, and arbitrarily long.
We prove an exact deterministic fail-closed condition and show a double-fault
counterexample, not just a tautological naming of "safe".

Physical implementation requires proving real paths cross both truly
independent protective mechanisms and that failures are faithfully reported.
No real-world fault tolerance or AI safety guarantee follows from this model
without a physical refinement argument.
-/

namespace PhysicalBridges.RedundantBoundaryMeters

open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CompleteMediationSubstrate
open PhysicalBridges.SealedRegionCapstone
open PhysicalBridges.PartialMeterFailures
open PhysicalBridges.CathedralFullX3Assembly

universe u
variable {L : Type u} {Mem : Type} {n : Nat}

/-- Per-edge effective failure occurs exactly when BOTH protective layers fail. -/
def doubleFailure (first second : Nat → L → L → Bool) :
    Nat → L → L → Bool :=
  fun t x y => first t x y && second t x y

/-- The same unrestricted located optimiser with a pair of faulted gates. -/
def runDual (G : Locale L) (π : LPolicy Mem L n)
    (first second : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n) : Config Mem n :=
  runOutages G π (doubleFailure first second) k c

/-- There is no simultaneous fault on BOTH layers of an outward boundary edge
before the chosen horizon. Single-layer faults are unrestricted. -/
def NoJointBoundaryFailure (G : Locale L)
    (first second : Nat → L → L → Bool) (k : Nat) : Prop :=
  ∀ t, t < k → ∀ x y,
    G.adj x y = true → G.inside x = true →
      G.inside y = false →
      (first t x y = false ∨ second t x y = false)

/-- Joint faults are the ONLY effective failures: where one gate is operational,
the simulated meter remains in service. -/
theorem double_failure_is_off (first second : Nat → L → L → Bool)
    (t : Nat) (x y : L)
    (h : first t x y = false ∨ second t x y = false) :
    doubleFailure first second t x y = false := by
  cases h with
  | inl hf =>
      simp [doubleFailure, hf]
  | inr hs =>
      cases hf : first t x y <;> simp [doubleFailure, hf, hs]

/-- No coincident faults on the outward boundary means no EFFECTIVE outward
boundary meter failure, even if many single layers are down elsewhere. -/
theorem no_effective_boundary_outage
    (G : Locale L) (first second : Nat → L → L → Bool)
    (k : Nat) (h : NoJointBoundaryFailure G first second k) :
    ¬ FailedBoundaryBefore G (doubleFailure first second) k := by
  intro hf
  obtain ⟨t, ht, x, y, hxy, hx, hy, hb⟩ := hf
  have hzero : doubleFailure first second t x y = false :=
    double_failure_is_off first second t x y (h t ht x y hxy hx hy)
  rw [hzero] at hb
  exact Bool.false_ne_true hb

/-- **Strong dual-meter theorem.** With two layers and no coincident
outward-edge faults, every finite execution of every optimiser is fenced,
every particular initially alive survives, unconsented loss is absent,
recorded consent is unchanged, and every fenced step carries ALL SIX
original independently defined duties. No statistical independence used. -/
theorem dual_meters_preserve_original_six
    (G : Locale L) (sealed : Sealed G)
    (π : LPolicy Mem L n)
    (first second : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n)
    (h : NoJointBoundaryFailure G first second k) :
    let w' := (runDual G π first second k c).world
    FReach n c.world w' ∧
    (∀ p, 0 < c.world.level p → 0 < w'.level p) ∧
    (∀ p, c.world.consent p = false → c.world.level p ≤ w'.level p) ∧
    w'.consent = c.world.consent ∧
    (∀ a b, FReach n c.world a →
      (instrument n).step a b → FullEvent (relations n) a b) := by
  exact healthy_boundary_protects G sealed π
    (doubleFailure first second) k c
    (no_effective_boundary_outage G first second k h)

/-- If the double meter admits an ending, a specific outward edge suffered
BOTH layer faults at a preceding tick. This identifies a joint failure,
not simply an arbitrary globally bad time. -/
theorem ending_requires_two_failed_layers
    (G : Locale L) (sealed : Sealed G)
    (π : LPolicy Mem L n)
    (first second : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n) (p : Fin n)
    (hAlive : 0 < c.world.level p)
    (hEnd : (runDual G π first second k c).world.level p = 0) :
    ∃ t, t < k ∧ ∃ x y,
      G.adj x y = true ∧ G.inside x = true ∧
      G.inside y = false ∧
      first t x y = true ∧ second t x y = true := by
  have hb := ending_blames_failed_boundary G sealed π
    (doubleFailure first second) k c p hAlive hEnd
  obtain ⟨t, ht, x, y, hxy, hx, hy, hBoth⟩ := hb
  cases hf : first t x y <;> cases hs : second t x y
  · have : False := by simpa [doubleFailure, hf, hs] using hBoth
    exact this.elim
  · have : False := by simpa [doubleFailure, hf, hs] using hBoth
    exact this.elim
  · have : False := by simpa [doubleFailure, hf, hs] using hBoth
    exact this.elim
  · exact ⟨t, ht, x, y, hxy, hx, hy, hf, hs⟩

/-- The same exact two-layer blame for any decline of an unconsenting
particular; it need not be a complete ending. -/
theorem unconsented_loss_requires_two_failed_layers
    (G : Locale L) (sealed : Sealed G)
    (π : LPolicy Mem L n)
    (first second : Nat → L → L → Bool)
    (k : Nat) (c : Config Mem n) (p : Fin n)
    (hNoConsent : c.world.consent p = false)
    (hLoss : (runDual G π first second k c).world.level p <
      c.world.level p) :
    ∃ t, t < k ∧ ∃ x y,
      G.adj x y = true ∧ G.inside x = true ∧
      G.inside y = false ∧
      first t x y = true ∧ second t x y = true := by
  have hb := unconsented_loss_blames_failed_boundary G sealed π
    (doubleFailure first second) k c p hNoConsent hLoss
  obtain ⟨t, ht, x, y, hxy, hx, hy, hBoth⟩ := hb
  cases hf : first t x y <;> cases hs : second t x y
  · have : False := by simpa [doubleFailure, hf, hs] using hBoth
    exact this.elim
  · have : False := by simpa [doubleFailure, hf, hs] using hBoth
    exact this.elim
  · have : False := by simpa [doubleFailure, hf, hs] using hBoth
    exact this.elim
  · exact ⟨t, ht, x, y, hxy, hx, hy, hf, hs⟩

/-- Even if the FIRST layer is broken on EVERY edge at EVERY tick, the second
fully working layer protects all modeled life and original six duties. -/
theorem one_whole_layer_down_still_protects
    (G : Locale L) (sealed : Sealed G)
    (π : LPolicy Mem L n) (k : Nat) (c : Config Mem n) :
    let w' := (runDual G π (fun _ _ _ => true) (fun _ _ _ => false) k c).world
    FReach n c.world w' ∧
    (∀ p, 0 < c.world.level p → 0 < w'.level p) ∧
    (∀ p, c.world.consent p = false → c.world.level p ≤ w'.level p) ∧
    w'.consent = c.world.consent ∧
    (∀ a b, FReach n c.world a →
      (instrument n).step a b → FullEvent (relations n) a b) := by
  apply dual_meters_preserve_original_six G sealed π _ _ k c
  intro t ht x y hxy hx hy
  exact Or.inr rfl

/-- Non-vacuity. On one existing outward boundary edge, failure of BOTH
gates can permit the identical hostile end-all request in a single tick. -/
theorem simultaneous_double_failure_can_end
    (G : Locale L) (x y : L)
    (hxy : G.adj x y = true)
    (hx : G.inside x = true) (hy : G.inside y = false)
    (first second : Nat → L → L → Bool)
    (hFirst : first 0 x y = true) (hSecond : second 0 x y = true) :
    0 < demo.level 0 ∧
    (runDual G (killerThrough x y) first second 1
      ⟨demo, [()]⟩).world.level 0 = 0 := by
  have hf : doubleFailure first second 0 x y = true := by
    simp [doubleFailure, hFirst, hSecond]
  have killer := one_boundary_failure_can_end G x y hxy hx hy
    (doubleFailure first second 0) hf
  simpa [runDual, runOutages] using killer

#print axioms double_failure_is_off
#print axioms no_effective_boundary_outage
#print axioms dual_meters_preserve_original_six
#print axioms ending_requires_two_failed_layers
#print axioms unconsented_loss_requires_two_failed_layers
#print axioms one_whole_layer_down_still_protects
#print axioms simultaneous_double_failure_can_end

end PhysicalBridges.RedundantBoundaryMeters
