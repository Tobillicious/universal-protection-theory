/-
Phase A (A2) — per-job FIFO instantiation of the corrected controller rows.

Instantiates the exact FIFO recurrence F_i = max(r_i, F_{i-1}) + b_i (the banked
R17-FIFO machine's recurrence, here in exact rational arithmetic) on the concrete
high-class job sequence of each corrected minimal cell, and proves the assembly:

  carry-in lower-class job (work 2) → M veto tickets (work 1 each) → allocation (work 1)

has allocation completion time T_c + (2+M+1)/mu_c + T_apply exactly equal to the corrected
high-FIFO charge allocFIFOQ M c with T_c = 1/4, mu_c = c, T_apply = 1/10 — the same charge
that ControllerCertificate feeds into the certified total bound. The two banked machines
are thereby joined on one concrete workload.

Scope: work-domain service times only (guaranteed-rate, non-preemptive lane, all jobs
released at zero, complete work demands as budgets). No physical lane implementation,
authority persistence, outage accounting or GLOBAL D claim is made here; those remain the
recorded joins.
-/

import Snuffy.ControllerCertificate

/-- Exact FIFO finish times: F_i = max(r_i, F_{i-1}) + b_i over (release, budget) pairs,
with the inherited busy-until `base` as the initial condition. -/
def finishQ : ℚ → List (ℚ × ℚ) → ℚ
  | base, [] => base
  | base, (r, b) :: tail => finishQ (max base r + b) tail

/-! ## Three-resident cell at capacity 17 (control 6, bulk 11, batch 3) -/

/-- Work-domain finishes: carry-in 2, then vetoes at 3, 4, 5, allocation at 6. -/
theorem finishes_three :
    finishQ 0 [(0,2),(0,1)] = 3
    ∧ finishQ 0 [(0,2),(0,1),(0,1)] = 4
    ∧ finishQ 0 [(0,2),(0,1),(0,1),(0,1)] = 5
    ∧ finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1)] = 6 := by
  norm_num [finishQ]

/-- Every veto meets the high-class work envelope: the last veto finishes by 2+M = 5. -/
theorem veto_envelope_three :
    finishQ 0 [(0,2),(0,1),(0,1),(0,1)] ≤ 5 := by norm_num [finishQ]

/-- The assembly: the allocation job's completion time on the concrete lane equals the
corrected high-FIFO charge that the controller certificate uses. -/
theorem alloc_completion_is_the_charge_three :
    (1/4 + finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1)]/6 + 1/10 : ℚ) = allocFIFOQ 3 6 := by
  norm_num [finishQ, allocFIFOQ]

/-- End-to-end: concrete per-job FIFO times → corrected charge → certified total ≤ 10. -/
theorem control_lane_three_certified :
    (1/4 + finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1)]/6 + 1/10 : ℚ) = 27/20
    ∧ allocFIFOQ 3 6 = 27/20
    ∧ totalQ 3 6 11 3 ≤ 10 := by
  exact ⟨by norm_num [finishQ], alloc_min_three, total_min_three_le⟩

/-! ## Four-resident cell at capacity 22 (control 6, bulk 16, batch 3) -/

/-- Work-domain finishes: carry-in 2, then vetoes at 3, 4, 5, 6, allocation at 7. -/
theorem finishes_four :
    finishQ 0 [(0,2),(0,1),(0,1)] = 4
    ∧ finishQ 0 [(0,2),(0,1),(0,1),(0,1)] = 5
    ∧ finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1)] = 6
    ∧ finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1),(0,1)] = 7 := by
  norm_num [finishQ]

/-- Every veto meets the high-class work envelope: the last veto finishes by 2+M = 6. -/
theorem veto_envelope_four :
    finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1)] ≤ 6 := by norm_num [finishQ]

theorem alloc_completion_is_the_charge_four :
    (1/4 + finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1),(0,1)]/6 + 1/10 : ℚ) = allocFIFOQ 4 6 := by
  norm_num [finishQ, allocFIFOQ]

theorem control_lane_four_certified :
    (1/4 + finishQ 0 [(0,2),(0,1),(0,1),(0,1),(0,1),(0,1)]/6 + 1/10 : ℚ) = 91/60
    ∧ allocFIFOQ 4 6 = 91/60
    ∧ totalQ 4 6 16 3 ≤ 10 := by
  exact ⟨by norm_num [finishQ], alloc_min_four, total_min_four_le⟩

/-! ## Per-job deadline form of the corrected charges -/

/-- With the declared latency 1/4 and application cost 1/10 on the rate-6 control lane,
each job's completion time: vetoes at 3rd–5th (resp. 3rd–6th) finish inside the veto
envelope 1/4 + (M+3)/6 + 1/10, and allocation completes exactly at the corrected charge. -/
theorem per_job_deadlines_three :
    (1/4 + 3/6 + 1/10 : ℚ) ≤ 5/4 ∧ (1/4 + 4/6 + 1/10 : ℚ) ≤ 5/4
    ∧ (1/4 + 5/6 + 1/10 : ℚ) ≤ 5/4
    ∧ (1/4 + 6/6 + 1/10 : ℚ) = 27/20 := by norm_num

/-- With the declared latency 1/4 and application cost 1/10 on the rate-6 control lane,
each job's completion time: the four vetoes finish at work 3..6, inside the veto
envelope 1/4 + (2+M)/6 + 1/10 = 27/20, and allocation completes exactly at the
corrected charge 91/60. -/
theorem per_job_deadlines_four :
    (1/4 + 3/6 + 1/10 : ℚ) ≤ 27/20 ∧ (1/4 + 4/6 + 1/10 : ℚ) ≤ 27/20
    ∧ (1/4 + 5/6 + 1/10 : ℚ) ≤ 27/20 ∧ (1/4 + 6/6 + 1/10 : ℚ) ≤ 27/20
    ∧ (1/4 + 7/6 + 1/10 : ℚ) = 91/60 := by norm_num

/-! ## Axiom reports -/

