
/-!
Snuffy R17-FIFO (candidate, 23 October 2026).
Exact upper-bound completion for a single continuously available,
non-preemptive FIFO service lane, measured in integer time units.

This does NOT formalise a physical service lane, R17-A authority, outage
calendar, or the multi-resource care system. It is deliberately separate
from R7-DIA's *preemptible* demand test.

Lean 4.35 / Mathlib proof candidate. Not compiled in this environment.
-/
namespace SnuffyFIFO

structure Job where
  release : Nat
  budget : Nat
  deadline : Nat
  deriving Repr

/-- Last completion time for the FIFO priorJobs when service time of each job is `work j`.
    `base` is the time the lane becomes free after inherited, unpreemptible work. -/
def finish (base : Nat) (jobs : List Job) (work : Job → Nat) : Nat :=
  match jobs with
  | [] => base
  | j :: tail => finish (max base j.release + work j) tail work

/-- A larger inherited completion time and larger service budget cannot
    reduce the completion bound for the next FIFO job. -/
theorem fifo_step (a b r w u : Nat) (hab : a ≤ b) (hwu : w ≤ u) :
    max a r + w ≤ max b r + u := by
  omega

/-- Every actual FIFO priorJobs finishes by its budgeted priorJobs time,
    provided the physical execution is continuously serviced without
    uncharged blocking, and actual work ≤ the independently warranted bound. -/
theorem finish_le_upper (work : Job → Nat) :
    ∀ jobs : List Job, (∀ j ∈ jobs, work j ≤ j.budget) →
    ∀ a b : Nat, a ≤ b →
      finish a jobs work ≤ finish b jobs (fun j => j.budget) := by
  intro jobs
  induction jobs with
  | nil =>
      intro _ a b hab
      simpa [finish] using hab
  | cons j rest ih =>
      intro hwork a b hab
      have hj : work j ≤ j.budget := hwork j (by simp)
      have ht : ∀ k ∈ rest, work k ≤ k.budget := by
        intro k hk
        exact hwork k (by simp [hk])
      have hstep := fifo_step a b j.release (work j) j.budget hab hj
      simpa [finish] using
        (ih ht (max a j.release + work j)
            (max b j.release + j.budget) hstep)

/-- A certified bound on the completion of any FIFO priorJobs proves its
    actual deadline, not just the final job's deadline. -/
theorem certified_prefix_meets_deadline
    (base : Nat) (priorJobs : List Job) (j : Job) (work : Job → Nat)
    (hwork : ∀ k ∈ (priorJobs ++ [j]), work k ≤ k.budget)
    (hcert : finish base (priorJobs ++ [j]) (fun k => k.budget) ≤ j.deadline) :
    finish base (priorJobs ++ [j]) work ≤ j.deadline := by
  exact Nat.le_trans (finish_le_upper work (priorJobs ++ [j]) hwork base base (Nat.le_refl _)) hcert

/-- The 1.1-unit demand against a 1-unit deadline counterexample,
    expressed in tenths to keep arithmetic exact. -/
example : ¬ (max (0 : Nat) 0 + 11 ≤ 10) := by omega

end SnuffyFIFO

