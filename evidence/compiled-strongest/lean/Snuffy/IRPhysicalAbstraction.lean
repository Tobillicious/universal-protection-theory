import Snuffy.IREventTimeBudget

/-! Ported from `Tobillicious/universal-protection-theory` `evidence/physical-bridges/PhysicalBridges/IRPhysicalAbstraction.lean` at main `740abbb` (sha256 `13ec507e179e58c0706d00c7e0d3e1833682d562c00a99359aa9032f6b1297a3`); imports redirected to the canon, inline `#print axioms` removed (audited by SummitsAudit), `#eval` finite checks commented, three style linters off; statements and proofs unchanged. -/
set_option linter.unusedVariables false
set_option linter.unnecessarySimpa false
set_option linter.unusedSimpArgs false
/-
IR-24: a classifier from physical event E to a modeled channel is not
physical coverage. Finite-trace simulation requires a bounded residual.
Physical event and model event types are deliberately distinct.
-/

namespace PhysicalBridges.IRPhysicalAbstraction
variable {E : Type}

def physicalStep (effect : E → Nat) (value : Nat) (e : E) : Nat :=
  value + effect e

def physicalRun (effect : E → Nat) (value : Nat) (events : List E) : Nat :=
  events.foldl (physicalStep effect) value

theorem physical_run_sum (effect : E → Nat) :
    ∀ (events : List E) (value : Nat),
      physicalRun effect value events = value + (events.map effect).sum := by
  intro events
  induction events with
  | nil => intro value; rfl
  | cons e rest ih =>
      intro value
      change physicalRun effect (value + effect e) rest =
        value + ((e :: rest).map effect).sum
      rw [ih]
      simp only [List.map_cons, List.sum_cons]
      omega

/-- True physical effect is covered by classified charge PLUS a measured
per-event residual. This must be shown for every consequential event. -/
theorem residual_sum_bound
    (events : List E) (effect residual : E → Nat)
    (encode : E → IRChannelInventory.Channel)
    (h : ∀ e, e ∈ events →
      effect e ≤ IRChannelInventory.charge (encode e) + residual e) :
    (events.map effect).sum ≤
      (events.map (fun e => IRChannelInventory.charge (encode e))).sum +
      (events.map residual).sum := by
  induction events with
  | nil => simp
  | cons e rest ih =>
      have hHead := h e List.mem_cons_self
      have hTail := ih (fun e he => h e (List.mem_cons_of_mem _ he))
      simp only [List.map_cons, List.sum_cons]
      omega

/-- Independent real-effect register is safe given joint classified and
unclassified influence budgets. Neither budget is inferred from typing. -/
theorem physical_guard_with_residual
    (events : List E) (effect residual : E → Nat)
    (encode : E → IRChannelInventory.Channel)
    (start budget residualBudget threshold : Nat)
    (hEvent : ∀ e, e ∈ events →
      effect e ≤ IRChannelInventory.charge (encode e) + residual e)
    (hCharged :
      (events.map (fun e => IRChannelInventory.charge (encode e))).sum ≤ budget)
    (hResidual : (events.map residual).sum ≤ residualBudget)
    (hGate : start + budget + residualBudget ≤ threshold) :
    physicalRun effect start events ≤ threshold := by
  have h := residual_sum_bound events effect residual encode hEvent
  rw [physical_run_sum]
  omega

/-- Use IR-23's physical-event clock and per-event modeled charge cap
to derive the charged budget; the residual budget still needs evidence. -/
theorem time_bounded_physical_guard
    (events : List E) (effect residual : E → Nat)
    (encode : E → IRChannelInventory.Channel)
    (start horizon cap residualBudget threshold : Nat)
    (tick : Nat → Nat)
    (progress : ∀ n, tick n + 1 ≤ tick (n + 1))
    (deadline : tick events.length ≤ horizon)
    (perEvent : ∀ e, e ∈ events →
      IRChannelInventory.charge (encode e) ≤ cap)
    (hEvent : ∀ e, e ∈ events →
      effect e ≤ IRChannelInventory.charge (encode e) + residual e)
    (hResidual : (events.map residual).sum ≤ residualBudget)
    (hGate : start + horizon * cap + residualBudget ≤ threshold) :
    physicalRun effect start events ≤ threshold := by
  have hLen := IREventTimeBudget.horizon_bounds_trace_length
    events tick progress deadline
  have hCharges := IREventTimeBudget.finite_list_charge_bound
    (fun e => IRChannelInventory.charge (encode e)) cap events perEvent
  have hTotal :
      (events.map (fun e => IRChannelInventory.charge (encode e))).sum ≤
        horizon * cap :=
    Nat.le_trans hCharges (Nat.mul_le_mul_right cap hLen)
  exact physical_guard_with_residual events effect residual encode
    start (horizon * cap) residualBudget threshold
    hEvent hTotal hResidual hGate

/-- Classification with zero charge cannot bound actual effects without a
physical correspondence hypothesis: construct an arbitrary counterexample. -/
theorem empty_classification_counterexample :
    ∀ budget : Nat,
      ∃ (effect : Unit → Nat) (encode : Unit → IRChannelInventory.Channel),
        budget < physicalRun effect 0 [()] ∧
        (([()] : List Unit).map (fun e =>
          IRChannelInventory.charge (encode e))).sum = 0 := by
  intro budget
  refine ⟨(fun _ => budget + 1), (fun _ => .authorised 0), ?_, ?_⟩
  · simp [physicalRun, physicalStep]
  · rfl

end PhysicalBridges.IRPhysicalAbstraction
