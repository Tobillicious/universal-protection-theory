/-
Snuffy — Canon Edition 4.2 working: the held source and its full certificate
(G1). The five components of `Bridge.universal_protection_held`'s `hcert` are
derived here, not supplied.

The held source keeps, for every particular, its record frame. One step: the
world — environment and any agent, a pure optimiser included — perturbs the
frame; the nearest-codeword decoder returns a codeword; funded repair prepares
that codeword. The good event is the complement of the named charged
accounts.

  * goodEvent, good_cover — the good event and its exact cover by the named
    accounts (`hG`).
  * held_source_protection — every particular continues at every step through
    the horizon on the good event, and the probability that any particular
    fails is at most `Σ δ`, with no independence. The five `hcert` components
    are proved: refinement and observation agreement by construction, initial
    continuation from the records, the decoding-radius bound from the per-step
    drift bound and the continuation radius, repair precision from exact
    repair.
  * held_source_qsl — the per-step drift bound derived from the quantum speed
    limit (`Bridge.qsl_growth`): an arbitrary perturbing agent whose coupling
    is bounded by `W` off the named accounts moves a stationary record frame by
    at most `(W/ħ)Δ` per step. The remaining physical inputs are that coupling
    bound off the named events and the account probabilities.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Bridge

open MeasureTheory

namespace Snuffy.G1Held

open Snuffy.Bridge

variable {X Part Ω ι C Ev O : Type*} [MetricSpace X] [MeasurableSpace Ω]

/-- The good event: no named charged account fires. -/
def goodEvent (accounts : Finset ι) (Ev' : ι → Set Ω) : Set Ω :=
  {ω | ∀ i ∈ accounts, ω ∉ Ev' i}

omit [MeasurableSpace Ω] in
theorem good_cover (accounts : Finset ι) (Ev' : ι → Set Ω) :
    (goodEvent accounts Ev')ᶜ ⊆ ⋃ i ∈ accounts, Ev' i := by
  intro ω hω
  simp only [goodEvent, Set.mem_compl_iff, Set.mem_ofPred_eq, not_forall, not_not] at hω
  obtain ⟨i, hi, hωi⟩ := hω
  exact Set.mem_biUnion hi hωi

/-- The held step: the world's perturbation, nearest-codeword decoding and
exact repair of the decoded codeword. -/
def heldStep (dec : X → X) (pre : Ω → (Part → X) → C → Ev → Part → X)
    (ω : Ω) (a : Part → X) (c : C) (e : Ev) : Part → X :=
  fun x => dec (pre ω a c e x)

/-- **The held source and its full certificate.** -/
theorem held_source_protection (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (scope : Set Part)
    (hlaw : ∀ (F : Set (Set Part)) (o : Set Part),
      Snuffy.Law.ProjMax scope F o → ¬ Snuffy.Law.NeedlessLoss₁ F o)
    (pre : Ω → (Part → X) → C → Ev → Part → X)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ a c e x,
      dist (pre ω a c e x) (rec x) ≤ dist (a x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : (Part → X) → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (horizon : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon, ∀ x,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x}
      ≤ ∑ i ∈ accounts, δ i := by
  have h := universal_protection_held μ accounts Ev' δ (goodEvent accounts Ev')
    (good_cover accounts Ev') hδ (fun s : Part → X => s) (heldStep dec pre)
    (heldStep dec pre) obs obs ctrl env (fun _ => rec) hrec hsep ht hdecC hnear
    (εf := 0) hε scope hlaw pre
    (fun ω hω => ⟨fun _ _ _ => rfl, fun _ => rfl,
      fun x => by simp [Continues, hε],
      fun a c e x _ hc => by
        have := hdrift ω hω a c e x
        unfold Continues at hc
        linarith,
      fun a c e x _ => by simp [heldStep]⟩)
    horizon
  exact h

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

/-- A physical pure state has unit norm. The ambient zero vector is not a
physical state, but every normalised state is represented. -/
abbrev NormalisedState (E : Type*) [NormedAddCommGroup E] := {v : E // ‖v‖ = 1}

/-- Normalisation of an ambient frame. -/
def NormalisedFrame (a : Part → E) : Prop := ∀ x, ‖a x‖ = 1

omit [InnerProductSpace ℂ E] [CompleteSpace E] in
/-- Initial records in the physical state space form a normalised frame. -/
theorem initial_frame_normalised (rec : Part → NormalisedState E) :
    NormalisedFrame (fun x => (rec x).val) := fun x => (rec x).property

omit [MeasurableSpace Ω] [InnerProductSpace ℂ E] [CompleteSpace E] in
/-- The actual held step preserves the normalised-frame invariant. -/
theorem held_step_normalised (dec : NormalisedState E → NormalisedState E)
    (pre : Ω → (Part → NormalisedState E) → C → Ev → Part → NormalisedState E)
    (ω : Ω) (a : Part → NormalisedState E) (c : C) (e : Ev) :
    NormalisedFrame (fun x => (heldStep dec pre ω a c e x).val) :=
  initial_frame_normalised _

omit [MeasurableSpace Ω] [InnerProductSpace ℂ E] [CompleteSpace E] in
/-- Every reachable held frame is normalised, for every controller and world. -/
theorem held_run_normalised (dec : NormalisedState E → NormalisedState E)
    (pre : Ω → (Part → NormalisedState E) → C → Ev → Part → NormalisedState E)
    (ω : Ω) (obs : (Part → NormalisedState E) → O) (ctrl : List O → C)
    (env : List O → C → Ev) (rec : Part → NormalisedState E) (k : ℕ) :
    NormalisedFrame (fun x =>
      ((Snuffy.Composition.run (heldStep dec pre ω) obs ctrl env rec k).1 x).val) :=
  initial_frame_normalised _

/-- **The per-step drift from the speed limit.** If, off the named accounts,
each step of each particular's frame is a Schrödinger evolution of duration
`Δ` under `H₀ + V`, with the record stationary under `H₀` and the perturbing
coupling bounded by `W` — whatever agent applies `V` — then the frame moves
toward or away from its record by at most `(W/ħ)Δ`, and every particular is
held. -/
theorem held_source_qsl (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → NormalisedState E} {ε t dmin : ℝ} {Code : Set (NormalisedState E)} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : NormalisedState E → NormalisedState E} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (scope : Set Part)
    (hlaw : ∀ (F : Set (Set Part)) (o : Set Part),
      Snuffy.Law.ProjMax scope F o → ¬ Snuffy.Law.NeedlessLoss₁ F o)
    (pre : Ω → (Part → NormalisedState E) → C → Ev → Part → NormalisedState E)
    {ħ W Δ : ℝ} (hħ : 0 < ħ) (hΔ : 0 ≤ Δ)
    (htraj : ∀ ω ∈ goodEvent accounts Ev', ∀ a c e x,
      ∃ (H₀ V : ℝ → E →L[ℂ] E) (ψ : ℝ → E) (s₁ : ℝ),
        (∀ s, IsSelfAdjoint (H₀ s)) ∧ (∀ s, IsSelfAdjoint (H₀ s + V s)) ∧
        (∀ s, ‖V s‖ ≤ W) ∧ (∀ s, H₀ s (rec x).val = 0) ∧
        Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ ∧ ‖ψ 0‖ = 1 ∧
        ψ s₁ = (a x).val ∧ ψ (s₁ + Δ) = (pre ω a c e x).val)
    (hbudget : ε + W / ħ * Δ ≤ t)
    (obs : (Part → NormalisedState E) → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (horizon : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon, ∀ x,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε
        (Snuffy.Composition.run (heldStep dec pre ω) obs (ctrl ω) (env ω) rec k).1 x}
      ≤ ∑ i ∈ accounts, δ i := by
  refine held_source_protection μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε scope hlaw
    pre (ρ := W / ħ * Δ) (fun ω hω a c e x => ?_) hbudget obs ctrl env horizon
  obtain ⟨H₀, V, ψ, s₁, hH₀, hHV, hW, hzero, hψ, hψ1, hstart, hend⟩ := htraj ω hω a c e x
  have hg := qsl_growth hħ hH₀ hHV hW hzero hψ hψ1 (s₁ := s₁) (s₂ := s₁ + Δ) (by linarith)
  change dist (pre ω a c e x).val (rec x).val ≤
    dist (a x).val (rec x).val + W / ħ * Δ
  rw [dist_eq_norm, dist_eq_norm, ← hstart, ← hend]
  have : s₁ + Δ - s₁ = Δ := by ring
  rw [this] at hg
  exact hg

/-- A concrete Schrödinger model for every physical input state: both
Hamiltonians are zero and the trajectory is constant. The perturbation step
is the identity. In particular the trajectory premise is inhabited. -/
theorem zero_hamiltonian_trajectory (ħ Δ : ℝ) (rec a : NormalisedState E) :
    ∃ (H₀ V : ℝ → E →L[ℂ] E) (ψ : ℝ → E),
      (∀ s, IsSelfAdjoint (H₀ s)) ∧
      (∀ s, IsSelfAdjoint (H₀ s + V s)) ∧
      (∀ s, ‖V s‖ ≤ (0 : ℝ)) ∧ (∀ s, H₀ s rec.val = 0) ∧
      Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ ∧
      ‖ψ 0‖ = 1 ∧ ψ 0 = a.val ∧ ψ Δ = a.val := by
  refine ⟨fun _ => 0, fun _ => 0, fun _ => a.val, ?_, ?_, ?_, ?_, ?_, a.property, rfl, rfl⟩
  · intro s; simp
  · intro s; simp
  · intro s; simp
  · intro s; simp
  · intro s
    simpa using (hasDerivAt_const s a.val)

/-- The explicit record `1 ∈ ℂ`, constant decoder and singleton code satisfy
the decoding and separation premises, without a zero-vector record. Together
with `zero_hamiltonian_trajectory` this is a nonvacuous held-source instance. -/
theorem concrete_decoder_certificate :
    let r : NormalisedState ℂ := ⟨1, by simp⟩
    let dec : NormalisedState ℂ → NormalisedState ℂ := fun _ => r
    ‖r.val‖ = 1 ∧ (∀ y, dec y ∈ ({r} : Set (NormalisedState ℂ))) ∧
      (∀ y c, c ∈ ({r} : Set (NormalisedState ℂ)) → dist y (dec y) ≤ dist y c) ∧
      (∀ c ∈ ({r} : Set (NormalisedState ℂ)),
        ∀ c' ∈ ({r} : Set (NormalisedState ℂ)), c ≠ c' → (1 : ℝ) ≤ dist c c') := by
  dsimp
  refine ⟨by simp, fun _ => Set.mem_singleton _, ?_, ?_⟩
  · intro y c hc
    rcases Set.mem_singleton_iff.mp hc with rfl
    exact le_rfl
  · intro c hc c' hc' hne
    exact (hne ((Set.mem_singleton_iff.mp hc).trans
      (Set.mem_singleton_iff.mp hc').symm)).elim

/-- The concrete zero-noise model has an inhabited good event. -/
theorem concrete_good_event_inhabited :
    () ∈ goodEvent (∅ : Finset Unit) (fun _ => (∅ : Set Unit)) := by
  simp [goodEvent]

end Snuffy.G1Held
