/-
Snuffy — Canon Edition v4.1: the bridge, derived — coverage from the law and
preservation along the holding route, composed from the instruments; the
Universal Protection Theorem with no assumed bridge clause (Global D; §§15–16;
Chapter 2; Chapter 3 / §19; §20.4).

The holding architecture runs, for every particular in its holding scope, one
cycle per step: the world (environment and any adversary, a pure optimiser
included) perturbs the particular's state; the syndrome decoder returns the
nearest codeword; funded repair prepares that codeword to repair precision.

  * coverage_from_law — Proposition 3 forces the holding scope to be every
    particular: a regime that decides by maximality on a scope `S` guarantees
    no needless existing loss for every feasible family only if `S` is
    everything (`Law.scope_guarantee_iff`).
  * nearest_decodes, exists_nearest_decoder — unique decoding: within half the
    code distance the nearest codeword is the record.
  * holding_preserves — if the step's perturbation keeps a continuing
    particular within the decoding radius, decoding returns its record and
    repair restores it: continuation is preserved.
  * qsl_growth, qsl_within_radius — sub-threshold perturbations: by the quantum
    speed limit (`SpeedLimit.branchA_divergence`) a particular whose code is
    stationary moves at most `(W/ħ)Δt` in a step, so it stays within the
    decoding radius at every time of the step.
  * headroom_within_radius — detected attacks: the errors accumulated during
    the response window are at most `(d − 1)/2` (`E9SelfHealing.code_headroom`),
    inside the decoding radius of a distance-`d` code.
  * holding_cycle_physical — the holding cycle from physics alone: discrete
    faults within E9's code headroom are decoded, sub-threshold drift of any
    agent is bounded by the speed limit at every time of the step, and the
    particular continues.
  * universal_protection_held — the assembled theorem: with coverage derived
    from the law and preservation derived from the holding cycle, every
    particular continues at every step through the horizon on the certified
    good event, and the probability that any particular fails is at most
    `Σ δ`, with no independence assumed.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Law
import Snuffy.SpeedLimit
import Snuffy.Composition
import Snuffy.E9SelfHealing
import Mathlib.Data.Set.Finite.Lemmas

open MeasureTheory Finset

namespace Snuffy.Bridge

/-! ## Coverage from the law -/

/-- **Coverage is forced by the law.** If a regime decides by maximality on its
holding scope `S` and guarantees no needless existing loss for every feasible
family (the law), then its holding scope is every particular. -/
theorem coverage_from_law {Part : Type*} (S : Set Part)
    (hlaw : ∀ (F : Set (Set Part)) (o : Set Part),
      Snuffy.Law.ProjMax S F o → ¬ Snuffy.Law.NeedlessLoss₁ F o) :
    ∀ x, x ∈ S := by
  have hS := (Snuffy.Law.scope_guarantee_iff S).mp hlaw
  intro x
  rw [hS]
  trivial

/-! ## Unique decoding -/

section Decoding

variable {X : Type*} [MetricSpace X]

/-- **Unique decoding.** If codewords are pairwise at distance at least `dmin`
and `2t < dmin`, a nearest-codeword decoder returns `c` for every received word
within `t` of the codeword `c`. -/
theorem nearest_decodes {Code : Set X} {dmin t : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code) (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    {c y : X} (hc : c ∈ Code) (hy : dist y c ≤ t) : dec y = c := by
  by_contra hne
  have h1 := hnear y c hc
  have h2 := hsep (dec y) (hdecC y) c hc hne
  have h3 : dist (dec y) c ≤ dist (dec y) y + dist y c := dist_triangle _ _ _
  rw [dist_comm (dec y) y] at h3
  linarith

/-- A finite nonempty code has a nearest-codeword decoder. -/
theorem exists_nearest_decoder (Code : Set X) (hfin : Code.Finite) (hne : Code.Nonempty) :
    ∃ dec : X → X, (∀ y, dec y ∈ Code) ∧ ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c := by
  classical
  refine ⟨fun y => (Set.exists_min_image Code (dist y) hfin hne).choose,
    fun y => (Set.exists_min_image Code (dist y) hfin hne).choose_spec.1,
    fun y c hc => (Set.exists_min_image Code (dist y) hfin hne).choose_spec.2 c hc⟩

/-- Continuation: a particular's state is within `ε` of its record. -/
def Continues {Part : Type*} (rec : Part → X) (ε : ℝ) (a : Part → X) (x : Part) : Prop :=
  dist (a x) (rec x) ≤ ε

/-- **The holding cycle preserves continuation.** Records are codewords of a
code with distance `dmin > 2t`; for every particular in the holding scope the
step's perturbation keeps a continuing particular within `t` of its record; the
decoder is nearest-codeword; repair prepares the decoded codeword to precision
`εf ≤ ε`. Then every continuing particular in the scope continues after the
step. -/
theorem holding_preserves {Part : Type*} {rec : Part → X} {ε εf t dmin : ℝ} {Code : Set X}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code) (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (hεf : εf ≤ ε) {S : Set Part} {pre step : (Part → X) → Part → X}
    (hgrow : ∀ a x, x ∈ S → Continues rec ε a x → dist (pre a x) (rec x) ≤ t)
    (hrep : ∀ a x, x ∈ S → dist (step a x) (dec (pre a x)) ≤ εf) :
    ∀ a x, x ∈ S → Continues rec ε a x → Continues rec ε (step a) x := by
  intro a x hx hc
  have hd : dec (pre a x) = rec x :=
    nearest_decodes hsep ht hdecC hnear (hrec x) (hgrow a x hx hc)
  have h := hrep a x hx
  rw [hd] at h
  exact h.trans hεf

end Decoding

/-! ## Sub-threshold perturbations: the quantum speed limit -/

section QSL

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-- **Bounded growth under any sub-threshold perturbation.** If the record
`rec` is stationary under the system's own dynamics (`H₀ rec = 0`: logical
states incur no autonomous drift, §18.1) and the actual state evolves under
`H₀ + V` with `‖V‖ ≤ W`, then over any interval the distance to the record
grows by at most `(W/ħ)` times its length. -/
theorem qsl_growth {ħ : ℝ} (hħ : 0 < ħ) {H₀ V : ℝ → E →L[ℂ] E}
    (hH₀ : ∀ s, IsSelfAdjoint (H₀ s)) (hHV : ∀ s, IsSelfAdjoint (H₀ s + V s))
    {W : ℝ} (hW : ∀ s, ‖V s‖ ≤ W) {rec : E} (hzero : ∀ s, H₀ s rec = 0) {ψ : ℝ → E}
    (hψ : Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ) (hψ1 : ‖ψ 0‖ = 1)
    {s₁ s₂ : ℝ} (h12 : s₁ ≤ s₂) :
    ‖ψ s₂ - rec‖ ≤ ‖ψ s₁ - rec‖ + W / ħ * (s₂ - s₁) := by
  have hφ : Snuffy.SpeedLimit.Solves ħ H₀ (fun _ => rec) := by
    intro s
    rw [hzero s, smul_zero]
    exact hasDerivAt_const s rec
  exact Snuffy.SpeedLimit.branchA_divergence hħ hH₀ hHV hW hψ hφ hψ1 h12

/-- **Within the decoding radius at every time of the step.** A particular that
starts the step within `ε` of its record, under any perturbation with
`‖V‖ ≤ W`, stays within `ε + (W/ħ)Δt ≤ t` of it at every time of the step. -/
theorem qsl_within_radius {ħ : ℝ} (hħ : 0 < ħ) {H₀ V : ℝ → E →L[ℂ] E}
    (hH₀ : ∀ s, IsSelfAdjoint (H₀ s)) (hHV : ∀ s, IsSelfAdjoint (H₀ s + V s))
    {W : ℝ} (hW : ∀ s, ‖V s‖ ≤ W) {rec : E} (hzero : ∀ s, H₀ s rec = 0) {ψ : ℝ → E}
    (hψ : Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ) (hψ1 : ‖ψ 0‖ = 1)
    {s₀ Δ ε t : ℝ} (hstart : ‖ψ s₀ - rec‖ ≤ ε) (hbudget : ε + W / ħ * Δ ≤ t) :
    ∀ s ∈ Set.Icc s₀ (s₀ + Δ), dist (ψ s) rec ≤ t := by
  intro s hs
  rw [dist_eq_norm]
  have hg := qsl_growth hħ hH₀ hHV hW hzero hψ hψ1 hs.1
  have hW0 : 0 ≤ W := (norm_nonneg _).trans (hW 0)
  have hlen : W / ħ * (s - s₀) ≤ W / ħ * Δ :=
    mul_le_mul_of_nonneg_left (by linarith [hs.2]) (div_nonneg hW0 hħ.le)
  linarith

end QSL

/-! ## Detected attacks: code headroom -/

/-- **Within the decoding radius during a response.** If the errors accumulated
during the response window number `N`, with `N ≤ λτ` and `2λτ < d`
(E9's code headroom), then `N ≤ t := (d − 1)/2` and `2t < d`: the corrupted
word is inside the unique-decoding radius of a distance-`d` code. -/
theorem headroom_within_radius {N d : ℕ} {lt : ℝ} (hN : (N : ℝ) ≤ lt) (hd : 2 * lt < d) :
    (N : ℝ) ≤ ((d : ℝ) - 1) / 2 ∧ 2 * (((d : ℝ) - 1) / 2) < d := by
  obtain ⟨-, h2⟩ := Snuffy.E9.code_headroom hN hd
  refine ⟨?_, by linarith⟩
  have hd1 : 1 ≤ d := by
    have : (0 : ℝ) ≤ lt := (Nat.cast_nonneg N).trans hN
    have : (0 : ℝ) < d := by linarith
    exact_mod_cast this
  have : ((N : ℕ) : ℝ) ≤ (((d - 1) / 2 : ℕ) : ℝ) := by exact_mod_cast h2
  have hdiv : (((d - 1) / 2 : ℕ) : ℝ) ≤ ((d : ℝ) - 1) / 2 := by
    rw [le_div_iff₀ (by norm_num : (0 : ℝ) < 2)]
    have h := Nat.div_mul_le_self (d - 1) 2
    have : (((d - 1) / 2 * 2 : ℕ) : ℝ) ≤ ((d - 1 : ℕ) : ℝ) := by exact_mod_cast h
    rw [Nat.cast_sub hd1, Nat.cast_one] at this
    push_cast at this
    linarith
  linarith

/-! ## The assembled theorem -/

section Assembly

variable {S A C Ev O : Type*}

/-- **The Universal Protection Theorem, with the bridge derived.** The abstract
state assigns each particular its state; the holding architecture's step is
perturbation, nearest-codeword decoding and repair, applied to every particular
in its holding scope. Coverage is derived from the law (the scope is every
particular) and preservation from the holding cycle. On the certified good event
every particular continues at every step through the horizon, and the
probability that any particular fails is at most `Σ δ`, with no independence
assumed. What the installation supplies is stated as hypotheses: the commuting
refinement of the physical machine by the abstract step, observation agreement,
the initial witness, that each step's perturbation stays within the decoding
radius (from `qsl_within_radius` or `headroom_within_radius`), repair to
precision `εf`, and the conditional kernel bounds. -/
theorem universal_protection_held {X Part : Type*} [MetricSpace X] {Ω ι : Type*}
    [MeasurableSpace Ω] (μ : Measure Ω)
    (accounts : Finset ι) (Ev' : ι → Set Ω) (δ : ι → ENNReal) (G : Set Ω)
    (hG : Gᶜ ⊆ ⋃ i ∈ accounts, Ev' i) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    (p : S → Part → X) (T : Ω → S → C → Ev → S) (U : Ω → (Part → X) → C → Ev → Part → X)
    (obsS : S → O) (obsA : (Part → X) → O) (ctrl : Ω → List O → C)
    (env : Ω → List O → C → Ev) (s₀ : Ω → S)
    -- records, code and decoder
    {rec : Part → X} {ε εf t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code) (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (hεf : εf ≤ ε)
    -- the holding scope implements the law
    (scope : Set Part)
    (hlaw : ∀ (F : Set (Set Part)) (o : Set Part),
      Snuffy.Law.ProjMax scope F o → ¬ Snuffy.Law.NeedlessLoss₁ F o)
    -- the per-step perturbation, before decoding
    (pre : Ω → (Part → X) → C → Ev → Part → X)
    (hcert : ∀ ω ∈ G, (∀ s c e, p (T ω s c e) = U ω (p s) c e) ∧
      (∀ s, obsS s = obsA (p s)) ∧ (∀ x, Continues rec ε (p (s₀ ω)) x) ∧
      (∀ a c e x, x ∈ scope → Continues rec ε a x → dist (pre ω a c e x) (rec x) ≤ t) ∧
      (∀ a c e x, x ∈ scope → dist (U ω a c e x) (dec (pre ω a c e x)) ≤ εf))
    (horizon : ℕ) :
    (∀ ω ∈ G, ∀ k ≤ horizon, ∀ x,
      Continues rec ε (p (Snuffy.Composition.run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1) x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε (p (Snuffy.Composition.run (T ω) obsS (ctrl ω) (env ω) (s₀ ω) k).1) x}
      ≤ ∑ i ∈ accounts, δ i := by
  have hcov := coverage_from_law scope hlaw
  exact Snuffy.Composition.theorem8_composition μ accounts Ev' δ G hG hδ p T U obsS obsA ctrl env s₀
    (fun a => ∀ x, Continues rec ε a x)
    (fun ω hω => by
      obtain ⟨hc, ho, hi, hgrow, hrep⟩ := hcert ω hω
      refine ⟨hc, ho, hi, fun a c e ha x => ?_⟩
      exact holding_preserves hrec hsep ht hdecC hnear hεf
        (pre := fun a' => pre ω a' c e) (step := fun a' => U ω a' c e)
        (fun a' y hy hcy => hgrow a' c e y hy hcy) (fun a' y hy => hrep a' c e y hy)
        a x (hcov x) (ha x))
    horizon

/-- Continuation of a particular whose state has a discrete error part (the
Pauli frame, corrected by syndrome decoding) and a continuous part (the state
vector, bounded by the speed limit): the discrete part is its record codeword
and the continuous part is within `ε` of its record vector. -/
def ContinuesP {Y E Part : Type*} [NormedAddCommGroup E] (recY : Part → Y) (recE : Part → E)
    (ε : ℝ) (a : Part → Y × E) (x : Part) : Prop :=
  (a x).1 = recY x ∧ ‖(a x).2 - recE x‖ ≤ ε

/-- **The holding cycle against any agent, from physics alone.** For a particular
in the holding scope:
  * discrete faults: starting at the record, the faults accumulated in a step
    number at most `N ≤ λτ` with `2λτ < d` (E9's code headroom), and the Pauli
    correction applies the nearest-codeword decoder of a distance-`d` code;
  * continuous drift: during the step the state vector evolves under `H₀ + V`
    with `‖V‖ ≤ W` (any sub-threshold perturbation, a pure optimiser's
    included) from a record that is stationary under `H₀`, and refresh from the
    record restores it to precision `εf ≤ ε`.
Then the particular continues after the step, and at every time during the step
its state vector stays within `ε + (W/ħ)Δt` of its record. -/
theorem holding_cycle_physical {Y E Part : Type*} [MetricSpace Y]
    [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]
    {recY : Part → Y} {recE : Part → E} {ε εf Δ : ℝ} {d N : ℕ} {lt : ℝ} {Code : Set Y}
    (hrecY : ∀ x, recY x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → (d : ℝ) ≤ dist c c')
    {dec : Y → Y} (hdecC : ∀ y, dec y ∈ Code) (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c)
    (hN : (N : ℝ) ≤ lt) (hd : 2 * lt < d) (hεf : εf ≤ ε)
    {ħ : ℝ} (hħ : 0 < ħ) {H₀ V : ℝ → E →L[ℂ] E}
    (hH₀ : ∀ s, IsSelfAdjoint (H₀ s)) (hHV : ∀ s, IsSelfAdjoint (H₀ s + V s))
    {W : ℝ} (hW : ∀ s, ‖V s‖ ≤ W) (hzero : ∀ x s, H₀ s (recE x) = 0)
    {a : Part → Y × E} {x : Part} (hc : ContinuesP recY recE ε a x)
    -- the step: discrete faults, then continuous evolution, then correction and refresh
    {yPre : Y} (hfault : dist yPre (recY x) ≤ N)
    {ψ : ℝ → E} (hψ : Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ) (hψ1 : ‖ψ 0‖ = 1)
    (hψ0 : ψ 0 = (a x).2)
    {next : Y × E} (hcorr : next.1 = dec yPre) (hrefresh : ‖next.2 - recE x‖ ≤ εf) :
    (next.1 = recY x ∧ ‖next.2 - recE x‖ ≤ ε) ∧
      ∀ s ∈ Set.Icc 0 Δ, ‖ψ s - recE x‖ ≤ ε + W / ħ * Δ := by
  obtain ⟨hNt, h2t⟩ := headroom_within_radius hN hd
  have hdecoded : dec yPre = recY x :=
    nearest_decodes hsep h2t hdecC hnear (hrecY x) (hfault.trans hNt)
  refine ⟨⟨hcorr.trans hdecoded, hrefresh.trans hεf⟩, fun s hs => ?_⟩
  have hstart : ‖ψ 0 - recE x‖ ≤ ε := by rw [hψ0]; exact hc.2
  have h := qsl_within_radius hħ hH₀ hHV hW (hzero x) hψ hψ1 (s₀ := 0) (Δ := Δ)
    hstart le_rfl s (by simpa using hs)
  rwa [dist_eq_norm] at h

end Assembly

end Snuffy.Bridge
