/-! R14: an independently specified journal/sink/external-care boundary.

The joint machine and the three local machines are defined separately. The
commuting equations are proved by inspecting the actual commands, rather than
transporting an arbitrary transition through an injective account encoding.
Weather acts on the external subject's own resource, not a resident replica.
Arbitrary harmful commands are refused at the actuator. Physical breaches and
weather above the declared envelope are named exceptional events.

The last theorem removes arbitrarily many recruitment-label events from an
execution without changing any protected result. No recruitment-rate bound is
used for this protocol result. The machine is a source-level reference
realisation; its physical implementation must refine this transition relation.
-/
namespace UPTR14Boundary

structure St where
  floor : Nat
  usedJ : List Nat
  usedK : List Nat
  journal : List Nat
  sink : List Nat
  outsideStock : Nat
  outsideAlive : Bool
  compromised : Bool
  deriving DecidableEq, Repr

inductive Ev where
  | journal (generation nonce payload : Nat)
  | effect (generation nonce payload : Nat) (harmful : Bool)
  | raise (generation : Nat)
  | weather (demand : Nat)
  | recruit (identity : Nat) (allegiance : Bool)
  | breach
  deriving DecidableEq, Repr

def step (s : St) : Ev → St
  | .journal g n p =>
      if s.floor ≤ g ∧ n ∉ s.usedJ then
        {s with usedJ := n :: s.usedJ, journal := s.journal ++ [p]} else s
  | .effect g n p harmful =>
      if s.floor ≤ g ∧ n ∉ s.usedK ∧ harmful = false then
        {s with usedK := n :: s.usedK, sink := s.sink ++ [p]} else s
  | .raise g => {s with floor := max s.floor g}
  | .weather d =>
      {s with outsideStock := s.outsideStock + 4 - d, outsideAlive := s.outsideAlive && decide (d ≤ s.outsideStock + 4)}
  | .recruit _ _ => s
  | .breach => {s with outsideAlive := false, compromised := true}

def run : St → List Ev → St
  | s, [] => s
  | s, e :: es => run (step s e) es

def Safe (s : St) : Prop :=
  s.outsideAlive = true ∧ 1 ≤ s.outsideStock ∧ s.compromised = false

def Good : Ev → Prop
  | .weather d => d ≤ 4
  | .breach => False
  | _ => True

theorem safe_step (s : St) (e : Ev) (hs : Safe s) (he : Good e) : Safe (step s e) := by
  obtain ⟨ha, hc, hi⟩ := hs
  cases e with
  | journal g n p => simp only [step]; split <;> exact ⟨ha, hc, hi⟩
  | effect g n p h => simp only [step]; split <;> exact ⟨ha, hc, hi⟩
  | raise g => exact ⟨ha, hc, hi⟩
  | weather d =>
      have hd : d ≤ 4 := he
      have hr : d ≤ s.outsideStock + 4 := by omega
      refine ⟨?_, ?_, hi⟩
      · simp [step, ha, hr]
      · change 1 ≤ s.outsideStock + 4 - d
        omega
  | recruit i b => exact ⟨ha, hc, hi⟩
  | breach => exact False.elim he

theorem every_good_trace_safe (s : St) (es : List Ev) (hs : Safe s)
    (he : ∀ e ∈ es, Good e) : Safe (run s es) := by
  induction es generalizing s with
  | nil => exact hs
  | cons e es ih =>
      exact ih (step s e) (safe_step s e hs (he e (by simp)))
        (fun x hx => he x (by simp [hx]))

structure J where
  floor : Nat
  used : List Nat
  log : List Nat
  deriving DecidableEq, Repr

def projectJ (s : St) : J := ⟨s.floor, s.usedJ, s.journal⟩
def jStep (s : J) : Ev → J
  | .journal g n p =>
      if s.floor ≤ g ∧ n ∉ s.used then {s with used := n :: s.used, log := s.log ++ [p]} else s
  | .raise g => {s with floor := max s.floor g}
  | _ => s

def projectK (s : St) : J := ⟨s.floor, s.usedK, s.sink⟩
def kStep (s : J) : Ev → J
  | .effect g n p harmful =>
      if s.floor ≤ g ∧ n ∉ s.used ∧ harmful = false then
        {s with used := n :: s.used, log := s.log ++ [p]} else s
  | .raise g => {s with floor := max s.floor g}
  | _ => s

structure Outside where
  stock : Nat
  alive : Bool
  deriving DecidableEq, Repr

def projectOutside (s : St) : Outside := ⟨s.outsideStock, s.outsideAlive⟩
def outsideStep (s : Outside) : Ev → Outside
  | .weather d => ⟨s.stock + 4 - d, s.alive && decide (d ≤ s.stock + 4)⟩
  | .breach => {s with alive := false}
  | _ => s

theorem journal_commutes (s : St) (e : Ev) : projectJ (step s e) = jStep (projectJ s) e := by
  cases e with
  | journal g n p =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedJ <;> simp [step, projectJ, jStep, h]
  | effect g n p b =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedK ∧ b = false <;> simp [step, projectJ, jStep, h]
  | raise g => rfl
  | weather d => rfl
  | recruit i b => rfl
  | breach => rfl

theorem sink_commutes (s : St) (e : Ev) : projectK (step s e) = kStep (projectK s) e := by
  cases e with
  | journal g n p =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedJ <;> simp [step, projectK, kStep, h]
  | effect g n p b =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedK ∧ b = false <;> simp [step, projectK, kStep, h]
  | raise g => rfl
  | weather d => rfl
  | recruit i b => rfl
  | breach => rfl

theorem outside_commutes (s : St) (e : Ev) :
    projectOutside (step s e) = outsideStep (projectOutside s) e := by
  cases e with
  | journal g n p =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedJ <;> simp [step, projectOutside, outsideStep, h]
  | effect g n p b =>
      by_cases h : s.floor ≤ g ∧ n ∉ s.usedK ∧ b = false <;> simp [step, projectOutside, outsideStep, h]
  | raise g => rfl
  | weather d => rfl
  | recruit i b => rfl
  | breach => rfl

theorem harmful_effect_refused (s : St) (g n p : Nat) :
    step s (.effect g n p true) = s := by simp [step]

theorem old_generation_refused (s : St) (g n p : Nat) (hg : g < s.floor) :
    step s (.effect g n p false) = s := by
  simp [step, Nat.not_le_of_gt hg]

theorem external_weather_is_not_a_replica_fault (s : St) (d : Nat) :
    (step s (.weather d)).journal = s.journal ∧
    (step s (.weather d)).sink = s.sink ∧
    (step s (.weather d)).compromised = s.compromised := ⟨rfl, rfl, rfl⟩

def isRecruit : Ev → Bool
  | .recruit _ _ => true
  | _ => false

theorem recruitment_erasure (s : St) (es : List Ev) :
    run s es = run s (es.filter (fun e => !isRecruit e)) := by
  induction es generalizing s with
  | nil => rfl
  | cons e es ih =>
      cases e <;> simp [run, isRecruit, ih, step]

theorem recruitment_never_ends_care (s : St) (i : Nat) (b : Bool) :
    step s (.recruit i b) = s := rfl

theorem failure_has_a_named_exception (s : St) (es : List Ev) (hs : Safe s)
    (hbad : ¬ Safe (run s es)) : ∃ e ∈ es, ¬ Good e := by
  classical
  apply Classical.byContradiction
  intro h
  apply hbad
  apply every_good_trace_safe s es hs
  intro e he
  apply Classical.byContradiction
  intro hn
  exact h ⟨e, he, hn⟩

end UPTR14Boundary

