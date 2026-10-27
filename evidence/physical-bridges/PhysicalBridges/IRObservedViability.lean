/-
IR-6: Observation-uniform robust viability.
State-based viability does NOT by itself construct a controller using only
observations. Here observable selection is an explicit premise, and a
countermodel rules out inferring it from per-state viability.
-/
import PhysicalBridges.IRViability
import PhysicalBridges.IRObservablePermit

namespace PhysicalBridges.IRObservedViability
universe u v w z
variable {S : Type u} {O : Type v} {A : Type w} {D : Type z}

/-- An observable action works from every viable physical state consistent
with that observation, against every permitted disturbance. -/
def UniformKeeper (observe : S → O) (next : S → A → D → S)
    (K : S → Prop) (o : O) (a : A) : Prop :=
  ∀ s, K s → observe s = o → ∀ d, K (next s a d)

/-- Observation-only policy plus a uniform-keeper certificate is sufficient
for robust invariance of K on every disturbance history. -/
theorem observable_policy_preserves_kernel
    (observe : S → O) (next : S → A → D → S) (K : S → Prop)
    (policy : O → A)
    (hUniform : ∀ o, UniformKeeper observe next K o (policy o)) :
    ∀ trace s, K s →
      K (IRViability.run next (fun s => policy (observe s)) s trace) := by
  have inv : ∀ s, K s → ∀ d,
      K (next s (policy (observe s)) d) := by
    intro s hs d
    exact hUniform (observe s) s hs rfl d
  exact IRViability.robust_policy_preserves_every_finite_trace
    K next (fun s => policy (observe s)) inv

/-- Any observation-only kernel-preserving controller is also safe when
membership in K implies the specified physical safety invariant. -/
theorem observable_policy_physically_safe
    (observe : S → O) (next : S → A → D → S)
    (K safe : S → Prop) (policy : O → A)
    (hUniform : ∀ o, UniformKeeper observe next K o (policy o))
    (hSafe : ∀ s, K s → safe s) :
    ∀ trace s, K s →
      safe (IRViability.run next (fun s => policy (observe s)) s trace) := by
  intro trace s hs
  exact hSafe _ (observable_policy_preserves_kernel
    observe next K policy hUniform trace s hs)

/-- A safe viable set needs a common action in each observation fiber,
not merely a different action in each physical state. -/
theorem uniform_policy_exists_of_fiber_selectors
    (observe : S → O) (next : S → A → D → S)
    (K : S → Prop) [Nonempty A]
    (hFiber : ∀ o, (∃ s, K s ∧ observe s = o) →
        ∃ a, UniformKeeper observe next K o a) :
    ∃ policy : O → A, ∀ o,
      UniformKeeper observe next K o (policy o) := by
  classical
  have choose : ∀ o, ∃ a, UniformKeeper observe next K o a := by
    intro o
    by_cases hf : ∃ s, K s ∧ observe s = o
    · exact hFiber o hf
    · refine ⟨Classical.choice inferInstance, ?_⟩
      intro s hs ho d
      exact False.elim (hf ⟨s, hs, ho⟩)
  exact ⟨fun o => Classical.choose (choose o),
    fun o => Classical.choose_spec (choose o)⟩

/-- Hidden physical states that individually admit a safe next action may
demand incompatible actions at one shared observation. -/
def hiddenSafe (s : Nat) : Prop := s ≤ 1
def hiddenObserve (_ : Nat) : Unit := ()
def hiddenNext (s : Nat) (a : Bool) (_ : Unit) : Nat :=
  if s = 0 then (if a then 2 else 0)
  else if s = 1 then (if a then 1 else 2)
  else 2

theorem separate_statewise_choices :
    IRViability.Viable hiddenSafe hiddenNext 1 0 ∧
    IRViability.Viable hiddenSafe hiddenNext 1 1 := by
  constructor
  · refine ⟨(by change 0 ≤ 1; omega), false, ?_⟩
    intro d
    cases d
    change 0 ≤ 1
    omega
  · refine ⟨(by change 1 ≤ 1; omega), true, ?_⟩
    intro d
    cases d
    change 1 ≤ 1
    omega

theorem no_observation_uniform_choice :
    ¬ ∃ policy : Unit → Bool, ∀ s, hiddenSafe s →
       ∀ d : Unit, hiddenSafe (hiddenNext s (policy (hiddenObserve s)) d) := by
  intro ⟨policy, h⟩
  cases hp : policy () with
  | false =>
      have h1 : hiddenSafe (hiddenNext 1 false ()) :=
        by simpa [hiddenObserve, hp] using h 1 (by change 1 ≤ 1; omega) ()
      have hn : ¬ hiddenSafe (hiddenNext 1 false ()) := by
        change ¬ (2 ≤ 1)
        omega
      exact hn h1
  | true =>
      have h0 : hiddenSafe (hiddenNext 0 true ()) :=
        by simpa [hiddenObserve, hp] using h 0 (by change 0 ≤ 1; omega) ()
      have hn : ¬ hiddenSafe (hiddenNext 0 true ()) := by
        change ¬ (2 ≤ 1)
        omega
      exact hn h0

#print axioms observable_policy_preserves_kernel
#print axioms observable_policy_physically_safe
#print axioms uniform_policy_exists_of_fiber_selectors
#print axioms separate_statewise_choices
#print axioms no_observation_uniform_choice
end PhysicalBridges.IRObservedViability
