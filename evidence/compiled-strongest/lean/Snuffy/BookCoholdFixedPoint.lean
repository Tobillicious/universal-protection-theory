/-! Ported from Paper 12 `evidence/papers-11-12/lean/modules/CoholdFixedPoint.lean` (source sha256 `30cdc430d6edae14f1cdac66afa0d119fb26ace9aa50bb4621cb0a72da4f31e9`).
Namespace renamed to `Snuffy.Book.CoholdFixedPoint`; dependency imports and namespace references redirected to the canon. Inline `#print axioms` commands are removed here and every public theorem is audited by SummitsAudit. Statements and proofs unchanged. -/

namespace Snuffy.Book.CoholdFixedPoint
universe u

/-- Step(C) adds co-hold obligations. Its duration and dependency analysis are supplied by the model. -/
def Subset {N : Type u} (C D : N → Prop) : Prop := ∀ x, C x → D x

def Monotone {N : Type u} (F : (N → Prop) → N → Prop) : Prop :=
  ∀ C D, Subset C D → Subset (F C) (F D)

def Extensive {N : Type u} (F : (N → Prop) → N → Prop) : Prop :=
  ∀ C, Subset C (F C)

def iterate {N : Type u} (F : (N → Prop) → N → Prop) (seed : N → Prop) : Nat → N → Prop
  | 0 => seed
  | k+1 => F (iterate F seed k)

theorem iterate_contains_seed {N : Type u} (F : (N → Prop) → N → Prop) (ext : Extensive F)
    (seed : N → Prop) : ∀ k, Subset seed (iterate F seed k)
  | 0 => fun _ hx => hx
  | k+1 => fun x hx => ext _ x (iterate_contains_seed F ext seed k x hx)

theorem iterate_below_every_certificate {N : Type u}
    (F : (N → Prop) → N → Prop) (mono : Monotone F)
    (seed cert : N → Prop) (initial : Subset seed cert) (closed : Subset (F cert) cert) :
    ∀ k, Subset (iterate F seed k) cert
  | 0 => initial
  | k+1 => fun x hx => closed x (mono _ _ (iterate_below_every_certificate F mono seed cert initial closed k) x hx)

/-- Once the increasing iteration stabilises, it is the least certificate containing the seed. -/
theorem stabilised_least {N : Type u}
    (F : (N → Prop) → N → Prop) (mono : Monotone F)
    (ext : Extensive F)
    (seed : N → Prop) (k : Nat)
    (stable : ∀ x, F (iterate F seed k) x ↔ iterate F seed k x) :
    Subset seed (iterate F seed k) ∧ Subset (F (iterate F seed k)) (iterate F seed k) ∧
    ∀ cert, Subset seed cert → Subset (F cert) cert → Subset (iterate F seed k) cert := by
  refine ⟨iterate_contains_seed F ext seed k,fun x hx => (stable x).mp hx, ?_⟩
  intro cert initial closed
  exact iterate_below_every_certificate F mono seed cert initial closed k

/-- Any monotone certificate bill at the least solution is no larger than at a competing certificate.
    This is a statement inside the supplied model, not a physical lower bound. -/
theorem least_bill {N : Type u} (least cert : N → Prop) (h : Subset least cert)
    (bill : (N → Prop) → Nat) (mono : ∀ C D, Subset C D → bill C ≤ bill D) : bill least ≤ bill cert :=
  mono least cert h

end Snuffy.Book.CoholdFixedPoint
