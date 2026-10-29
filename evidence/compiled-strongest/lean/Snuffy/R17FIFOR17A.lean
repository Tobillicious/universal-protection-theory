import Snuffy.FIFOWorkload
import Snuffy.R17AQueueFinality

/-!
R17-FIFO/R17-A joint time-and-application lemma (candidate).
The bound controls *when the target receives a final application opportunity*;
R17-A controls whether that opportunity is authorized in its actual state.
No actual application is inferred from a mere scheduling certificate.

These modules depend on the original source bindings: R12-A -> R17-A,
not on a newly invented permit bit. Not independently compiled here.
-/
namespace SnuffyFIFO

/-- Every successfully applied effect from a deadline-certified FIFO priorJobs
    is timely *and* has R17-A's current permit witness. -/
theorem applied_fifo_effect_is_timely_and_authorized
    (base : Nat) (priorJobs : List Job) (j : Job) (work : Job → Nat)
    (hwork : ∀ k ∈ (priorJobs ++ [j]), work k ≤ k.budget)
    (hcert : finish base (priorJobs ++ [j]) (fun k => k.budget) ≤ j.deadline)
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine)
    (ticket : Nat) (e : UPTR12A.Effect)
    (hnow : s.now = finish base (priorJobs ++ [j]) work)
    (happend : (UPTR17A.applyOne registry s ticket e).applied ≠ s.applied) :
    s.now ≤ j.deadline ∧
      ∃ p, registry ticket = some p ∧ UPTR17A.Ready s ticket e p := by
  constructor
  · rw [hnow]
    exact certified_prefix_meets_deadline base priorJobs j work hwork hcert
  · exact UPTR17A.new_effect_has_current_permit registry s ticket e happend

/-- To go from safe-and-timely *if applied* to actual timely delivery one also
    needs a live R17-A permit at the application time. This is deliberately
    not derived from enqueue-time authorisation. -/
theorem ready_fifo_effect_applies_before_deadline
    (base : Nat) (priorJobs : List Job) (j : Job) (work : Job → Nat)
    (hwork : ∀ k ∈ (priorJobs ++ [j]), work k ≤ k.budget)
    (hcert : finish base (priorJobs ++ [j]) (fun k => k.budget) ≤ j.deadline)
    (registry : UPTR17A.Registry) (s : UPTR17A.Machine)
    (ticket : Nat) (e : UPTR12A.Effect) (p : UPTR17A.Contract)
    (hnow : s.now = finish base (priorJobs ++ [j]) work)
    (hreg : registry ticket = some p)
    (hready : UPTR17A.Ready s ticket e p) :
    s.now ≤ j.deadline ∧
    (UPTR17A.applyOne registry s ticket e).applied = s.applied ++ [(ticket,e)] := by
  constructor
  · rw [hnow]
    exact certified_prefix_meets_deadline base priorJobs j work hwork hcert
  · classical
    simp [UPTR17A.applyOne, hreg, hready]

end SnuffyFIFO

