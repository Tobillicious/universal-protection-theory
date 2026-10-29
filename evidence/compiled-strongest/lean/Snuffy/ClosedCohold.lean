namespace CodexCohold
universe u v w

/-- R specifies the model's co-hold obligations; it is not inferred from a physical system here. -/
inductive Reach {N : Type u} (R : N → N → Prop) (seed : N → Prop) : N → Prop
  | initial (x) : seed x → Reach R seed x
  | edge (x y) : Reach R seed x → R x y → Reach R seed y

def Closed {N : Type u} (R : N → N → Prop) (C : N → Prop) : Prop :=
  ∀ x, C x → ∀ y, R x y → C y

theorem reachable_closed {N : Type u} (R : N → N → Prop) (seed : N → Prop) :
    Closed R (Reach R seed) := fun x hx y hxy => Reach.edge x y hx hxy

theorem reachable_least {N : Type u} (R : N → N → Prop) (seed C : N → Prop)
    (contains : ∀ x, seed x → C x) (closed : Closed R C) :
    ∀ x, Reach R seed x → C x := by
  intro x hx
  induction hx with
  | initial x hs => exact contains x hs
  | edge x y _ hxy ih => exact closed x ih y hxy

/-- An explicitly factorised joint transition provides a conditional closed component. -/
def iter {S : Type u} (f : S → S) : Nat → S → S
  | 0, s => s
  | n+1, s => iter f n (f s)

def active : List Bool → Nat
  | [] => 0
  | true :: w => active w
  | false :: w => active w + 1

def run {S : Type u} {E : Type v} (f : S → S) (g : E → E) : S × E → List Bool → S × E
  | z, [] => z
  | (s,e), p :: w => run f g ((if p then s else f s), g e) w

/-- The held component advances on its own active ticks; the independent outside advances every tick. -/
theorem factorised_cohold {S : Type u} {E : Type v} (f : S → S) (g : E → E) :
    ∀ word s e, run f g (s,e) word = (iter f (active word) s, iter g word.length e) := by
  intro word
  induction word with
  | nil => intro s e; rfl
  | cons p word ih =>
    intro s e
    cases p with
    | false => exact ih (f s) (g e)
    | true => exact ih s (g e)

def trace {S : Type u} {E : Type v} (f : S → S) (g : E → E) : S × E → List Bool → List (S × E)
  | _, [] => []
  | (s,e), p :: w =>
    let next := ((if p then s else f s), g e)
    next :: trace f g next w

def outsideTrace {E : Type v} (g : E → E) : Nat → E → List E
  | 0, _ => []
  | n+1, e => g e :: outsideTrace g n (g e)

/-- Literal outside state traces agree at every global tick, under the factorisation premise. -/
theorem outside_unchanged {S : Type u} {E : Type v} (f : S → S) (g : E → E) :
    ∀ word s e, (trace f g (s,e) word).map Prod.snd = outsideTrace g word.length e := by
  intro word
  induction word with
  | nil => intro s e; rfl
  | cons p word ih =>
    intro s e
    show g e :: (trace f g ((if p then s else f s),g e) word).map Prod.snd = _
    rw [ih]
    rfl

-- This factorisation is an actual premise: a boundary crossing can expose the hold.
def coupled (s e : Nat) : Nat × Nat := (s+1,e+s)
def coupledHold (s e : Nat) : Nat × Nat := (s,e+s)
theorem crossing_boundary_changes_outside_later :
    (coupled (coupled 0 0).1 (coupled 0 0).2).2 ≠
    (coupled (coupledHold 0 0).1 (coupledHold 0 0).2).2 := by decide

end CodexCohold
