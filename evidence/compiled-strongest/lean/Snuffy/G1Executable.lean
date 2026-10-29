namespace Snuffy.G1Executable

universe u

inductive Command (α : Type u) where
  | read (id : Nat) : Command α
  | write (id : Nat) (val : α) : Command α
  | flush : Command α
deriving Repr, DecidableEq

inductive Event (α : Type u) where
  | ack (id : Nat) : Event α
  | update (id : Nat) (val : α) : Event α
  | fault (msg : String) : Event α
deriving Repr, DecidableEq

inductive Observation (α : Type u) where
  | recorded (id : Nat) (val : α) : Observation α
  | idle : Observation α
  | error (msg : String) : Observation α
deriving Repr, DecidableEq

structure SystemState (α : Type u) where
  store : Nat → α
  secure : Bool

def admitCommand {α : Type u} (cmd : Command α) (st : SystemState α) : Bool :=
  match cmd with
  | .read _ => true
  | .write _ _ => st.secure
  | .flush => true

def stepSystem {α : Type u} (cmd : Command α) (st : SystemState α) : Event α × SystemState α :=
  if admitCommand cmd st then
    match cmd with
    | .read id => (.ack id, st)
    | .write id val =>
      let newStore := fun n => if n == id then val else st.store n
      (.update id val, { st with store := newStore })
    | .flush => (.ack 0, { st with secure := true })
  else
    (.fault "Command rejected by G1 admission filter", st)

def observe {α : Type u} (ev : Event α) (st : SystemState α) : Observation α :=
  match ev with
  | .ack id => .recorded id (st.store id)
  | .update id val => .recorded id val
  | .fault msg => .error msg

def executeCommand {α : Type u} (cmd : Command α) (st : SystemState α) : Observation α × SystemState α :=
  let (ev, st') := stepSystem cmd st
  let obs := observe ev st'
  (obs, st')

theorem g1_admission_soundness {α : Type u} (cmd : Command α) (st : SystemState α) :
    admitCommand cmd st = true →
    ∃ (ev : Event α) (st' : SystemState α), stepSystem cmd st = (ev, st') := by
  intro h
  unfold stepSystem
  rw [h]
  cases cmd with
  | read id =>
    exact ⟨.ack id, st, rfl⟩
  | write id val =>
    exact ⟨.update id val, { st with store := fun n => if n == id then val else st.store n }, rfl⟩
  | flush =>
    exact ⟨.ack 0, { st with secure := true }, rfl⟩

end Snuffy.G1Executable