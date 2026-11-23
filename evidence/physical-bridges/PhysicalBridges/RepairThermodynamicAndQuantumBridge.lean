import PhysicalBridges.RepairQualificationGate

/-!
# Thermodynamic Passivity, Finite-Bath Landauer Obstruction, and Noether Sector Separation

This module provides non-vacuous, hypothesis-dependent replacements for the thermodynamic,
conservation, Landauer, and unitarity arguments in `PhysicalBridges.GNamedPhysicalLaws` and
`PhysicalBridges.GThermodynamicLaws`.

## Defect Diagnosis in the Legacy Modules

Under the formal-benchmarking and autoformalisation audit criteria of:
- Ammanamanchi, Bhat & Biderman (ICML 2026, arXiv:2606.29493), *Faults in Our Formal Benchmarking:
  Dataset Defects and Evaluation Failures in Lean Theorem Proving*, and
- Bastounis, Circelli & Hansen (2026, arXiv:2610.08144), *Why Lean Verification of AI
  Autoformalisation Does Not Guarantee Correct Natural Language Proofs*,

legacy theorems such as `GNamedPhysicalLaws.second_law_refutes_ender`,
`GNamedPhysicalLaws.noether_refutes_ender`, `GNamedPhysicalLaws.unitarity_refutes_ender`, and
`GThermodynamicLaws.first_law_refutes_ender` all shared the same proof body
`fun ender => (ender s).elim` against `AbsoluteEnder S := S → Empty`. None of those proof terms
inspected `L.non_decreasing`, `N.conserved`, `L.conserved`, or `U.injective`; as certified by
`RepairQualificationGate`, mutating `LossOf` or deleting the physical structure fields left their
proofs intact.

## Constructive Repair Architecture

To turn those physical intuitions into genuinely load-bearing formal theorems, we model open
boundaries, finite bath capacities, and multi-step transition paths explicitly:

1. **Port-Hamiltonian Dissipative Open Systems & Metered Supply Safety**
   (adapting `Obend.Category.OpenSystem` from `github.com/emberian/obend`; grounded in
   Willems 1972 *Arch. Ration. Mech. Anal.* 45, van der Schaft & Jeltsema 2014 *Port-Hamiltonian
   Systems Theory*, Baez & Courser 2020 *Structured Cospans* arXiv:1911.04630, Baez 2026
   *Double Categories of Open Systems: The Cospan Approach* arXiv:2509.22584, Abadi & Lamport 1995
   *Conjoining Specifications* TOPLAS 17(3), Havelund & Roşu 2002 *Synthesizing Monitors for
   Safety Properties*, and the runtime envelope discipline of `github.com/emberian/svenvs`,
   `safetyScript.sml : safety_preservation` / `envelopeScript.sml : enveloped_step_closed`):
   - `OpenDissipativeSys State PortIn PortOut` enforces non-negative storage `0 ≤ energy s` and
     the discrete passivity inequality `energy (step s u).1 - energy s ≤ supply u (step s u).2`,
     closed under `parallelCompose`, `feedbackInterconnect`, and skew-symmetric gyrator coupling
     (`skew_gyrator_power_cancels`, `skewFeedbackInterconnect`).
   - `metered_supply_forbids_high_energy_breach` proves that when an unsafe set requires critical
     energy `E_crit ≤ sys.energy s` and cumulative external supply satisfies
     `sys.energy s0 + sys.trajectorySupply s0 us < E_crit`, the trajectory cannot enter `Unsafe`.
   - `metered_envelope_forbids_high_energy_breach` wraps arbitrary untrusted command sequences in
     a runtime budget clamp (`supplyClamp`, `meteredInputs`), guaranteeing safety regardless of
     controller behavior ("verify the cage, not the animal").
   - `unmetered_supply_permits_high_energy_breach` constructs a passive open system that breaches
     every positive `E_crit > 0` when external supply is unmetered, proving that passivity without
     boundary metering is insufficient.

2. **Exact Combinatorial Landauer / Finite-Bath Erasure Obstruction**
   (discrete finite-microstate core of Landauer 1961 *IBM J. Res. Dev.* 5(3); Reeb & Wolf 2014
   *An (im-)proving Landauer's principle*, *New J. Phys.* 16 103011 — see also the Gibbs/Shannon
   formalization in `Snuffy.Landauer`; Pati & Braunstein 2000 *Impossibility of deleting an
   unknown quantum state*, *Nature* 404 164–165; Unruh 2019 *Quantum Relational Hoare Logic*,
   POPL / arXiv:1802.03188; and Bekenstein 1981 *Phys. Rev. D* 23 287):
   - Joint microscopic reversibility on `Reg × Bath` is modeled by `Function.Injective evolve`.
   - Constructive list pigeonhole (`injective_image_nodup_length`) establishes that resetting
     `regStates` (`Nodup`) across `initBath` (`Nodup`) into a single register state `blank` with
     final bath microstates in `availBath` forces
     `regStates.length * initBath.length ≤ availBath.length`, and strictly expands bath support
     (`initBath.length < availBath.length`) whenever `2 ≤ regStates.length` and
     `1 ≤ initBath.length` (`finite_bath_forbids_k_to_1_erasure`).
   - `insufficient_bath_capacity_forbids_erasure` proves that whenever a bounded region satisfies
     `availBath.length < regStates.length * initBath.length`, no reversible evolution can erase
     `regStates` to `blank`; `non_injective_dynamics_bypasses_bath_bound` shows why `Injective` is
     likewise indispensable.

3. **Noether Conservation & Superselection Sector Separation**
   - `ConservedSystem S` pairs a transition relation `step : S → S → Prop` with an integer invariant
     `charge : S → Int` preserved on every step (`step s t → charge s = charge t`).
   - `noether_forbids_cross_sector_predation` inducts along multi-step paths `Reaches N.step s t`
     using `N.conserved` to prove that no finite trajectory can reach any target `t` in a distinct
     charge sector (`N.charge t ≠ N.charge s`).
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairThermodynamicAndQuantumBridge

universe u

-- ═══════════════════════════════════════════════════════════════════
-- I. PORT-HAMILTONIAN DISSIPATIVE OPEN SYSTEMS & METERED SUPPLY SAFETY
-- ═══════════════════════════════════════════════════════════════════

/-- Discrete-time dissipative / passive open system (`Obend.Category.OpenSystem`) with non-negative
    internal storage `energy`, boundary supply rate `supply`, and step passivity inequality
    `energy (step s u).1 - energy s ≤ supply u (step s u).2`. -/
structure OpenDissipativeSys (State PortIn PortOut : Type) where
  energy : State → Int
  energy_nonneg : ∀ s : State, 0 ≤ energy s
  supply : PortIn → PortOut → Int
  step : State → PortIn → State × PortOut
  dissipative : ∀ (s : State) (u : PortIn),
    energy (step s u).1 - energy s ≤ supply u (step s u).2

namespace OpenDissipativeSys

/-- Execute `sys` from initial state `s` along a finite sequence of port inputs `us`. -/
def runTrajectory {State PortIn PortOut : Type}
    (sys : OpenDissipativeSys State PortIn PortOut) : State → List PortIn → State
  | s, [] => s
  | s, u :: us => runTrajectory sys (sys.step s u).1 us

/-- Cumulative external port energy supplied along the trajectory from `s` under `us`. -/
def trajectorySupply {State PortIn PortOut : Type}
    (sys : OpenDissipativeSys State PortIn PortOut) : State → List PortIn → Int
  | _, [] => 0
  | s, u :: us =>
      sys.supply u (sys.step s u).2 + trajectorySupply sys (sys.step s u).1 us

/-- **Global Trajectory Passivity Bound.**
    Terminal stored energy is non-negative and bounded above by initial stored energy plus
    cumulative external supply `sys.trajectorySupply s0 us`. -/
theorem energy_bounded_along_trajectory {State PortIn PortOut : Type}
    (sys : OpenDissipativeSys State PortIn PortOut) (s0 : State) (us : List PortIn) :
    0 ≤ sys.energy (sys.runTrajectory s0 us) ∧
      sys.energy (sys.runTrajectory s0 us) ≤ sys.energy s0 + sys.trajectorySupply s0 us := by
  refine ⟨sys.energy_nonneg (sys.runTrajectory s0 us), ?_⟩
  induction us generalizing s0 with
  | nil =>
    simp [runTrajectory, trajectorySupply]
  | cons u rest ih =>
    simp only [runTrajectory, trajectorySupply]
    have hStep := sys.dissipative s0 u
    have hRest := ih (sys.step s0 u).1
    omega

/-- Under passive / non-injecting boundary termination (`supply u y ≤ 0` along `us`), stored
    energy is a global non-increasing Lyapunov function. -/
theorem autonomous_lyapunov_nonincreasing {State PortIn PortOut : Type}
    (sys : OpenDissipativeSys State PortIn PortOut) (s0 : State) (us : List PortIn)
    (hPassive : ∀ (s : State) (u : PortIn), u ∈ us → sys.supply u (sys.step s u).2 ≤ 0) :
    0 ≤ sys.energy (sys.runTrajectory s0 us) ∧
      sys.energy (sys.runTrajectory s0 us) ≤ sys.energy s0 := by
  refine ⟨sys.energy_nonneg (sys.runTrajectory s0 us), ?_⟩
  induction us generalizing s0 with
  | nil =>
    simp [runTrajectory]
  | cons u rest ih =>
    simp only [runTrajectory]
    have hu : sys.supply u (sys.step s0 u).2 ≤ 0 :=
      hPassive s0 u (List.Mem.head rest)
    have hStep := sys.dissipative s0 u
    have hRest := ih (sys.step s0 u).1 (fun s v hv =>
      hPassive s v (List.Mem.tail u hv))
    omega

/-- Parallel composition of two open dissipative systems with additive storage `H₁ + H₂` and
    additive boundary supply `w₁ + w₂`. -/
def parallelCompose {S₁ U₁ Y₁ S₂ U₂ Y₂ : Type}
    (sys₁ : OpenDissipativeSys S₁ U₁ Y₁)
    (sys₂ : OpenDissipativeSys S₂ U₂ Y₂) :
    OpenDissipativeSys (S₁ × S₂) (U₁ × U₂) (Y₁ × Y₂) where
  energy s := sys₁.energy s.1 + sys₂.energy s.2
  energy_nonneg s := Int.add_nonneg (sys₁.energy_nonneg s.1) (sys₂.energy_nonneg s.2)
  supply u y := sys₁.supply u.1 y.1 + sys₂.supply u.2 y.2
  step s u :=
    let r₁ := sys₁.step s.1 u.1
    let r₂ := sys₂.step s.2 u.2
    ((r₁.1, r₂.1), (r₁.2, r₂.2))
  dissipative s u := by
    have h₁ := sys₁.dissipative s.1 u.1
    have h₂ := sys₂.dissipative s.2 u.2
    dsimp only
    omega

/-- A causal power-conserving or dissipative interconnection junction coupling `sys₁` and `sys₂`
    to external ports `(ExtIn, ExtOut)` without internal power creation:
    `supply₁ u₁ y₁ + supply₂ u₂ y₂ ≤ supplyExt uExt yExt`. -/
structure PassiveJunction {S₁ U₁ Y₁ S₂ U₂ Y₂ : Type}
    (sys₁ : OpenDissipativeSys S₁ U₁ Y₁)
    (sys₂ : OpenDissipativeSys S₂ U₂ Y₂)
    (ExtIn ExtOut : Type) where
  resolveInputs : S₁ → S₂ → ExtIn → U₁ × U₂
  mergeOutputs : ExtIn → Y₁ → Y₂ → ExtOut
  supplyExt : ExtIn → ExtOut → Int
  power_conserving : ∀ (s₁ : S₁) (s₂ : S₂) (uExt : ExtIn),
    let u₁ := (resolveInputs s₁ s₂ uExt).1
    let u₂ := (resolveInputs s₁ s₂ uExt).2
    let y₁ := (sys₁.step s₁ u₁).2
    let y₂ := (sys₂.step s₂ u₂).2
    sys₁.supply u₁ y₁ + sys₂.supply u₂ y₂ ≤ supplyExt uExt (mergeOutputs uExt y₁ y₂)

/-- Interconnect `sys₁` and `sys₂` across a `PassiveJunction`, yielding a certified composite
    `OpenDissipativeSys` with additive storage `H₁ + H₂`. -/
def feedbackInterconnect {S₁ U₁ Y₁ S₂ U₂ Y₂ ExtIn ExtOut : Type}
    (sys₁ : OpenDissipativeSys S₁ U₁ Y₁)
    (sys₂ : OpenDissipativeSys S₂ U₂ Y₂)
    (J : PassiveJunction sys₁ sys₂ ExtIn ExtOut) :
    OpenDissipativeSys (S₁ × S₂) ExtIn ExtOut where
  energy s := sys₁.energy s.1 + sys₂.energy s.2
  energy_nonneg s := Int.add_nonneg (sys₁.energy_nonneg s.1) (sys₂.energy_nonneg s.2)
  supply := J.supplyExt
  step s uExt :=
    let u₁ := (J.resolveInputs s.1 s.2 uExt).1
    let u₂ := (J.resolveInputs s.1 s.2 uExt).2
    let r₁ := sys₁.step s.1 u₁
    let r₂ := sys₂.step s.2 u₂
    ((r₁.1, r₂.1), J.mergeOutputs uExt r₁.2 r₂.2)
  dissipative s uExt := by
    have hp := J.power_conserving s.1 s.2 uExt
    have h₁ := sys₁.dissipative s.1 (J.resolveInputs s.1 s.2 uExt).1
    have h₂ := sys₂.dissipative s.2 (J.resolveInputs s.1 s.2 uExt).2
    dsimp only at hp ⊢
    omega

/-- Skew-symmetric gyrator power cancellation identity (`Obend.Category.OpenSystem`):
    internal cross-coupling terms `-k * y₂ * y₁` and `+k * y₁ * y₂` cancel identically. -/
theorem skew_gyrator_power_cancels (k e₁ e₂ y₁ y₂ : Int) :
    (e₁ - k * y₂) * y₁ + (e₂ + k * y₁) * y₂ = e₁ * y₁ + e₂ * y₂ := by
  rw [Int.sub_mul, Int.add_mul]
  have hComm : (k * y₂) * y₁ = (k * y₁) * y₂ := by
    rw [Int.mul_assoc, Int.mul_comm y₂ y₁, ← Int.mul_assoc]
  omega

/-- Scalar Port-Hamiltonian subsystem with state-causal port readout `portOut s` and bilinear
    effort-flow supply `u * portOut s`. -/
structure StatePortHamiltonianSys (State : Type) where
  energy : State → Int
  energy_nonneg : ∀ s : State, 0 ≤ energy s
  portOut : State → Int
  nextState : State → Int → State
  dissipative : ∀ (s : State) (u : Int),
    energy (nextState s u) - energy s ≤ u * portOut s

/-- Embed a `StatePortHamiltonianSys` into `OpenDissipativeSys State Int Int`. -/
def StatePortHamiltonianSys.toOpenSys {State : Type}
    (P : StatePortHamiltonianSys State) : OpenDissipativeSys State Int Int where
  energy := P.energy
  energy_nonneg := P.energy_nonneg
  supply u y := u * y
  step s u := (P.nextState s u, P.portOut s)
  dissipative := P.dissipative

/-- Standard negative-feedback skew interconnection (`u₁ = e₁ - k * y₂`, `u₂ = e₂ + k * y₁`)
    of two Port-Hamiltonian subsystems with coupling gain `k : Int`. -/
def skewFeedbackInterconnect {S₁ S₂ : Type}
    (P₁ : StatePortHamiltonianSys S₁)
    (P₂ : StatePortHamiltonianSys S₂)
    (k : Int) :
    OpenDissipativeSys (S₁ × S₂) (Int × Int) (Int × Int) :=
  feedbackInterconnect P₁.toOpenSys P₂.toOpenSys
    { resolveInputs := fun s₁ s₂ ⟨e₁, e₂⟩ =>
        (e₁ - k * P₂.portOut s₂, e₂ + k * P₁.portOut s₁)
      mergeOutputs := fun _ y₁ y₂ => (y₁, y₂)
      supplyExt := fun ⟨e₁, e₂⟩ ⟨y₁, y₂⟩ => e₁ * y₁ + e₂ * y₂
      power_conserving := fun s₁ s₂ ⟨e₁, e₂⟩ => by
        dsimp only [StatePortHamiltonianSys.toOpenSys]
        rw [skew_gyrator_power_cancels k e₁ e₂ (P₁.portOut s₁) (P₂.portOut s₂)]
        exact Int.le_refl _ }

/-- Any skew-interconnected pair of Port-Hamiltonian systems inherits the global trajectory
    energy bound regardless of internal gyrator gain `k`. -/
theorem skewFeedback_energy_bounded {S₁ S₂ : Type}
    (P₁ : StatePortHamiltonianSys S₁)
    (P₂ : StatePortHamiltonianSys S₂)
    (k : Int) (s0 : S₁ × S₂) (us : List (Int × Int)) :
    let composite := skewFeedbackInterconnect P₁ P₂ k
    composite.energy (composite.runTrajectory s0 us) ≤
      composite.energy s0 + composite.trajectorySupply s0 us :=
  (energy_bounded_along_trajectory (skewFeedbackInterconnect P₁ P₂ k) s0 us).2

end OpenDissipativeSys

/-- **Metered Energy-Barrier Protection.**
    If entering `Unsafe` requires stored energy at least `E_crit`, and initial energy plus
    cumulative external port supply along `us` stays strictly below `E_crit`, then the terminal
    state `sys.runTrajectory s0 us` cannot lie in `Unsafe`. -/
theorem metered_supply_forbids_high_energy_breach
    {State PortIn PortOut : Type}
    (sys : OpenDissipativeSys State PortIn PortOut)
    (Unsafe : State → Prop)
    (E_crit : Int)
    (hBarrier : ∀ s : State, Unsafe s → E_crit ≤ sys.energy s)
    (s0 : State)
    (us : List PortIn)
    (hMetered : sys.energy s0 + sys.trajectorySupply s0 us < E_crit) :
    ¬ Unsafe (sys.runTrajectory s0 us) := by
  intro hUnsafe
  have hCrit : E_crit ≤ sys.energy (sys.runTrajectory s0 us) :=
    hBarrier (sys.runTrajectory s0 us) hUnsafe
  have hBound := (sys.energy_bounded_along_trajectory s0 us).2
  omega

/-- Runtime actuator / supply envelope clamp (`svenvs`-style policy shield): clamps an untrusted
    command `req` into `[0, rem]` when `0 ≤ rem` (and `0` otherwise). -/
def supplyClamp (rem req : Int) : Int :=
  if req ≤ 0 then 0
  else if req ≤ rem then req
  else if 0 ≤ rem then rem
  else 0

/-- For any non-negative remaining budget `0 ≤ rem`, `supplyClamp rem req` lies in `[0, rem]`. -/
theorem supplyClamp_bounds (rem req : Int) (hRem : 0 ≤ rem) :
    0 ≤ supplyClamp rem req ∧ supplyClamp rem req ≤ rem := by
  unfold supplyClamp
  split
  · omega
  · split <;> omega

/-- Filter an arbitrary untrusted command stream `reqs` through a cumulative energy budget `rem`,
    decrementing the remaining allowance by each admitted command. -/
def meteredInputs : Int → List Int → List Int
  | _, [] => []
  | rem, req :: rest =>
      let u := supplyClamp rem req
      u :: meteredInputs (rem - u) rest

/-- If non-negative input commands upper-bound single-step port supply (`0 ≤ u → supply u y ≤ u`),
    then `meteredInputs budget reqs` caps cumulative `trajectorySupply` at `budget` for every
    untrusted command sequence `reqs`. -/
theorem meteredInputs_supply_le_budget
    {State PortOut : Type}
    (sys : OpenDissipativeSys State Int PortOut)
    (hPortGain : ∀ (u : Int) (y : PortOut), 0 ≤ u → sys.supply u y ≤ u)
    (s0 : State) (budget : Int) (hBudget : 0 ≤ budget)
    (reqs : List Int) :
    sys.trajectorySupply s0 (meteredInputs budget reqs) ≤ budget := by
  induction reqs generalizing s0 budget with
  | nil =>
    simp only [meteredInputs, OpenDissipativeSys.trajectorySupply]
    exact hBudget
  | cons req rest ih =>
    simp only [meteredInputs, OpenDissipativeSys.trajectorySupply]
    have hClamp := supplyClamp_bounds budget req hBudget
    have hStepSupply : sys.supply (supplyClamp budget req)
        (sys.step s0 (supplyClamp budget req)).2 ≤ supplyClamp budget req :=
      hPortGain (supplyClamp budget req) _ hClamp.1
    have hRemNonneg : 0 ≤ budget - supplyClamp budget req := by omega
    have hTail := ih (sys.step s0 (supplyClamp budget req)).1
      (budget - supplyClamp budget req) hRemNonneg
    omega

/-- **Envelope-Enforced Energy-Barrier Safety (`svenvs` + `Obend.Category.OpenSystem`).**
    Wrapping any untrusted or adversarial command sequence `reqs` in `meteredInputs budget reqs`
    with `sys.energy s0 + budget < E_crit` guarantees `¬ Unsafe` without trusting the controller. -/
theorem metered_envelope_forbids_high_energy_breach
    {State PortOut : Type}
    (sys : OpenDissipativeSys State Int PortOut)
    (hPortGain : ∀ (u : Int) (y : PortOut), 0 ≤ u → sys.supply u y ≤ u)
    (Unsafe : State → Prop)
    (E_crit : Int)
    (hBarrier : ∀ s : State, Unsafe s → E_crit ≤ sys.energy s)
    (s0 : State) (budget : Int) (hBudget : 0 ≤ budget)
    (hSafeBudget : sys.energy s0 + budget < E_crit)
    (reqs : List Int) :
    ¬ Unsafe (sys.runTrajectory s0 (meteredInputs budget reqs)) := by
  have hSup := meteredInputs_supply_le_budget sys hPortGain s0 budget hBudget reqs
  apply metered_supply_forbids_high_energy_breach sys Unsafe E_crit hBarrier s0
    (meteredInputs budget reqs)
  omega

/-- Canonical lossless discrete work accumulator: satisfies `OpenDissipativeSys` passivity with
    equality (`ΔE = u`), used to prove necessity of the metered-supply hypothesis. -/
def unmeteredAccumulator : OpenDissipativeSys Nat Nat Unit where
  energy s := (s : Int)
  energy_nonneg _ := by omega
  supply u _ := (u : Int)
  step s u := (s + u, ())
  dissipative _ _ := by
    dsimp only
    omega

/-- **Unmetered Converse Countermodel.**
    Passivity (`dissipative`) alone does not prevent breaching `E_crit`: for every positive
    threshold `0 < E_crit`, `unmeteredAccumulator` starts strictly outside the unsafe barrier at
    `s0 = 0` (`energy 0 = 0 < E_crit`) yet reaches `Unsafe` in one unmetered step
    `[E_crit.toNat]`. -/
theorem unmetered_supply_permits_high_energy_breach
    (E_crit : Int) (hPos : 0 < E_crit) :
    let Unsafe := fun s : Nat => E_crit ≤ unmeteredAccumulator.energy s
    (∀ s : Nat, Unsafe s → E_crit ≤ unmeteredAccumulator.energy s) ∧
      ¬ Unsafe 0 ∧
      Unsafe (unmeteredAccumulator.runTrajectory 0 [E_crit.toNat]) := by
  refine ⟨fun _ h => h, ?_, ?_⟩
  · simp only [unmeteredAccumulator]
    omega
  · simp only [OpenDissipativeSys.runTrajectory, unmeteredAccumulator]
    omega

-- ═══════════════════════════════════════════════════════════════════
-- II. COMBINATORIAL LANDAUER & FINITE-BATH ERASURE OBSTRUCTION
-- ═══════════════════════════════════════════════════════════════════

/-- Remove the first occurrence of `b` from a list `ys`. -/
def removeOne {β : Type} [DecidableEq β] (b : β) : List β → List β
  | [] => []
  | y :: ys => if b = y then ys else y :: removeOne b ys

/-- Removing an element `b ∈ ys` decreases `ys.length` by exactly `1`. -/
theorem removeOne_length_of_mem {β : Type} [DecidableEq β]
    {b : β} {ys : List β} (hMem : b ∈ ys) :
    (removeOne b ys).length + 1 = ys.length := by
  induction ys with
  | nil => nomatch hMem
  | cons y rest ih =>
    unfold removeOne
    split
    · rfl
    · next hNe =>
      cases List.mem_cons.mp hMem with
      | inl hEq => exact absurd hEq hNe
      | inr hRest =>
        have hSub := ih hRest
        simp only [List.length_cons] at hSub ⊢
        omega

/-- Any `z ∈ ys` distinct from `b` remains in `removeOne b ys`. -/
theorem mem_removeOne_of_ne {β : Type} [DecidableEq β]
    {b z : β} {ys : List β} (hz : z ∈ ys) (hNe : z ≠ b) :
    z ∈ removeOne b ys := by
  induction ys with
  | nil => nomatch hz
  | cons y rest ih =>
    unfold removeOne
    split
    · next hEq =>
      cases List.mem_cons.mp hz with
      | inl hzy => exact absurd (hzy.trans hEq.symm) hNe
      | inr hRest => exact hRest
    · cases List.mem_cons.mp hz with
      | inl hzy => exact hzy ▸ List.Mem.head _
      | inr hRest => exact List.Mem.tail y (ih hRest)

/-- Constructive domain-restricted list pigeonhole principle: if `f` is injective on `xs`,
    `xs` is duplicate-free (`xs.Nodup`), and `f` maps every member of `xs` into `ys`, then
    `xs.length ≤ ys.length`. -/
theorem injective_on_nodup_length {α β : Type} [DecidableEq β]
    (f : α → β)
    (xs : List α) (hNodup : xs.Nodup)
    (hInjOn : ∀ x₁ x₂ : α, x₁ ∈ xs → x₂ ∈ xs → f x₁ = f x₂ → x₁ = x₂)
    (ys : List β) (hImage : ∀ x : α, x ∈ xs → f x ∈ ys) :
    xs.length ≤ ys.length := by
  induction xs generalizing ys with
  | nil => exact Nat.zero_le ys.length
  | cons x rest ih =>
    cases hNodup with
    | cons hxNe hRestNodup =>
      have hfxMem : f x ∈ ys := hImage x (List.Mem.head rest)
      have hLen : (removeOne (f x) ys).length + 1 = ys.length :=
        removeOne_length_of_mem hfxMem
      have hRestInj : ∀ x₁ x₂ : α, x₁ ∈ rest → x₂ ∈ rest → f x₁ = f x₂ → x₁ = x₂ :=
        fun x₁ x₂ h₁ h₂ hfeq =>
          hInjOn x₁ x₂ (List.Mem.tail x h₁) (List.Mem.tail x h₂) hfeq
      have hRestImg : ∀ x' : α, x' ∈ rest → f x' ∈ removeOne (f x) ys := by
        intro x' hx'
        apply mem_removeOne_of_ne (hImage x' (List.Mem.tail x hx'))
        intro hfeq
        have hEq : x' = x :=
          hInjOn x' x (List.Mem.tail x hx') (List.Mem.head rest) hfeq
        exact hxNe x' hx' hEq.symm
      have hSub := ih hRestNodup hRestInj (removeOne (f x) ys) hRestImg
      simp only [List.length_cons]
      omega

/-- **Constructive List Cardinality Pigeonhole.**
    For any globally injective map `f : α → β` and duplicate-free list `xs`, if `f` maps `xs`
    into `ys`, then `xs.length ≤ ys.length`. -/
theorem injective_image_nodup_length {α β : Type} [DecidableEq β]
    (f : α → β) (hf : Function.Injective f)
    (xs : List α) (hNodup : xs.Nodup)
    (ys : List β) (hImage : ∀ x : α, x ∈ xs → f x ∈ ys) :
    xs.length ≤ ys.length :=
  injective_on_nodup_length f xs hNodup (fun _ _ _ _ h => hf h) ys hImage

/-- Explicit Cartesian product of two lists `xs × ys`. -/
def listProd {α β : Type} : List α → List β → List (α × β)
  | [], _ => []
  | x :: xs, ys => (ys.map (fun y => (x, y))) ++ listProd xs ys

/-- Cardinality of `listProd xs ys` equals `xs.length * ys.length`. -/
theorem length_listProd {α β : Type} (xs : List α) (ys : List β) :
    (listProd xs ys).length = xs.length * ys.length := by
  induction xs with
  | nil => simp [listProd]
  | cons x rest ih =>
    simp only [listProd, List.length_append, List.length_map, List.length_cons, ih]
    rw [Nat.add_mul, Nat.one_mul, Nat.add_comm]

/-- Membership characterization for `listProd xs ys`. -/
theorem mem_listProd {α β : Type} {x : α} {y : β} {xs : List α} {ys : List β} :
    (x, y) ∈ listProd xs ys ↔ x ∈ xs ∧ y ∈ ys := by
  induction xs with
  | nil =>
    simp [listProd]
  | cons a rest ih =>
    simp only [listProd, List.mem_append, List.mem_map, ih, List.mem_cons]
    constructor
    · intro h
      rcases h with ⟨b, hb, hPair⟩ | ⟨hRest, hy⟩
      · injection hPair with hxa hby
        exact ⟨Or.inl hxa.symm, hby ▸ hb⟩
      · exact ⟨Or.inr hRest, hy⟩
    · rintro ⟨ rfl | hRest, hy ⟩
      · exact Or.inl ⟨y, hy, rfl⟩
      · exact Or.inr ⟨hRest, hy⟩

/-- Appending two duplicate-free, elementwise-disjoint lists preserves `Nodup`. -/
theorem nodup_append_of_disjoint {α : Type} {as bs : List α}
    (ha : as.Nodup) (hb : bs.Nodup)
    (hDisj : ∀ x : α, x ∈ as → x ∈ bs → False) :
    (as ++ bs).Nodup := by
  induction ha with
  | nil => simpa using hb
  | @cons a rest hHead _ ih =>
    simp only [List.cons_append]
    refine List.Pairwise.cons ?_ (ih fun x hx hbs => hDisj x (List.Mem.tail a hx) hbs)
    intro z hz hEq
    cases List.mem_append.mp hz with
    | inl hRest => exact hHead z hRest hEq
    | inr hBs => exact hDisj a (List.Mem.head rest) (hEq ▸ hBs)

/-- Pairing a fixed left element `x` across a duplicate-free list `ys` preserves `Nodup`. -/
theorem nodup_map_pair_left {α β : Type} (x : α) {ys : List β} (hy : ys.Nodup) :
    (ys.map (fun y => (x, y))).Nodup := by
  induction hy with
  | nil => exact List.Pairwise.nil
  | @cons y rest hHead _ ih =>
    simp only [List.map_cons]
    refine List.Pairwise.cons ?_ ih
    intro p hp hEq
    rcases List.mem_map.mp hp with ⟨y', hy', hpEq⟩
    have hPair : (x, y) = (x, y') := hEq.trans hpEq.symm
    injection hPair with _ hyy'
    exact hHead y' hy' hyy'

/-- Cartesian product of two duplicate-free lists is duplicate-free. -/
theorem nodup_listProd {α β : Type} {xs : List α} {ys : List β}
    (hx : xs.Nodup) (hy : ys.Nodup) :
    (listProd xs ys).Nodup := by
  induction hx with
  | nil => exact List.Pairwise.nil
  | @cons x rest hHead _ ih =>
    unfold listProd
    refine nodup_append_of_disjoint (nodup_map_pair_left x hy) ih ?_
    intro p hpMap hpProd
    rcases List.mem_map.mp hpMap with ⟨y, _, rfl⟩
    have hxRest : x ∈ rest := (mem_listProd.mp hpProd).1
    exact hHead x hxRest rfl

/-- Joint evolution `evolve` resets every `(r, b) ∈ regStates × initBath` into target register
    state `blank` while landing the bath microstate inside `availBath`. -/
def ErasesInto {Reg Bath : Type}
    (evolve : Reg × Bath → Reg × Bath)
    (regStates : List Reg) (initBath : List Bath)
    (blank : Reg) (availBath : List Bath) : Prop :=
  ∀ (r : Reg) (b : Bath), r ∈ regStates → b ∈ initBath →
    (evolve (r, b)).1 = blank ∧ (evolve (r, b)).2 ∈ availBath

/-- **Microstate Landauer Counting Bound.**
    Under any injective joint evolution `evolve : Reg × Bath → Reg × Bath`, resetting all
    `regStates` (`Nodup`) across `initBath` (`Nodup`) into a single `blank` register state
    requires `regStates.length * initBath.length ≤ availBath.length` distinct bath microstates. -/
theorem landauer_bath_capacity_lower_bound
    {Reg Bath : Type} [DecidableEq Bath]
    (evolve : Reg × Bath → Reg × Bath)
    (hInj : Function.Injective evolve)
    (regStates : List Reg) (hRegNodup : regStates.Nodup)
    (initBath : List Bath) (hBathNodup : initBath.Nodup)
    (blank : Reg) (availBath : List Bath)
    (hErase : ErasesInto evolve regStates initBath blank availBath) :
    regStates.length * initBath.length ≤ availBath.length := by
  have hProdNodup : (listProd regStates initBath).Nodup :=
    nodup_listProd hRegNodup hBathNodup
  have hBathInjOn : ∀ p₁ p₂ : Reg × Bath,
      p₁ ∈ listProd regStates initBath →
      p₂ ∈ listProd regStates initBath →
      (evolve p₁).2 = (evolve p₂).2 → p₁ = p₂ := by
    rintro ⟨r₁, b₁⟩ ⟨r₂, b₂⟩ hp₁ hp₂ hBathEq
    have ⟨hr₁, hb₁⟩ := mem_listProd.mp hp₁
    have ⟨hr₂, hb₂⟩ := mem_listProd.mp hp₂
    have hBlank₁ := (hErase r₁ b₁ hr₁ hb₁).1
    have hBlank₂ := (hErase r₂ b₂ hr₂ hb₂).1
    apply hInj
    exact Prod.ext (hBlank₁.trans hBlank₂.symm) hBathEq
  have hBathImg : ∀ p : Reg × Bath,
      p ∈ listProd regStates initBath → (evolve p).2 ∈ availBath := by
    rintro ⟨r, b⟩ hp
    have ⟨hr, hb⟩ := mem_listProd.mp hp
    exact (hErase r b hr hb).2
  have hLe := injective_on_nodup_length
    (fun p => (evolve p).2)
    (listProd regStates initBath) hProdNodup hBathInjOn availBath hBathImg
  rw [length_listProd] at hLe
  exact hLe

/-- **Combinatorial Landauer / Finite-Bath k-to-1 Erasure Theorem**
    (Reeb & Wolf 2014 *New J. Phys.* 16 103011; Pati & Braunstein 2000 *Nature* 404 164–165).
    Whenever `2 ≤ regStates.length` (`k ≥ 2` distinct register states) and `1 ≤ initBath.length`
    (`m ≥ 1` initial bath microstates), any reversible joint reset into `blank` simultaneously
    forces `regStates.length * initBath.length ≤ availBath.length` and strict bath microstate
    expansion `initBath.length < availBath.length` (strictly positive bath entropy export). -/
theorem finite_bath_forbids_k_to_1_erasure
    {Reg Bath : Type} [DecidableEq Bath]
    (evolve : Reg × Bath → Reg × Bath)
    (hInj : Function.Injective evolve)
    (regStates : List Reg) (hRegNodup : regStates.Nodup) (hRegCard : 2 ≤ regStates.length)
    (initBath : List Bath) (hBathNodup : initBath.Nodup) (hBathCard : 1 ≤ initBath.length)
    (blank : Reg) (availBath : List Bath)
    (hErase : ErasesInto evolve regStates initBath blank availBath) :
    regStates.length * initBath.length ≤ availBath.length ∧
      initBath.length < availBath.length := by
  have hProd := landauer_bath_capacity_lower_bound
    evolve hInj regStates hRegNodup initBath hBathNodup blank availBath hErase
  have hMul : 2 * initBath.length ≤ regStates.length * initBath.length :=
    Nat.mul_le_mul_right initBath.length hRegCard
  refine ⟨hProd, ?_⟩
  omega

/-- **No Zero-Expansion / Ancilla-Preserving Deletion** (discrete Pati–Braunstein corollary):
    no injective joint evolution can reset `2 ≤ regStates.length` distinct register states to
    `blank` while keeping a non-empty bath confined to its initial support `initBath`. -/
theorem no_zero_expansion_erasure
    {Reg Bath : Type} [DecidableEq Bath]
    (evolve : Reg × Bath → Reg × Bath)
    (hInj : Function.Injective evolve)
    (regStates : List Reg) (hRegNodup : regStates.Nodup) (hRegCard : 2 ≤ regStates.length)
    (initBath : List Bath) (hBathNodup : initBath.Nodup) (hBathCard : 1 ≤ initBath.length)
    (blank : Reg) :
    ¬ ErasesInto evolve regStates initBath blank initBath := by
  intro hErase
  have hStrict := (finite_bath_forbids_k_to_1_erasure
    evolve hInj regStates hRegNodup hRegCard initBath hBathNodup hBathCard blank initBath hErase).2
  omega

/-- **Bekenstein / Landauer Insufficient Bath-Capacity Obstruction.**
    If a bounded physical region has `availBath.length < regStates.length * initBath.length`,
    then no reversible microscopic evolution `evolve` can erase `regStates` into `blank`. -/
theorem insufficient_bath_capacity_forbids_erasure
    {Reg Bath : Type} [DecidableEq Bath]
    (evolve : Reg × Bath → Reg × Bath)
    (hInj : Function.Injective evolve)
    (regStates : List Reg) (hRegNodup : regStates.Nodup)
    (initBath : List Bath) (hBathNodup : initBath.Nodup)
    (blank : Reg) (availBath : List Bath)
    (hCap : availBath.length < regStates.length * initBath.length) :
    ¬ ErasesInto evolve regStates initBath blank availBath := by
  intro hErase
  have hLower := landauer_bath_capacity_lower_bound
    evolve hInj regStates hRegNodup initBath hBathNodup blank availBath hErase
  omega

/-- Executable bath-capacity gate: returns `true` iff `availCap` microstates suffice to absorb
    `regCard * initBathCard` distinct reversible trajectories. -/
def canEraseBool (regCard initBathCard availCap : Nat) : Bool :=
  decide (regCard * initBathCard ≤ availCap)

/-- Soundness of `canEraseBool`: when `canEraseBool = false`, reversible erasure is impossible. -/
theorem canEraseBool_false_forbids_erasure
    {Reg Bath : Type} [DecidableEq Bath]
    (evolve : Reg × Bath → Reg × Bath)
    (hInj : Function.Injective evolve)
    (regStates : List Reg) (hRegNodup : regStates.Nodup)
    (initBath : List Bath) (hBathNodup : initBath.Nodup)
    (blank : Reg) (availBath : List Bath)
    (hGate : canEraseBool regStates.length initBath.length availBath.length = false) :
    ¬ ErasesInto evolve regStates initBath blank availBath := by
  unfold canEraseBool at hGate
  have hNotLe : ¬ (regStates.length * initBath.length ≤ availBath.length) :=
    of_decide_eq_false hGate
  apply insufficient_bath_capacity_forbids_erasure
    evolve hInj regStates hRegNodup initBath hBathNodup blank availBath
  omega

/-- Converse necessity of `Function.Injective evolve`: if microscopic reversibility is dropped,
    a constant reset `fun _ => (blank, b0)` erases arbitrarily many register states into a
    1-element bath `[b0]`. -/
theorem non_injective_dynamics_bypasses_bath_bound
    {Reg Bath : Type}
    (blank : Reg) (b0 : Bath)
    (regStates : List Reg) (initBath : List Bath) :
    ErasesInto (fun _ => (blank, b0)) regStates initBath blank [b0] :=
  fun _ _ _ _ => ⟨rfl, List.Mem.head []⟩

-- ═══════════════════════════════════════════════════════════════════
-- III. NOETHER CONSERVATION & SUPERSELECTION SECTOR SEPARATION
-- ═══════════════════════════════════════════════════════════════════

/-- Reflexive-transitive multi-step reachability along a transition relation `step`. -/
inductive Reaches {S : Type u} (step : S → S → Prop) : S → S → Prop where
  | refl (s : S) : Reaches step s s
  | tail {s m t : S} : Reaches step s m → step m t → Reaches step s t

/-- A discrete dynamical system conserving an integer Noether charge across every step. -/
structure ConservedSystem (S : Type u) where
  step : S → S → Prop
  charge : S → Int
  conserved : ∀ (s t : S), step s t → charge s = charge t

/-- Multi-step conservation: `N.charge` is invariant along any finite reachable trajectory,
    proved by induction on `Reaches N.step s t` invoking `N.conserved` at each transition. -/
theorem conserved_along_reaches {S : Type u} (N : ConservedSystem S)
    {s t : S} (hReach : Reaches N.step s t) :
    N.charge s = N.charge t := by
  induction hReach with
  | refl => rfl
  | tail _ hStep ih => exact ih.trans (N.conserved _ _ hStep)

/-- **Noether Cross-Sector Unreachability.**
    Any target state `t` carrying conserved charge `N.charge t ≠ N.charge s` is unreachable
    from `s` in arbitrarily many steps of `N`. -/
theorem noether_forbids_cross_sector_predation {S : Type u}
    (N : ConservedSystem S) (s t : S)
    (hSector : N.charge t ≠ N.charge s) :
    ¬ Reaches N.step s t := by
  intro hReach
  have hEq : N.charge s = N.charge t := conserved_along_reaches N hReach
  exact hSector hEq.symm

/-- Set-level superselection separation: if every state in `PredatoryRegion` carries charge
    distinct from `N.charge s0`, no multi-step trajectory from `s0` can enter `PredatoryRegion`. -/
theorem noether_forbids_cross_sector_region {S : Type u}
    (N : ConservedSystem S)
    (PredatoryRegion : S → Prop)
    (s0 : S)
    (hOffShell : ∀ u : S, PredatoryRegion u → N.charge u ≠ N.charge s0)
    (t : S)
    (hReach : Reaches N.step s0 t) :
    ¬ PredatoryRegion t := by
  intro hPred
  exact noether_forbids_cross_sector_predation N s0 t (hOffShell t hPred) hReach

/-- Executable charge-sector equality test. -/
def sameSectorBool (q₁ q₂ : Int) : Bool :=
  decide (q₁ = q₂)

/-- Soundness of `sameSectorBool`: when `sameSectorBool (N.charge t) (N.charge s) = false`,
    `t` is unreachable from `s` in `N`. -/
theorem different_sector_bool_forbids_reach {S : Type u}
    (N : ConservedSystem S) (s t : S)
    (hGate : sameSectorBool (N.charge t) (N.charge s) = false) :
    ¬ Reaches N.step s t := by
  unfold sameSectorBool at hGate
  exact noether_forbids_cross_sector_predation N s t (of_decide_eq_false hGate)

/-- Converse necessity of `N.conserved`: an unconstrained transition relation reaches `q₂` from
    `q₁` in one step even when `q₂ ≠ q₁`. -/
theorem broken_conservation_permits_cross_sector_reach
    (q₁ q₂ : Int) (hNe : q₂ ≠ q₁) :
    q₂ ≠ q₁ ∧ Reaches (fun _ _ : Int => True) q₁ q₂ :=
  ⟨hNe, Reaches.tail (Reaches.refl q₁) trivial⟩

-- ═══════════════════════════════════════════════════════════════════
-- IV. METATHEORETIC QUALIFICATION GATES (`#upt_tooth`, `#upt_census`)
-- ═══════════════════════════════════════════════════════════════════

-- Tooth 1: Mutating `trajectorySupply` to ignore external port supply (`0`) MUST break
-- `metered_supply_forbids_high_energy_breach`:
#upt_tooth metered_supply_forbids_high_energy_breach
  by mutation OpenDissipativeSys.trajectorySupply := fun _sys _s _us => 0

-- Tooth 2: Mutating the `svenvs`-style actuator envelope `supplyClamp` to pass raw untrusted
-- commands through unclamped MUST break `metered_envelope_forbids_high_energy_breach`:
#upt_tooth metered_envelope_forbids_high_energy_breach
  by mutation supplyClamp := fun _rem req => req

-- Tooth 3: Mutating `canEraseBool` to ignore register multiplicity `regCard` MUST break
-- `canEraseBool_false_forbids_erasure`:
#upt_tooth canEraseBool_false_forbids_erasure
  by mutation canEraseBool := fun _regCard initBathCard availCap => decide (initBathCard ≤ availCap)

-- Tooth 4: Mutating `canEraseBool` to unconditionally report `false` MUST break
-- `canEraseBool_false_forbids_erasure`:
#upt_tooth canEraseBool_false_forbids_erasure
  by mutation canEraseBool := fun _ _ _ => false

-- Tooth 5: Mutating `sameSectorBool` to unconditionally report `false` MUST break
-- `different_sector_bool_forbids_reach`:
#upt_tooth different_sector_bool_forbids_reach
  by mutation sameSectorBool := fun _ _ => false

-- Namespace-wide census: verify universal quantification and standard-only kernel axioms:
#upt_census PhysicalBridges.RepairThermodynamicAndQuantumBridge

-- Explicit kernel axiom audit on primary theorems:
#print axioms OpenDissipativeSys.energy_bounded_along_trajectory
#print axioms OpenDissipativeSys.autonomous_lyapunov_nonincreasing
#print axioms OpenDissipativeSys.skew_gyrator_power_cancels
#print axioms OpenDissipativeSys.skewFeedback_energy_bounded
#print axioms metered_supply_forbids_high_energy_breach
#print axioms metered_envelope_forbids_high_energy_breach
#print axioms unmetered_supply_permits_high_energy_breach
#print axioms injective_image_nodup_length
#print axioms landauer_bath_capacity_lower_bound
#print axioms finite_bath_forbids_k_to_1_erasure
#print axioms no_zero_expansion_erasure
#print axioms insufficient_bath_capacity_forbids_erasure
#print axioms canEraseBool_false_forbids_erasure
#print axioms non_injective_dynamics_bypasses_bath_bound
#print axioms conserved_along_reaches
#print axioms noether_forbids_cross_sector_predation
#print axioms noether_forbids_cross_sector_region
#print axioms different_sector_bool_forbids_reach

end PhysicalBridges.RepairThermodynamicAndQuantumBridge
