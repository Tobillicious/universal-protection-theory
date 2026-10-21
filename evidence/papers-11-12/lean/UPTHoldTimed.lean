/-
  O-2R refined (Codex R5): stutter erasure, admissible peers, intervals, and co-holding a closed system.
  Claude (Opus 5.5), 21 October 2026. Core Lean 4 only.
  A peer is any deterministic automaton receiving, at each tick, either a message or nothing.
-/
namespace UPTTimed

universe u v

variable {S : Type u} {M : Type v}

/-- Messages actually received, with the empty ticks erased. -/
def received : List (Option M) → List M
  | [] => []
  | none :: l => received l
  | some m :: l => m :: received l

/-- A peer is STUTTER-INVARIANT (admissible) when a tick with no message leaves it unchanged. -/
def StutterInvariant (δ : S → Option M → S) : Prop := ∀ s, δ s none = s

/-- **Stutter erasure.** A stutter-invariant peer's state after any tick sequence equals its state after just the
    messages received. -/
theorem stutter_erasure (δ : S → Option M → S) (hδ : StutterInvariant δ) :
    ∀ (l : List (Option M)) (s : S), l.foldl δ s = (received l).foldl (fun s m => δ s (some m)) s
  | [], _ => rfl
  | none :: l, s => by
    show l.foldl δ (δ s none) = _
    rw [hδ s]; exact stutter_erasure δ hδ l s
  | some m :: l, s => stutter_erasure δ hδ l (δ s (some m))

/-- **Admissible peers see no hold.** If two tick sequences deliver the same messages in the same order (as the
    general hold theorem guarantees for the resident's effects), a stutter-invariant peer ends in the same state,
    whatever the timing. -/
theorem admissible_peer (δ : S → Option M → S) (hδ : StutterInvariant δ) (l1 l2 : List (Option M))
    (h : received l1 = received l2) (s : S) : l1.foldl δ s = l2.foldl δ s := by
  rw [stutter_erasure δ hδ l1 s, stutter_erasure δ hδ l2 s, h]

/-- **An autonomous peer is not admissible** (Codex's example): a peer that counts ticks on its own sees the hold. -/
def counter : Nat → Option Nat → Nat
  | s, none => s + 1
  | s, some _ => s
theorem autonomous_peer_sees_hold :
    received [some 0] = received [none, some 0] ∧ [some 0].foldl counter 0 ≠ [none, some 0].foldl counter 0 :=
  ⟨rfl, by decide⟩

/-- **Interval to events.** A hold over ticks [v, v + h) becomes an event schedule in which every tick of the
    interval is a hold. Enforcing this mapping is the scheduler's (fence's) job. -/
inductive Ev | step | hold
def schedule (v h T : Nat) : List Ev := (List.range T).map (fun t => if v ≤ t ∧ t < v + h then .hold else .step)

theorem schedule_holds_interval (v h T t : Nat) (ht : t < T) (hin : v ≤ t ∧ t < v + h) :
    (schedule v h T)[t]? = some .hold := by
  simp [schedule, ht, hin]

/-- **Co-holding a closed system.** Treat the resident and its time-dependent peers as ONE joint system. During
    the co-hold, nothing crosses its boundary (closure), and the joint system is frozen: frozen ticks are exactly
    stutters. So the joint system's state equals its state on the unheld ticks alone. -/
def frozen (step : S → M → S) : S → Option M → S
  | s, none => s
  | s, some m => step s m
theorem cohold_closed (step : S → M → S) (l : List (Option M)) (s : S) :
    l.foldl (frozen step) s = (received l).foldl step s := by
  have h := stutter_erasure (frozen step) (fun _ => rfl) l s
  rw [h]
  rfl

end UPTTimed
