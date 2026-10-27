/-
IR-23: a non-Zeno time-progress certificate AND per-event channel envelope
suffice to construct a finite aggregate effect budget, which then
discharges IR-15's aggregate safety premise in the same modeled world.

The physical clock, minimum dwell, deadline, and event impact bound
are named hypotheses; the theorem is not evidence that a real device
satisfies them.
-/
import PhysicalBridges.IRChannelInventory

namespace PhysicalBridges.IREventTimeBudget

/-- A natural-valued event clock advances by at least one tick on every
event. The clock may begin after time zero. -/
theorem strict_clock_progress_bounds_event_index
    (tick : Nat → Nat)
    (progress : ∀ n, tick n + 1 ≤ tick (n + 1)) :
    ∀ n, n ≤ tick n := by
  intro n
  induction n with
  | zero => exact Nat.zero_le _
  | succ n ih =>
    have hn := progress n
    omega

/-- Thus every count of events completed within an absolute time horizon
has finite length at most that horizon, independently of agent count. -/
theorem horizon_bounds_trace_length
    {E : Type} (trace : List E) (tick : Nat → Nat)
    (progress : ∀ n, tick n + 1 ≤ tick (n + 1))
    (deadline : tick trace.length ≤ horizon) :
    trace.length ≤ horizon := by
  exact Nat.le_trans
    (strict_clock_progress_bounds_event_index tick progress trace.length)
    deadline

/-- A common per-event influence bound yields an aggregate bound for
any finite event list, regardless of the kinds/numbers of agents. -/
theorem finite_list_charge_bound
    {E : Type} (charge : E → Nat) (cap : Nat) :
    ∀ trace : List E,
      (∀ e, e ∈ trace → charge e ≤ cap) →
      (trace.map charge).sum ≤ trace.length * cap := by
  intro trace
  induction trace with
  | nil =>
      intro _
      simp
  | cons e rest ih =>
      intro h
      have hHead : charge e ≤ cap := h e List.mem_cons_self
      have hTail : (rest.map charge).sum ≤ rest.length * cap :=
        ih (fun x hx => h x (List.mem_cons_of_mem e hx))
      simp only [List.map_cons, List.sum_cons, List.length_cons]
      have hAdd := Nat.add_le_add hHead hTail
      simpa [Nat.succ_mul, Nat.add_comm, Nat.add_left_comm,
        Nat.add_assoc] using hAdd

/-- The concrete physical model is safe for the entire interval if:
(1) every physical event is charged, (2) each event obeys the cap,
(3) the clock strictly progresses, (4) all listed events occur before
the supplied deadline, and (5) the initial gate reserves total slack. -/
theorem nonzeno_timed_metered_guard
    (trace : List IRChannelInventory.Channel)
    (state : IRChannelInventory.MeteredState)
    (tick : Nat → Nat) (horizon cap threshold : Nat)
    (progress : ∀ n, tick n + 1 ≤ tick (n + 1))
    (deadline : tick trace.length ≤ horizon)
    (perEvent : ∀ e, e ∈ trace → IRChannelInventory.charge e ≤ cap)
    (gate : state.physical + horizon * cap ≤ threshold) :
    (IRChannelInventory.run state trace).physical ≤ threshold := by
  have hLen : trace.length ≤ horizon :=
    horizon_bounds_trace_length trace tick progress deadline
  have hIndividual :
      (trace.map IRChannelInventory.charge).sum ≤ trace.length * cap :=
    finite_list_charge_bound IRChannelInventory.charge cap trace perEvent
  have hAggregate :
      (trace.map IRChannelInventory.charge).sum ≤ horizon * cap :=
    Nat.le_trans hIndividual (Nat.mul_le_mul_right cap hLen)
  exact IRChannelInventory.bounded_all_channel_effects
    trace state (horizon * cap) threshold hAggregate gate

/-- If there is no proven clock progress, a clock can remain at zero
while the purported event count grows beyond any finite deadline. -/
theorem stalled_clock_allows_unbounded_events :
    ∀ bound : Nat, ∃ count : Nat,
      (fun _ : Nat => 0) count ≤ 0 ∧ bound < count := by
  intro bound
  exact ⟨bound + 1, Nat.le_refl _, Nat.lt_succ_self _⟩

#print axioms strict_clock_progress_bounds_event_index
#print axioms horizon_bounds_trace_length
#print axioms finite_list_charge_bound
#print axioms nonzeno_timed_metered_guard
#print axioms stalled_clock_allows_unbounded_events
end PhysicalBridges.IREventTimeBudget
