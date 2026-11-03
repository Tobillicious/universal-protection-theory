import PhysicalBridges.SummitSourceDynamicsExperiment

/-!
# Summit fibre/dynamics bridge — separate the readout from enacted transitions

4 November 2026. Noncanonical review increment. This module does not establish
universal UPT and does not alter original X3.

PR #271 proves a valid conditional fibre obstruction: if an invariant has a
living/nonliving pair in the same fibre, then equality of that invariant alone
does not prevent a continuation loss. That does NOT establish that every
source-derived transition is permitted to cross such a fibre.

The exact extra dynamical premise is FIBRE SATURATION: an observed/source
step lifts to every pair of physical states with those observed endpoints.
Under saturation and a source self-loop, a mixed-continuation fibre indeed
forces a violating transition. Without saturation, even nontrivial changing
physical dynamics with energy/charge conservation and monotone time may
preserve continuation despite the very same fibre ambiguity.

This is a mathematical scope correction, not a claim that an actual BCRD
generator has the frame property. The real BCRD source relation and all six
original-X3 components remain separate source-correspondence obligations.
-/

namespace PhysicalBridges.SummitFibreDynamicsBridge

open PhysicalBridges.SummitSourceDynamicsExperiment

universe u v

variable {S : Type u} {O : Type v}

/-- A maximally saturated lift of readout-level transition rules. -/
def ReadoutLift (observe : S → O) (sourceStep : O → O → Prop) :
    S → S → Prop :=
  fun s t => sourceStep (observe s) (observe t)

/-- The ordinary transition-invariance property of a state predicate.
This is only the continuation component, not full original X3. -/
def StepPreserves (step : S → S → Prop) (P : S → Prop) : Prop :=
  ∀ s t, step s t → P s → P t

/-- FIBRE NO-GO, WITH ITS MISSING DYNAMICAL PREMISE VISIBLE:
A mixed protected/unprotected readout fibre and a readout-level
self-loop force a violation only when all such readout-level steps
lift to actual physical-state pairs. This is not automatic. -/
theorem fibre_saturation_exposes_violation
    (observe : S → O) (sourceStep : O → O → Prop)
    (P : S → Prop) (s t : S)
    (hSame : observe s = observe t)
    (hGood : P s) (hBad : ¬ P t)
    (hLoop : sourceStep (observe s) (observe s)) :
    ¬ StepPreserves (ReadoutLift observe sourceStep) P := by
  intro hStable
  apply hBad
  apply hStable s t
  · change sourceStep (observe s) (observe t)
    rw [← hSame]
    exact hLoop
  · exact hGood

/-- A mixed fibre is compatible with protective physical dynamics:
the physical transition relation can distinguish state features
which the observation map discards. No universal claim is made. -/
theorem mixed_fibre_alone_does_not_force_violating_step :
    ∃ (observe : Bool → Unit) (P : Bool → Prop)
      (step : Bool → Bool → Prop),
      (∃ s t, observe s = observe t ∧ P s ∧ ¬ P t) ∧
      StepPreserves step P ∧ step true true := by
  refine ⟨(fun _ => ()), (fun b => b = true), (fun s t => s = t),
    ?_, ?_, rfl⟩
  · exact ⟨true, false, rfl, rfl, by decide⟩
  · intro s t hst hs
    cases hst
    exact hs

/-- A changing source evolution: advance physical clock and retain
all other state coordinates. The continuation-preservation property
is subsequently derived; it is not a premise of SourceLawful. -/
def sourceTick (s : PhysState) : PhysState :=
  { s with clock := s.clock + 1 }

def TickStep (s t : PhysState) : Prop :=
  t = sourceTick s

/-- Every tick transition conserves both ledgers and respects clock order. -/
theorem tick_satisfies_source_laws (s t : PhysState)
    (h : TickStep s t) :
    SourceLawful s t := by
  change t = sourceTick s at h
  subst t
  change s.energy = s.energy ∧
    s.charge = s.charge ∧ s.clock ≤ s.clock + 1
  exact ⟨rfl, rfl, Nat.le_succ s.clock⟩

/-- The changing tick dynamics also preserves continuation, not because
energy/charge conservation entails it, but because of its transition rule. -/
theorem tick_preserves_continuation (s t : PhysState)
    (h : TickStep s t) :
    PreservesX3 s t := by
  change t = sourceTick s at h
  subst t
  intro hLive
  exact hLive

/-- This example is nonstationary: a real state coordinate changes. -/
theorem tick_has_a_changing_step :
    ∃ s t : PhysState, TickStep s t ∧ s ≠ t := by
  let s : PhysState :=
    { energy := 5, charge := 2, clock := 0, continues := true }
  refine ⟨s, sourceTick s, rfl, ?_⟩
  intro h
  have hc := congrArg PhysState.clock h
  have hImpossible : (0 : Nat) = 1 := by
    simpa [s, sourceTick] using hc
  cases hImpossible

def ledgerReadout (s : PhysState) : Nat × Int × Nat :=
  (s.energy, s.charge, s.clock)

/-- The conserved quantities and clock do not reconstruct continuation. -/
theorem ledger_fibre_mixes_continuation :
    ∃ s t : PhysState,
      ledgerReadout s = ledgerReadout t ∧
      s.continues = true ∧ t.continues = false := by
  exact ⟨⟨5, 2, 0, true⟩, ⟨5, 2, 0, false⟩, rfl, rfl, rfl⟩

/-- POSITIVE COUNTERWEIGHT TO AN OVERBROAD NO-GO:
The observation is ambiguous about continuation, yet a nontrivial
physical transition law both respects conservation and preserves
continuation. Therefore ambiguous invariant fibres alone cannot
exclude a stronger source-derived identity-preserving dynamics. -/
theorem ambiguous_fibre_coexists_with_lawful_continuation :
    (∃ s t : PhysState,
      ledgerReadout s = ledgerReadout t ∧
      s.continues = true ∧ t.continues = false) ∧
    (∀ s t, TickStep s t → SourceLawful s t ∧ PreservesX3 s t) ∧
    (∃ s t : PhysState, TickStep s t ∧ s ≠ t) := by
  refine ⟨ledger_fibre_mixes_continuation, ?_, tick_has_a_changing_step⟩
  intro s t h
  exact ⟨tick_satisfies_source_laws s t h, tick_preserves_continuation s t h⟩

/-!
Audit interpretation:
* The existing PR #271 energy/charge/clock countermodel remains valid.
* The conditional fibre theorem remains valid.
* Neither proves a universal impossibility of source-derived X3 preservation.
* Actual BCRD physical dynamics must be tested for fibre saturation or other
  source-derived transition restrictions; the tick toy is not that test.
-/

#print axioms fibre_saturation_exposes_violation
#print axioms mixed_fibre_alone_does_not_force_violating_step
#print axioms tick_satisfies_source_laws
#print axioms tick_preserves_continuation
#print axioms tick_has_a_changing_step
#print axioms ledger_fibre_mixes_continuation
#print axioms ambiguous_fibre_coexists_with_lawful_continuation

end PhysicalBridges.SummitFibreDynamicsBridge
