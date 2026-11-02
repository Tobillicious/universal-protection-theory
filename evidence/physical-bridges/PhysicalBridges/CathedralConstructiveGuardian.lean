import PhysicalBridges.CathedralCutGuardianCriterion

/-!
CATHEDRAL CONSTRUCTIVE GUARDIAN — the fibre-common guardian as a program.

The published cut-guardian iff (`CathedralCutGuardianCriterion`) is an
existence proof: its policy is selected by `Classical.choice`, and the axiom
audit records that. In the finite decidable setting the selection needs no
choice. This module constructs the policy by Boolean search over explicit
enumerations of states and actions and proves it correct: `swarmPolicy` is a
total, structurally-recursive definition (no `noncomputable`), and
`computable_cut_guardian` shows it satisfies `ExistsCutGuardian` under the
same fibre-common certificate.

Axiom target: no `Classical.choice`, no `sorryAx` — the audit block at the
end records what remains. The construction itself is choice-free.
-/

namespace PhysicalBridges.CathedralConstructiveGuardian

universe u v w

open CathedralCutGuardianCriterion

/-! ### Boolean list utilities (core only) -/

/-- Boolean "for every element of the list". -/
def listAll {S : Type u} (p : S → Bool) : List S → Bool
  | [] => true
  | s :: l => p s && listAll p l

theorem listAll_true {S : Type u} {p : S → Bool} {l : List S}
    (h : listAll p l = true) : ∀ s ∈ l, p s = true := by
  induction l with
  | nil => intro s hs; cases hs
  | cons a l ih =>
      intro t ht
      simp only [listAll, Bool.and_eq_true] at h
      cases ht with
      | head => exact h.1
      | tail _ hmem => exact ih h.2 t hmem

theorem listAll_intro {S : Type u} {p : S → Bool} {l : List S}
    (h : ∀ s ∈ l, p s = true) : listAll p l = true := by
  induction l with
  | nil => rfl
  | cons a l ih =>
      have h1 : p a = true := h a (List.mem_cons_self ..)
      have h2 : listAll p l = true :=
        ih (fun x hx => h x (List.mem_cons_of_mem _ hx))
      simp [listAll, h1, h2]

/-- Boolean "first element passing the test". -/
def findFirst {A : Type v} (test : A → Bool) : List A → Option A
  | [] => none
  | a :: l => cond (test a) (some a) (findFirst test l)

theorem findFirst_some {A : Type v} {test : A → Bool} {l : List A} {a : A}
    (h : findFirst test l = some a) : test a = true := by
  induction l with
  | nil => simp [findFirst] at h
  | cons a' l ih =>
      simp only [findFirst] at h
      cases htest : test a' with
      | true =>
          have h1 : some a' = some a := by simpa [htest] using h
          have h2 : a' = a := Option.some.inj h1
          subst h2
          exact htest
      | false => simp only [htest] at h; exact ih h

theorem findFirst_found {A : Type v} {test : A → Bool} {l : List A}
    (h : ∃ a, a ∈ l ∧ test a = true) :
    ∃ a, findFirst test l = some a ∧ test a = true := by
  induction l with
  | nil =>
      obtain ⟨a, ham, _⟩ := h
      cases ham
  | cons a' l ih =>
      cases htest : test a' with
      | true => exact ⟨a', by simp [findFirst, htest], htest⟩
      | false =>
          have hex : ∃ x, x ∈ l ∧ test x = true := by
            obtain ⟨x, hx, hxt⟩ := h
            cases hx with
            | head => simp [htest] at hxt
            | tail _ hx' => exact ⟨x, hx', hxt⟩
          obtain ⟨x, hfind, hxt⟩ := ih hex
          refine ⟨x, ?_, hxt⟩
          simp only [findFirst, htest]
          exact hfind

/-! ### The constructive guardian -/

variable {S : Type u} {A : Type v} {O : Type w}

/-- Boolean guard test: `a` is allowed at `s`, and every enumerated state
that is a step-successor of `(s, a)` is protected. -/
def isGuard (allowed : S → A → Prop) (step : S → A → S → Prop) (P : S → Prop)
    (enumS : List S) (s : S) (a : A)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] : Bool :=
  decide (allowed s a) &&
    listAll (fun t => !(decide (step s a t) && !decide (P t))) enumS

theorem isGuard_iff (allowed : S → A → Prop) (step : S → A → S → Prop) (P : S → Prop)
    (enumS : List S) (s : S) (a : A)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] (henum : ∀ t, t ∈ enumS) :
    isGuard allowed step P enumS s a = true ↔
      allowed s a ∧ ∀ t, step s a t → P t := by
  constructor
  · intro h
    simp only [isGuard, Bool.and_eq_true] at h
    obtain ⟨h1, h2⟩ := h
    refine ⟨decide_eq_true_iff.mp h1, ?_⟩
    intro t hstep
    have ht := listAll_true h2 t (henum t)
    cases hs : decide (step s a t) with
    | false => exact absurd hstep (decide_eq_false_iff_not.mp hs)
    | true =>
        simp [hs] at ht
        exact ht
  · intro h
    have h1 : decide (allowed s a) = true := decide_eq_true_iff.mpr h.1
    have h2 : listAll (fun t => !(decide (step s a t) && !decide (P t))) enumS = true := by
      apply listAll_intro
      intro t hmem
      show (!(decide (step s a t) && !decide (P t))) = true
      cases hs : decide (step s a t) with
      | false => simp
      | true =>
          have ht : P t := h.2 t (decide_eq_true_iff.mp hs)
          simp [decide_eq_true_iff.mpr ht]
    show (decide (allowed s a) &&
      listAll (fun t => !(decide (step s a t) && !decide (P t))) enumS) = true
    rw [h1, h2]
    rfl

/-- Boolean fibre test: action `a` guards every enumerated protected state
reading `o`. -/
def fibreOk (allowed : S → A → Prop) (step : S → A → S → Prop) (P : S → Prop)
    (observe : S → O) (enumS : List S) (a : A) (o : O)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] [DecidableEq O] : Bool :=
  listAll (fun s => !(decide (observe s = o) && decide (P s)) ||
    isGuard allowed step P enumS s a) enumS

theorem fibreOk_iff (allowed : S → A → Prop) (step : S → A → S → Prop) (P : S → Prop)
    (observe : S → O) (enumS : List S) (a : A) (o : O)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] [DecidableEq O] (henum : ∀ s, s ∈ enumS) :
    fibreOk allowed step P observe enumS a o = true ↔
      ∀ s, observe s = o → P s → isGuard allowed step P enumS s a = true := by
  constructor
  · intro h s hobs hp
    have ht := listAll_true h s (henum s)
    cases hb : decide (observe s = o) with
    | false => exact absurd hobs (decide_eq_false_iff_not.mp hb)
    | true =>
        cases hp' : decide (P s) with
        | false => exact absurd hp (decide_eq_false_iff_not.mp hp')
        | true =>
            simp [hb, hp'] at ht
            exact ht
  · intro h
    apply listAll_intro
    intro s hmem
    cases hb : decide (observe s = o) with
    | false => simp
    | true =>
        cases hp' : decide (P s) with
        | false => simp
        | true =>
            have hx := h s (decide_eq_true_iff.mp hb) (decide_eq_true_iff.mp hp')
            simp [hx]

/-- The constructive guardian policy: total, structurally recursive,
choice-free. For each cut value it returns the first enumerated action whose
fibre test passes, or the default action when none does. -/
def swarmPolicy (allowed : S → A → Prop) (step : S → A → S → Prop) (P : S → Prop)
    (observe : S → O) (enumS : List S) (enumA : List A) (o : O)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] [DecidableEq O] [Inhabited A] : A :=
  match findFirst (fibreOk allowed step P observe enumS · o) enumA with
  | some a => a
  | none => default

theorem swarmPolicy_correct (allowed : S → A → Prop) (step : S → A → S → Prop) (P : S → Prop)
    (observe : S → O) (enumS : List S) (enumA : List A) (o : O)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] [DecidableEq O] [Inhabited A]
    (henumS : ∀ s, s ∈ enumS) (henumA : ∀ a, a ∈ enumA)
    (hfibres : FibreHasGuard observe step allowed P) :
    ∀ s, observe s = o → P s →
      allowed s (swarmPolicy allowed step P observe enumS enumA o) ∧
      ∀ t, step s (swarmPolicy allowed step P observe enumS enumA o) t → P t := by
  have hex : ∃ a, a ∈ enumA ∧
      fibreOk allowed step P observe enumS a o = true := by
    obtain ⟨a, ha⟩ := hfibres o
    refine ⟨a, henumA a, ?_⟩
    exact (fibreOk_iff allowed step P observe enumS a o henumS).mpr
      (fun s hobs hp => (isGuard_iff allowed step P enumS s a henumS).mpr (ha s hobs hp))
  obtain ⟨a, hfind, htest⟩ := findFirst_found hex
  have hpol : swarmPolicy allowed step P observe enumS enumA o = a := by
    simp [swarmPolicy, hfind]
  intro s hobs hp
  rw [hpol]
  exact isGuard_iff allowed step P enumS s a henumS |>.mp
    ((fibreOk_iff allowed step P observe enumS a o henumS).mp htest s hobs hp)

/-- THE CONSTRUCTIVE CUT GUARDIAN: under the same fibre-common certificate
as the published iff, the constructed policy satisfies `ExistsCutGuardian`.
Unlike the classical selection, `swarmPolicy` is a program: total,
structural, and choice-free. -/
theorem computable_cut_guardian (allowed : S → A → Prop) (step : S → A → S → Prop)
    (P : S → Prop) (observe : S → O) (enumS : List S) (enumA : List A)
    [(s : S) → (a : A) → Decidable (allowed s a)] [∀ (s : S) (a : A) (t : S), Decidable (step s a t)]
    [DecidablePred P] [DecidableEq O] [Inhabited A]
    (henumS : ∀ s, s ∈ enumS) (henumA : ∀ a, a ∈ enumA)
    (hfibres : FibreHasGuard observe step allowed P) :
    ExistsCutGuardian observe step allowed P := by
  refine ⟨fun o => swarmPolicy allowed step P observe enumS enumA o, ?_⟩
  intro s hp
  exact swarmPolicy_correct allowed step P observe enumS enumA (observe s)
    henumS henumA hfibres s rfl hp

/-! ### Axiom audit -/

#print axioms listAll_true
#print axioms listAll_intro
#print axioms findFirst_some
#print axioms findFirst_found
#print axioms isGuard_iff
#print axioms fibreOk_iff
#print axioms swarmPolicy_correct
#print axioms computable_cut_guardian

end PhysicalBridges.CathedralConstructiveGuardian
