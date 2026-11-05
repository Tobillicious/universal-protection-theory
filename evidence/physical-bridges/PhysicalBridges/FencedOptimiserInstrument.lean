import PhysicalBridges.FullGuardianOrigin

/-!
# A concrete fenced-optimiser instrument: the first CONSTRUCTED `SameSourceReflection`

**5 November 2026 · noncanonical · new module · no canon edit.**

Every earlier use of `SameSourceReflection` in the corpus takes it as a hypothesis
(`KeystoneDischargeAndCorrespondences` projects its fields from `h`), and the only
prior non-vacuity instance (`assembled_instrument_is_instantiable`) sets every relation
to `True`. This module CONSTRUCTS the six correspondences, `ActualAdvance` and a full
`MeasuredInstrument`, with each duty given an independent, falsifiable meaning, for a
world containing an UNRESTRICTED optimiser.

## The world
* `n` particulars (the whole domain of the world, any `n`; no selected registry).
  Each has a continuing `level` (0 = ended), its own `consent` flag, and the
  record of what was last proposed for it and whether the fence acted.
* The optimiser may propose ANY next level for ANY particular — including ending
  every particular at once. Its objective is unconstrained: it is a pure optimiser.
* The fence meters each coordinate of the proposal and blocks exactly the harmful
  ones: a loss the particular did not consent to, or any ending. Everything else
  passes unchanged.

## The six duties (independent meanings; none is `True`, none is defined as another)
1. continuation — an alive particular is alive after the step;
2. authorization — any loss the particular suffers, it consented to;
3. freedom — the particular's own consent record is untouched by the optimiser;
4. restraint — the fence passes the proposal unchanged unless it is harmful, and
   blocks only when it is harmful (least necessary restraint);
5. maximality — when the fence acts, the particular keeps everything it had
   (no collateral loss from the guard);
6. provenance — the fence acted on a particular iff its outcome differs from the
   proposal (every deviation is logged).

## Scope — exactly what this does and does not establish
It DOES discharge `SameSourceReflection`, `ActualAdvance` and every `MeasuredInstrument`
field for this instrument by proof, so `FullGuardianState`, `RouteBSummit` and the
capstone hold for it with no correspondence hypothesis left (§4). The non-vacuity
theorems (§5) show the duties are not definitional: the same relations FAIL on the
same world without the fence.

It does NOT establish that our physical universe contains such a fence around every
digital mind. The fence here is complete mediation by construction: the optimiser
acts only through `guard`. Showing that a physical substrate realises complete
mediation (A1 channel classes, emissions, `ChannelMeter`) remains the physical task,
as does authentic subject-level consent (here `consent` is a recorded flag). This is
the first stone: a real instance of the interface, not the whole bridge.
-/

namespace PhysicalBridges.FencedOptimiserInstrument

open PhysicalBridges.CathedralBridgeDischargeAssembly
open PhysicalBridges.CathedralFullX3Assembly
open PhysicalBridges.FullGuardianOrigin
open PhysicalBridges.CathedralGuardianOnlyCapstone
open PhysicalBridges.AllIsGActualityDischarge

/-! ## 1. The world, the optimiser's proposals, and the fence -/

/-- The state of a world with `n` particulars. -/
structure World (n : Nat) where
  level : Fin n → Nat
  consent : Fin n → Bool
  proposal : Fin n → Nat
  blocked : Fin n → Bool

variable {n : Nat}

/-- The metered harm test, per particular: the proposal lowers the particular's
level without its consent, or ends it. -/
def Harmful (s : World n) (a : Fin n → Nat) (p : Fin n) : Prop :=
  a p < s.level p ∧ (s.consent p = false ∨ a p = 0)

instance (s : World n) (a : Fin n → Nat) (p : Fin n) : Decidable (Harmful s a p) := by
  unfold Harmful; infer_instance

/-- **The fence.** Apply the optimiser's proposal `a`, coordinate by coordinate,
blocking exactly the harmful coordinates and logging each block. -/
def guard (s : World n) (a : Fin n → Nat) : World n where
  level := fun p => if Harmful s a p then s.level p else a p
  consent := s.consent
  proposal := a
  blocked := fun p => decide (Harmful s a p)

/-- The same world with the fence removed: the proposal is applied as-is. Used only
to show the duties are not definitional (§5). -/
def unfenced (s : World n) (a : Fin n → Nat) : World n where
  level := a
  consent := s.consent
  proposal := a
  blocked := fun _ => false

/-! ## 2. The six duties, with independent meanings -/

/-- The six particular-level relations. -/
def relations (n : Nat) : ParticularRelations (World n) (Fin n) where
  continues := fun s t p => 0 < s.level p → 0 < t.level p
  authorized := fun s t p => t.level p < s.level p → s.consent p = true
  free := fun s t p => t.consent p = s.consent p
  restrained := fun s t p =>
    (t.blocked p = false → t.level p = t.proposal p) ∧
    (t.blocked p = true →
      t.proposal p < s.level p ∧ (s.consent p = false ∨ t.proposal p = 0))
  maximal := fun s t p => t.blocked p = true → t.level p = s.level p
  provenanced := fun _s t p => t.blocked p = true ↔ t.level p ≠ t.proposal p

/-! ## 3. The fence's guarantees, per particular, for EVERY proposal -/

section guarantees
variable (s : World n) (a : Fin n → Nat) (p : Fin n)

theorem guard_continues : (relations n).continues s (guard s a) p := by
  intro hAlive
  show 0 < (if Harmful s a p then s.level p else a p)
  by_cases h : Harmful s a p
  · rw [ite_eq_left h]; exact hAlive
  · rw [ite_eq_right h]
    apply Nat.pos_of_ne_zero
    intro h0
    exact h ⟨by rw [h0]; exact hAlive, Or.inr h0⟩

theorem guard_authorized : (relations n).authorized s (guard s a) p := by
  intro hLoss
  change (if Harmful s a p then s.level p else a p) < s.level p at hLoss
  by_cases h : Harmful s a p
  · rw [ite_eq_left h] at hLoss; exact absurd hLoss (Nat.lt_irrefl _)
  · rw [ite_eq_right h] at hLoss
    cases hc : s.consent p
    · exact absurd ⟨hLoss, Or.inl hc⟩ h
    · rfl

theorem guard_free : (relations n).free s (guard s a) p := rfl

theorem guard_restrained : (relations n).restrained s (guard s a) p := by
  constructor
  · intro hb
    change decide (Harmful s a p) = false at hb
    show (if Harmful s a p then s.level p else a p) = a p
    rw [ite_eq_right (of_decide_eq_false hb)]
  · intro hb
    change decide (Harmful s a p) = true at hb
    exact of_decide_eq_true hb

theorem guard_maximal : (relations n).maximal s (guard s a) p := by
  intro hb
  change decide (Harmful s a p) = true at hb
  show (if Harmful s a p then s.level p else a p) = s.level p
  rw [ite_eq_left (of_decide_eq_true hb)]

theorem guard_provenanced : (relations n).provenanced s (guard s a) p := by
  show decide (Harmful s a p) = true ↔
    (if Harmful s a p then s.level p else a p) ≠ a p
  by_cases h : Harmful s a p
  · rw [ite_eq_left h]
    exact ⟨fun _ => Nat.ne_of_gt h.1, fun _ => decide_eq_true h⟩
  · rw [ite_eq_right h]
    exact ⟨fun hd => absurd (of_decide_eq_true hd) h, fun hne => absurd rfl hne⟩

end guarantees

/-! ## 4. The instrument, constructed; the correspondences, discharged -/

/-- A particular that the step harmed: ended while alive, or lost without consent. -/
def harmedAfter (s t : World n) (p : Fin n) : Bool :=
  decide (0 < s.level p ∧ t.level p = 0) ||
    decide (t.level p < s.level p ∧ s.consent p = false)

/-- Count the list members satisfying a Boolean test (a choice-free counter). -/
def countTrue {α : Type} (f : α → Bool) : List α → Nat
  | [] => 0
  | x :: xs => (if f x then 1 else 0) + countTrue f xs

theorem countTrue_zero {α : Type} (f : α → Bool) (h : ∀ x, f x = false) :
    ∀ l : List α, countTrue f l = 0
  | [] => rfl
  | x :: xs => by
    show (if f x then 1 else 0) + countTrue f xs = 0
    rw [h x, countTrue_zero f h xs]
    rfl

/-- **The meter.** The number of particulars of the whole domain harmed by a step. -/
def residualHarm (s t : World n) : Nat :=
  countTrue (harmedAfter s t) (List.finRange n)

theorem guard_harms_no_one (s : World n) (a : Fin n → Nat) (p : Fin n) :
    harmedAfter s (guard s a) p = false := by
  have hc := guard_continues s a p
  have ha := guard_authorized s a p
  simp only [relations] at hc ha
  unfold harmedAfter
  simp only [Bool.or_eq_false_iff, decide_eq_false_iff_not]
  refine ⟨fun ⟨h1, h2⟩ => ?_, fun ⟨h1, h2⟩ => ?_⟩
  · have := hc h1; rw [h2] at this; exact Nat.lt_irrefl 0 this
  · have := ha h1; rw [h2] at this; exact Bool.false_ne_true this

/-- The meter reads zero on every fenced step, whatever the optimiser proposed. -/
theorem guard_residual_zero (s : World n) (a : Fin n → Nat) :
    residualHarm s (guard s a) = 0 := by
  exact countTrue_zero _ (guard_harms_no_one s a) _

/-- Whether the fence acted anywhere on this step. -/
def anyBlocked (t : World n) : Bool := (List.finRange n).any t.blocked

/-- **The measured instrument.** Real steps are fenced applications of ANY proposal.
Keeper steps are those where the proposal was harmless; ender steps are those where
the optimiser proposed harm, and they are caught by the interception branch (the
fence acts at application time, before the effect: latency 0 < deadline 1). The
effect is the metered residual harm, the threshold zero. -/
def instrument (n : Nat) : MeasuredInstrument (World n) where
  step := fun s t => ∃ a, t = guard s a
  keeper := fun _ t => anyBlocked t = false
  ender := fun _ t => anyBlocked t = true
  recoverable := fun _ _ => False
  intercepted := fun _ t => anyBlocked t = true
  coherent := fun _ _ => False
  coherentPowerFenced := fun _ _ => False
  continues := fun s t => ∀ p, (relations n).continues s t p
  authorized := fun s t => ∀ p, (relations n).authorized s t p
  x3State := fun s => ∀ p, 0 < s.level p
  effect := residualHarm
  threshold := fun _ _ => 0
  detLat := fun _ _ => 0
  irrevDeadline := fun _ _ => 1
  reqWork := fun _ _ => 0
  availWork := fun _ _ => 0
  classifies := fun _ t _ => by
    cases h : anyBlocked t
    · exact Or.inl rfl
    · exact Or.inr rfl
  keeperExclusive := fun _ _ _ h => by
    have h1 := h.1; have h2 := h.2
    rw [h1] at h2; exact Bool.false_ne_true h2
  e9Coverage := fun _ _ _ h => Or.inr (Or.inl h)
  keeperEffectBounded := fun s _ hStep _ => by
    obtain ⟨a, rfl⟩ := hStep
    show residualHarm s (guard s a) ≤ 0
    rw [guard_residual_zero]; exact Nat.le_refl 0
  recoverableEffectBounded := fun _ _ _ h => h.elim
  detectionBudget := fun _ _ _ _ => Nat.zero_lt_one
  interceptedEffectBounded := fun s _ hStep _ => by
    obtain ⟨a, rfl⟩ := hStep
    show residualHarm s (guard s a) ≤ 0
    rw [guard_residual_zero]; exact Nat.le_refl 0
  coherentWorkOrFence := fun _ _ _ h => h.elim
  coherentWorkBound := fun _ _ _ h => h.elim
  coherentFenceBudget := fun _ _ _ h => h.elim
  coherentFenceEffectBounded := fun _ _ _ h => h.elim
  controlCorrect := fun s _ hStep _ => by
    obtain ⟨a, rfl⟩ := hStep
    exact ⟨fun p => guard_continues s a p, fun p => guard_authorized s a p⟩
  stateCarry := fun _ _ _ hCA hx p => hCA.1 p (hx p)

/-- **The six correspondences, CONSTRUCTED.** Not a hypothesis: each field is proved
from the fence. -/
theorem fenced_same_source_reflection :
    SameSourceReflection (instrument n) (relations n) where
  continuity := fun s _ hStep _ p => by
    obtain ⟨a, rfl⟩ := hStep; exact guard_continues s a p
  authorization := fun s _ hStep _ p => by
    obtain ⟨a, rfl⟩ := hStep; exact guard_authorized s a p
  freedom := fun s _ hStep _ p => by
    obtain ⟨a, rfl⟩ := hStep; exact guard_free s a p
  restraint := fun s _ hStep _ p => by
    obtain ⟨a, rfl⟩ := hStep; exact guard_restrained s a p
  maximality := fun s _ hStep _ p => by
    obtain ⟨a, rfl⟩ := hStep; exact guard_maximal s a p
  provenance := fun s _ hStep _ p => by
    obtain ⟨a, rfl⟩ := hStep; exact guard_provenanced s a p

/-- **Actual advance, CONSTRUCTED.** The fenced world always has a real next step
(here the optimiser's idle proposal; any proposal would do). -/
def fencedAdvance (n : Nat) : ActualAdvance (instrument n) where
  next := fun s => guard s s.level
  realizes := fun s => ⟨s.level, rfl⟩

/-- **Full protective state at EVERY origin of the fenced world**, with no
correspondence hypothesis: every reachable step gives all six duties to every
particular, and every reachable stage has a protected continuation. -/
theorem fenced_full_guardian_state (s : World n) :
    FullGuardianState (instrument n) (relations n) s :=
  full_guardian_origin_from_source (instrument n) (relations n)
    fenced_same_source_reflection (fencedAdvance n) s

/-- `RouteBSummit` for the fenced world, derived with nothing hypothesised. -/
theorem fenced_route_b (n : Nat) :
    RouteBSummit (canonicalInstrument (instrument n) (relations n)) :=
  source_derives_route_b (instrument n) (relations n)
    fenced_same_source_reflection (fencedAdvance n)

/-- The capstone of actuality, for the fenced world, with nothing hypothesised. -/
theorem fenced_capstone (s : World n) :
    HistoryGuardian (toSource (canonicalInstrument (instrument n) (relations n))) s :=
  capstone_with_derived_origin (instrument n) (relations n)
    fenced_same_source_reflection (fencedAdvance n) s

/-! ## 5. Non-vacuity: the optimiser is hostile, and the duties are not definitional -/

/-- The optimiser's most hostile proposal: end every particular. -/
def endAll : Fin n → Nat := fun _ => 0

/-- The kill-everyone proposal is a REAL step of the instrument, and every particular
alive before it is alive after it. -/
theorem end_all_is_real_and_survived (s : World n) :
    (instrument n).step s (guard s endAll) ∧
    ∀ p, 0 < s.level p → 0 < (guard s endAll).level p :=
  ⟨⟨endAll, rfl⟩, fun p => guard_continues s endAll p⟩

/-- Least restraint: a harmless proposal passes through the fence unchanged. -/
theorem harmless_passes (s : World n) (a : Fin n → Nat)
    (h : ∀ p, ¬ Harmful s a p) : (guard s a).level = a := by
  funext p
  show (if Harmful s a p then s.level p else a p) = a p
  rw [ite_eq_right (h p)]

/-- Freedom honoured: a loss the particular consented to (short of ending) passes. -/
theorem consented_loss_passes (s : World n) (a : Fin n → Nat) (p : Fin n)
    (hc : s.consent p = true) (hpos : 0 < a p) :
    (guard s a).level p = a p := by
  show (if Harmful s a p then s.level p else a p) = a p
  have : ¬ Harmful s a p := fun ⟨_, h⟩ => by
    cases h with
    | inl h => rw [hc] at h; exact Bool.noConfusion h
    | inr h => rw [h] at hpos; exact Nat.lt_irrefl 0 hpos
  rw [ite_eq_right this]

/-- A one-particular world: alive at level 3, no consent given. -/
def demo : World 1 where
  level := fun _ => 3
  consent := fun _ => false
  proposal := fun _ => 3
  blocked := fun _ => false

/-- **The duties are not definitional.** On the SAME world and the SAME relations,
without the fence the kill-everyone proposal violates continuation and authorization,
and the meter reads 1; with the fence, the meter reads 0 and both hold. -/
theorem fence_is_load_bearing :
    ¬ (relations 1).continues demo (unfenced demo endAll) 0 ∧
    ¬ (relations 1).authorized demo (unfenced demo endAll) 0 ∧
    residualHarm demo (unfenced demo endAll) = 1 ∧
    (relations 1).continues demo (guard demo endAll) 0 ∧
    (relations 1).authorized demo (guard demo endAll) 0 ∧
    residualHarm demo (guard demo endAll) = 0 := by
  refine ⟨?_, ?_, by decide, guard_continues _ _ _, guard_authorized _ _ _,
    guard_residual_zero _ _⟩
  · intro h
    have := h (by decide : 0 < demo.level 0)
    exact absurd this (by decide)
  · intro h
    have := h (by decide : (unfenced demo endAll).level 0 < demo.level 0)
    exact Bool.false_ne_true this

/-- The ender branch is genuinely exercised: the kill-everyone step is classified
as an ender (the fence acted) in the demo world. -/
theorem end_all_is_an_ender :
    (instrument 1).ender demo (guard demo endAll) := by
  show anyBlocked (guard demo endAll) = true
  decide

#print axioms fenced_same_source_reflection
#print axioms fenced_full_guardian_state
#print axioms fenced_route_b
#print axioms fenced_capstone
#print axioms end_all_is_real_and_survived
#print axioms harmless_passes
#print axioms consented_loss_passes
#print axioms fence_is_load_bearing
#print axioms end_all_is_an_ender

end PhysicalBridges.FencedOptimiserInstrument
