import Snuffy.FIFOWorkload
import Snuffy.R16Feedback

/-! Source-level continuation of the received FIFO proof. Certificates concern
one continuously serviced lane and unstarted pending jobs. The current running
job is inherited in base; it cannot be removed by cancelling a pending job.
Actual durations are bounded separately for each occurrence, including identical
Job records. This file does not warrant physical service or authority persistence.
-/
namespace SnuffyFIFO

def Certified : Nat → List Job → Prop
  | _, [] => True
  | base, j :: tail =>
      max base j.release + j.budget ≤ j.deadline ∧
      Certified (max base j.release + j.budget) tail

def checks : Nat → List Job → Bool
  | _, [] => true
  | base, j :: tail =>
      decide (max base j.release + j.budget ≤ j.deadline) &&
      checks (max base j.release + j.budget) tail

theorem checks_iff (base : Nat) (jobs : List Job) :
    checks base jobs = true ↔ Certified base jobs := by
  induction jobs generalizing base with
  | nil => simp [checks, Certified]
  | cons j tail ih => simp [checks, Certified, ih]

theorem certified_mono (jobs : List Job) (a b : Nat) (hab : a ≤ b)
    (h : Certified b jobs) : Certified a jobs := by
  induction jobs generalizing a b with
  | nil => trivial
  | cons j tail ih =>
      have hs := fifo_step a b j.release j.budget j.budget hab (Nat.le_refl _)
      exact ⟨Nat.le_trans hs h.1, ih _ _ hs h.2⟩

theorem certified_append (base : Nat) (first rest : List Job) :
    Certified base (first ++ rest) ↔
      Certified base first ∧ Certified (finish base first (fun j => j.budget)) rest := by
  induction first generalizing base with
  | nil => simp [Certified, finish]
  | cons j tail ih => simp only [List.cons_append, Certified, finish, ih, and_assoc]

def admit (base : Nat) (jobs : List Job) (j : Job) : List Job :=
  if checks base (jobs ++ [j]) then jobs ++ [j] else jobs

theorem admission_preserves (base : Nat) (jobs : List Job) (j : Job)
    (h : Certified base jobs) : Certified base (admit base jobs j) := by
  unfold admit
  split
  · next accepted => exact (checks_iff base (jobs ++ [j])).mp accepted
  · exact h

theorem completion_preserves (base : Nat) (j : Job) (tail : List Job)
    (actual : Nat) (bounded : actual ≤ j.budget) (h : Certified base (j :: tail)) :
    max base j.release + actual ≤ j.deadline ∧
      Certified (max base j.release + actual) tail := by
  have hs := fifo_step base base j.release actual j.budget (Nat.le_refl _) bounded
  exact ⟨Nat.le_trans hs h.1, certified_mono tail _ _ hs h.2⟩

def cancel : Nat → List Job → List Job
  | _, [] => []
  | 0, _ :: tail => tail
  | n+1, j :: tail => j :: cancel n tail

theorem cancellation_preserves (index base : Nat) (jobs : List Job)
    (h : Certified base jobs) : Certified base (cancel index jobs) := by
  induction jobs generalizing index base with
  | nil => cases index <;> simp [cancel, Certified]
  | cons j tail ih =>
      cases index with
      | zero =>
          have hb : base ≤ max base j.release + j.budget := by omega
          exact certified_mono tail base _ hb h.2
      | succ index => exact ⟨h.1, ih index _ h.2⟩

/-- Actual work is attached to each occurrence; two equal Job records need
not take equal time. The received finish(work : Job -> Nat) special case remains. -/
def ActualTimely : Nat → List (Job × Nat) → Prop
  | _, [] => True
  | base, (j, actual) :: tail =>
      max base j.release + actual ≤ j.deadline ∧
      ActualTimely (max base j.release + actual) tail

theorem all_occurrences_timely (base : Nat) (execution : List (Job × Nat))
    (h : Certified base (execution.map Prod.fst))
    (bounds : ∀ item ∈ execution, item.2 ≤ item.1.budget) :
    ActualTimely base execution := by
  induction execution generalizing base with
  | nil => trivial
  | cons item tail ih =>
      obtain ⟨j, actual⟩ := item
      have bounded : actual ≤ j.budget := bounds (j,actual) (by simp)
      have next := completion_preserves base j (tail.map Prod.fst) actual bounded h
      exact ⟨next.1, ih _ next.2 (fun item hi => bounds item (by simp [hi]))⟩

structure Queue where
  base : Nat
  jobs : List Job

inductive QueueEvent where
  | admission (job : Job)
  | cancellation (index : Nat)
  | completion (actual : Nat)

def queueStep (s : Queue) : QueueEvent → Queue
  | .admission j => {s with jobs := admit s.base s.jobs j}
  | .cancellation i => {s with jobs := cancel i s.jobs}
  | .completion actual =>
      match s.jobs with
      | [] => s
      | j :: tail =>
          if actual ≤ j.budget then ⟨max s.base j.release + actual, tail⟩ else s

theorem queue_step_preserves (s : Queue) (e : QueueEvent)
    (h : Certified s.base s.jobs) :
    Certified (queueStep s e).base (queueStep s e).jobs := by
  cases e with
  | admission j => exact admission_preserves s.base s.jobs j h
  | cancellation i => exact cancellation_preserves i s.base s.jobs h
  | completion actual =>
      cases hs : s.jobs with
      | nil => simpa [queueStep, hs] using h
      | cons j tail =>
          by_cases hb : actual ≤ j.budget
          · simpa [queueStep, hs, hb] using
              (completion_preserves s.base j tail actual hb (by simpa [hs] using h)).2
          · simpa [queueStep, hs, hb] using h

/-- Uses the compiled R16 refinement lemma. The square is a separate source
obligation; this does not prove a real service lane satisfies the reference step. -/
theorem refinement_preserves_queue {S : Type} (p : S → Queue)
    (sourceTick : S → S) (choose : Queue → QueueEvent)
    (square : ∀ s, p (sourceTick s) = queueStep (p s) (choose (p s)))
    (s : S) (initial : Certified (p s).base (p s).jobs) (n : Nat) :
    Certified (p (UPTR16.iterate sourceTick n s)).base
      (p (UPTR16.iterate sourceTick n s)).jobs := by
  rw [UPTR16.map_iterate p sourceTick (fun q => queueStep q (choose q)) square n s]
  induction n with
  | zero => exact initial
  | succ n ih => exact queue_step_preserves _ _ ih

end SnuffyFIFO

