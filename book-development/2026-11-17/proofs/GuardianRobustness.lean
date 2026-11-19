import UniversalGuardianFixedPoint

/-!
Hostile-review repair: state-dependent, nondeterministic effect coverage.
The independently specified certificate may be the complete original-six
event proposition. No proxy for those duties or for Complete Koru is defined.
Safety, existence of a next event, and eventual exercise of agency have
different types. In particular, even serial safety can admit endless idling.
-/

namespace Snuffy.BookWork.GuardianRobustness

open Snuffy.BookWork.UniversalGuardianFixedPoint

universe u v
variable {Action : Type u} {S : Type v}

def RelOperator (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop) (X : S → Prop) (s : S) : Prop :=
  safe s ∧ ∀ a t, step a s t → certificate s t ∧ X t

def SafeFor (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop) : Nat → S → Prop
  | 0, s => safe s
  | n + 1, s => safe s ∧ ∀ a t, step a s t →
      certificate s t ∧ SafeFor step safe certificate n t

def RelG (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop) (s : S) : Prop :=
  ∀ n, SafeFor step safe certificate n s

theorem relational_G_is_a_fixed_point
    (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop) (s : S) :
    RelG step safe certificate s ↔
      RelOperator step safe certificate (RelG step safe certificate) s := by
  constructor
  · intro h
    refine ⟨h 0, ?_⟩
    intro a t ht
    exact ⟨((h 1).2 a t ht).1, fun n => ((h (n + 1)).2 a t ht).2⟩
  · intro h n
    cases n with
    | zero => exact h.1
    | succ n => exact ⟨h.1, fun a t ht =>
        ⟨(h.2 a t ht).1, (h.2 a t ht).2 n⟩⟩

theorem relational_G_is_greatest
    (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop) (X : S → Prop)
    (hClosed : ∀ s, X s → RelOperator step safe certificate X s) :
    ∀ s, X s → RelG step safe certificate s := by
  have hFinite : ∀ n s, X s → SafeFor step safe certificate n s := by
    intro n
    induction n with
    | zero => exact fun s hs => (hClosed s hs).1
    | succ n ih =>
      intro s hs
      have h := hClosed s hs
      exact ⟨h.1, fun a t ht =>
        ⟨(h.2 a t ht).1, ih t (h.2 a t ht).2⟩⟩
  exact fun s hs n => hFinite n s hs

/-- Adding possible effects cannot enlarge a universally safe domain. -/
theorem adding_possible_effects_can_only_shrink_G
    (small large : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop)
    (hCoverage : ∀ a s t, small a s t → large a s t) :
    ∀ s, RelG large safe certificate s → RelG small safe certificate s := by
  apply relational_G_is_greatest small safe certificate
    (RelG large safe certificate)
  intro s hs
  have h := (relational_G_is_a_fixed_point large safe certificate s).mp hs
  exact ⟨h.1, fun a t ht => h.2 a t (hCoverage a s t ht)⟩

/-- A larger effect inventory preserves the exact domain only after every
    newly represented edge from the old domain has its full certificate
    and returns to that domain. This is an actionable extension rule. -/
theorem compatible_new_effects_preserve_exact_G
    (small large : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop)
    (hCoverage : ∀ a s t, small a s t → large a s t)
    (hNew : ∀ s, RelG small safe certificate s →
      ∀ a t, large a s t →
        certificate s t ∧ RelG small safe certificate t) :
    ∀ s, RelG large safe certificate s ↔ RelG small safe certificate s := by
  have hBack := relational_G_is_greatest large safe certificate
    (RelG small safe certificate) (fun s hs =>
      ⟨(relational_G_is_a_fixed_point small safe certificate s).mp hs |>.1,
        hNew s hs⟩)
  exact fun s =>
    ⟨adding_possible_effects_can_only_shrink_G
      small large safe certificate hCoverage s, hBack s⟩

def MapStep (update : Action → S → S) (a : Action) (s t : S) : Prop :=
  t = update a s

/-- The original deterministic construction embeds without changing its
    state or certificate meanings. -/
theorem deterministic_and_relational_G_agree
    (update : Action → S → S) (safe : S → Prop)
    (certificate : S → S → Prop) :
    ∀ s, UniversalG update safe certificate s ↔
      RelG (MapStep update) safe certificate s := by
  intro s
  constructor
  · intro hs
    apply relational_G_is_greatest (MapStep update) safe certificate
      (UniversalG update safe certificate) ?_ s hs
    intro s hs
    have h := (universal_G_is_a_fixed_point update safe certificate s).mp hs
    refine ⟨h.1, ?_⟩
    intro a t ht
    cases ht
    exact h.2 a
  · intro hs
    apply every_certified_domain_is_inside_G update safe certificate
      (RelG (MapStep update) safe certificate) ?_ s hs
    intro s hs
    have h := (relational_G_is_a_fixed_point
      (MapStep update) safe certificate s).mp hs
    exact ⟨h.1, fun a => h.2 a (update a s) rfl⟩

/-- Every outcome of every represented nondeterministic execution is
    covered. The execution's existence and step fidelity are explicit. -/
theorem every_represented_execution_is_protected
    (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop)
    (run : Nat → S) (action : Nat → Action)
    (hRun : ∀ n, step (action n) (run n) (run (n + 1)))
    (hInitial : RelG step safe certificate (run 0)) :
    ∀ n, RelG step safe certificate (run n) ∧
      certificate (run n) (run (n + 1)) := by
  have hG : ∀ n, RelG step safe certificate (run n) := by
    intro n
    induction n with
    | zero => exact hInitial
    | succ n ih =>
      exact ((relational_G_is_a_fixed_point step safe certificate _).mp ih).2
        (action n) (run (n + 1)) (hRun n) |>.2
  exact fun n => ⟨hG n,
    ((relational_G_is_a_fixed_point step safe certificate _).mp (hG n)).2
      (action n) (run (n + 1)) (hRun n) |>.1⟩

/-- No successor is created by a universal statement over absent steps. -/
theorem a_deadlock_can_belong_to_G :
    (∀ s : Unit, RelG (fun (_ : Unit) _ _ => False)
      (fun _ => True) (fun _ _ => True) s) ∧
    ¬ (∃ (a : Unit) (t : Unit),
      (fun (_ : Unit) (_ _) => False) a () t) := by
  constructor
  · intro s
    apply relational_G_is_greatest _ _ _ (fun _ => True) ?_ s trivial
    exact fun _ _ => ⟨trivial, fun _ _ h => False.elim h⟩
  · exact fun ⟨_, _, h⟩ => h

def CanRun (step : Action → S → S → Prop)
    (certificate : S → S → Prop) (G : S → Prop) : Nat → S → Prop
  | 0, _ => True
  | n + 1, s => ∃ a t, step a s t ∧ certificate s t ∧
      G t ∧ CanRun step certificate G n t

/-- Independent seriality repairs deadlock at each finite horizon. This
    is not yet a deadline, fairness, goal-attainment or limit-event law. -/
theorem serial_G_has_arbitrarily_long_certified_executions
    (step : Action → S → S → Prop) (safe : S → Prop)
    (certificate : S → S → Prop)
    (hSerial : ∀ s, RelG step safe certificate s → ∃ a t, step a s t) :
    ∀ n s, RelG step safe certificate s →
      CanRun step certificate (RelG step safe certificate) n s := by
  intro n
  induction n with
  | zero => exact fun _ _ => trivial
  | succ n ih =>
    intro s hs
    obtain ⟨a, t, ht⟩ := hSerial s hs
    have h := ((relational_G_is_a_fixed_point step safe certificate s).mp hs).2 a t ht
    exact ⟨a, t, ht, h.1, h.2, ih t h.2⟩

def IdleStep (_ : Unit) (s t : Bool) : Prop := t = s

/-- Even a serial certified system may idle forever without attaining a
    separately specified goal. Authentic freedom requires more than this
    abstract safety proposition. -/
theorem serial_protected_execution_can_idle_forever :
    (∀ s, RelG IdleStep (fun _ => True) (fun s t => t = s) s) ∧
    (∀ s : Bool, ∃ a t, IdleStep a s t) ∧
    (∃ run : Nat → Bool, run 0 = false ∧
      (∀ n, IdleStep () (run n) (run (n + 1))) ∧
      (∀ n, run n ≠ true)) := by
  refine ⟨?_, (fun s => ⟨(), s, rfl⟩),
    ⟨(fun _ => false), rfl, (fun _ => rfl), (fun _ => Bool.false_ne_true)⟩⟩
  intro s
  apply relational_G_is_greatest IdleStep _ _ (fun _ => True) ?_ s trivial
  exact fun _ _ => ⟨trivial, fun _ _ ht => ⟨ht, trivial⟩⟩

#print axioms relational_G_is_a_fixed_point
#print axioms relational_G_is_greatest
#print axioms adding_possible_effects_can_only_shrink_G
#print axioms compatible_new_effects_preserve_exact_G
#print axioms deterministic_and_relational_G_agree
#print axioms every_represented_execution_is_protected
#print axioms a_deadlock_can_belong_to_G
#print axioms serial_G_has_arbitrarily_long_certified_executions
#print axioms serial_protected_execution_can_idle_forever

end Snuffy.BookWork.GuardianRobustness
