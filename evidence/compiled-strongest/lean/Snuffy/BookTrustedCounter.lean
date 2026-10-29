/-! Ported from Paper 12 `evidence/papers-11-12/lean/modules/TrustedCounter.lean` (source sha256 `b5f8d7ec3d726d8c8f208c1355843aacc59a8a727ad75f368cb553cadb079743`).
Namespace renamed to `Snuffy.Book.TrustedCounter`; dependency imports and namespace references redirected to the canon. Inline `#print axioms` commands are removed here and every public theorem is audited by SummitsAudit. Statements and proofs unchanged. -/

namespace Snuffy.Book.TrustedCounter
universe u

/-- The event predicate is supplied by a trusted, complete event source. No hardware mapping is inferred. -/
def count {E : Type u} (forbidden : E → Bool) : List E → Nat
  | [] => 0
  | e :: es => (if forbidden e then 1 else 0) + count forbidden es

def clean {E : Type u} (forbidden : E → Bool) : List E → Prop
  | [] => True
  | e :: es => forbidden e = false ∧ clean forbidden es

theorem count_zero_iff_clean {E : Type u} (forbidden : E → Bool) :
    ∀ events, count forbidden events = 0 ↔ clean forbidden events
  | [] => by exact ⟨fun _ => trivial,fun _ => rfl⟩
  | e :: es => by
    have ih := count_zero_iff_clean forbidden es
    cases he : forbidden e with
    | false => simpa [count,clean,he] using ih
    | true => simp [count,clean,he]

/-- A protected non-wrapping cumulative counter catches every forbidden event in the interval, including
    an event followed by rollback of ordinary state. Coverage and protection are premises of its meaning. -/
theorem endpoint_counter_certificate {E : Type u} (forbidden : E → Bool) (events : List E) (before : Nat) :
    before + count forbidden events = before ↔ clean forbidden events := by
  constructor
  · intro h
    apply (count_zero_iff_clean forbidden events).mp
    omega
  · intro h
    rw [(count_zero_iff_clean forbidden events).mpr h,Nat.add_zero]

theorem count_append {E : Type u} (forbidden : E → Bool) :
    ∀ a b, count forbidden (a ++ b) = count forbidden a + count forbidden b
  | [], b => by simp [count]
  | e :: es, b => by
    simp only [List.cons_append,count,count_append forbidden es b,Nat.add_assoc]

theorem prefix_counter_monotone {E : Type u} (forbidden : E → Bool) (a b : List E) :
    count forbidden a ≤ count forbidden (a ++ b) := by
  rw [count_append]
  exact Nat.le_add_right _ _

/-- A bounded-width counter without a no-wrap certificate is not this natural-number monitor. -/
theorem wrapping_counter_misses_two :
    (0 + count id [true,true]) % 2 = 0 ∧ ¬ clean id [true,true] := by simp [count,clean]

/-- Dropping the forbidden event from the observed trace defeats the predicate even with an honest counter. -/
theorem missing_event_misses_violation :
    clean id ([] : List Bool) ∧ ¬ clean id [true] := by simp [clean]

end Snuffy.Book.TrustedCounter
