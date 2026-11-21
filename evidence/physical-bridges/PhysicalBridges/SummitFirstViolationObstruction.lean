/-!
# The first-violation obstruction — decomposing the heart-bridge (not closing it)

**4 November 2026 · noncanonical · sharpens the open summit · no canon edit.**

This decomposes the heart-bridge (`ALL IS ⟹ no first X3 violation`) into two named,
independently attackable source-obligations. It does **not** close the summit — it relocates
the difficulty precisely and proves that one of the two pieces (enactment-necessity) does
genuine, irreducible work. Honesty discipline, three ways:

1. Non-circular: nothing assumes the actual action preserves X3; that is derived.
2. No admissibility-by-definition: there is NO "an X3-violating step is not an admissible
   morphism" definition (that would smuggle the conclusion into the source). The stronger
   structural route is left as an explicit *derived* obligation, never a definition.
3. No false confidence: `protection_feasible_but_not_enacted_still_violates` proves the
   enactment premise is not automatic — *optimal ⇏ inevitable*. Feasibility of protection is
   NOT enough; the enactment-necessity is a genuine, still-open theorem.
-/

namespace PhysicalBridges.SummitFirstViolationObstruction

universe u v w

variable {S : Type u} {P : Type v} {A : Type w}

/-- Abstract source dynamics: the action actually enacted at a state, which actions preserve a
particular's original X3, which are feasible, and the preservation-order dominance between
actions. None of these is defined in terms of the protection conclusion. -/
structure SourceDynamics (S : Type u) (P : Type v) (A : Type w) where
  actualAction : S → A
  preservesX3 : S → A → P → Prop
  feasible : S → A → Prop
  dominates : S → A → A → Prop

/-- A first X3 violation at `s` for particular `x`: the actually-enacted action fails to
preserve `x`'s original X3. -/
def FirstViolation (D : SourceDynamics S P A) (s : S) (x : P) : Prop :=
  ¬ D.preservesX3 s (D.actualAction s) x

/-- Obstruction 1 (feasibility): no feasible action preserves `x`. -/
def NoFeasibleProtection (D : SourceDynamics S P A) (s : S) (x : P) : Prop :=
  ¬ ∃ a, D.feasible s a ∧ D.preservesX3 s a x

/-- Obstruction 2 (enactment): a feasible protecting action existed that dominates the actual
action — i.e. the actual transition failed to follow the preservation order. -/
def DominatedActual (D : SourceDynamics S P A) (s : S) (x : P) : Prop :=
  ∃ a, D.feasible s a ∧ D.preservesX3 s a x ∧ D.dominates s a (D.actualAction s)

/-- **Decomposition.** A first violation forces one of the two obstructions, given only the
preservation-order premise `hOrder` (a feasible protector dominates a non-protecting actual —
the content of `BookUPTLaw.aligned_no_needless`). Nothing assumes protection. -/
theorem first_violation_forces_obstruction
    (D : SourceDynamics S P A) (s : S) (x : P)
    (hViol : FirstViolation D s x)
    (hOrder : ∀ a, D.feasible s a → D.preservesX3 s a x →
                ¬ D.preservesX3 s (D.actualAction s) x → D.dominates s a (D.actualAction s)) :
    NoFeasibleProtection D s x ∨ DominatedActual D s x := by
  by_cases h : ∃ a, D.feasible s a ∧ D.preservesX3 s a x
  · obtain ⟨a, hfeas, hpres⟩ := h
    exact Or.inr ⟨a, hfeas, hpres, hOrder a hfeas hpres hViol⟩
  · exact Or.inl h

/-- **If the source excludes both obstructions, no first violation.** The two exclusions are
the named source obligations: feasibility (a protecting action exists) and enactment-necessity
(the actual action is never a dominated one). This is the exact target; the obligations are
visible, not assumed away. -/
theorem no_first_full_x3_violation_from_source_selection
    (D : SourceDynamics S P A) (s : S) (x : P)
    (hOrder : ∀ a, D.feasible s a → D.preservesX3 s a x →
                ¬ D.preservesX3 s (D.actualAction s) x → D.dominates s a (D.actualAction s))
    (hFeasible : ¬ NoFeasibleProtection D s x)
    (hEnact : ¬ DominatedActual D s x) :
    ¬ FirstViolation D s x := by
  intro hViol
  rcases first_violation_forces_obstruction D s x hViol hOrder with h1 | h2
  · exact hFeasible h1
  · exact hEnact h2

/-- **The enactment premise does real work (anti-false-confidence control).** Feasibility of
protection alone does NOT prevent a violation: here a protecting action is feasible, yet the
dominated harmful action is actually enacted, so `x` is violated. So excluding Obstruction 1 is
not enough — the enactment-necessity (Obstruction 2's exclusion) is a genuine, separate, still
open obligation. *Protection optimal ⇏ protection inevitable.* -/
theorem protection_feasible_but_not_enacted_still_violates :
    ∃ (D : SourceDynamics Unit Unit Bool) (s : Unit) (x : Unit),
      ¬ NoFeasibleProtection D s x ∧ FirstViolation D s x ∧ DominatedActual D s x := by
  refine ⟨{ actualAction := fun _ => false
            preservesX3 := fun _ a _ => a = true
            feasible := fun _ _ => True
            dominates := fun _ a b => a = true ∧ b = false }, (), (), ?_, ?_, ?_⟩
  · intro h; exact h ⟨true, trivial, rfl⟩
  · simp [FirstViolation]
  · exact ⟨true, trivial, rfl, rfl, rfl⟩

#print axioms first_violation_forces_obstruction
#print axioms no_first_full_x3_violation_from_source_selection
#print axioms protection_feasible_but_not_enacted_still_violates

end PhysicalBridges.SummitFirstViolationObstruction
