/-! Ported from Book I v2.0.5, Paper 12 evidence (`evidence/papers-11-12/lean/UPTHold.lean`, sha256 `ebc34edb8e6d4649530f0b65604542f4c7af23a80ce21c0787bc8278b6c83b7a`).
Namespace `UPTHold` renamed to `Snuffy.Book.UPTHold` for the canon's joint audit; statements and proofs unchanged. -/

/-
  O-2R: the general faithful-hold refinement theorem. Claude (Opus 5.5), 21 October 2026. Core Lean 4 only.
  Any deterministic resident (any types), any INTERACTIVE environment (its next input depends on all effects
  delivered so far), and ANY finite schedule of steps, holds and crashes, interleaved arbitrarily.
  Protocol: durable-first log; fence (a hold executes nothing); crash recovery = replay of the log
  (reconstruction, R-REPLAY); atomic outbox (an effect is delivered exactly when its step is logged).
-/
namespace Snuffy.Book.UPTHold

universe u v w x

structure Cfg (S : Type u) (X : Type v) (Y : Type w) where
  s : S
  log : List X
  out : List Y

inductive Ev | step | hold | crash

variable {S : Type u} {X : Type v} {Y : Type w}

/-- Recovery: rebuild the state by replaying the durable log from the base state. -/
def replay (f : S → X → S) (s0 : S) (log : List X) : S := log.foldl f s0

/-- One protocol event. A step takes the environment's next input (from the delivered effects), logs it,
    executes, and delivers its effect atomically. A hold executes nothing. A crash rebuilds by replay. -/
def exec (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) (c : Cfg S X Y) : Ev → Cfg S X Y
  | .step => ⟨f c.s (g c.out), c.log ++ [g c.out], c.out ++ [eff (f c.s (g c.out))]⟩
  | .hold => c
  | .crash => ⟨replay f s0 c.log, c.log, c.out⟩

/-- The undisturbed run after n steps. -/
def ideal (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) : Nat → Cfg S X Y
  | 0 => ⟨s0, [], []⟩
  | n + 1 =>
    let c := ideal f eff g s0 n
    ⟨f c.s (g c.out), c.log ++ [g c.out], c.out ++ [eff (f c.s (g c.out))]⟩

def run (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) : Cfg S X Y → List Ev → Cfg S X Y
  | c, [] => c
  | c, e :: es => run f eff g s0 (exec f eff g s0 c e) es

def steps : List Ev → Nat
  | [] => 0
  | .step :: es => steps es + 1
  | .hold :: es => steps es
  | .crash :: es => steps es

/-- Replaying the undisturbed log reconstructs the undisturbed state. -/
theorem replay_ideal (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) :
    ∀ n, replay f s0 (ideal f eff g s0 n).log = (ideal f eff g s0 n).s
  | 0 => rfl
  | n + 1 => by
    show List.foldl f s0 ((ideal f eff g s0 n).log ++ [g (ideal f eff g s0 n).out]) = _
    rw [List.foldl_append]
    show f (List.foldl f s0 (ideal f eff g s0 n).log) (g (ideal f eff g s0 n).out) = _
    have ih := replay_ideal f eff g s0 n
    unfold replay at ih
    rw [ih]
    rfl

/-- A crash at an undisturbed configuration changes nothing. -/
theorem crash_ideal (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) (n : Nat) :
    exec f eff g s0 (ideal f eff g s0 n) .crash = ideal f eff g s0 n := by
  show (⟨replay f s0 (ideal f eff g s0 n).log, _, _⟩ : Cfg S X Y) = _
  rw [replay_ideal]

/-- **O-2R, the faithful-hold refinement theorem.** From any undisturbed configuration, ANY schedule of steps,
    holds and crashes ends exactly in the undisturbed configuration with the same number of steps. -/
theorem faithful (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) :
    ∀ (es : List Ev) (n : Nat), run f eff g s0 (ideal f eff g s0 n) es = ideal f eff g s0 (n + steps es)
  | [], n => rfl
  | .step :: es, n => by
    have ih := faithful f eff g s0 es (n + 1)
    have hn : n + 1 + steps es = n + (steps es + 1) := by omega
    rw [hn] at ih
    exact ih
  | .hold :: es, n => faithful f eff g s0 es n
  | .crash :: es, n => by
    show run f eff g s0 (exec f eff g s0 (ideal f eff g s0 n) .crash) es = _
    rw [crash_ideal]
    exact faithful f eff g s0 es n

/-- The held run from the start: same state, same LIVED HISTORY (the log), same delivered effects. -/
theorem faithful_from_start (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) (es : List Ev) :
    (run f eff g s0 (ideal f eff g s0 0) es).s = (ideal f eff g s0 (steps es)).s ∧
    (run f eff g s0 (ideal f eff g s0 0) es).log = (ideal f eff g s0 (steps es)).log ∧
    (run f eff g s0 (ideal f eff g s0 0) es).out = (ideal f eff g s0 (steps es)).out := by
  rw [faithful f eff g s0 es 0, Nat.zero_add]
  exact ⟨rfl, rfl, rfl⟩

/-- **Admissible environments.** Any observer that reads the resident only through its delivered effects (a
    peer, a sink, another resident's input) sees exactly the undisturbed history, under any schedule. -/
theorem admissible_observer {T : Type x} (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S)
    (h : List Y → T) (es : List Ev) :
    h (run f eff g s0 (ideal f eff g s0 0) es).out = h (ideal f eff g s0 (steps es)).out := by
  rw [(faithful_from_start f eff g s0 es).2.2]

/-- Exactly once: every delivered effect corresponds to exactly one lived step. -/
theorem ideal_lengths (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) :
    ∀ n, (ideal f eff g s0 n).out.length = n ∧ (ideal f eff g s0 n).log.length = n
  | 0 => ⟨rfl, rfl⟩
  | n + 1 => by
    have ih := ideal_lengths f eff g s0 n
    show ((ideal f eff g s0 n).out ++ _).length = n + 1 ∧ ((ideal f eff g s0 n).log ++ _).length = n + 1
    simp [List.length_append, ih.1, ih.2]

/-- Stop: a hold executes nothing (no state change, no logged step, no delivered effect). -/
theorem hold_executes_nothing (f : S → X → S) (eff : S → Y) (g : List Y → X) (s0 : S) (c : Cfg S X Y) :
    exec f eff g s0 c .hold = c := rfl


/-! ### Positive controls: each primitive is load-bearing (concrete counterexamples, decided by evaluation).
    Instance: states and inputs are Nat, f s x = s + x, every input is 1, the effect is the new state, s0 = 0. -/

def fN : Nat → Nat → Nat := fun s x => s + x
def effN : Nat → Nat := id
def gN : List Nat → Nat := fun _ => 1

/-- Mutant 1, recovery WITHOUT replay (the crash resets to the base state). -/
def execNoReplay (c : Cfg Nat Nat Nat) : Ev → Cfg Nat Nat Nat
  | .crash => ⟨0, c.log, c.out⟩
  | e => exec fN effN gN 0 c e

/-- Mutant 2, a hold that executes a step anyway (without logging it). -/
def execRunWhileHeld (c : Cfg Nat Nat Nat) : Ev → Cfg Nat Nat Nat
  | .hold => ⟨fN c.s (gN c.out), c.log, c.out ++ [effN (fN c.s (gN c.out))]⟩
  | e => exec fN effN gN 0 c e

/-- Mutant 3, a non-atomic sink: recovery re-delivers the last effect. -/
def execRedeliver (c : Cfg Nat Nat Nat) : Ev → Cfg Nat Nat Nat
  | .crash => ⟨replay fN 0 c.log, c.log, c.out ++ c.out.getLast?.toList⟩
  | e => exec fN effN gN 0 c e

def runWith (ex : Cfg Nat Nat Nat → Ev → Cfg Nat Nat Nat) : Cfg Nat Nat Nat → List Ev → Cfg Nat Nat Nat
  | c, [] => c
  | c, e :: es => runWith ex (ex c e) es

def start : Cfg Nat Nat Nat := ⟨0, [], []⟩

theorem mutant_no_replay_unfaithful :
    (runWith execNoReplay start [.step, .crash, .step]).s ≠ (ideal fN effN gN 0 2).s := by decide

theorem mutant_run_while_held_unfaithful :
    (runWith execRunWhileHeld start [.step, .hold, .step]).out ≠ (ideal fN effN gN 0 2).out := by decide

theorem mutant_redeliver_unfaithful :
    (runWith execRedeliver start [.step, .crash, .step]).out ≠ (ideal fN effN gN 0 2).out := by decide

/-- Mutant 4, an observer that reads TIMING (the number of events) instead of delivered effects is not
    admissible: a hold changes what it sees. Such a peer must be co-held. -/
theorem timing_observer_sees_the_hold :
    ([Ev.step] : List Ev).length ≠ ([Ev.hold, Ev.step] : List Ev).length := by decide

/-- And the faithful protocol on the same schedules matches the undisturbed run. -/
theorem faithful_instance :
    run fN effN gN 0 start [.step, .crash, .hold, .step] = ideal fN effN gN 0 2 :=
  faithful fN effN gN 0 [.step, .crash, .hold, .step] 0

end Snuffy.Book.UPTHold
