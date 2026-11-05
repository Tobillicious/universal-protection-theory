import Snuffy.Law

/-!
CATHEDRAL-INTRINSIC-STANDING: source-aligned mathematical COROLLARY candidates.
No new axioms, no canon modifications. Uncompiled in this environment.
Embedding reflection is an independent, strong hypothesis.
-/

universe u

namespace Cathedral.IntrinsicStanding

/-- Scope does not change under any injection of a subject into a larger
    mathematical domain. This is stronger than ordinary forward naturality. -/
def EmbeddingIndependent
    (Scope : (X : Type u) → Set X) : Prop :=
  ∀ (X Y : Type u) (f : X → Y),
    Function.Injective f →
    ∀ x : X, x ∈ Scope X ↔ f x ∈ Scope Y

private theorem singleton_injection {Y : Type u} (b : Y) :
    Function.Injective (fun _ : PUnit.{u} => b) := by
  intro x y _
  exact Subsingleton.elim x y

/-- One member with intrinsic standing forces standing for every member
    of every mathematical domain. -/
theorem one_anchor_implies_universal
    (Scope : (X : Type u) → Set X)
    (hreflect : EmbeddingIndependent Scope)
    {A : Type u} (a : A) (ha : a ∈ Scope A) :
    ∀ (Y : Type u) (b : Y), b ∈ Scope Y := by
  have hanchor : (PUnit.unit : PUnit.{u}) ∈ Scope PUnit := by
    exact ((hreflect PUnit A (fun _ => a)
      (singleton_injection a) PUnit.unit)).mpr ha
  intro Y b
  exact ((hreflect PUnit Y (fun _ => b)
    (singleton_injection b) PUnit.unit)).mp hanchor

/-- The only embedding-independent intrinsic standing assignments are the
    identically empty and identically full ones. -/
theorem empty_or_universal
    (Scope : (X : Type u) → Set X)
    (hreflect : EmbeddingIndependent Scope) :
    (∀ (X : Type u) (x : X), x ∈ Scope X) ∨
    (∀ (X : Type u) (x : X), x ∉ Scope X) := by
  classical
  by_cases h : ∃ (A : Type u) (a : A), a ∈ Scope A
  · left
    obtain ⟨A, a, ha⟩ := h
    exact one_anchor_implies_universal Scope hreflect a ha
  · right
    intro X x hx
    exact h ⟨X, x, hx⟩

/-- The *already compiled* UPT Law.scope_guarantee_iff, instantiated on
    the all-subject domain supplied by the categorical theorem. This is
    only the source's stage-one no-needless-loss condition, not X3 physical
    installation or the original four-stage physical maximality law. -/
theorem original_scope_law_across_every_type
    (Scope : (X : Type u) → Set X)
    (hreflect : EmbeddingIndependent Scope)
    {A : Type u} (a : A) (ha : a ∈ Scope A)
    (Y : Type u) :
    ∀ (F : Set (Set Y)) (o : Set Y),
      Snuffy.Law.ProjMax (Scope Y) F o →
      ¬ Snuffy.Law.NeedlessLoss₁ F o := by
  have hfull : Scope Y = Set.univ := by
    apply Set.eq_univ_of_forall
    intro y
    exact one_anchor_implies_universal Scope hreflect a ha Y y
  exact (Snuffy.Law.scope_guarantee_iff (Scope Y)).mpr hfull

end Cathedral.IntrinsicStanding
