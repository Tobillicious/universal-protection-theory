import PhysicalBridges.CathedralInternalInscription

/-!
CATHEDRAL — Intrinsic atomic interpretation, not a global truth oracle.

The original three-position inscription predicate expressed only a
relation between nodes. This module advances to a finite *atomic
semantic protocol* where source/target, interpreter and description
token are positions in ONE AND THE SAME relational structure, and
the statement described is itself an instance of that very relation.

A token's relational code does NOT by definition imply its assertion
is true. Both accurate and inaccurate SELF-assertions are constructively
exhibited in one connected, relationally individuated, rootless web.

It is an existing mathematical construction, not a novel operator,
not an internal truth predicate for arbitrary Lean propositions,
not independent physical proof of BCRD, and not universal-X3 proof.
The mathematical definitions and proof still inhabit a metatheory.
The next problem is whether formal syntax and *its* interpretation
can be internalised in a sufficiently rich source theory without
unjustified truth/reflection assumptions.
-/

namespace PhysicalBridges.CathedralIntrinsicAtomicSemantics

open CathedralIntrinsicArticulation
universe u v
variable {P : Type u} {Q : Type v}

/-- An atomic assertion is represented by an INTERNAL token.
Its interpreter/speaker, token, and the two positions being described
are ALL elements of the same `P`, with only relations of ONE `w`.
The three coding edges do NOT include the asserted edge source→target.
Thus an internal claim can be false without breaking the code. -/
def AssertsLink (w : Web P)
    (speaker token source target : P) : Prop :=
  w.link speaker token ∧
  w.link token source ∧
  w.link target token

/-- Meaning of this *bounded atomic* proposition: the edge actually
exists according to the same `w`. No separate evaluator oracle. -/
def AtomHolds (w : Web P) (source target : P) : Prop :=
  w.link source target

def AccurateAtom (w : Web P)
    (speaker token source target : P) : Prop :=
  AssertsLink w speaker token source target ∧
    AtomHolds w source target

def InaccurateAtom (w : Web P)
    (speaker token source target : P) : Prop :=
  AssertsLink w speaker token source target ∧
    ¬ AtomHolds w source target

/-- The entire coded relation is transported, not just its labels.
Neither the speaker nor token is anchored to an exterior location. -/
theorem assertion_reindex
    (w : Web P) (f : Rename P Q)
    (speaker token source target : P) :
    AssertsLink (reindex w f)
      (f.forward speaker) (f.forward token)
      (f.forward source) (f.forward target) ↔
    AssertsLink w speaker token source target := by
  simp [AssertsLink, reindex, f.left_inverse]

theorem accuracy_reindex
    (w : Web P) (f : Rename P Q)
    (speaker token source target : P) :
    AccurateAtom (reindex w f)
      (f.forward speaker) (f.forward token)
      (f.forward source) (f.forward target) ↔
    AccurateAtom w speaker token source target := by
  simp [AccurateAtom, AssertsLink, AtomHolds,
    reindex, f.left_inverse]

theorem inaccuracy_reindex
    (w : Web P) (f : Rename P Q)
    (speaker token source target : P) :
    InaccurateAtom (reindex w f)
      (f.forward speaker) (f.forward token)
      (f.forward source) (f.forward target) ↔
    InaccurateAtom w speaker token source target := by
  simp [InaccurateAtom, AssertsLink, AtomHolds,
    reindex, f.left_inverse]

/-- A symmetry acts on all four internal positions at once;
semantic accuracy of the bounded relational proposition survives. -/
theorem accuracy_symmetry
    (w : Web P) (σ : Symmetry w)
    (speaker token source target : P) :
    AccurateAtom w
      (σ.perm.forward speaker) (σ.perm.forward token)
      (σ.perm.forward source) (σ.perm.forward target) ↔
    AccurateAtom w speaker token source target := by
  have h := accuracy_reindex w σ.perm
    speaker token source target
  -- Whole-web symmetry means reindexing describes the SAME link.
  have hEdges : ∀ a b : P,
      (reindex w σ.perm).link a b ↔ w.link a b := by
    intro a b
    have h0 := σ.respects (σ.perm.backward a)
      (σ.perm.backward b)
    simpa [reindex, σ.perm.right_inverse] using h0.symm
  unfold AccurateAtom AssertsLink AtomHolds
  constructor
  · rintro ⟨⟨h1,h2,h3⟩,h4⟩
    exact ⟨⟨(σ.respects speaker token).mp h1,
      (σ.respects token source).mp h2,
      (σ.respects target token).mp h3⟩,
      (σ.respects source target).mp h4⟩
  · rintro ⟨⟨h1,h2,h3⟩,h4⟩
    exact ⟨⟨(σ.respects speaker token).mpr h1,
      (σ.respects token source).mpr h2,
      (σ.respects target token).mpr h3⟩,
      (σ.respects source target).mpr h4⟩

/-- A four-position WEB: two binary coordinates are merely convenient
presentation labels. The source relation is the 4-cycle (Hamming
distance one), plus loops at nodes with first coordinate=false.
The graph is entirely within the same relational domain. -/
def balancedWeb : Web (Bool × Bool) where
  link := fun a b =>
    (a.1 = b.1 ∧ a.2 ≠ b.2) ∨
    (a.1 ≠ b.1 ∧ a.2 = b.2) ∨
    (a = b ∧ a.1 = false)

theorem true_internal_self_assertion :
    AccurateAtom balancedWeb
      (false, false) (true, false)
      (false, false) (false, false) := by
  simp [AccurateAtom, AssertsLink, AtomHolds, balancedWeb]

theorem false_internal_self_assertion :
    InaccurateAtom balancedWeb
      (true, false) (false, false)
      (true, false) (true, false) := by
  simp [InaccurateAtom, AssertsLink, AtomHolds, balancedWeb]

/-- No built-in requirement that a mathematical assertion carried by
an internal code is correct. The same one web supports both cases. -/
theorem one_web_has_true_and_false_self_assertions :
    (∃ p d : Bool × Bool, p ≠ d ∧
       AccurateAtom balancedWeb p d p p) ∧
    (∃ p d : Bool × Bool, p ≠ d ∧
       InaccurateAtom balancedWeb p d p p) := by
  constructor
  · exact ⟨(false,false), (true,false),
      by decide, true_internal_self_assertion⟩
  · exact ⟨(true,false), (false,false),
      by decide, false_internal_self_assertion⟩

theorem internal_assertions_not_automatically_true :
    ¬ ∀ (speaker token source target : Bool × Bool),
        AssertsLink balancedWeb speaker token source target →
        AtomHolds balancedWeb source target := by
  intro universal
  have hFalse := false_internal_self_assertion
  exact hFalse.2 (universal (true,false) (false,false)
    (true,false) (true,false) hFalse.1)

/-- A root-changing symmetry: flip the second coordinate everywhere;
the structural first-coordinate loop difference remains preserved.
No absolute label or privileged interpreter is introduced. -/
def flipSecond : Rename (Bool × Bool) (Bool × Bool) where
  forward := fun a => (a.1, !a.2)
  backward := fun a => (a.1, !a.2)
  left_inverse := by
    intro a
    cases a with
    | mk x y =>
      cases x <;> cases y <;> rfl
  right_inverse := by
    intro a
    cases a with
    | mk x y =>
      cases x <;> cases y <;> rfl

def flipSecondSymmetry : Symmetry balancedWeb where
  perm := flipSecond
  respects := by
    intro a b
    cases a with
    | mk ax ay =>
      cases b with
      | mk bx bz =>
        cases ax <;> cases ay <;> cases bx <;> cases bz <;>
          simp [balancedWeb, flipSecond]

theorem flipSecond_no_fixed_point :
    ∀ p : Bool × Bool, flipSecond.forward p ≠ p := by
  intro p
  cases p with
  | mk x y =>
    cases x <;> cases y <;> simp [flipSecond]

theorem balancedWeb_no_privileged_root :
    NoPrivilegedRoot balancedWeb := by
  intro h
  obtain ⟨p,hEvery⟩ := h
  exact flipSecond_no_fixed_point p (hEvery flipSecondSymmetry)

/-- A one-edge path and a specified two-edge path avoid any finite
decision procedure for the unbounded inductive path relation. -/
private theorem edgePath (a b : Bool × Bool)
    (h : balancedWeb.link a b) :
    Chain balancedWeb.link a b :=
  Chain.extend (Chain.refl a) h

private theorem twoPath (a mid b : Bool × Bool)
    (h1 : balancedWeb.link a mid)
    (h2 : balancedWeb.link mid b) :
    Chain balancedWeb.link a b :=
  Chain.extend (edgePath a mid h1) h2

theorem balancedWeb_connected : Connected balancedWeb := by
  intro a b
  cases a with
  | mk ax ay =>
    cases b with
    | mk bx bz =>
      cases ax <;> cases ay <;> cases bx <;> cases bz
      all_goals first
        | exact Chain.refl _
        | exact edgePath _ _ (by simp [balancedWeb])
        | exact twoPath _ (false,false) _
            (by simp [balancedWeb]) (by simp [balancedWeb])
        | exact twoPath _ (false,true) _
            (by simp [balancedWeb]) (by simp [balancedWeb])
        | exact twoPath _ (true,false) _
            (by simp [balancedWeb]) (by simp [balancedWeb])
        | exact twoPath _ (true,true) _
            (by simp [balancedWeb]) (by simp [balancedWeb])

/-- Every one of the four positions has a different adjacency profile
despite the existence of a fixed-point-free whole-web symmetry. -/
theorem balancedWeb_relationally_individuated :
    RelationallyIndividuated balancedWeb := by
  intro a b h
  have h0 := h (false,false)
  have h1 := h (false,true)
  have h2 := h (true,false)
  have h3 := h (true,true)
  cases a with
  | mk ax ay =>
    cases b with
    | mk bx bz =>
      cases ax <;> cases ay <;> cases bx <;> cases bz <;>
        simp_all [balancedWeb]

theorem balancedWeb_intrinsic_articulation :
    IntrinsicArticulation balancedWeb := by
  refine ⟨balancedWeb_connected, ?_, ?_, balancedWeb_no_privileged_root⟩
  · exact ⟨(false,false), (true,false), by decide⟩
  · exact balancedWeb_relationally_individuated

/-- The full result: different inner positions, accurate and inaccurate
SELF-assertion, relation-only individuation, connectedness, no fixed
privileged root, all in ONE source relation. This is a finite model,
not an external-truth-oracle elimination for unbounded mathematics. -/
theorem rooted_in_one_web_without_truth_oracle :
    IntrinsicArticulation balancedWeb ∧
    (∃ p d : Bool × Bool, p ≠ d ∧
       AccurateAtom balancedWeb p d p p) ∧
    (∃ p d : Bool × Bool, p ≠ d ∧
       InaccurateAtom balancedWeb p d p p) := by
  exact ⟨balancedWeb_intrinsic_articulation,
    one_web_has_true_and_false_self_assertions⟩

#print axioms assertion_reindex
#print axioms accuracy_reindex
#print axioms inaccuracy_reindex
#print axioms accuracy_symmetry
#print axioms one_web_has_true_and_false_self_assertions
#print axioms internal_assertions_not_automatically_true
#print axioms balancedWeb_intrinsic_articulation
#print axioms rooted_in_one_web_without_truth_oracle

end PhysicalBridges.CathedralIntrinsicAtomicSemantics
