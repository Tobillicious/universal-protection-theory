import Snuffy.Composition

namespace Snuffy.G1FullDomain

inductive SourceDomain where
  | InternalEngine
  | ExternalUser
  | SubstrateTelemetry
  deriving Repr, DecidableEq

inductive FaultType where
  | None
  | EnvironmentalNoise
  | UncertifiedInjection
  | BoundaryViolation
  deriving Repr, DecidableEq

structure EventNode where
  eventId : Nat
  timestamp : Nat
  source : SourceDomain
  fault : FaultType
  isClosed : Bool
  deriving Repr, DecidableEq

abbrev EventTrace := List EventNode

def G1_Compliant (trace : EventTrace) : Prop :=
  ∀ e ∈ trace, e.fault ≠ FaultType.None → e.isClosed = false

def G1_FaultFree (e : EventNode) : Prop :=
  e.fault = FaultType.None

def G1_AllSourcesValid (trace : EventTrace) : Prop :=
  ∀ e ∈ trace, e.source = SourceDomain.InternalEngine ∨
               e.source = SourceDomain.ExternalUser ∨
               e.source = SourceDomain.SubstrateTelemetry

theorem g1_source_exhaustive (trace : EventTrace) (h : G1_AllSourcesValid trace) :
    ∀ e ∈ trace, e.source = SourceDomain.InternalEngine ∨
                 e.source = SourceDomain.ExternalUser ∨
                 e.source = SourceDomain.SubstrateTelemetry := h

theorem g1_fault_taxonomy_exhaustive (f : FaultType) :
    f = FaultType.None ∨ f = FaultType.EnvironmentalNoise ∨
    f = FaultType.UncertifiedInjection ∨ f = FaultType.BoundaryViolation := by
  cases f <;> simp

theorem g1_append_preserves (trace : EventTrace) (e : EventNode)
    (h_trace : G1_Compliant trace)
    (h_e : e.fault ≠ FaultType.None → e.isClosed = false) :
    G1_Compliant (trace ++ [e]) := by
  intro x hx
  rw [List.mem_append, List.mem_singleton] at hx
  rcases hx with h_in | h_eq
  · exact h_trace x h_in
  · subst h_eq
    exact h_e

/-- The live source state and its complete initial/input record are distinct
fields. The source step updates both independently. No hash replaces the
command or environmental payload. -/
structure JournalState (X C Ev : Type*) where
  initial : X
  live : X
  inputs : List (C × Ev)

def journalInit {X C Ev : Type*} (x : X) : JournalState X C Ev :=
  ⟨x, x, []⟩

def journalStep {X C Ev : Type*} (T : X → C → Ev → X)
    (s : JournalState X C Ev) (c : C) (e : Ev) : JournalState X C Ev :=
  { s with live := T s.live c e, inputs := s.inputs ++ [(c, e)] }

def replay {X C Ev : Type*} (T : X → C → Ev → X) (s : JournalState X C Ev) : X :=
  s.inputs.foldl (fun x ce => T x ce.1 ce.2) s.initial

def replayHistory {X C Ev : Type*} (T : X → C → Ev → X)
    (initial : X) (inputs : List (C × Ev)) : List X :=
  inputs.scanl (fun x ce => T x ce.1 ce.2) initial

/-- Replay is a derived invariant of the independently updated source.
Retiring recomputable caches retains the full initial state and every input. -/
theorem replay_journal_step {X C Ev : Type*} (T : X → C → Ev → X)
    (s : JournalState X C Ev) (c : C) (e : Ev) (h : replay T s = s.live) :
    replay T (journalStep T s c e) = (journalStep T s c e).live := by
  simpa only [replay, journalStep, List.foldl_append, List.foldl_cons,
    List.foldl_nil] using congrArg (fun x => T x c e) h

/-- The complete journal and the original live machine have the same states
and observations against every reactive controller and environment. Its
replay recovers the actual final live state at every step. -/
theorem journal_reactive_fidelity {X C Ev O : Type*} (T : X → C → Ev → X)
    (obs : X → O) (ctrl : List O → C) (env : List O → C → Ev) (x₀ : X) :
    ∀ k,
      let js := Snuffy.Composition.run (journalStep T)
        (fun s : JournalState X C Ev => obs s.live) ctrl env (journalInit x₀) k
      let xs := Snuffy.Composition.run T obs ctrl env x₀ k
      js.1.live = xs.1 ∧ js.2 = xs.2 ∧ replay T js.1 = js.1.live := by
  intro k
  have hlock := Snuffy.Composition.reactive_lockstep
    (fun s : JournalState X C Ev => s.live) (journalStep T) T
    (fun _ _ _ => rfl) (fun s => obs s.live) obs (fun _ => rfl)
    ctrl env (journalInit x₀) k
  refine ⟨hlock.1, hlock.2, ?_⟩
  clear hlock
  induction k with
  | zero => rfl
  | succ k ih =>
      exact replay_journal_step T _ _ _ ih

/-- A fixed-length full transcript contains the initial source label and
every command/environment pair, in order. -/
abbrev TranscriptAt (X C Ev : Type*) (N : ℕ) := X × (Fin N → C × Ev)

/-- The actual transcript alphabet gives its capacity. This counts the full
payload, rather than the length of an authenticator. -/
theorem transcript_capacity {X C Ev : Type*} [Fintype X] [Fintype C] [Fintype Ev]
    (N initialBits inputBits : ℕ)
    (hinit : Fintype.card X ≤ 2 ^ initialBits)
    (hinput : Fintype.card (C × Ev) ≤ 2 ^ inputBits) :
    Fintype.card (TranscriptAt X C Ev N) ≤ 2 ^ (initialBits + inputBits * N) := by
  calc
    _ = Fintype.card X * Fintype.card (C × Ev) ^ N := by
      simp [TranscriptAt]
    _ ≤ 2 ^ initialBits * (2 ^ inputBits) ^ N :=
      Nat.mul_le_mul hinit (pow_le_pow_left' hinput N)
    _ = _ := by rw [← pow_mul, ← pow_add]

end Snuffy.G1FullDomain
