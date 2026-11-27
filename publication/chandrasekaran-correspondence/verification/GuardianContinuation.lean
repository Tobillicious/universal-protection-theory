/- Constructive greatest safe nonterminal fixed point. Standalone Lean 4; replay pending. -/
namespace GuardianContinuation
universe u
variable {S : Type u}

def StepOp (T : S → S → Prop) (safe : S → Prop) (X : S → Prop) (s : S) : Prop :=
  safe s ∧ (∃ t, T s t) ∧ (∀ t, T s t → X t)

def Postfixed (T : S → S → Prop) (safe X : S → Prop) : Prop :=
  ∀ s, X s → StepOp T safe X s

def Guardian (T : S → S → Prop) (safe : S → Prop) (s : S) : Prop :=
  ∃ X : S → Prop, Postfixed T safe X ∧ X s

theorem monotone (T : S → S → Prop) (safe X Y : S → Prop)
    (h : ∀ s, X s → Y s) (s : S) :
    StepOp T safe X s → StepOp T safe Y s := by
  intro hs
  exact ⟨hs.1, hs.2.1, fun t ht => h t (hs.2.2 t ht)⟩

theorem guardian_postfixed (T : S → S → Prop) (safe : S → Prop) :
    Postfixed T safe (Guardian T safe) := by
  intro s hs
  obtain ⟨X, hx, hxs⟩ := hs
  exact monotone T safe X (Guardian T safe) (fun t ht => ⟨X, hx, ht⟩) s (hx s hxs)

theorem guardian_fixed (T : S → S → Prop) (safe : S → Prop) (s : S) :
    Guardian T safe s ↔ StepOp T safe (Guardian T safe) s := by
  constructor
  · exact guardian_postfixed T safe s
  · intro h
    refine ⟨StepOp T safe (Guardian T safe), ?_, h⟩
    intro a ha
    exact monotone T safe (Guardian T safe) (StepOp T safe (Guardian T safe))
      (guardian_postfixed T safe) a ha

theorem guardian_greatest (T : S → S → Prop) (safe X : S → Prop)
    (h : Postfixed T safe X) (s : S) (hs : X s) : Guardian T safe s :=
  ⟨X, h, hs⟩

theorem no_common_output (f : S → S) (inj : ∀ a b, f a = f b → a = b)
    (a b : S) (hne : a ≠ b) : f a ≠ f b := by
  intro h
  exact hne (inj a b h)

theorem safe_successor (T : S → S → Prop) (safe : S → Prop)
    (s : S) (hs : Guardian T safe s) : ∃ t, T s t ∧ Guardian T safe t := by
  have h := guardian_postfixed T safe s hs
  obtain ⟨t, ht⟩ := h.2.1
  exact ⟨t, ht, h.2.2 t ht⟩

#print axioms guardian_fixed
#print axioms guardian_greatest
#print axioms safe_successor
#print axioms no_common_output
end GuardianContinuation
