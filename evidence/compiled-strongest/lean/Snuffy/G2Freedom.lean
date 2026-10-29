/-
Snuffy — Canon Edition 4.2 working: holding and timely authorised delivery on
the same physical execution (G2 freedom stage; review objection 3).

The installation's state is the pair of its physical frames and the R17
effect machine. One step corrects the frames after the world acts — the
physical consequences of every applied effect are part of the world's bounded
drift — and advances the effect machine by its own delivery transition. The
corrector does not touch the effect machine, and delivery does not touch the
readouts.

  * joint_holding — every particular continues at every step of the joint run
    on the good event, with failure probability at most `Σ δ`.
  * joint_holding_and_delivery — on that same run, at every step, every
    particular continues and every effect that is ready under a live R17
    contract, inside a deadline-certified FIFO prefix, is applied by its
    deadline (`SnuffyFIFO.ready_fifo_effect_applies_before_deadline`).

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G1Refinement
import Snuffy.R17FIFOR17A

open MeasureTheory

namespace Snuffy.G2Freedom

open Snuffy.Bridge Snuffy.G1Held Snuffy.G1Refinement

variable {X Part P Ω ι C Ev O : Type*} [MetricSpace X] [MeasurableSpace Ω]

/-- The joint world step: the world acts on the frames, and the effect machine
advances by its delivery transition. -/
def jointPerturb (perturb : Ω → P → C → Ev → P) (deliver : UPTR17A.Machine → C → Ev → UPTR17A.Machine)
    (ω : Ω) (s : P × UPTR17A.Machine) (c : C) (e : Ev) : P × UPTR17A.Machine :=
  (perturb ω s.1 c e, deliver s.2 c e)

/-- The joint corrector: correct the frames, leave the effect machine. -/
def jointCorrect (correct : P → P) (s : P × UPTR17A.Machine) : P × UPTR17A.Machine :=
  (correct s.1, s.2)

/-- **Holding on the joint run.** -/
theorem joint_holding (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : P → Part → X) (correct : P → P)
    (hcorr : ∀ p x, read (correct p) x = dec (read p x))
    (perturb : Ω → P → C → Ev → P) (deliver : UPTR17A.Machine → C → Ev → UPTR17A.Machine)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ p c e x,
      dist (read (perturb ω p c e) x) (rec x) ≤ dist (read p x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : P × UPTR17A.Machine → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → P × UPTR17A.Machine) (hinit : ∀ ω x, read (s₀ ω).1 x = rec x) (horizon : ℕ) :
    (∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon, ∀ x,
      Continues rec ε
        (read (Snuffy.Composition.run (guardedStep (jointCorrect correct) (jointPerturb perturb deliver) ω)
          obs (ctrl ω) (env ω) (s₀ ω) k).1.1) x) ∧
    μ {ω | ∃ k ≤ horizon, ¬ ∀ x,
      Continues rec ε
        (read (Snuffy.Composition.run (guardedStep (jointCorrect correct) (jointPerturb perturb deliver) ω)
          obs (ctrl ω) (env ω) (s₀ ω) k).1.1) x}
      ≤ ∑ i ∈ accounts, δ i :=
  physical_protection μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε
    (fun s => read s.1) (jointCorrect correct) (fun s x => hcorr s.1 x)
    (jointPerturb perturb deliver) (fun ω hω s c e x => hdrift ω hω s.1 c e x) hbudget
    obs ctrl env s₀ hinit horizon

/-- **Holding and timely authorised delivery on the same run.** -/
theorem joint_holding_and_delivery (μ : Measure Ω) (accounts : Finset ι) (Ev' : ι → Set Ω)
    (δ : ι → ENNReal) (hδ : ∀ i ∈ accounts, μ (Ev' i) ≤ δ i)
    {rec : Part → X} {ε ρ t dmin : ℝ} {Code : Set X} (hrec : ∀ x, rec x ∈ Code)
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c') (ht : 2 * t < dmin)
    {dec : X → X} (hdecC : ∀ y, dec y ∈ Code)
    (hnear : ∀ y, ∀ c ∈ Code, dist y (dec y) ≤ dist y c) (hε : 0 ≤ ε)
    (read : P → Part → X) (correct : P → P)
    (hcorr : ∀ p x, read (correct p) x = dec (read p x))
    (perturb : Ω → P → C → Ev → P) (deliver : UPTR17A.Machine → C → Ev → UPTR17A.Machine)
    (hdrift : ∀ ω ∈ goodEvent accounts Ev', ∀ p c e x,
      dist (read (perturb ω p c e) x) (rec x) ≤ dist (read p x) (rec x) + ρ)
    (hbudget : ε + ρ ≤ t)
    (obs : P × UPTR17A.Machine → O) (ctrl : Ω → List O → C) (env : Ω → List O → C → Ev)
    (s₀ : Ω → P × UPTR17A.Machine) (hinit : ∀ ω x, read (s₀ ω).1 x = rec x) (horizon : ℕ) :
    ∀ ω ∈ goodEvent accounts Ev', ∀ k ≤ horizon,
      let m := (Snuffy.Composition.run (guardedStep (jointCorrect correct) (jointPerturb perturb deliver) ω)
          obs (ctrl ω) (env ω) (s₀ ω) k).1
      (∀ x, Continues rec ε (read m.1) x) ∧
      ∀ (base : Nat) (priorJobs : List SnuffyFIFO.Job) (j : SnuffyFIFO.Job)
        (work : SnuffyFIFO.Job → Nat) (registry : UPTR17A.Registry) (ticket : Nat)
        (eff : UPTR12A.Effect) (p : UPTR17A.Contract),
        (∀ q ∈ (priorJobs ++ [j]), work q ≤ q.budget) →
        SnuffyFIFO.finish base (priorJobs ++ [j]) (fun q => q.budget) ≤ j.deadline →
        m.2.now = SnuffyFIFO.finish base (priorJobs ++ [j]) work →
        registry ticket = some p → UPTR17A.Ready m.2 ticket eff p →
        m.2.now ≤ j.deadline ∧
          (UPTR17A.applyOne registry m.2 ticket eff).applied = m.2.applied ++ [(ticket, eff)] := by
  intro ω hω k hk m
  refine ⟨(joint_holding μ accounts Ev' δ hδ hrec hsep ht hdecC hnear hε read correct hcorr
    perturb deliver hdrift hbudget obs ctrl env s₀ hinit horizon).1 ω hω k hk, ?_⟩
  intro base priorJobs j work registry ticket eff p hwork hcert hnow hreg hready
  exact SnuffyFIFO.ready_fifo_effect_applies_before_deadline base priorJobs j work hwork hcert
    registry m.2 ticket eff p hnow hreg hready

end Snuffy.G2Freedom
