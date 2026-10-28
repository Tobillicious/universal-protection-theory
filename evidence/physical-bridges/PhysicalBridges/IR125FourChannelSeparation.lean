import PhysicalBridges.IR123RealEventCoverage

/-!
IR-125: the missing state-separation and witness-emission joins
for a proposed four-channel BCRD event inventory.

A list of four named channels is NOT, by itself, an exhaustion proof.
Conservation laws, topological sector preservation, and causal DAG
constraints do not entail that every state transition changes one
of the four readouts, or that changed readouts are independently
detected and durably recorded.

Two distinct conditional bridges:
 (A) joint readout separation, modulo declared physical equivalence,
     makes each non-equivalent real transition alter a readout;
 (B) independently justified event capture for each changed
     readout yields one captured witness for every real step,
     hence an IR-123 captured event trace for finite executions.

Countermodels exhibit hidden internal change, zero-net-flux internal
redistribution, unrecorded readout change, and sensor-equivalent
physical states with indistinguishable alarm output.

No claim is made that these conditions follow from physical BCRD.
The flux field here is a cumulative *state readout*, not a
signed net boundary integral unless separately physically justified.
-/
namespace PhysicalBridges.IR125

universe u v w x
variable {S : Type} {D : Type u} {F : Type v}
variable {G : Type w} {A : Type x} {Event : Type}

/-- Four proposed independent readouts, not asserted complete. -/
structure FourReadouts (S : Type) (D : Type u)
    (F : Type v) (G : Type w) (A : Type x) where
  dag : S → D
  flux : S → F
  gauge : S → G
  actuator : S → A

def SameFourReadouts
    (r : FourReadouts S D F G A) (s t : S) : Prop :=
  r.dag s = r.dag t ∧
  r.flux s = r.flux t ∧
  r.gauge s = r.gauge t ∧
  r.actuator s = r.actuator t

/-- Joint separation only along admitted real transitions and
only modulo physically warranted equivalence. The absence of
unrepresented state coordinates is a genuine physical premise. -/
def SeparatesRealTransitions
    (r : FourReadouts S D F G A)
    (realStep samePhysical : S → S → Prop) : Prop :=
  ∀ s t, realStep s t →
    SameFourReadouts r s t → samePhysical s t

theorem changed_real_step_changes_one_readout
    (r : FourReadouts S D F G A)
    (realStep samePhysical : S → S → Prop)
    (hSeparates : SeparatesRealTransitions r realStep samePhysical)
    (s t : S) (hStep : realStep s t)
    (hDistinct : ¬ samePhysical s t) :
    r.dag s ≠ r.dag t ∨ r.flux s ≠ r.flux t ∨
    r.gauge s ≠ r.gauge t ∨ r.actuator s ≠ r.actuator t := by
  classical
  by_cases hDag : r.dag s = r.dag t
  · by_cases hFlux : r.flux s = r.flux t
    · by_cases hGauge : r.gauge s = r.gauge t
      · by_cases hAct : r.actuator s = r.actuator t
        · exact False.elim (hDistinct (hSeparates s t hStep
            ⟨hDag, hFlux, hGauge, hAct⟩))
        · exact Or.inr (Or.inr (Or.inr hAct))
      · exact Or.inr (Or.inr (Or.inl hGauge))
    · exact Or.inr (Or.inl hFlux)
  · exact Or.inl hDag

/-- Distinguish factual causal witness from independently captured
event. Observability and durable logging are not automatic. -/
def CapturedWitness (witness : S → Event → S → Prop)
    (captured : Event → Prop) (s : S) (e : Event) (t : S) :
    Prop := witness s e t ∧ captured e

theorem four_readout_changes_generate_captured_witness
    (r : FourReadouts S D F G A)
    (realStep samePhysical : S → S → Prop)
    (witness : S → Event → S → Prop)
    (captured : Event → Prop)
    (hSeparates : SeparatesRealTransitions r realStep samePhysical)
    (hDag : ∀ s t, realStep s t →
      r.dag s ≠ r.dag t →
      ∃ e, CapturedWitness witness captured s e t)
    (hFlux : ∀ s t, realStep s t →
      r.flux s ≠ r.flux t →
      ∃ e, CapturedWitness witness captured s e t)
    (hGauge : ∀ s t, realStep s t →
      r.gauge s ≠ r.gauge t →
      ∃ e, CapturedWitness witness captured s e t)
    (hAct : ∀ s t, realStep s t →
      r.actuator s ≠ r.actuator t →
      ∃ e, CapturedWitness witness captured s e t)
    (s t : S) (hStep : realStep s t)
    (hDistinct : ¬ samePhysical s t) :
    ∃ e, CapturedWitness witness captured s e t := by
  rcases changed_real_step_changes_one_readout
    r realStep samePhysical hSeparates s t hStep hDistinct with
    hD | hF | hG | hA
  · exact hDag s t hStep hD
  · exact hFlux s t hStep hF
  · exact hGauge s t hStep hG
  · exact hAct s t hStep hA

/-- Identity-equivalent/no-op steps also require a neutral witness
if the claim is literally that EVERY step produces an event. -/
theorem full_step_capture_from_four_channels
    (r : FourReadouts S D F G A)
    (realStep samePhysical : S → S → Prop)
    (witness : S → Event → S → Prop)
    (captured : Event → Prop)
    (hSeparates : SeparatesRealTransitions r realStep samePhysical)
    (hDag : ∀ s t, realStep s t →
      r.dag s ≠ r.dag t →
      ∃ e, CapturedWitness witness captured s e t)
    (hFlux : ∀ s t, realStep s t →
      r.flux s ≠ r.flux t →
      ∃ e, CapturedWitness witness captured s e t)
    (hGauge : ∀ s t, realStep s t →
      r.gauge s ≠ r.gauge t →
      ∃ e, CapturedWitness witness captured s e t)
    (hAct : ∀ s t, realStep s t →
      r.actuator s ≠ r.actuator t →
      ∃ e, CapturedWitness witness captured s e t)
    (hIdentityWitness : ∀ s t, realStep s t →
      samePhysical s t →
      ∃ e, CapturedWitness witness captured s e t) :
    ∀ s t, realStep s t →
      ∃ e, CapturedWitness witness captured s e t := by
  classical
  intro s t hStep
  by_cases hSame : samePhysical s t
  · exact hIdentityWitness s t hStep hSame
  · exact four_readout_changes_generate_captured_witness
      r realStep samePhysical witness captured
      hSeparates hDag hFlux hGauge hAct s t hStep hSame

/-- Reuse existing IR-123 construction rather than creating a
new circularly defined transition system. -/
theorem finite_real_execution_has_complete_captured_trace
    (r : FourReadouts S D F G A)
    (realStep samePhysical : S → S → Prop)
    (witness : S → Event → S → Prop)
    (captured : Event → Prop)
    (hSeparates : SeparatesRealTransitions r realStep samePhysical)
    (hDag : ∀ s t, realStep s t →
      r.dag s ≠ r.dag t →
      ∃ e, CapturedWitness witness captured s e t)
    (hFlux : ∀ s t, realStep s t →
      r.flux s ≠ r.flux t →
      ∃ e, CapturedWitness witness captured s e t)
    (hGauge : ∀ s t, realStep s t →
      r.gauge s ≠ r.gauge t →
      ∃ e, CapturedWitness witness captured s e t)
    (hAct : ∀ s t, realStep s t →
      r.actuator s ≠ r.actuator t →
      ∃ e, CapturedWitness witness captured s e t)
    (hIdentityWitness : ∀ s t, realStep s t →
      samePhysical s t →
      ∃ e, CapturedWitness witness captured s e t)
    {initial final : S}
    (execution : IR96.Reach realStep initial final) :
    ∃ events : List Event,
      IR123.WitnessedPhysicalReach
        (CapturedWitness witness captured) initial events final := by
  exact IR123.all_real_steps_witnessed_yield_complete_trace
    realStep (CapturedWitness witness captured)
    (full_step_capture_from_four_channels
      r realStep samePhysical witness captured
      hSeparates hDag hFlux hGauge hAct hIdentityWitness)
    execution

/-- Countermodel: change a hidden coordinate while all four
proposed readouts are identical. -/
theorem hidden_state_change_at_constant_four_readouts :
    ∃ r : FourReadouts (Bool × Bool) Bool Bool Bool Bool,
      (false, false) ≠ (false, true) ∧
      SameFourReadouts r (false, false) (false, true) := by
  let r : FourReadouts (Bool × Bool) Bool Bool Bool Bool :=
    { dag := Prod.fst, flux := Prod.fst,
      gauge := Prod.fst, actuator := Prod.fst }
  exact ⟨r, by decide, ⟨rfl, rfl, rfl, rfl⟩⟩

/-- Countermodel: zero net boundary flux permits internal
redistribution with total energy conserved and state altered. -/
theorem conserved_total_allows_nontrivial_internal_evolution :
    ∃ s t : Nat × Nat,
      s.1 + s.2 = t.1 + t.2 ∧ s ≠ t := by
  exact ⟨(1, 0), (0, 1), by decide, by decide⟩

/-- Countermodel: distinct sensor states need not generate any
durable event, independently of how observables are classified. -/
theorem changed_readout_without_emitted_witness :
    ∃ (readout : Bool → Bool)
      (witness : Bool → Unit → Bool → Prop),
      readout false ≠ readout true ∧
      ¬ ∃ e, witness false e true := by
  refine ⟨id, (fun _ _ _ => False), by decide, ?_⟩
  rintro ⟨_, h⟩
  exact h

/-- Countermodel principle: alarm output depends only on captured
sensor input, and cannot distinguish two states with identical input. -/
theorem same_sensor_reading_cannot_force_new_alarm
    {O : Type} (sensor : S → O) (alarm : O → Bool)
    (s t : S)
    (hSame : sensor s = sensor t)
    (hQuiet : alarm (sensor s) = false) :
    alarm (sensor t) = false := by
  rw [← hSame]
  exact hQuiet

end PhysicalBridges.IR125
