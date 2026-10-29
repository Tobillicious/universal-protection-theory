namespace Snuffy.TemporalSafety

inductive Command (α : Type) where
  | read (id : Nat) : Command α
  | write (id : Nat) (val : α) : Command α
  | flush : Command α

structure SystemState (α : Type) where
  store : Nat → α
  secure : Bool

def admitCommand {α : Type} (cmd : Command α) (st : SystemState α) : Bool :=
  match cmd with
  | .read _ => true
  | .write _ _ => st.secure
  | .flush => true

def stepSecure {α : Type} (cmd : Command α) (st : SystemState α) : SystemState α :=
  if admitCommand cmd st then
    match cmd with
    | .read _ => st
    | .write _ _ => st
    | .flush => { st with secure := true }
  else
    st

theorem admit_of_secure {α : Type} (cmd : Command α) (st : SystemState α) (h : st.secure = true) :
    admitCommand cmd st = true := by
  cases cmd <;> simp [admitCommand, h]

theorem secure_preserved {α : Type} (cmd : Command α) (st : SystemState α) (h : st.secure = true) :
    (stepSecure cmd st).secure = true := by
  have hadm := admit_of_secure cmd st h
  unfold stepSecure
  simp [hadm]
  cases cmd <;> simp [h]

def runTrace {α : Type} : List (Command α) → SystemState α → SystemState α
  | [], st => st
  | c :: cs, st => runTrace cs (stepSecure c st)

theorem trace_secure {α : Type} (cmds : List (Command α)) (st : SystemState α) (h : st.secure = true) :
    (runTrace cmds st).secure = true := by
  induction cmds generalizing st with
  | nil =>
      simp [runTrace, h]
  | cons c cs ih =>
      simp [runTrace]
      have h' := secure_preserved c st h
      exact ih _ h'

end Snuffy.TemporalSafety