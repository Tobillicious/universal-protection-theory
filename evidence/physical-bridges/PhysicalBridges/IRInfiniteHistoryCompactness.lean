/-
IR-72 — orthogonal infinite-horizon physical-history feasibility route.

From ALL finite-horizon robust viability witnesses and only TWO available
actions, derive one common memoryless robust policy whose actual modeled
trajectory remains safe at EVERY natural-number time, for EVERY
disturbance stream. No finitary STATIC retention obstruction or
downward closure of physical-history feasibility is required.

The proof is not a physical-plant refinement: mapping the archived
nine-transition plant to S, next and safe, validating actual disturbance
coverage, delivering historical continuation, and proving X3 freedoms
are independent physical/semantic obligations.

Infinite-branching countermodel: viable for every finite horizon,
but no action preserves viability at all horizons. Therefore
'forall finite n exists plan' cannot be universally promoted to
'one infinite continuation' without a compactness assumption.
-/
import PhysicalBridges.IRViability

namespace PhysicalBridges.IRInfiniteHistoryCompactness

open IRViability

universe u v

variable {S : Type u} {D : Type v}

def ForeverViable (safe : S → Prop)
    (next : S → Bool → D → S) (s : S) : Prop :=
  ∀ n : Nat, Viable safe next n s

theorem viable_weaken
    {A : Type v} (safe : S → Prop) (next : S → A → D → S)
    (n m : Nat) (h : n ≤ m) (s : S) :
    Viable safe next m s → Viable safe next n s := by
  induction m with
  | zero =>
      have hn : n = 0 := by omega
      subst n
      exact fun h => h
  | succ m ih =>
      intro hv
      by_cases heq : n = m + 1
      · subst n
        exact hv
      · have hn : n ≤ m := by omega
        exact ih hn (viable_horizon_monotone safe next m s hv)

/-- Bounded branching of ACTIONS yields a compactness-style
selection: ONE action works for all remaining finite horizons.
There is no finite state requirement and disturbances may be
arbitrary and potentially infinite. -/
theorem forever_viable_has_common_action
    (safe : S → Prop) (next : S → Bool → D → S)
    (s : S) (h : ForeverViable safe next s) :
    ∃ a : Bool, ∀ d : D, ForeverViable safe next (next s a d) := by
  classical
  by_cases hTrue :
      ∀ n : Nat, ∀ d : D, Viable safe next n (next s true d)
  · exact ⟨true,fun d n => hTrue n d⟩
  · by_cases hFalse :
        ∀ n : Nat, ∀ d : D, Viable safe next n (next s false d)
    · exact ⟨false,fun d n => hFalse n d⟩
    · obtain ⟨nt, hnt⟩ := not_forall.mp hTrue
      obtain ⟨dt, hdt⟩ := not_forall.mp hnt
      obtain ⟨nf, hnf⟩ := not_forall.mp hFalse
      obtain ⟨df, hdf⟩ := not_forall.mp hnf
      let m := max nt nf
      have hLong : Viable safe next (m+1) s := h (m+1)
      obtain ⟨_, a, ha⟩ := hLong
      cases a with
      | false =>
          have hSmall : Viable safe next nf (next s false df) :=
            viable_weaken safe next nf m (Nat.le_max_right _ _) _
              (ha df)
          exact False.elim (hdf hSmall)
      | true =>
          have hSmall : Viable safe next nt (next s true dt) :=
            viable_weaken safe next nt m (Nat.le_max_left _ _) _
              (ha dt)
          exact False.elim (hdt hSmall)

/-- A specific policy is derived from the finite-branching theorem,
not postulated as a model hypothesis. It may be noncomputable because
viability itself is an unrestricted higher-order predicate. -/
noncomputable def compactPolicy
    (safe : S → Prop) (next : S → Bool → D → S) (s : S) : Bool := by
  classical
  exact if hs : ForeverViable safe next s then
    Classical.choose (forever_viable_has_common_action safe next s hs)
  else false

theorem compact_policy_keeps_forever_viable
    (safe : S → Prop) (next : S → Bool → D → S)
    (s : S) (h : ForeverViable safe next s) :
    ∀ d, ForeverViable safe next
      (next s (compactPolicy safe next s) d) := by
  classical
  have hChosen :=
    Classical.choose_spec (forever_viable_has_common_action
      safe next s h)
  simpa [compactPolicy, h] using hChosen

def stateAt
    (next : S → Bool → D → S)
    (policy : S → Bool)
    (stream : Nat → D) (initial : S) : Nat → S
  | 0 => initial
  | n+1 =>
      next (stateAt next policy stream initial n)
        (policy (stateAt next policy stream initial n)) (stream n)

/-- If each finite robust horizon is achievable with a finite action
alphabet, the extracted ONE strategy keeps ALL modeled physical
prefixes safe, against EVERY infinite disturbance stream. This is
not just 'each horizon admits its own unrelated finite plan'. -/
theorem derived_infinite_robust_safe_history
    (safe : S → Prop) (next : S → Bool → D → S)
    (initial : S) (h : ForeverViable safe next initial) :
    ∃ policy : S → Bool,
      ∀ stream : Nat → D, ∀ n : Nat,
        safe (stateAt next policy stream initial n) := by
  let policy := compactPolicy safe next
  refine ⟨policy,?_⟩
  intro stream n
  have hAt : ∀ j : Nat,
      ForeverViable safe next (stateAt next policy stream initial j) := by
    intro j
    induction j with
    | zero => exact h
    | succ j ih =>
        change ForeverViable safe next
          (next (stateAt next policy stream initial j)
            (policy (stateAt next policy stream initial j))
            (stream j))
        exact compact_policy_keeps_forever_viable safe next
          (stateAt next policy stream initial j) ih (stream j)
  exact viable_now_safe safe next 0 _
    (hAt n 0)

/-- Independently choose a finite starting countdown. With infinitely
many available first actions, every finite horizon is viable, but
the selected countdown always runs out. -/
def countdownSafe : Option Nat → Prop
  | none => True
  | some n => 0 < n

def countdownStep (s : Option Nat) (a : Nat) (_ : Unit) :
    Option Nat :=
  match s with
  | none => some (a+1)
  | some 0 => some 0
  | some (n+1) => some n

theorem countdown_finite_budget_viable :
    ∀ n : Nat,
      Viable countdownSafe countdownStep n (some (n+1)) := by
  intro n
  induction n with
  | zero =>
      exact Nat.zero_lt_succ _
  | succ n ih =>
      refine ⟨Nat.zero_lt_succ _, 0, ?_⟩
      intro _
      simpa [countdownStep] using ih

theorem countdown_any_finite_horizon_viable :
    ∀ n : Nat, Viable countdownSafe countdownStep n none := by
  intro n
  cases n with
  | zero => trivial
  | succ n =>
      refine ⟨trivial, n, ?_⟩
      intro _
      simpa [countdownStep] using countdown_finite_budget_viable n

theorem countdown_budget_exhausts :
    ∀ n : Nat,
      ¬ Viable countdownSafe countdownStep (n+1) (some n) := by
  intro n
  induction n with
  | zero =>
      intro h
      exact (Nat.not_succ_le_zero 0) h.1
  | succ n ih =>
      intro h
      obtain ⟨_,a,ha⟩ := h
      apply ih
      simpa [countdownStep] using ha ()

theorem infinite_action_branching_blocks_common_policy :
    (∀ n : Nat, Viable countdownSafe countdownStep n none) ∧
    (∀ a : Nat, ¬ (∀ n : Nat,
      Viable countdownSafe countdownStep n
        (countdownStep none a ()))) := by
  constructor
  · exact countdown_any_finite_horizon_viable
  · intro a hall
    have hNo := countdown_budget_exhausts (a+1)
    exact hNo (by simpa [countdownStep] using hall (a+2))

#print axioms viable_weaken
#print axioms forever_viable_has_common_action
#print axioms compact_policy_keeps_forever_viable
#print axioms derived_infinite_robust_safe_history
#print axioms countdown_finite_budget_viable
#print axioms countdown_any_finite_horizon_viable
#print axioms countdown_budget_exhausts
#print axioms infinite_action_branching_blocks_common_policy

end PhysicalBridges.IRInfiniteHistoryCompactness
