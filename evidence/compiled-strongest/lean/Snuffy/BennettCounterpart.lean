/-
Snuffy — Canon Edition 4.2 working: premise 5 with the Bennett counterpart
constructed (Part I premise 5; §17; §23.8).

An option is a policy together with the implementation of its administration.
The administration is either irreversible — a joint register–bath dynamics
that leaves the register in the law of an overwrite `f` — or reversible — a
bijection of the register alone, such as Bennett's compute–copy–uncompute
cycle (`Bennett.bennettEquiv`), which writes `f x` into a clean output and
returns the workspace exactly (`Bennett.bennett_compute_uncompute`).

The cost of an option is the base cost of its policy plus the energy its
administration delivers to the bath (`Landauer.heat`). The outcome stages
before the resource stage are the policy's outcomes; the resource stage
records the residual slack `B − cost` through a strictly monotone reading.
The Bennett counterpart of an option runs the same policy with reversible
administration.

  * counterpart_heat_zero — reversible administration delivers exactly zero
    heat (`Bennett.heat_reversible`).
  * merging_heat_pos — merging irreversible administration delivers strictly
    positive heat (`Bennett.heat_irreversible`).
  * counterpart_feasible, counterpart_same, counterpart_more_slack — the
    counterpart is realisable whenever the option is, has the same outcomes
    before the resource stage, the same base cost, and strictly more slack.
  * premise5_constructed — no canonical option has merging irreversible
    administration. Every hypothesis on the counterpart is derived above.
  * bennett_counterpart_computes — the reversible counterpart instantiated
    by the Bennett cycle computes the same administration result, with a
    clean workspace.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.Bennett
import Snuffy.Greatestness
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Tactic.Ring

open Finset

namespace Snuffy.BennettCounterpart

open Snuffy.Landauer Snuffy.Bennett Snuffy.Greatestness

/-- How an option's administration is implemented. -/
inductive Mode (Reg Bath : Type*)
  | irreversible (σ : Reg × Bath ≃ Reg × Bath) (f : Reg → Reg)
  | reversible (e : Reg ≃ Reg)

variable {Reg Bath Pol : Type*} [Fintype Reg] [Fintype Bath] [Nonempty Bath] [DecidableEq Reg]

/-- The energy the administration delivers to the bath. -/
noncomputable def heatOf (p : Reg → ℝ) (kT : ℝ) (E : Bath → ℝ) : Mode Reg Bath → ℝ
  | .irreversible σ _ => heat p (1 / kT) E σ
  | .reversible e => heat p (1 / kT) E (e.prodCongr (Equiv.refl Bath))

/-- Irreversible administration that leaves the register in the law of `f`,
where `f` merges two register states of positive probability. -/
def Merging (p : Reg → ℝ) (kT : ℝ) (E : Bath → ℝ) : Mode Reg Bath → Prop
  | .irreversible σ f => margA (evolve p (1 / kT) E σ) = push p f ∧
      ∃ x₁ x₂, x₁ ≠ x₂ ∧ f x₁ = f x₂ ∧ 0 < p x₁ ∧ 0 < p x₂
  | .reversible _ => False

omit [DecidableEq Reg] [Nonempty Bath] in
theorem counterpart_heat_zero (p : Reg → ℝ) (hp1 : ∑ x, p x = 1) (kT : ℝ) (E : Bath → ℝ)
    (e : Reg ≃ Reg) : heatOf p kT E (.reversible e) = 0 :=
  heat_reversible p hp1 (1 / kT) E e

theorem merging_heat_pos (p : Reg → ℝ) (hp : ∀ x, 0 ≤ p x) (hp1 : ∑ x, p x = 1)
    {kT : ℝ} (hkT : 0 < kT) (E : Bath → ℝ) (m : Mode Reg Bath) (hm : Merging p kT E m) :
    0 < heatOf p kT E m := by
  cases m with
  | reversible e => exact hm.elim
  | irreversible σ f =>
      obtain ⟨himpl, x₁, x₂, hne, hf, h₁, h₂⟩ := hm
      obtain ⟨hpos, hle⟩ := heat_irreversible p hp hp1 hkT E σ f himpl hne hf h₁ h₂
      exact lt_of_lt_of_le hpos hle

variable {n : ℕ} {L : Fin n → Type*} [∀ i, SemilatticeSup (L i)]

/-- The outcome tuple of an option: the policy's outcomes, with the resource
stage `j` reading the residual slack. -/
noncomputable def tuple (out : Pol → ∀ i, L i) (j : Fin n) (stage : ℝ → L j)
    (base : Pol → ℝ) (B : ℝ) (p : Reg → ℝ) (kT : ℝ) (E : Bath → ℝ)
    (x : Pol × Mode Reg Bath) : ∀ i, L i :=
  Function.update (out x.1) j (stage (B - (base x.1 + heatOf p kT E x.2)))

/-- The feasible family: realisable policies, any implementation, cost within
budget. -/
def feasible (Rpol : Set Pol) (out : Pol → ∀ i, L i) (j : Fin n) (stage : ℝ → L j)
    (base : Pol → ℝ) (B : ℝ) (p : Reg → ℝ) (kT : ℝ) (E : Bath → ℝ) : Set (∀ i, L i) :=
  {t | ∃ x : Pol × Mode Reg Bath, x.1 ∈ Rpol ∧ base x.1 + heatOf p kT E x.2 ≤ B ∧
    tuple out j stage base B p kT E x = t}

omit [Nonempty Bath] [DecidableEq Reg] [∀ i, SemilatticeSup (L i)] in
theorem counterpart_same (out : Pol → ∀ i, L i) (j : Fin n) (stage : ℝ → L j)
    (base : Pol → ℝ) (B : ℝ) (p : Reg → ℝ) (kT : ℝ) (E : Bath → ℝ)
    (x : Pol × Mode Reg Bath) (e : Reg ≃ Reg) :
    ∀ i, i < j → tuple out j stage base B p kT E x i =
      tuple out j stage base B p kT E (x.1, .reversible e) i := by
  intro i hi
  simp [tuple, Function.update_of_ne (ne_of_lt hi)]

theorem counterpart_feasible (base : Pol → ℝ) (B : ℝ) (p : Reg → ℝ)
    (hp : ∀ x, 0 ≤ p x) (hp1 : ∑ x, p x = 1) {kT : ℝ} (hkT : 0 < kT) (E : Bath → ℝ)
    (x : Pol × Mode Reg Bath) (hxB : base x.1 + heatOf p kT E x.2 ≤ B)
    (hm : Merging p kT E x.2) (e : Reg ≃ Reg) :
    base x.1 + heatOf p kT E (.reversible e) ≤ B := by
  have h0 := counterpart_heat_zero p hp1 kT E e
  have hpos := merging_heat_pos p hp hp1 hkT E x.2 hm
  linarith

theorem counterpart_more_slack (j : Fin n) (stage : ℝ → L j) (hstage : StrictMono stage)
    (out : Pol → ∀ i, L i) (base : Pol → ℝ) (B : ℝ) (p : Reg → ℝ)
    (hp : ∀ x, 0 ≤ p x) (hp1 : ∑ x, p x = 1) {kT : ℝ} (hkT : 0 < kT) (E : Bath → ℝ)
    (x : Pol × Mode Reg Bath) (hm : Merging p kT E x.2) (e : Reg ≃ Reg) :
    tuple out j stage base B p kT E x j <
      tuple out j stage base B p kT E (x.1, .reversible e) j := by
  have h0 := counterpart_heat_zero p hp1 kT E e
  have hpos := merging_heat_pos p hp hp1 hkT E x.2 hm
  simp only [tuple, Function.update_self]
  apply hstage
  rw [h0]
  linarith

/-- **Premise 5, with the counterpart constructed.** No canonical option has
merging irreversible administration. -/
theorem premise5_constructed (Rpol : Set Pol) (out : Pol → ∀ i, L i) (j : Fin n)
    (stage : ℝ → L j) (hstage : StrictMono stage) (base : Pol → ℝ) (B : ℝ)
    (p : Reg → ℝ) (hp : ∀ x, 0 ≤ p x) (hp1 : ∑ x, p x = 1) {kT : ℝ} (hkT : 0 < kT)
    (E : Bath → ℝ) (e : Reg ≃ Reg) (x : Pol × Mode Reg Bath) (hxR : x.1 ∈ Rpol)
    (hxB : base x.1 + heatOf p kT E x.2 ≤ B)
    (ho : Aligned (feasible Rpol out j stage base B p kT E) (tuple out j stage base B p kT E x)) :
    ¬ Merging p kT E x.2 := by
  intro hm
  refine ho.2 (tuple out j stage base B p kT E (x.1, .reversible e))
    ⟨(x.1, .reversible e), hxR, counterpart_feasible base B p hp hp1 hkT E x hxB hm e, rfl⟩
    ⟨j, counterpart_same out j stage base B p kT E x e, ?_⟩
  exact counterpart_more_slack j stage hstage out base B p hp hp1 hkT E x hm e

/-- **The counterpart computes the same administration result.** Instantiated
by the Bennett cycle for `f = h ∘ g`, the reversible administration writes
`h (g a)` into a clean output and returns the workspace to zero. -/
theorem bennett_counterpart_computes {α γ β : Type*} [AddGroup γ] [AddGroup β]
    (g : α → γ) (h : γ → β) (a : α) :
    bennettEquiv g h (a, 0, 0) = (a, 0, h (g a)) :=
  bennett_compute_uncompute g h a

section ImplementedProgram

variable {State Work : Type*} [AddGroup State] [AddGroup Work]

/-- Relabel the computed output as the live register, retaining the original
input as history. This permutation is its own inverse. -/
def swapEnds : State × Work × State ≃ State × Work × State where
  toFun z := (z.2.2, z.2.1, z.1)
  invFun z := (z.2.2, z.2.1, z.1)
  left_inv _ := rfl
  right_inv _ := rfl

/-- The specific administration, not an arbitrary reversible bijection. -/
def implementedProgram (g : State → Work) (h : Work → State) :
    State × Work × State ≃ State × Work × State :=
  (bennettEquiv g h).trans swapEnds

theorem implemented_program_computes (g : State → Work) (h : Work → State) (s : State) :
    implementedProgram g h (s, 0, 0) = (h (g s), 0, s) := by
  change swapEnds (bennettEquiv g h (s, 0, 0)) = _
  rw [bennett_compute_uncompute]
  rfl

theorem implemented_program_output (g : State → Work) (h : Work → State) (s : State) :
    (implementedProgram g h (s, 0, 0)).1 = h (g s) := by
  rw [implemented_program_computes]

theorem implemented_program_workspace (g : State → Work) (h : Work → State) (s : State) :
    (implementedProgram g h (s, 0, 0)).2.1 = 0 := by
  rw [implemented_program_computes]

theorem implemented_program_history (g : State → Work) (h : Work → State) (s : State) :
    (implementedProgram g h (s, 0, 0)).2.2 = s := by
  rw [implemented_program_computes]

/-- One committed administration consumes a reserved clean output cell,
executes the specific reversible program, and retains its history cell. The
provisioning, transfer and continued retention belong in the lifecycle bill. -/
def implementedStep (g : State → Work) (h : Work → State)
    (s : State × List State) : State × List State :=
  let z := implementedProgram g h (s.1, 0, 0)
  (z.1, s.2 ++ [z.2.2])

theorem implemented_step_fields (g : State → Work) (h : Work → State)
    (s : State × List State) :
    implementedStep g h s = (h (g s.1), s.2 ++ [s.1]) := by
  simp only [implementedStep, implemented_program_computes]

def sourceRun (g : State → Work) (h : Work → State) (s₀ : State) : ℕ → State
  | 0 => s₀
  | k + 1 => h (g (sourceRun g h s₀ k))

def implementedRun (g : State → Work) (h : Work → State) (s₀ : State) :
    ℕ → State × List State
  | 0 => (s₀, [])
  | k + 1 => implementedStep g h (implementedRun g h s₀ k)

/-- The actual implemented trajectory reproduces the administration and
retains exactly one full input record per committed step. -/
theorem implemented_run_refines (g : State → Work) (h : Work → State) (s₀ : State) :
    ∀ k, (implementedRun g h s₀ k).1 = sourceRun g h s₀ k ∧
      (implementedRun g h s₀ k).2.length = k := by
  intro k
  induction k with
  | zero => exact ⟨rfl, rfl⟩
  | succ k ih =>
      simp only [implementedRun, implemented_step_fields, sourceRun,
        List.length_append, List.length_singleton, ih.1, ih.2]
      constructor <;> trivial

/-- The retained cells contain the full ordered source history, not merely a
counter of successful administrations. -/
theorem implemented_run_history (g : State → Work) (h : Work → State) (s₀ : State) :
    ∀ k, (implementedRun g h s₀ k).2 = (List.range k).map (sourceRun g h s₀) := by
  intro k
  induction k with
  | zero => rfl
  | succ k ih =>
      rw [implementedRun, implemented_step_fields, List.range_succ, List.map_append,
        List.map_singleton, ih, (implemented_run_refines g h s₀ k).1]

variable [Fintype State] [Fintype Work]
variable {Ref : Type*} [Fintype Ref]

/-- The same implemented permutation is a unitary on the joint quantum
register, leaving an arbitrary reference register untouched. -/
noncomputable def quantumProgram (g : State → Work) (h : Work → State) :
    EuclideanSpace ℂ ((State × Work × State) × Ref) ≃ₗᵢ[ℂ]
      EuclideanSpace ℂ ((State × Work × State) × Ref) :=
  LinearIsometryEquiv.piLpCongrLeft 2 ℂ ℂ
    ((implementedProgram g h).prodCongr (Equiv.refl Ref))

theorem implemented_quantum_norm (g : State → Work) (h : Work → State)
    (ψ : EuclideanSpace ℂ ((State × Work × State) × Ref)) :
    ‖quantumProgram g h ψ‖ = ‖ψ‖ :=
  (quantumProgram g h).norm_map ψ

theorem implemented_quantum_roundtrip (g : State → Work) (h : Work → State)
    (ψ : EuclideanSpace ℂ ((State × Work × State) × Ref)) :
    (quantumProgram g h).symm (quantumProgram g h ψ) = ψ :=
  (quantumProgram g h).symm_apply_apply ψ

end ImplementedProgram

/-- The non-heat lifecycle charges. These explicitly retain provisioning,
workspace return, output/history movement and continued archive care. -/
structure LifecycleCharge where
  compute : ℝ
  copy : ℝ
  uncompute : ℝ
  provision : ℝ
  archiveWrite : ℝ
  archiveHold : ℝ
  routing : ℝ
  reset : ℝ
  guard : ℝ
  controller : ℝ
  verification : ℝ
  endpoints : ℝ

def LifecycleCharge.total (q : LifecycleCharge) : ℝ :=
  q.compute + q.copy + q.uncompute + q.provision + q.archiveWrite + q.archiveHold +
    q.routing + q.reset + q.guard + q.controller + q.verification + q.endpoints

/-- Exact comparison of complete costs: eliminating bath heat does not by
itself remove the other physical lifecycle charges. -/
theorem complete_cost_difference (rev irr : LifecycleCharge) (heat : ℝ) :
    (rev.total + 0) - (irr.total + heat) = (rev.total - irr.total) - heat := by
  ring

theorem complete_cost_strict_iff (rev irr : LifecycleCharge) (heat : ℝ) :
    rev.total + 0 < irr.total + heat ↔ rev.total - irr.total < heat := by
  constructor <;> intro h <;> linarith

/-- A fixed circuit multiplier and full archive allowance preserve the
original exponent. The coefficient is explicit and independent of age. -/
theorem implemented_work_ceiling {base archive total α C γ t : ℝ} {d : ℕ}
    (hα : 0 ≤ α) (hbase : base ≤ C * t ^ d) (harchive : archive ≤ γ * t ^ d)
    (hledger : total = α * base + archive) :
    total ≤ (α * C + γ) * t ^ d := by
  have hm := mul_le_mul_of_nonneg_left hbase hα
  rw [hledger]
  nlinarith

/-- The exact compatibility condition for finite-time adiabatic work and the
same deadline. The device must establish this window for its complete bill;
slowing a circuit without a deadline bound is not sufficient. -/
theorem adiabatic_slack_window {drive archive heat maxTime : ℝ}
    (hgap : 0 < heat - archive) (htime : 0 < maxTime)
    (hwindow : drive / (heat - archive) < maxTime) :
    ∃ switchTime : ℝ, 0 < switchTime ∧ switchTime ≤ maxTime ∧
      drive / switchTime + archive < heat := by
  refine ⟨maxTime, htime, le_rfl, ?_⟩
  have hw := (div_lt_iff₀ hgap).mp hwindow
  have hd : drive / maxTime < heat - archive :=
    (div_lt_iff₀ htime).mpr (by nlinarith)
  linarith

theorem switched_program_meets_deadline {depth overhead deadline switchTime : ℝ}
    (hdepth : 0 < depth) (hwindow : switchTime ≤ (deadline - overhead) / depth) :
    depth * switchTime + overhead ≤ deadline := by
  rw [le_div_iff₀ hdepth] at hwindow
  nlinarith

/-- For the stated inverse-time device model, the engineering inequalities
are necessary as well as sufficient. This identifies the exact support
needed; it does not assume that a particular device satisfies it. -/
theorem adiabatic_feasible_iff {drive archive heat maxTime : ℝ}
    (hdrive : 0 ≤ drive) (htime : 0 < maxTime) :
    (∃ switchTime : ℝ, 0 < switchTime ∧ switchTime ≤ maxTime ∧
      drive / switchTime + archive < heat) ↔
    0 < heat - archive ∧ drive / (heat - archive) < maxTime := by
  constructor
  · rintro ⟨switchTime, hswitch, hdeadline, hcost⟩
    have hnonneg : 0 ≤ drive / switchTime := div_nonneg hdrive hswitch.le
    have hgap : 0 < heat - archive := by linarith
    refine ⟨hgap, (div_lt_iff₀ hgap).mpr ?_⟩
    have hswitchcost : drive / switchTime < heat - archive := by linarith
    have hproduct := (div_lt_iff₀ hswitch).mp hswitchcost
    exact lt_of_lt_of_le hproduct (by
      simpa [mul_comm] using mul_le_mul_of_nonneg_left hdeadline hgap.le)
  · rintro ⟨hgap, hwindow⟩
    exact adiabatic_slack_window hgap htime hwindow

end Snuffy.BennettCounterpart
