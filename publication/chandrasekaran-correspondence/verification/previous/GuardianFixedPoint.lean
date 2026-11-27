/- Standalone constructive transport lemmas; replay pending. -/
namespace GuardianFixedPoint
universe u v

def Fixed {A : Type u} (f : A → A) (g : A) : Prop := f g = g

def iterate {A : Type u} (f : A → A) : Nat → A → A
  | 0, x => x
  | n+1, x => f (iterate f n x)

structure Correspondence (A : Type u) (B : Type v) where
  forward : A → B
  back : B → A
  leftInv : ∀ a, back (forward a) = a
  rightInv : ∀ b, forward (back b) = b

theorem transport_fixed {A : Type u} {B : Type v}
    (J : Correspondence A B) (f : A → A) (g : B → B)
    (h : ∀ a, J.forward (f a) = g (J.forward a)) (x : A) :
    Fixed f x ↔ Fixed g (J.forward x) := by
  constructor
  · intro hx
    change f x = x at hx
    change g (J.forward x) = J.forward x
    rw [← h x, hx]
  · intro hx
    change g (J.forward x) = J.forward x at hx
    change f x = x
    have he : J.forward (f x) = J.forward x := (h x).trans hx
    have hb := congrArg J.back he
    simp only [J.leftInv] at hb
    exact hb

theorem transport_unique {A : Type u} {B : Type v}
    (J : Correspondence A B) (f : A → A) (g : B → B)
    (h : ∀ a, J.forward (f a) = g (J.forward a)) (x : A)
    (hx : Fixed f x) (hu : ∀ a, Fixed f a → a = x) :
    Fixed g (J.forward x) ∧ ∀ b, Fixed g b → b = J.forward x := by
  constructor
  · exact (transport_fixed J f g h x).mp hx
  · intro b hb
    have hh : Fixed g (J.forward (J.back b)) := by rw [J.rightInv]; exact hb
    have ha := hu (J.back b) ((transport_fixed J f g h (J.back b)).mpr hh)
    calc
      b = J.forward (J.back b) := (J.rightInv b).symm
      _ = J.forward x := congrArg J.forward ha

theorem transport_iterates {A : Type u} {B : Type v}
    (J : Correspondence A B) (f : A → A) (g : B → B)
    (h : ∀ a, J.forward (f a) = g (J.forward a)) (n : Nat) (x : A) :
    J.forward (iterate f n x) = iterate g n (J.forward x) := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change J.forward (f (iterate f n x)) = g (iterate g n (J.forward x))
    rw [h, ih]

-- A safe predicate must be independently invariant, not merely transported.
theorem safety_along_orbit {A : Type u} (f : A → A) (safe : A → Prop)
    (preserve : ∀ a, safe a → safe (f a)) (x : A) (hx : safe x) (n : Nat) :
    safe (iterate f n x) := by
  induction n with
  | zero => exact hx
  | succ n ih => exact preserve (iterate f n x) ih

-- Classical reversible extension of a reset: keep the former bit in the record.
def swap (x : Bool × Bool) : Bool × Bool := (x.2, x.1)
theorem swap_involution (x : Bool × Bool) : swap (swap x) = x := by
  cases x; rfl

theorem reset_keeps_record (x : Bool) : swap (x, false) = (false, x) := rfl

#print axioms transport_fixed
#print axioms transport_unique
#print axioms transport_iterates
#print axioms safety_along_orbit
#print axioms swap_involution
#print axioms reset_keeps_record
end GuardianFixedPoint
