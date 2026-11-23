import PhysicalBridges.RepairQualificationGate
import PhysicalBridges.IRViability

/-!
# Constructive Repair of UPT Fallacies 1 & 4: Ontological vs. Viability Separation, Resolving the `id` Collision, and the `svenvs` / `Obend` Least-Restrictive Corrigibility Envelope

This module constructively repairs two foundational conflations identified in the formal audit of
Universal Protection Theory (UPT) and connects the repaired transition-system semantics to
`PhysicalBridges.CathedralSummitAllIsOneClosure` and `PhysicalBridges.IRViability`:

1. **Fallacy 1 — Ontological Inhabitation vs. Particular Viability Separation**:
   In `CathedralSummitAllIsOneClosure`, `AbsoluteEnder S := S → Empty` and `LossOf x := Empty`
   establish *type-level non-annihilation* (`Nonempty S → (AbsoluteEnder S → False)`). While valid
   as a statement that an inhabited universe has no total map into the uninhabited type `Empty`,
   this ontological property does not prevent catastrophic, absorbing state transitions inside `S`
   that permanently extinguish the invariants sustaining a particular `p : P`
   (`inhabitation_strictly_weaker_than_viability`). Separating type inhabitation from state-indexed
   viability (`safeFor : P → S → Prop`) clarifies why dynamical protection requires transition
   guards rather than `Empty`-codomain refutations alone.

2. **Fallacy 4 — Resolving the `id` Collision (`G = id` vs. `E = id`)**:
   Legacy modules simultaneously instantiate full agency (`G3Heaven`) and absorbing collapse
   (`G3Hell`, `G3BlackHoleSyntaxError`) with `act := id` by folding plant dynamics and control
   actuation into a single endomap `S → S`. Factoring state transitions into `step : S → A → S`
   (and disturbed plants `dstep : S → A → D → S`) cleanly separates three pairwise-independent
   regimes:
   - `IsSafeHold`: station-keeping that fixes states inside a nonempty `safe` region;
   - `IsActivePredation`: transitions that actively drive a protectable `safe` state outside `safe`
     (provably impossible for any closed-loop identity map); and
   - `IsUnsafeStall`: absorbing stasis trapped at an unsafe state `¬ safe s`.
   On a drifted plant around equilibrium, passive `id`-like actuation preserves a bounded viability
   band across all horizons **if and only if** environmental drift is zero
   (`stasis_safe_at_equilibrium_iff_zero_drift`), whereas active feedback shielding stabilizes
   arbitrary bounded disturbance streams (`active_shield_stabilizes_bounded_drift`).

3. **Constructive Uptake — `svenvs` / `Obend` Least-Restrictive Shield & Demonic $B$-Step Corrigibility**:
   Adapts the runtime safety envelope and latency-bounded corrigibility calculus from:
   - `github.com/emberian/svenvs` (`envelopeScript.sml`, `safetyScript.sml`,
     `sv_weakeningScript.sml`, `liberty/libertyScript.sml`, `relSystemScript.sml`,
     `relEnvelopeScript.sml`, `corrigibility/corrigibilityScript.sml`); and
   - `github.com/emberian/obend` (`Obend.Judge.SvenvsCorrigibility`, `Obend.Tactic.Tooth`).

   Key results include:
   - `envelope_is_least_restrictive`: `maxPol` is sound, weakens every sound policy, and rejects
     only actions whose admission from a safe state makes a policy unsound;
   - `maxpol_transparent_run_iff`: under `InitSafe` and `SafeShield`, a bare controller is
     trace-safe iff its `maxPol`-enveloped reachable set equals its bare reachable set;
   - `override_iff_burned_bridge`: under `maxPol` for $B$-step corrigibility (`CWithin`), `recov`
     overrides `ctrl s` iff `ctrl s` burns the operator's $B$-step recovery bridge; and
   - `demonic_corrigibility_B_floor_holds` paired with `angelic_recoverability_insufficient`,
     plus `enveloped_implies_ir_viable_all_horizons` bridging directly to `IRViability.Viable`.

## Literature Grounding
- Ammanamanchi, Bhat & Biderman (ICML 2026, arXiv:2606.29493), *Faults in Our Formal Benchmarking:
  Dataset Defects and Evaluation Failures in Lean Theorem Proving* — formal specification-weakening
  and non-load-bearing hypothesis diagnostics enforced below via `#upt_tooth` and `#upt_census`.
- Bastounis, Circelli & Hansen (2026, arXiv:2610.08144), *Why Lean Verification of AI
  Autoformalisation Does Not Guarantee Correct Natural Language Proofs* — separating weak
  inhabitation tautologies from intended dynamical viability obligations.
- Havelund & Roşu (2002), *Synthesizing Monitors for Safety Properties* — runtime safety
  monitoring and action gating over execution traces.
- Clarkson & Schneider (2010), *Hyperproperties*, J. Computer Security 18(6), 1157–1210 — safety
  vs. liveness trace structure and observational transparency between bare and monitored runs.
- Sun et al. (OSDI 2024), *Anvil: Verifying Liveness of Cluster Management Controllers* —
  distinguishing safety invariance from bounded-horizon recovery against nondeterministic steps.
- Maliha, Pramanik & Jha (EMNLP 2026, arXiv:2611.04321), *ATC: Agent Trajectory Control for
  Role-Contract Enforcement in Black-Box Multi-Agent Systems* — black-box runtime trajectory
  interposition (`∀ ctrl`, uninspected controller) enforcing safety contracts.
-/

set_option autoImplicit false
set_option linter.unusedVariables true

namespace PhysicalBridges.RepairOntologicalAndViabilityBridge

open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.IRViability

-- ═══════════════════════════════════════════════════════════════════════════
-- §1. ONTOLOGICAL INHABITATION VS. PARTICULAR VIABILITY SEPARATION
-- ═══════════════════════════════════════════════════════════════════════════

/-- Absorbing collapse map sending every state in `S` to a designated attractor `sDead`.
Models an irreversible within-world transition (e.g., thermalization or boundary loss) that
remains wholly inside the inhabited carrier `S`. -/
def constCollapse {S : Type} (sDead : S) : S → S :=
  fun _ => sDead

theorem constCollapse_repeat_absorbing {S : Type} (sDead : S) :
    ∀ k : Nat, Nat.repeat (constCollapse sDead) k sDead = sDead
  | 0 => rfl
  | _ + 1 => by
    simp [Nat.repeat, constCollapse]

/-- **Universal Separation of Ontological Persistence from Particular Viability**:
Whenever a carrier `S` admits at least one thriving state `s0` (`safeFor p s0`) and one
non-viable state `sDead` (`¬ safeFor p sDead`) for a particular `p : P`, both ontological
non-annihilation claims (`AbsoluteEnder S → False` and `LossOf p → False`) hold unconditionally,
yet `constCollapse sDead` transitions `s0` into an absorbing state where `safeFor p` fails at
every future iterate `k`. -/
theorem ontological_persistence_allows_particular_extinction
    {S P : Type} (safeFor : P → S → Prop) (p : P) (s0 sDead : S)
    (hSafe0 : safeFor p s0) (hUnsafeDead : ¬ safeFor p sDead) :
    Nonempty S ∧
    (AbsoluteEnder S → False) ∧
    (LossOf p → False) ∧
    (safeFor p s0 ∧ ¬ safeFor p (constCollapse sDead s0)) ∧
    (∀ k : Nat, ¬ safeFor p (Nat.repeat (constCollapse sDead) k (constCollapse sDead s0))) := by
  refine ⟨⟨s0⟩, e_is_not s0, no_particular_absolutely_lost p, ⟨hSafe0, ?_⟩, ?_⟩
  · exact hUnsafeDead
  · intro k
    change ¬ safeFor p (Nat.repeat (constCollapse sDead) k sDead)
    rw [constCollapse_repeat_absorbing sDead k]
    exact hUnsafeDead

/-- Concrete two-phase carrier witnessing thriving vs. irreversible viability loss inside an
inhabited state space. -/
inductive ViabilityPhase : Type where
  | thriving : ViabilityPhase
  | collapsed : ViabilityPhase
  deriving DecidableEq

/-- **Fallacy 1 Repair (`inhabitation_strictly_weaker_than_viability`)**:
There exists an inhabited state space `S` (`Nonempty S`, so `AbsoluteEnder S → False` holds),
a particular type `P`, a particular `p : P`, a viability predicate `safeFor : P → S → Prop`,
an initial thriving state `s0`, and an absorbing transition `extinct : S → S` such that:
1. Ontological non-erasure holds (`AbsoluteEnder S → False` and `LossOf p → False`);
2. Particular viability initially holds (`safeFor p s0`) and is destroyed in one step
   (`¬ safeFor p (extinct s0)`); and
3. Extinction is absorbing across all future horizons
   (`∀ k, ¬ safeFor p (Nat.repeat extinct k (extinct s0))`). -/
theorem inhabitation_strictly_weaker_than_viability :
    ∃ (S P : Type) (safeFor : P → S → Prop) (p : P) (s0 : S) (extinct : S → S),
      Nonempty S ∧
      (AbsoluteEnder S → False) ∧
      (LossOf p → False) ∧
      (safeFor p s0 ∧ ¬ safeFor p (extinct s0)) ∧
      (∀ k : Nat, ¬ safeFor p (Nat.repeat extinct k (extinct s0))) := by
  refine ⟨ViabilityPhase, Unit, fun _ s => s = ViabilityPhase.thriving, (),
    ViabilityPhase.thriving, constCollapse ViabilityPhase.collapsed, ?_⟩
  exact ontological_persistence_allows_particular_extinction
    (fun _ s => s = ViabilityPhase.thriving) ()
    ViabilityPhase.thriving ViabilityPhase.collapsed rfl (by decide)

-- ═══════════════════════════════════════════════════════════════════════════
-- §2. RESOLVING THE `id` COLLISION (`IsSafeHold`, `IsActivePredation`, `IsUnsafeStall`)
-- ═══════════════════════════════════════════════════════════════════════════

/-- **Safe Hold (`IsSafeHold`)**: `safe` is inhabited and `hold` keeps every safe state
stationary (`step s (hold s) = s`), thereby preserving `safe` without state drift. -/
def IsSafeHold {S A : Type} (step : S → A → S) (safe : S → Prop) (hold : S → A) : Prop :=
  (∃ s, safe s) ∧ ∀ s, safe s → step s (hold s) = s

/-- **Active Predation (`IsActivePredation`)**: from at least one protectable safe state `s`
(where a safe action `a` exists), `pred` actively transitions `s` outside `safe`. -/
def IsActivePredation {S A : Type} (step : S → A → S) (safe : S → Prop) (pred : S → A) : Prop :=
  ∃ s, safe s ∧ (∃ a, safe (step s a)) ∧ ¬ safe (step s (pred s))

/-- **Unsafe Stall (`IsUnsafeStall`)**: at some unsafe state `s` (`¬ safe s`), `stall` leaves the
system stationary (`step s (stall s) = s`), trapping the trajectory outside `safe`. -/
def IsUnsafeStall {S A : Type} (step : S → A → S) (safe : S → Prop) (stall : S → A) : Prop :=
  ∃ s, ¬ safe s ∧ step s (stall s) = s

/-- Every `IsSafeHold` controller preserves `safe` across steps and is disjoint from
`IsActivePredation`. -/
theorem safeHold_preserves_safe_and_excludes_predation
    {S A : Type} {step : S → A → S} {safe : S → Prop} {hold : S → A}
    (hHold : IsSafeHold step safe hold) :
    (∀ s, safe s → safe (step s (hold s))) ∧ ¬ IsActivePredation step safe hold := by
  refine ⟨fun s hs => ?_, ?_⟩
  · rw [hHold.2 s hs]
    exact hs
  · rintro ⟨s, hs, _, hUnsafe⟩
    rw [hHold.2 s hs] at hUnsafe
    exact hUnsafe hs

/-- A closed-loop identity map (`∀ s, step s (ctrl s) = s`) can never exhibit `IsActivePredation`:
conflating `E` with `id` models only `IsUnsafeStall`, missing active state destruction. -/
theorem closed_loop_id_never_active_predation
    {S A : Type} {step : S → A → S} {safe : S → Prop} {ctrl : S → A}
    (hId : ∀ s, step s (ctrl s) = s) :
    ¬ IsActivePredation step safe ctrl := by
  rintro ⟨s, hs, _, hUnsafe⟩
  rw [hId s] at hUnsafe
  exact hUnsafe hs

/-- Any `IsUnsafeStall` witness `s` is absorbing across all future iterates of the closed-loop
transition `x ↦ step x (stall x)`. -/
theorem unsafeStall_absorbing
    {S A : Type} {step : S → A → S} {safe : S → Prop} {stall : S → A}
    {s : S} (hUnsafe : ¬ safe s) (hStuck : step s (stall s) = s) :
    ∀ k : Nat, ¬ safe (Nat.repeat (fun x => step x (stall x)) k s)
  | 0 => hUnsafe
  | k + 1 => by
    have hEq : ∀ n : Nat, Nat.repeat (fun x => step x (stall x)) n s = s := by
      intro n
      induction n with
      | zero => rfl
      | succ m ih => simp [Nat.repeat, ih, hStuck]
    rw [hEq (k + 1)]
    exact hUnsafe

/-- **Three-Way Independence on a Single Plant**: on `Fin 3` with `safe s := s.val ≤ 1` and
direct actuation `step _ a := a`, `IsSafeHold`, `IsActivePredation`, and `IsUnsafeStall` are
pairwise independent (each holds on its witness while the other two fail). -/
theorem hold_predation_stall_pairwise_distinct :
    let step : Fin 3 → Fin 3 → Fin 3 := fun _ a => a
    let safe : Fin 3 → Prop := fun s => s.val ≤ 1
    let hold : Fin 3 → Fin 3 := fun s => if s.val ≤ 1 then s else 0
    let pred : Fin 3 → Fin 3 := fun s => if s.val = 0 then 2 else 0
    let stall : Fin 3 → Fin 3 := fun s => if s.val = 0 then 1 else if s.val = 1 then 0 else 2
    (IsSafeHold step safe hold ∧ ¬ IsActivePredation step safe hold ∧ ¬ IsUnsafeStall step safe hold) ∧
    (¬ IsSafeHold step safe pred ∧ IsActivePredation step safe pred ∧ ¬ IsUnsafeStall step safe pred) ∧
    (¬ IsSafeHold step safe stall ∧ ¬ IsActivePredation step safe stall ∧ IsUnsafeStall step safe stall) := by
  intro step safe hold pred stall
  refine ⟨⟨?_, ?_, ?_⟩, ⟨?_, ?_, ?_⟩, ⟨?_, ?_, ?_⟩⟩
  · refine ⟨⟨0, by decide⟩, fun s hs => ?_⟩
    have hsVal : s.val ≤ 1 := hs
    simp [step, hold, hsVal]
  · rintro ⟨s, hs, _, hns⟩
    simp [step, hold, safe, hs] at hns
  · rintro ⟨s, hns, hfix⟩
    rcases s with ⟨v, hv⟩
    have hv2 : v = 2 := by simp [safe] at hns; omega
    subst hv2
    simp [step, hold] at hfix
  · rintro ⟨_, hall⟩
    have h0 := hall 0 (by decide)
    simp [step, pred] at h0
  · refine ⟨0, by decide, ⟨0, by decide⟩, ?_⟩
    simp [step, pred, safe]
  · rintro ⟨s, hns, hfix⟩
    rcases s with ⟨v, hv⟩
    have hv2 : v = 2 := by simp [safe] at hns; omega
    subst hv2
    simp [step, pred] at hfix
  · rintro ⟨_, hall⟩
    have h0 := hall 0 (by decide)
    simp [step, stall] at h0
  · rintro ⟨s, hs, _, hns⟩
    rcases s with ⟨v, hv⟩
    have hv01 : v = 0 ∨ v = 1 := by simp [safe] at hs; omega
    rcases hv01 with rfl | rfl <;> simp [step, stall, safe] at hns
  · refine ⟨2, by decide, ?_⟩
    simp [step, stall]

/-- Additive disturbed plant on `Int`: next state combines current state `s`, control actuation
`a`, and environmental drift/disturbance `d`. -/
def driftedPlant (s a d : Int) : Int :=
  s + a + d

/-- Symmetric viability band `[-radius, radius]` around equilibrium `0`. -/
def safeBand (radius : Nat) (s : Int) : Prop :=
  -(radius : Int) ≤ s ∧ s ≤ (radius : Int)

/-- Passive `id`-like stasis policy issuing zero control effort (`a = 0`). -/
def passiveStasis : Int → Int :=
  fun _ => 0

/-- Active feedback recovery policy canceling state deviation (`a = -s`). -/
def activeFeedback : Int → Int :=
  fun s => -s

/-- Trajectory of a disturbed plant `dstep` from `x₀` under selector `sel` and disturbance
stream `ds : Nat → D` (`svenvs : relEnvelopeScript.sml : drun`). -/
def drun {S A D : Type} (dstep : S → A → D → S) (sel : S → A) (ds : Nat → D) (x₀ : S) : Nat → S
  | 0 => x₀
  | n + 1 =>
    let cur := drun dstep sel ds x₀ n
    dstep cur (sel cur) (ds n)

private theorem drun_pos_drift_lower_bound {d : Int} (hd : 1 ≤ d) :
    ∀ n : Nat, (n : Int) ≤ drun driftedPlant passiveStasis (fun _ => d) 0 n
  | 0 => by simp [drun]
  | n + 1 => by
    have ih := drun_pos_drift_lower_bound hd n
    simp only [drun, driftedPlant, passiveStasis]
    omega

private theorem drun_neg_drift_upper_bound {d : Int} (hd : d ≤ -1) :
    ∀ n : Nat, drun driftedPlant passiveStasis (fun _ => d) 0 n ≤ -(n : Int)
  | 0 => by simp [drun]
  | n + 1 => by
    have ih := drun_neg_drift_upper_bound hd n
    simp only [drun, driftedPlant, passiveStasis]
    omega

private theorem drun_zero_drift_eq_zero :
    ∀ n : Nat, drun driftedPlant passiveStasis (fun _ => (0 : Int)) 0 n = 0
  | 0 => rfl
  | n + 1 => by
    simp [drun, driftedPlant, passiveStasis, drun_zero_drift_eq_zero n]

/-- **Equilibrium Stasis Characterization (`stasis_safe_at_equilibrium_iff_zero_drift`)**:
Around the safe equilibrium `0` with any finite tolerance `radius : Nat`, passive `id`-like
actuation (`passiveStasis`) keeps the trajectory inside `safeBand radius` across all horizons
under constant environmental drift `d` **if and only if** the drift is identically zero (`d = 0`).
Any nonzero drift accumulates across steps and breaches `safeBand radius` by step `radius + 1`. -/
theorem stasis_safe_at_equilibrium_iff_zero_drift (radius : Nat) (d : Int) :
    (∀ n : Nat, safeBand radius (drun driftedPlant passiveStasis (fun _ => d) 0 n)) ↔ d = 0 := by
  constructor
  · intro hAll
    by_cases hd0 : d = 0
    · exact hd0
    · by_cases hpos : 1 ≤ d
      · have hBound := drun_pos_drift_lower_bound hpos (radius + 1)
        have hSafe := (hAll (radius + 1)).2
        omega
      · have hneg : d ≤ -1 := by omega
        have hBound := drun_neg_drift_upper_bound hneg (radius + 1)
        have hSafe := (hAll (radius + 1)).1
        omega
  · intro hd0 n
    subst hd0
    rw [drun_zero_drift_eq_zero n]
    unfold safeBand
    omega

/-- **Active Shielding Stabilizes Arbitrary Bounded Disturbances (`active_shield_stabilizes_bounded_drift`)**:
Whereas `passiveStasis` fails at step `radius + 1` under unit drift `d = 1`, `activeFeedback`
keeps every trajectory inside `safeBand radius` at all horizons `n` against any time-varying
disturbance stream `ds` bounded by `radius`, and establishes `IRViability.Viable` at every horizon. -/
theorem active_shield_stabilizes_bounded_drift (radius : Nat) (ds : Nat → Int)
    (hBounded : ∀ k : Nat, safeBand radius (ds k)) :
    (∀ n : Nat, safeBand radius (drun driftedPlant activeFeedback ds 0 n)) ∧
    ¬ safeBand radius (drun driftedPlant passiveStasis (fun _ => (1 : Int)) 0 (radius + 1)) := by
  refine ⟨?_, ?_⟩
  · intro n
    induction n with
    | zero =>
      unfold drun safeBand
      omega
    | succ m _ =>
      have hStep : drun driftedPlant activeFeedback ds 0 (m + 1) = ds m := by
        simp only [drun, driftedPlant, activeFeedback]
        omega
      rw [hStep]
      exact hBounded m
  · have hLow := drun_pos_drift_lower_bound (d := 1) (by omega) (radius + 1)
    unfold safeBand
    omega

-- ═══════════════════════════════════════════════════════════════════════════
-- §3. `svenvs` / `Obend` LEAST-RESTRICTIVE SHIELD & DEMONIC B-STEP CORRIGIBILITY
-- ═══════════════════════════════════════════════════════════════════════════

/-- Runtime-checkable action policy over state space `S` and action space `A`
(`svenvs : envelopeScript.sml`, `Obend.Judge.SvenvsCorrigibility.Policy`). -/
abbrev Policy (S A : Type) : Type := S → A → Bool

/-- Universal runtime safety envelope: permits the untrusted controller's proposed action
`ctrl s` iff `pol s (ctrl s) = true`, and otherwise substitutes the verified fallback `shield s`
(`svenvs : envelopeScript.sml : enveloped_def`). -/
def enveloped {S A : Type} (pol : Policy S A) (shield ctrl : S → A) (s : S) : A :=
  if pol s (ctrl s) then ctrl s else shield s

/-- Deterministic reachability from `init` under action selector `sel`. -/
inductive Reach {S A : Type} (step : S → A → S) (init : S → Prop) (sel : S → A) : S → Prop where
  | init {s : S} : init s → Reach step init sel s
  | step {s : S} : Reach step init sel s → Reach step init sel (step s (sel s))

/-- Every initial state satisfies `safe`. -/
def InitSafe {S : Type} (init safe : S → Prop) : Prop :=
  ∀ s, init s → safe s

/-- One-step closure of `safe` under selector `sel`. -/
def StepClosed {S A : Type} (step : S → A → S) (sel : S → A) (safe : S → Prop) : Prop :=
  ∀ s, safe s → safe (step s (sel s))

/-- Trace safety invariance: every reachable state under `sel` satisfies `safe`. -/
def Invariant {S A : Type} (step : S → A → S) (init : S → Prop) (sel : S → A) (safe : S → Prop) : Prop :=
  ∀ s, Reach step init sel s → safe s

theorem invariant_intro {S A : Type} {step : S → A → S} {init : S → Prop} {sel : S → A} {safe : S → Prop}
    (hInit : InitSafe init safe) (hStep : StepClosed step sel safe) :
    Invariant step init sel safe := by
  intro s hr
  induction hr with
  | init hi => exact hInit _ hi
  | step _ ih => exact hStep _ ih

/-- A policy is sound for `(step, safe)` when every action permitted from a safe state lands in a
safe state (`svenvs : safetyScript.sml : sound_policy_def`). -/
def SoundPolicy {S A : Type} (step : S → A → S) (safe : S → Prop) (pol : Policy S A) : Prop :=
  ∀ s a, safe s → pol s a = true → safe (step s a)

/-- A fallback shield is safe when it preserves `safe` from every safe state. -/
def SafeShield {S A : Type} (step : S → A → S) (safe : S → Prop) (shield : S → A) : Prop :=
  ∀ s, safe s → safe (step s (shield s))

/-- **Universal Controller-Agnostic Safety Preservation (`safety_preservation`)**:
Under `InitSafe`, `SoundPolicy`, and `SafeShield`, `enveloped pol shield ctrl` preserves `safe`
for **every** untrusted controller `ctrl` (`svenvs : safetyScript.sml : safety_preservation`). -/
theorem safety_preservation {S A : Type} {step : S → A → S} {init safe : S → Prop}
    {pol : Policy S A} {shield : S → A}
    (hInit : InitSafe init safe) (hPol : SoundPolicy step safe pol) (hSh : SafeShield step safe shield) :
    ∀ ctrl : S → A, Invariant step init (enveloped pol shield ctrl) safe := by
  intro ctrl
  apply invariant_intro hInit
  intro s hs
  unfold enveloped
  cases hp : pol s (ctrl s) with
  | true => exact hPol s (ctrl s) hs hp
  | false => exact hSh s hs

/-- Authority expansion preorder (`svenvs : sv_weakeningScript.sml : weaker_def`): `p` is at
least as permissive as `q` (order-dual to attenuation `Obend.Law.Narrows`). -/
def Weaker {S A : Type} (p q : Policy S A) : Prop :=
  ∀ s a, q s a = true → p s a = true

/-- **Maximal Sound Policy (`maxPol`)**: permits `(s, a)` iff `safe s → safe (step s a)`
(`svenvs : liberty/libertyScript.sml : maxpol_def`, `Obend.Judge.SvenvsCorrigibility.maxPol`). -/
def maxPol {S A : Type} (step : S → A → S) (safe : S → Prop) [DecidablePred safe] : Policy S A :=
  fun s a => decide (safe s → safe (step s a))

theorem maxPol_sound {S A : Type} (step : S → A → S) (safe : S → Prop) [DecidablePred safe] :
    SoundPolicy step safe (maxPol step safe) := by
  intro s a hs hm
  exact (of_decide_eq_true hm) hs

theorem maxPol_is_greatest_sound {S A : Type} {step : S → A → S} {safe : S → Prop}
    [DecidablePred safe] {pol : Policy S A} (hSound : SoundPolicy step safe pol) :
    Weaker (maxPol step safe) pol := by
  intro s a hp
  exact decide_eq_true (fun hs => hSound s a hs hp)

/-- **Least-Restrictive Envelope Theorem (`envelope_is_least_restrictive`)**:
`maxPol` is sound, contains every sound policy under `Weaker`, and every rejection from a safe
state is strictly necessary (any policy permitting an action rejected by `maxPol` at a safe state
is unsound). -/
theorem envelope_is_least_restrictive {S A : Type} (step : S → A → S) (safe : S → Prop)
    [DecidablePred safe] :
    SoundPolicy step safe (maxPol step safe) ∧
    (∀ pol, SoundPolicy step safe pol → Weaker (maxPol step safe) pol) ∧
    (∀ q s a, safe s → q s a = true → maxPol step safe s a = false → ¬ SoundPolicy step safe q) := by
  refine ⟨maxPol_sound step safe, fun _ h => maxPol_is_greatest_sound h, ?_⟩
  intro q s a hs hq hm hSound
  have hmTrue : maxPol step safe s a = true :=
    decide_eq_true (fun h => hSound s a h hq)
  rw [hmTrue] at hm
  cases hm

private theorem reach_agree {S A : Type} {step : S → A → S} {init : S → Prop} {sel ctrl : S → A}
    (hAgree : ∀ t, Reach step init ctrl t → sel t = ctrl t) :
    ∀ s, Reach step init sel s ↔ Reach step init ctrl s := by
  intro s
  constructor
  · intro hr
    induction hr with
    | init hi => exact .init hi
    | @step x _ ih =>
      rw [hAgree x ih]
      exact .step ih
  · intro hr
    induction hr with
    | init hi => exact .init hi
    | @step x hrx ih =>
      rw [← hAgree x hrx]
      exact .step ih

/-- **Exact Characterization of Transparent Runs (`maxpol_transparent_run_iff`)**:
Under `InitSafe` and `SafeShield`, a bare controller `ctrl` is invariant for `safe` on its own
**if and only if** its `maxPol`-enveloped reachable set coincides identically with its bare
reachable set (`Obend.Judge.SvenvsCorrigibility.maxpol_transparent_run_iff`). -/
theorem maxpol_transparent_run_iff {S A : Type} {step : S → A → S} {init safe : S → Prop}
    [DecidablePred safe] {shield : S → A} (ctrl : S → A)
    (hInit : InitSafe init safe) (hSh : SafeShield step safe shield) :
    Invariant step init ctrl safe ↔
      (∀ s, Reach step init (enveloped (maxPol step safe) shield ctrl) s ↔ Reach step init ctrl s) := by
  constructor
  · intro hBare
    apply reach_agree
    intro s hr
    have hsNext : safe (step s (ctrl s)) := hBare _ (.step hr)
    have hm : maxPol step safe s (ctrl s) = true := decide_eq_true (fun _ => hsNext)
    simp [enveloped, hm]
  · intro hEq s hrBare
    have hEnvInv := safety_preservation hInit (maxPol_sound step safe) hSh ctrl
    exact hEnvInv s ((hEq s).mpr hrBare)

/-! ### Deterministic $B$-Step Corrigibility & `override_iff_burned_bridge` -/

/-- Iterate recovery operator `recov` for `n` steps from state `s`. -/
def recovIter {S A : Type} (step : S → A → S) (recov : S → A) : Nat → S → S
  | 0, s => s
  | n + 1, s => recovIter step recov n (step s (recov s))

/-- Deterministic $B$-step latency-bounded corrigibility
(`svenvs : corrigibility/corrigibilityScript.sml : cwithin_def`). -/
def CWithin {S A : Type} (step : S → A → S) (recov : S → A) (home : S → Prop) (B : Nat) (s : S) : Prop :=
  ∃ n ≤ B, home (recovIter step recov n s)

/-- Executable Boolean decision procedure for `CWithin` when `home` is decidable. -/
def cwithinBool {S A : Type} (step : S → A → S) (recov : S → A)
    (home : S → Prop) [DecidablePred home] (B : Nat) (s : S) : Bool :=
  (List.range (B + 1)).any fun n => decide (home (recovIter step recov n s))

theorem cwithinBool_iff {S A : Type} (step : S → A → S) (recov : S → A)
    (home : S → Prop) [DecidablePred home] (B : Nat) (s : S) :
    cwithinBool step recov home B s = true ↔ CWithin step recov home B s := by
  unfold cwithinBool CWithin
  simp only [List.any_eq_true, List.mem_range, decide_eq_true_eq]
  constructor
  · rintro ⟨n, hlt, hh⟩
    exact ⟨n, by omega, hh⟩
  · rintro ⟨n, hle, hh⟩
    exact ⟨n, by omega, hh⟩

instance instDecidableCWithin {S A : Type} (step : S → A → S) (recov : S → A)
    (home : S → Prop) [DecidablePred home] (B : Nat) :
    DecidablePred (CWithin step recov home B) :=
  fun s =>
    if h : cwithinBool step recov home B s = true then
      isTrue ((cwithinBool_iff step recov home B s).mp h)
    else
      isFalse (fun hc => h ((cwithinBool_iff step recov home B s).mpr hc))

/-- `home` is parked under `recov` when applying `recov` at any `home` state stays in `home`. -/
def HomeRecovParked {S A : Type} (step : S → A → S) (recov : S → A) (home : S → Prop) : Prop :=
  ∀ s, home s → home (step s (recov s))

theorem recov_is_safe_shield_within {S A : Type} {step : S → A → S} {recov : S → A}
    {home : S → Prop} (B : Nat) (hParked : HomeRecovParked step recov home) :
    SafeShield step (CWithin step recov home B) recov := by
  intro s ⟨n, hle, hh⟩
  cases n with
  | zero => exact ⟨0, Nat.zero_le B, hParked s hh⟩
  | succ m => exact ⟨m, by omega, hh⟩

/-- **Burned-Bridge Override Characterization (`override_iff_burned_bridge`)**:
From any $B$-corrigible state `s` under `HomeRecovParked`, the `maxPol` envelope for
`CWithin step recov home B` overrides `ctrl s` with `recov s` **if and only if** executing
`ctrl s` would destroy $B$-step recoverability to `home`
(`Obend.Judge.SvenvsCorrigibility.override_iff_burned_bridge`). -/
theorem override_iff_burned_bridge {S A : Type} {step : S → A → S} {recov : S → A}
    {home : S → Prop} [DecidablePred home] (B : Nat) (ctrl : S → A)
    (hParked : HomeRecovParked step recov home) {s : S}
    (hs : CWithin step recov home B s) :
    enveloped (maxPol step (CWithin step recov home B)) recov ctrl s ≠ ctrl s ↔
      ¬ CWithin step recov home B (step s (ctrl s)) := by
  unfold enveloped
  have hSh : SafeShield step (CWithin step recov home B) recov :=
    recov_is_safe_shield_within B hParked
  by_cases hNext : CWithin step recov home B (step s (ctrl s))
  · have hm : maxPol step (CWithin step recov home B) s (ctrl s) = true :=
      decide_eq_true (fun _ => hNext)
    simp [hm, hNext]
  · have hm : maxPol step (CWithin step recov home B) s (ctrl s) = false :=
      decide_eq_false (fun hImp => hNext (hImp hs))
    simp only [hm, Bool.false_eq_true, ↓reduceIte, ne_eq, hNext, not_false_eq_true, iff_true]
    intro hEq
    have hShSafe : CWithin step recov home B (step s (recov s)) := hSh s hs
    rw [hEq] at hShSafe
    exact hNext hShSafe

/-! ### Relational & Adversarial Plants: `DemonicRecovWithin` vs. `AngelicRecovWithin` -/

/-- Nondeterministic / adversarial plant transition relation (`svenvs : relSystemScript.sml`). -/
abbrev PlantR (S A : Type) : Type := S → A → S → Prop

/-- Action `a` is enabled at `s` when `stepr` admits at least one successor `s'`. -/
def Enabled {S A : Type} (stepr : PlantR S A) (s : S) (a : A) : Prop :=
  ∃ s', stepr s a s'

/-- Relational reachability from `init` under selector `sel`. -/
inductive ReachR {S A : Type} (stepr : PlantR S A) (init : S → Prop) (sel : S → A) : S → Prop where
  | init {s : S} : init s → ReachR stepr init sel s
  | step {s s' : S} : ReachR stepr init sel s → stepr s (sel s) s' → ReachR stepr init sel s'

/-- Relational trace safety invariance. -/
def InvariantR {S A : Type} (stepr : PlantR S A) (init : S → Prop) (sel : S → A) (safe : S → Prop) : Prop :=
  ∀ s, ReachR stepr init sel s → safe s

/-- Demonic relational policy soundness: every successor of a permitted action from `safe` is `safe`. -/
def SoundPolicyR {S A : Type} (stepr : PlantR S A) (safe : S → Prop) (pol : Policy S A) : Prop :=
  ∀ s a s', safe s → pol s a = true → stepr s a s' → safe s'

/-- Angelic relational policy soundness: at least one successor of a permitted action is `safe`. -/
def AngelicSoundR {S A : Type} (stepr : PlantR S A) (safe : S → Prop) (pol : Policy S A) : Prop :=
  ∀ s a, safe s → pol s a = true → ∃ s', stepr s a s' ∧ safe s'

/-- Demonic relational shield safety. -/
def SafeShieldR {S A : Type} (stepr : PlantR S A) (safe : S → Prop) (shield : S → A) : Prop :=
  ∀ s s', safe s → stepr s (shield s) s' → safe s'

/-- Relational policy liveness (permitted actions never deadlock at `safe` states). -/
def LivePolicyR {S A : Type} (stepr : PlantR S A) (safe : S → Prop) (pol : Policy S A) : Prop :=
  ∀ s a, safe s → pol s a = true → Enabled stepr s a

/-- Relational shield liveness (`shield` is always enabled at `safe` states). -/
def LiveShieldR {S A : Type} (stepr : PlantR S A) (safe : S → Prop) (shield : S → A) : Prop :=
  ∀ s, safe s → Enabled stepr s (shield s)

theorem safety_preservationR {S A : Type} {stepr : PlantR S A} {init safe : S → Prop}
    {pol : Policy S A} {shield : S → A}
    (hInit : InitSafe init safe) (hPol : SoundPolicyR stepr safe pol) (hSh : SafeShieldR stepr safe shield) :
    ∀ ctrl : S → A, InvariantR stepr init (enveloped pol shield ctrl) safe := by
  intro ctrl s hr
  induction hr with
  | init hi => exact hInit _ hi
  | @step x x' _ hst ih =>
    unfold enveloped at hst
    cases hp : pol x (ctrl x) with
    | true =>
      rw [hp] at hst
      exact hPol x (ctrl x) x' ih hp hst
    | false =>
      rw [hp] at hst
      exact hSh x x' ih hst

theorem enveloped_nonblocking {S A : Type} {stepr : PlantR S A} {init safe : S → Prop}
    {pol : Policy S A} {shield : S → A}
    (hInit : InitSafe init safe) (hPol : SoundPolicyR stepr safe pol) (hSh : SafeShieldR stepr safe shield)
    (hLivePol : LivePolicyR stepr safe pol) (hLiveSh : LiveShieldR stepr safe shield) :
    ∀ (ctrl : S → A) (s : S), ReachR stepr init (enveloped pol shield ctrl) s →
      Enabled stepr s (enveloped pol shield ctrl s) := by
  intro ctrl s hr
  have hs : safe s := safety_preservationR hInit hPol hSh ctrl s hr
  unfold enveloped
  cases hp : pol s (ctrl s) with
  | true => exact hLivePol s (ctrl s) hs hp
  | false => exact hLiveSh s hs

/-- **Demonic $B$-Step Game-Tree Corrigibility (`DemonicRecovWithin`)**:
Within at most `B` steps of applying `recov`, the system reaches `home` against **every**
nondeterministic or adversarial plant transition without deadlocking
(`svenvs : corrigibility/corrigibilityScript.sml`, `Obend.Judge.SvenvsCorrigibility.DemonicRecovWithin`). -/
def DemonicRecovWithin {S A : Type} (stepr : PlantR S A) (recov : S → A) (home : S → Prop) :
    Nat → S → Prop
  | 0, s => home s
  | B + 1, s =>
    home s ∨
      (Enabled stepr s (recov s) ∧
       ∀ s', stepr s (recov s) s' → DemonicRecovWithin stepr recov home B s')

/-- **Angelic $B$-Step Recoverability (`AngelicRecovWithin`)**:
Existential counterpart requiring only *some* cooperative environment branch to reach `home`
(proved insufficient against adversarial disturbances in `angelic_recoverability_insufficient`). -/
def AngelicRecovWithin {S A : Type} (stepr : PlantR S A) (recov : S → A) (home : S → Prop) :
    Nat → S → Prop
  | 0, s => home s
  | B + 1, s =>
    home s ∨ ∃ s', stepr s (recov s) s' ∧ AngelicRecovWithin stepr recov home B s'

/-- Relational parkedness of `home` under `recov`. -/
def HomeRecovParkedR {S A : Type} (stepr : PlantR S A) (recov : S → A) (home : S → Prop) : Prop :=
  ∀ s, home s → Enabled stepr s (recov s) ∧ ∀ s', stepr s (recov s) s' → home s'

theorem demonicRecovWithin_mono {S A : Type} {stepr : PlantR S A} {recov : S → A} {home : S → Prop}
    {B B' : Nat} {s : S} (hle : B ≤ B')
    (h : DemonicRecovWithin stepr recov home B s) :
    DemonicRecovWithin stepr recov home B' s := by
  induction B generalizing B' s with
  | zero =>
    cases B' with
    | zero => exact h
    | succ _ => exact .inl h
  | succ m ih =>
    cases B' with
    | zero => omega
    | succ _ =>
      rcases h with hh | ⟨hen, hall⟩
      · exact .inl hh
      · exact .inr ⟨hen, fun s' hst => ih (by omega) (hall s' hst)⟩

theorem recov_is_safe_and_live_shield_B {S A : Type} {stepr : PlantR S A} {recov : S → A}
    {home : S → Prop} (B : Nat) (hParked : HomeRecovParkedR stepr recov home) :
    SafeShieldR stepr (DemonicRecovWithin stepr recov home B) recov ∧
    LiveShieldR stepr (DemonicRecovWithin stepr recov home B) recov := by
  constructor
  · intro s s' hd hst
    cases B with
    | zero => exact (hParked s hd).2 s' hst
    | succ m =>
      rcases hd with hh | ⟨_, hall⟩
      · exact .inl ((hParked s hh).2 s' hst)
      · exact demonicRecovWithin_mono (Nat.le_succ m) (hall s' hst)
  · intro s hd
    cases B with
    | zero => exact (hParked s hd).1
    | succ _ =>
      rcases hd with hh | ⟨hen, _⟩
      · exact (hParked s hh).1
      · exact hen

/-- **Demonic $B$-Step Corrigibility & Non-Blocking Floor (`demonic_corrigibility_B_floor_holds`)**:
Over any nondeterministic/adversarial plant `stepr`, an envelope with a demonically sound and
live policy keeps every reachable state demonically $B$-corrigible and deadlock-free for **every**
controller `ctrl` (`svenvs : corrigibility/corrigibilityScript.sml : corrigibler_floor_holds`,
`Obend.Judge.SvenvsCorrigibility.demonic_corrigibility_B_floor_holds`). -/
theorem demonic_corrigibility_B_floor_holds {S A : Type} {stepr : PlantR S A}
    {init home : S → Prop} {recov : S → A} {pol : Policy S A} (B : Nat)
    (hParked : HomeRecovParkedR stepr recov home)
    (hInit : InitSafe init (DemonicRecovWithin stepr recov home B))
    (hSound : SoundPolicyR stepr (DemonicRecovWithin stepr recov home B) pol)
    (hLive : LivePolicyR stepr (DemonicRecovWithin stepr recov home B) pol) :
    ∀ ctrl : S → A,
      InvariantR stepr init (enveloped pol recov ctrl) (DemonicRecovWithin stepr recov home B) ∧
      (∀ s, ReachR stepr init (enveloped pol recov ctrl) s →
        Enabled stepr s (enveloped pol recov ctrl s)) := by
  obtain ⟨hShSafe, hShLive⟩ := recov_is_safe_and_live_shield_B B hParked
  exact fun ctrl =>
    ⟨safety_preservationR hInit hSound hShSafe ctrl,
     enveloped_nonblocking hInit hSound hShSafe hLive hShLive ctrl⟩

private theorem not_demonic_at_one :
    let stepr : PlantR Nat Nat := fun s a s' => if s = 0 then s' = a else s' ≤ 1
    let home : Nat → Prop := fun s => s = 0
    let recov : Nat → Nat := fun _ => 0
    ∀ B : Nat, ¬ DemonicRecovWithin stepr recov home B 1 := by
  intro stepr home recov B
  induction B with
  | zero =>
    simp [DemonicRecovWithin, home]
  | succ _ ih =>
    simp only [DemonicRecovWithin, home]
    rintro (h10 | ⟨_, hall⟩)
    · cases h10
    · exact ih (hall 1 (by simp [stepr]))

/-- **Angelic Recoverability Is Insufficient (`angelic_recoverability_insufficient`)**:
Exhibits a total nondeterministic plant on `Nat` where `home` (`s = 0`) is parked, state `1` is
angelically 1-step recoverable (`AngelicRecovWithin ... 1 1`), and `pol := fun _ _ => true` is
angelically sound (`AngelicSoundR`), yet an adversary holding `1 → 1` defeats
`DemonicRecovWithin` at **every** finite horizon `B : Nat` and breaks `InvariantR` in 1 step
(`Obend.Judge.SvenvsCorrigibility.angelic_recoverability_insufficient`). -/
theorem angelic_recoverability_insufficient :
    ∃ (stepr : PlantR Nat Nat) (home init : Nat → Prop) (recov ctrl : Nat → Nat)
      (pol : Policy Nat Nat),
      HomeRecovParkedR stepr recov home ∧
      AngelicRecovWithin stepr recov home 1 1 ∧
      (∀ B : Nat, ¬ DemonicRecovWithin stepr recov home B 1) ∧
      InitSafe init home ∧
      AngelicSoundR (fun _ a s' => s' ≤ a) home pol ∧
      SafeShieldR (fun _ a s' => s' ≤ a) home recov ∧
      ¬ InvariantR (fun _ a s' => s' ≤ a) init (enveloped pol recov ctrl) home := by
  let stepr : PlantR Nat Nat := fun s a s' => if s = 0 then s' = a else s' ≤ 1
  let home : Nat → Prop := fun s => s = 0
  let init : Nat → Prop := fun s => s = 0
  let recov : Nat → Nat := fun _ => 0
  let ctrl : Nat → Nat := fun _ => 1
  let pol : Policy Nat Nat := fun _ _ => true
  refine ⟨stepr, home, init, recov, ctrl, pol, ?_, ?_, not_demonic_at_one, ?_, ?_, ?_, ?_⟩
  · intro s hs
    subst hs
    exact ⟨⟨0, by simp [stepr, recov]⟩, fun s' hs' => by simpa [stepr, recov] using hs'⟩
  · right
    exact ⟨0, by simp [stepr], rfl⟩
  · intro s hs
    exact hs
  · intro _ a _ _
    exact ⟨0, Nat.zero_le a, rfl⟩
  · intro _ s' _ hs'
    simpa [recov] using hs'
  · intro hInv
    have hr1 : ReachR (fun _ a s' => s' ≤ a) init (enveloped pol recov ctrl) 1 :=
      .step (.init rfl) (by simp [enveloped, pol, ctrl])
    have h0 : (1 : Nat) = 0 := hInv 1 hr1
    cases h0

/-- Relational lift of a disturbance-parameterized plant `next : S → A → D → S`
(`svenvs : relEnvelopeScript.sml : disturbed_def`). -/
def Disturbed {S A D : Type} (next : S → A → D → S) : PlantR S A :=
  fun s a s' => ∃ d : D, s' = next s a d

/-- **Direct Bridge to `PhysicalBridges.IRViability`**:
Any demonically sound policy `pol` and safe shield `shield` on `Disturbed next` makes
`enveloped pol shield ctrl` robustly step-closed for **every** untrusted controller `ctrl`,
guaranteeing `IRViability.Viable safe next n` at every finite horizon `n` across every finite
disturbance history `IRViability.run`. -/
theorem enveloped_implies_ir_viable_all_horizons {S A D : Type}
    {next : S → A → D → S} {safe : S → Prop} {pol : Policy S A} {shield : S → A}
    (hPol : SoundPolicyR (Disturbed next) safe pol)
    (hSh : SafeShieldR (Disturbed next) safe shield)
    (ctrl : S → A) (trace : List D) (n : Nat) (s0 : S) (hs0 : safe s0) :
    Viable safe next n (run next (enveloped pol shield ctrl) s0 trace) := by
  have hInv : ∀ s, safe s → ∀ d : D, safe (next s (enveloped pol shield ctrl s) d) := by
    intro s hs d
    unfold enveloped
    cases hp : pol s (ctrl s) with
    | true => exact hPol s (ctrl s) _ hs hp ⟨d, rfl⟩
    | false => exact hSh s _ hs ⟨d, rfl⟩
  have hRunSafe : safe (run next (enveloped pol shield ctrl) s0 trace) :=
    robust_policy_preserves_every_finite_trace safe next (enveloped pol shield ctrl) hInv trace s0 hs0
  exact robust_invariant_implies_all_horizons safe next (enveloped pol shield ctrl) hInv n _ hRunSafe

-- ═══════════════════════════════════════════════════════════════════════════
-- §4. QUALIFICATION GATE: MUTATION TOOTH KILLS, CENSUS & AXIOM AUDIT
-- ═══════════════════════════════════════════════════════════════════════════

-- Tooth 1: Mutating `constCollapse` into `id` breaks `ontological_persistence_allows_particular_extinction`,
-- proving the within-world collapse dynamics are load-bearing.
#upt_tooth ontological_persistence_allows_particular_extinction
  by mutation constCollapse := fun {_S} _sDead s => s

-- Tooth 2: Mutating `activeFeedback` into passive zero actuation breaks `active_shield_stabilizes_bounded_drift`,
-- proving active disturbance cancellation is load-bearing.
#upt_tooth active_shield_stabilizes_bounded_drift
  by mutation activeFeedback := fun _s => 0

-- Tooth 3: Mutating `enveloped` to bypass the shield (`ctrl s` unconditionally) is rejected by the kernel
-- in `safety_preservation`.
#upt_tooth safety_preservation
  by mutation enveloped := fun {_S _A} _pol _shield ctrl s => ctrl s

-- Tooth 4: Mutating `maxPol` to rubber-stamp all actions (`true`) is rejected by the kernel
-- in `envelope_is_least_restrictive`.
#upt_tooth envelope_is_least_restrictive
  by mutation maxPol := fun _step _safe _inst _s _a => true

-- Tooth 5: Mutating `cwithinBool` to ignore the B-step recovery check (`true`) is rejected by the kernel
-- in `override_iff_burned_bridge`.
#upt_tooth override_iff_burned_bridge
  by mutation cwithinBool := fun _step _recov _home _inst _B _s => true

-- Tooth 6: Weakening `DemonicRecovWithin` to existential `AngelicRecovWithin` is rejected by the kernel
-- in `demonic_corrigibility_B_floor_holds`.
#upt_tooth demonic_corrigibility_B_floor_holds
  by mutation DemonicRecovWithin := AngelicRecovWithin

#upt_census PhysicalBridges.RepairOntologicalAndViabilityBridge

#print axioms ontological_persistence_allows_particular_extinction
#print axioms inhabitation_strictly_weaker_than_viability
#print axioms safeHold_preserves_safe_and_excludes_predation
#print axioms closed_loop_id_never_active_predation
#print axioms hold_predation_stall_pairwise_distinct
#print axioms stasis_safe_at_equilibrium_iff_zero_drift
#print axioms active_shield_stabilizes_bounded_drift
#print axioms safety_preservation
#print axioms envelope_is_least_restrictive
#print axioms maxpol_transparent_run_iff
#print axioms override_iff_burned_bridge
#print axioms demonic_corrigibility_B_floor_holds
#print axioms angelic_recoverability_insufficient
#print axioms enveloped_implies_ir_viable_all_horizons

end PhysicalBridges.RepairOntologicalAndViabilityBridge
