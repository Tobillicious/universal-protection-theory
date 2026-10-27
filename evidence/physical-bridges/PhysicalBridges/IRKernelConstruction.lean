/-
IR-9: Descending robust viability kernel, greatest invariant subset at a
certified fixed point. The operator is monotone AND contracting. Invariant
subset inclusion is proved without assuming a nonempty safe kernel.
Finite termination and real physical adequacy are separate obligations.
-/
import PhysicalBridges.IRViability

namespace PhysicalBridges.IRKernelConstruction
universe u v w
variable {S : Type u} {A : Type v} {D : Type w}

/-- Eliminate states from which no action guarantees remaining within K for
every disturbance. Retaining K in the definition makes this contracting. -/
def Prune (next : S → A → D → S) (K : S → Prop) : S → Prop :=
  fun s => K s ∧ ∃ a : A, ∀ d : D, K (next s a d)

def Inside (K L : S → Prop) : Prop := ∀ s, K s → L s

theorem prune_inside (next : S → A → D → S) (K : S → Prop) :
    Inside (Prune next K) K :=
  fun _ h => h.1

theorem prune_monotone (next : S → A → D → S)
    (K L : S → Prop) (h : Inside K L) :
    Inside (Prune next K) (Prune next L) := by
  intro s hs
  obtain ⟨hsK, a, ha⟩ := hs
  exact ⟨h s hsK, a, fun d => h _ (ha d)⟩

/-- Descending approximations, beginning with the original safety envelope. -/
def Approx (next : S → A → D → S) (safe : S → Prop) : Nat → S → Prop
  | 0 => safe
  | n + 1 => Prune next (Approx next safe n)

theorem approx_next_inside (next : S → A → D → S)
    (safe : S → Prop) (n : Nat) :
    Inside (Approx next safe (n + 1)) (Approx next safe n) :=
  prune_inside next (Approx next safe n)

theorem approx_inside_initial (next : S → A → D → S)
    (safe : S → Prop) :
    ∀ n, Inside (Approx next safe n) safe := by
  intro n
  induction n with
  | zero => exact fun _ h => h
  | succ n ih =>
    exact fun s hs => ih s (prune_inside next (Approx next safe n) s hs)

/-- Any robustly invariant subset I of safe survives every pruning round. -/
theorem invariant_survives_all_rounds
    (next : S → A → D → S) (safe I : S → Prop)
    (hSafe : Inside I safe)
    (hInvariant : ∀ s, I s → ∃ a : A, ∀ d : D, I (next s a d)) :
    ∀ n, Inside I (Approx next safe n) := by
  intro n
  induction n with
  | zero => exact hSafe
  | succ n ih =>
    intro s hs
    obtain ⟨a, ha⟩ := hInvariant s hs
    exact ⟨ih s hs, a, fun d => ih _ (ha d)⟩

/-- If a pruning iterate has actually stabilised, it contains EVERY
safe robustly invariant subset. It is itself robustly invariant and safe. -/
theorem stabilised_approx_is_greatest_invariant
    (next : S → A → D → S) (safe : S → Prop) (k : Nat)
    (stable : ∀ s, Prune next (Approx next safe k) s ↔
      Approx next safe k s) :
    Inside (Approx next safe k) safe ∧
    (∀ s, Approx next safe k s →
      ∃ a : A, ∀ d : D, Approx next safe k (next s a d)) ∧
    (∀ I : S → Prop, Inside I safe →
      (∀ s, I s → ∃ a : A, ∀ d : D, I (next s a d)) →
      Inside I (Approx next safe k)) := by
  refine ⟨approx_inside_initial next safe k, ?_, ?_⟩
  · intro s hs
    exact ((stable s).mpr hs).2
  · intro I hi hinv
    exact invariant_survives_all_rounds next safe I hi hinv k

/-- When action space has a fallback action, stability allows a fully
state-observing policy to be selected and certified for every finite trace.
An observation-only policy requires the distinct IR-6 fiber condition. -/
theorem stable_kernel_has_policy
    (next : S → A → D → S) (safe : S → Prop) (k : Nat)
    [Nonempty A]
    (stable : ∀ s, Prune next (Approx next safe k) s ↔
      Approx next safe k s) :
    ∃ policy : S → A, ∀ s, Approx next safe k s →
      ∀ d, Approx next safe k (next s (policy s) d) := by
  classical
  have eligible : ∀ s, ∃ a : A,
      Approx next safe k s → ∀ d, Approx next safe k (next s a d) := by
    intro s
    by_cases hk : Approx next safe k s
    · obtain ⟨a, ha⟩ := ((stable s).mpr hk).2
      exact ⟨a, fun _ => ha⟩
    · exact ⟨Classical.choice inferInstance, fun h => False.elim (hk h)⟩
  exact ⟨fun s => Classical.choose (eligible s),
    fun s => Classical.choose_spec (eligible s)⟩

theorem stable_kernel_safe_at_every_finite_trace
    (next : S → A → D → S) (safe : S → Prop) (k : Nat)
    [Nonempty A]
    (stable : ∀ s, Prune next (Approx next safe k) s ↔
      Approx next safe k s) :
    ∃ policy : S → A, ∀ trace s, Approx next safe k s →
      safe (IRViability.run next policy s trace) := by
  obtain ⟨policy, hp⟩ := stable_kernel_has_policy next safe k stable
  refine ⟨policy, ?_⟩
  intro trace s hs
  have hK := IRViability.robust_policy_preserves_every_finite_trace
    (Approx next safe k) next policy hp trace s hs
  exact approx_inside_initial next safe k _ hK

#print axioms prune_inside
#print axioms prune_monotone
#print axioms invariant_survives_all_rounds
#print axioms stabilised_approx_is_greatest_invariant
#print axioms stable_kernel_has_policy
#print axioms stable_kernel_safe_at_every_finite_trace
end PhysicalBridges.IRKernelConstruction
