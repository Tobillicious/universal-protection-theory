/- Standalone Lean 4 companion. No imports beyond Lean's prelude.
   Mathematical transport only; no assertion of physical applicability.
   Replay pending: lean NullConeBridge.lean -/
namespace NullConeBridge
universe u v w

def InjectiveMap {A : Type u} {B : Type v} (f : A → B) : Prop :=
  ∀ ⦃a b⦄, f a = f b → a = b

structure Recovery (A : Type u) (B : Type v) where
  forward : A → B
  back : B → A
  leftInv : ∀ a, back (forward a) = a

theorem recovery_injective {A : Type u} {B : Type v} (r : Recovery A B) :
    InjectiveMap r.forward := by
  intro a b h
  calc
    a = r.back (r.forward a) := (r.leftInv a).symm
    _ = r.back (r.forward b) := congrArg r.back h
    _ = b := r.leftInv b

def compose {A : Type u} {B : Type v} {C : Type w}
    (r : Recovery A B) (s : Recovery B C) : Recovery A C where
  forward := fun a => s.forward (r.forward a)
  back := fun c => r.back (s.back c)
  leftInv := by
    intro a
    rw [s.leftInv, r.leftInv]

theorem predicate_transport {A : Type u} {B : Type v}
    (r : Recovery A B) (P : A → Prop) (a : A) :
    P (r.back (r.forward a)) ↔ P a := by rw [r.leftInv]

-- A finite reversible global evolution can erase a local record.
def swapPair : Bool × Bool → Bool × Bool := fun x => (x.2, x.1)
def swapRecovery : Recovery (Bool × Bool) (Bool × Bool) where
  forward := swapPair
  back := swapPair
  leftInv := by intro x; cases x; rfl

def localRead (x : Bool × Bool) : Bool := (swapPair x).1

theorem global_swap_local_collision :
    (true, false) ≠ (false, false) ∧
    localRead (true, false) = localRead (false, false) := by
  constructor
  · intro h
    have h' := congrArg Prod.fst h
    cases h'
  · rfl

inductive Duty where
  | continuity | authorization | freedom | restraint | maximality | provenance

-- Source predicates and independently meaningful actual predicates.
def AllSix {E : Type u} {P : Type v}
    (d : E → P → Duty → Prop) (e : E) (p : P) : Prop :=
  ∀ i, d e p i

theorem six_transport {E : Type u} {W : Type v} {P : Type w}
    (actual : E → Prop) (owed : E → P → Prop)
    (realizes : E → W → Prop)
    (source : W → P → Duty → Prop) (target : E → P → Duty → Prop)
    (coverage : ∀ e, actual e → ∃ w, realizes e w)
    (sourceTruth : ∀ e w p, actual e → owed e p → realizes e w → AllSix source w p)
    (reflection : ∀ e w p i, actual e → owed e p → realizes e w → source w p i → target e p i) :
    ∀ e p, actual e → owed e p → AllSix target e p := by
  intro e p ha ho i
  obtain ⟨w, hw⟩ := coverage e ha
  exact reflection e w p i ha ho hw (sourceTruth e w p ha ho hw i)

-- The same physical event and reversible dynamics cannot decide an
-- independent authorization proposition without a semantic premise.
theorem independent_authorization_countermodel :
    (∀ i : Duty, True) ∧ ¬ (∀ i : Duty, match i with
      | .authorization => False | _ => True) := by
  constructor
  · intro _; trivial
  · intro h; exact h Duty.authorization

#print axioms recovery_injective
#print axioms compose
#print axioms predicate_transport
#print axioms global_swap_local_collision
#print axioms six_transport
#print axioms independent_authorization_countermodel
end NullConeBridge
