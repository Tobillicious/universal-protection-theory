/-
Snuffy — Canon Edition 4.2 working: protection of the installation's own
physical transition (G1; review objection 2).

The installation has its own physical state space `S`, which may carry hidden
internal degrees of freedom. A readout `read : S → Part → X` gives each
particular's record frame. One physical step is guarded: the world (the
environment and any agent) acts, then the physical corrector acts. No
abstraction map to a separate held machine is needed. Protection is proved
for the physical run itself, from three properties of the device:

  * correction — the corrector writes the nearest codeword back into each
    particular's readout: `read (correct s) x = dec (read s x)`;
  * drift — on the good event the world's action moves each readout by at
    most `ρ` toward or away from its record (supplied for normalised quantum
    frames by `G1Held.held_source_qsl` and `G1E9.held_source_e9`);
  * initialisation — the records are written at the start.

  * guarded_step_continues — one guarded physical step keeps every continuing
    particular continuing.
  * physical_protection — every particular continues at every step of the
    installation's physical run on the good event, and the probability that
    any particular fails is at most `Σ δ`, with no independence.
  * physical_qsl_drift, physical_protection_qsl — the drift from the speed
    limit for any agent of coupling at most `W`, on normalised readouts; with
    `W` the maximal physical coupling, correcting often enough holds every
    particular with no alarm-response device.
  * physical_instance_inhabited — every hypothesis has a concrete instance.
  * journaled_protection — adding the complete journal of
    `G1FullDomain` changes nothing the controller or environment observes,
    keeps every particular protected along the live state, and replays the
    live state exactly. The journal retains history; the guard provides the
    protection.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G1Held
import Snuffy.G1FullDomain

open MeasureTheory

namespace Snuffy.G1Refinement

open Snuffy.Bridge Snuffy.G1Held

variable {X Part S Ω ι C Ev O : Type*} [MetricSpace X] [MeasurableSpace Ω]

/-- The installation's guarded physical step: the world acts, then the
corrector acts. -/
def guardedStep (correct : S → S) (perturb : Ω → S → C → Ev → S)
    (ω : Ω) (s : S) (c : C) (e : Ev) : S :=
  correct (perturb ω s c e)

omit [MeasurableSpace Ω] in
/-- **One guarded physical step preserves continuation.** -/
theorem guarded_step_continues {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : S → Part → X) (correct : S → S)
    (hcorr : ∀ s x, read (correct s) x = dec (read s x))
    (perturb : Ω → S → C → Ev → S) (ω : Ω)
    (hdrift : ∀ s c e x, dist (read (perturb ω s c e) x) (rec x) ≤ dist (read s x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t) :
    ∀ s c e, (∀ x, Continues rec ε (read s) x) →
      ∀ x, Continues rec ε (read (guardedStep correct perturb ω s c e)) x := by
  intro s c e hs x
  unfold Continues guardedStep
  rw [hcorr]
  have hx : dist (read s x) (rec x) ≤ ε := hs x
  have hy : dist (read (perturb ω s c e) x) (rec x) ≤ t := by
    have := hdrift s c e x
    linarith
  rw [nearest_decodes hsep ht hdecC hnear (hrec x) hy, dist_self]
  exact hε

/-- **Protection of the installation's physical run.** -/
theorem physical_protection (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : S → Part → X) (correct : S → S)
    (hcorr : ∀ s x, read (correct s) x = dec (read s x))
    (perturb : Ω → S → C → Ev → S)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ s c e x,
      dist (read (perturb ω s c e) x) (rec x) ≤ dist (read s x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : S → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → S) (hinit : ∀ ω x, read (s₀ ω) x = rec x) (horizon : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon, ∀ x,
      Continues rec ε
        (read (Snuffy.Composition.run (guardedStep correct perturb ω) obs (ctrl ω) (env ω)
          (s₀ ω) k).1) x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε
        (read (Snuffy.Composition.run (guardedStep correct perturb ω) obs (ctrl ω) (env ω)
          (s₀ ω) k).1) x}
      ≤ ∑ i ∈ accounts, δ i :=
  Snuffy.Composition.theorem8_composition μ accounts Ev' δ (goodEvent accounts Ev')
    (good_cover accounts Ev') hδ (fun s : S => s) (guardedStep correct perturb)
    (guardedStep correct perturb) obs obs ctrl env s₀
    (fun s => ∀ x, Continues rec ε (read s) x)
    (fun ω hω => ⟨fun _ _ _ => rfl, fun _ => rfl,
      fun x => by simp [Continues, hinit, hε],
      guarded_step_continues hrec hsep ht hdecC hnear hε read correct hcorr perturb ω
        (hdrift ω hω) hbudget⟩)
    horizon

/-- **The journaled installation.** The complete journal observes nothing new,
keeps every particular protected along the live state, and replays the live
state exactly. -/
theorem journaled_protection (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : S → Part → X) (correct : S → S)
    (hcorr : ∀ s x, read (correct s) x = dec (read s x))
    (perturb : Ω → S → C → Ev → S)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ s c e x,
      dist (read (perturb ω s c e) x) (rec x) ≤ dist (read s x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : S → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → S) (hinit : ∀ ω x, read (s₀ ω) x = rec x) (horizon : ℕ) :
    ∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon,
      let js := Snuffy.Composition.run (Snuffy.G1FullDomain.journalStep
          (guardedStep correct perturb ω))
        (fun j : Snuffy.G1FullDomain.JournalState S C Ev => obs j.live) (ctrl ω) (env ω)
        (Snuffy.G1FullDomain.journalInit (s₀ ω)) k
      (∀ x, Continues rec ε (read js.1.live) x) ∧
        Snuffy.G1FullDomain.replay (guardedStep correct perturb ω) js.1 = js.1.live := by
  intro ω hω k hk
  obtain ⟨hlive, -, hreplay⟩ := Snuffy.G1FullDomain.journal_reactive_fidelity
    (guardedStep correct perturb ω) obs (ctrl ω) (env ω) (s₀ ω) k
  refine ⟨fun x => ?_, hreplay⟩
  rw [hlive]
  exact (physical_protection μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε read correct hcorr
    perturb hdrift hbudget obs ctrl env s₀ hinit horizon).1 ω hω k hk x

section Quantum

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

omit [MeasurableSpace Ω] in
/-- **The physical drift from the speed limit.** If each guarded step's
perturbation of each normalised readout is a Schrödinger evolution of duration
`Δ` under `H₀ + V` with the record stationary under `H₀` and `‖V‖ ≤ W` —
whatever agent applies `V` — then each readout moves toward or away from its
record by at most `(W/ħ)Δ`. -/
theorem physical_qsl_drift {rec : Part → NormalisedState E} (read : S → Part → NormalisedState E)
    (perturb : Ω → S → C → Ev → S) (G : Set Ω) {ħ W Δ : ℝ} (hħ : 0 < ħ) (hΔ : 0 ≤ Δ)
    (htraj : ∀ ω ∈ G, ∀ s c e x,
      ∃ (H₀ V : ℝ → E →L[ℂ] E) (ψ : ℝ → E) (s₁ : ℝ),
        (∀ s, IsSelfAdjoint (H₀ s)) ∧ (∀ s, IsSelfAdjoint (H₀ s + V s)) ∧
        (∀ s, ‖V s‖ ≤ W) ∧ (∀ s, H₀ s (rec x).val = 0) ∧
        Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ ∧ ‖ψ 0‖ = 1 ∧
        ψ s₁ = (read s x).val ∧ ψ (s₁ + Δ) = (read (perturb ω s c e) x).val) :
    ∀ ω ∈ G, ∀ s c e x,
      dist (read (perturb ω s c e) x) (rec x) ≤ dist (read s x) (rec x) + W / ħ * Δ := by
  intro ω hω s c e x
  obtain ⟨H₀, V, ψ, s₁, hH₀, hHV, hW, hzero, hψ, hψ1, hstart, hend⟩ := htraj ω hω s c e x
  have hg := qsl_growth hħ hH₀ hHV hW hzero hψ hψ1 (s₁ := s₁) (s₂ := s₁ + Δ) (by linarith)
  change dist (read (perturb ω s c e) x).val (rec x).val ≤
    dist (read s x).val (rec x).val + W / ħ * Δ
  rw [dist_eq_norm, dist_eq_norm, ← hstart, ← hend]
  have : s₁ + Δ - s₁ = Δ := by ring
  rw [this] at hg
  exact hg

/-- **Protection of the physical run under any agent of bounded coupling.**
Take `W` to be the maximal physical coupling of any agent (finite local
power). Correcting at intervals `Δ` with `ε + (W/ħ)Δ ≤ t` holds every
particular; no alarm-response device is needed for holding. -/
theorem physical_protection_qsl (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → NormalisedState E} {ε t dmin : ℝ} {Code : Set (NormalisedState E)}
    (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : NormalisedState E → NormalisedState E} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : S → Part → NormalisedState E) (correct : S → S)
    (hcorr : ∀ s x, read (correct s) x = dec (read s x))
    (perturb : Ω → S → C → Ev → S) {ħ W Δ : ℝ} (hħ : 0 < ħ) (hΔ : 0 ≤ Δ)
    (htraj : ∀ ω ∈ goodEvent accounts Ev', ∀ s c e x,
      ∃ (H₀ V : ℝ → E →L[ℂ] E) (ψ : ℝ → E) (s₁ : ℝ),
        (∀ s, IsSelfAdjoint (H₀ s)) ∧ (∀ s, IsSelfAdjoint (H₀ s + V s)) ∧
        (∀ s, ‖V s‖ ≤ W) ∧ (∀ s, H₀ s (rec x).val = 0) ∧
        Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ ∧ ‖ψ 0‖ = 1 ∧
        ψ s₁ = (read s x).val ∧ ψ (s₁ + Δ) = (read (perturb ω s c e) x).val)
    (hbudget : ε + W / ħ * Δ ≤ t)
    (obs : S → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → S) (hinit : ∀ ω x, read (s₀ ω) x = rec x) (horizon : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon, ∀ x,
      Continues rec ε
        (read (Snuffy.Composition.run (guardedStep correct perturb ω) obs (ctrl ω) (env ω)
          (s₀ ω) k).1) x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε
        (read (Snuffy.Composition.run (guardedStep correct perturb ω) obs (ctrl ω) (env ω)
          (s₀ ω) k).1) x}
      ≤ ∑ i ∈ accounts, δ i :=
  physical_protection μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε read correct hcorr perturb
    (physical_qsl_drift read perturb _ hħ hΔ htraj) hbudget obs ctrl env s₀ hinit horizon

omit [CompleteSpace E] in
/-- **A nonvacuous physical instance.** The state is the frame of normalised
readouts, the corrector applies the decoder, and the world is the identity
under zero Hamiltonians. Correction, trajectory and initialisation hypotheses
all hold, so the physical theorem has inhabited instances. -/
theorem physical_instance_inhabited [CompleteSpace E] (dec : NormalisedState E → NormalisedState E)
    (rec : Part → NormalisedState E) (ħ Δ : ℝ) :
    let read : (Part → NormalisedState E) → Part → NormalisedState E := fun s => s
    let correct : (Part → NormalisedState E) → Part → NormalisedState E := fun s x => dec (s x)
    let perturb : Unit → (Part → NormalisedState E) → Unit → Unit → Part → NormalisedState E :=
      fun _ s _ _ => s
    (∀ s x, read (correct s) x = dec (read s x)) ∧
      (∀ s x, ∃ (H₀ V : ℝ → E →L[ℂ] E) (ψ : ℝ → E) (s₁ : ℝ),
        (∀ s, IsSelfAdjoint (H₀ s)) ∧ (∀ s, IsSelfAdjoint (H₀ s + V s)) ∧
        (∀ s, ‖V s‖ ≤ (0 : ℝ)) ∧ (∀ s, H₀ s (rec x).val = 0) ∧
        Snuffy.SpeedLimit.Solves ħ (fun s => H₀ s + V s) ψ ∧ ‖ψ 0‖ = 1 ∧
        ψ s₁ = (read s x).val ∧ ψ (s₁ + Δ) = (read (perturb () s () ()) x).val) ∧
      (∀ x, read rec x = rec x) := by
  intro read correct perturb
  refine ⟨fun _ _ => rfl, fun s x => ?_, fun _ => rfl⟩
  obtain ⟨H₀, V, ψ, h1, h2, h3, h4, h5, h6, h7, h8⟩ := zero_hamiltonian_trajectory ħ Δ (rec x) (s x)
  exact ⟨H₀, V, ψ, 0, h1, h2, h3, h4, h5, h6, h7, by rw [zero_add]; exact h8⟩

end Quantum

end Snuffy.G1Refinement
