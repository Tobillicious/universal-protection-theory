/-
IR-4: Robust viability, distinguished from immediate safe action and from
maximality in a merely nonempty feasible outcome family. The model includes
nondeterministic disturbances; an admissible action must work against every
disturbance at each step. These are conditional transition-system results.
-/
namespace PhysicalBridges.IRViability

universe u v w
variable {S : Type u} {A : Type v} {D : Type w}

/-- Finite-horizon robust controllability of the safety invariant.
An action exists NOW whose every possible disturbance successor is viable
for the remaining n steps; future actions may adapt to observed states. -/
def Viable (safe : S → Prop) (next : S → A → D → S) : Nat → S → Prop
  | 0, s => safe s
  | n + 1, s => safe s ∧ ∃ a : A, ∀ d : D, Viable safe next n (next s a d)

theorem viable_now_safe
    (safe : S → Prop) (next : S → A → D → S) (n : Nat) (s : S)
    (h : Viable safe next n s) : safe s := by
  cases n with
  | zero => exact h
  | succ n => exact h.1

/-- Surviving more steps entails surviving fewer steps, for all models. -/
theorem viable_horizon_monotone
    (safe : S → Prop) (next : S → A → D → S) :
    ∀ n s, Viable safe next (n + 1) s → Viable safe next n s := by
  intro n
  induction n with
  | zero =>
      intro s h
      exact h.1
  | succ n ih =>
      intro s h
      obtain ⟨hs, a, ha⟩ := h
      exact ⟨hs, a, fun d => ih (next s a d) (ha d)⟩

/-- A fixed robustly invariant policy supplies viability at every finite horizon.
The theorem does NOT construct such a policy or establish a nonempty kernel. -/
theorem robust_invariant_implies_all_horizons
    (safe : S → Prop) (next : S → A → D → S)
    (policy : S → A)
    (hInvariant : ∀ s, safe s → ∀ d, safe (next s (policy s) d)) :
    ∀ n s, safe s → Viable safe next n s := by
  intro n
  induction n with
  | zero =>
      intro s hs
      exact hs
  | succ n ih =>
      intro s hs
      refine ⟨hs, policy s, ?_⟩
      intro d
      exact ih (next s (policy s) d) (hInvariant s hs d)

/-- A complete arbitrary finite disturbance history under a fixed policy. -/
def run (next : S → A → D → S) (policy : S → A) : S → List D → S
  | s, [] => s
  | s, d :: ds => run next policy (next s (policy s) d) ds

theorem robust_policy_preserves_every_finite_trace
    (safe : S → Prop) (next : S → A → D → S)
    (policy : S → A)
    (hInvariant : ∀ s, safe s → ∀ d, safe (next s (policy s) d)) :
    ∀ trace s, safe s → safe (run next policy s trace) := by
  intro trace
  induction trace with
  | nil =>
      intro s hs
      exact hs
  | cons d ds ih =>
      intro s hs
      exact ih (next s (policy s) d) (hInvariant s hs d)

/-- A safe immediate effect may lead to a state with no safe continuation. -/
def toySafe (s : Nat) : Prop := s ≤ 1
def toyStep (s : Nat) (a : Bool) (_ : Unit) : Nat :=
  if s = 0 then (if a then 1 else 0) else 2

theorem safe_immediate_but_not_viable :
    toySafe 0 ∧ toySafe (toyStep 0 true ()) ∧
      ¬ Viable toySafe toyStep 1 (toyStep 0 true ()) := by
  refine ⟨(by unfold toySafe; omega),
    (by unfold toySafe toyStep; omega), ?_⟩
  intro h
  obtain ⟨_, a, ha⟩ := h
  have hs : toySafe (toyStep (toyStep 0 true ()) a ()) := ha ()
  have he : toyStep (toyStep 0 true ()) a () = 2 := by
    cases a <;> decide
  rw [he] at hs
  have impossible : ¬ toySafe 2 := by
    unfold toySafe
    omega
  exact impossible hs

#print axioms viable_horizon_monotone
#print axioms robust_invariant_implies_all_horizons
#print axioms robust_policy_preserves_every_finite_trace
#print axioms safe_immediate_but_not_viable
end PhysicalBridges.IRViability
