/-
IR-70: exact necessary-and-sufficient interface for the original X3
two-stage finitary-closure route. This does NOT demonstrate that the
real physical feasible predicate satisfies the criterion.

A feasibility predicate over ALL tagged retention sets admits a
finite-forbidden-pattern representation IFF every infeasible outcome
has one finite set of retained facts that forces infeasibility in
every larger retention outcome.

The condition can be falsified by an infinite-tail-only constraint.
It must be established for a *specified real physical model* before
IR-68/69 could establish its original X3 maximality.
-/
import PhysicalBridges.IRResourceDerivedClosure

namespace PhysicalBridges.IRFiniteRefutationCriterion

open IRCoupledFinitaryTwoStage

def Contains (xs : List Fact) (s : Outcome) : Prop :=
  ∀ f, f ∈ xs → s f

/-- Precise minimal missing physical-logic premise for the
finite-obstruction route. It speaks about the entire actual F,
not just resources that a modeller chose to enumerate. -/
def FiniteRefutations (F : Outcome → Prop) : Prop :=
  ∀ s, ¬ F s →
    ∃ xs : List Fact, Contains xs s ∧
      ∀ t, Contains xs t → ¬ F t

/-- Canonical no-good pattern: any physical outcome containing all
these retained facts is infeasible, across the WHOLE outcome universe.
This is a semantic definition, NOT a physically observed pattern. -/
def CanonicalForbidden (F : Outcome → Prop)
    (xs : List Fact) : Prop :=
  ∀ t, Contains xs t → ¬ F t

/-- Sufficiency: the whole feasible universe is EXACTLY a closed
finite-pattern constraint system whenever its failures admit finite
refutations. No finite catalogue of patterns is required. -/
theorem finite_refutations_give_exact_representation
    (F : Outcome → Prop)
    (h : FiniteRefutations F) :
    ∀ s, F s ↔
      IRCoupledFinitaryTwoStage.Feasible
        (CanonicalForbidden F) s := by
  intro s
  constructor
  · intro hs xs hBad hAll
    exact hBad s hAll hs
  · intro hAvoid
    by_cases hFeasible : F s
    · exact hFeasible
    · obtain ⟨xs,hContains,hAlwaysBad⟩ := h s hFeasible
      exact False.elim ((hAvoid xs hAlwaysBad) hContains)

/-- Necessity: any EXACT finite-pattern description implies that
infeasible outcomes have a finite explicit incompatibility
certificate. Mere partial coverage does not suffice. -/
theorem any_exact_finite_pattern_model_is_finitely_refutable
    (F : Outcome → Prop) (bad : List Fact → Prop)
    (hExact : ∀ s, F s ↔
      IRCoupledFinitaryTwoStage.Feasible bad s) :
    FiniteRefutations F := by
  intro s hNot
  by_cases hExists : ∃ xs, bad xs ∧ Contains xs s
  · obtain ⟨xs,hBad,hContained⟩ := hExists
    refine ⟨xs,hContained,?_⟩
    intro t hIn hFt
    exact ((hExact t).mp hFt xs hBad) hIn
  · have hAvoid :
        IRCoupledFinitaryTwoStage.Feasible bad s := by
      intro xs hBad hAll
      exact False.elim (hExists ⟨xs,hBad,hAll⟩)
    exact False.elim (hNot ((hExact s).mpr hAvoid))

theorem finite_refutations_iff_exact_finite_patterns
    (F : Outcome → Prop) :
    FiniteRefutations F ↔
      ∃ bad : List Fact → Prop,
        ∀ s, F s ↔ IRCoupledFinitaryTwoStage.Feasible bad s := by
  constructor
  · intro hFinite
    exact ⟨CanonicalForbidden F,
      finite_refutations_give_exact_representation F hFinite⟩
  · rintro ⟨bad,hExact⟩
    exact any_exact_finite_pattern_model_is_finitely_refutable
      F bad hExact

/-- Exact finite-refutability logically IMPLIES hereditary feasibility;
it cannot apply to a physical feasibility predicate where retaining
fewer historical particulars can itself violate a positive duty. -/
theorem finite_refutations_force_downward_feasibility
    (F : Outcome → Prop) (h : FiniteRefutations F)
    (larger smaller : Outcome) (hLarger : F larger)
    (hSub : UPTExist.Sub smaller larger) :
    F smaller := by
  by_cases hSmall : F smaller
  · exact hSmall
  · obtain ⟨xs,hContained,hAlwaysBad⟩ :=
      h smaller hSmall
    have hLargeContains : Contains xs larger := by
      intro fact hMem
      exact hSub fact (hContained fact hMem)
    exact False.elim ((hAlwaysBad larger hLargeContains) hLarger)

/-- Generic two-stage ORIGINAL full-feasible lex existence from the
SHARPLY CHARACTERIZED premise. The theorem parameters are substantial:
it does not produce actual physical finite-refutation evidence. -/
theorem source_two_stage_maximal_from_physical_finite_refutations
    (F : Outcome → Prop)
    (hEmpty : F (fun _ => False))
    (hFinite : FiniteRefutations F) :
    ∃ selected : Outcome,
      UPTExist.LexAlignedL F
        ([firstKey,secondKey] : List (Outcome → Nat → Prop))
        selected := by
  let bad := CanonicalForbidden F
  have hExact := finite_refutations_give_exact_representation F hFinite
  have hBase :
      IRCoupledFinitaryTwoStage.Feasible bad (fun _ => False) :=
    (hExact (fun _ => False)).mp hEmpty
  have hModel :=
    IRCoupledFinitaryTwoStage.coupled_two_stage_full_feasible_lex_maximal
      bad hBase
  refine ⟨IRCoupledFinitaryTwoStage.fullChoice bad, ?_⟩
  constructor
  · exact (hExact _).mpr hModel.1
  · intro other hF hBetter
    exact hModel.2 other ((hExact other).mp hF) hBetter

/-- Resource-capacity and finite hard conflicts give the exact
finite-refutation property; this is a noncircular source bridge from
IR-69's physical-style constraints to IR-70's general criterion. -/
theorem resource_feasibility_has_finite_refutations
    (weight : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) :
    FiniteRefutations
      (IRResourceDerivedClosure.CapacityFeasible
        weight capacity hard) := by
  have hExact :
      ∀ s, IRResourceDerivedClosure.CapacityFeasible
        weight capacity hard s ↔
        IRCoupledFinitaryTwoStage.Feasible
          (IRResourceDerivedClosure.DerivedForbidden weight capacity hard) s :=
    IRResourceDerivedClosure.resource_feasible_iff_finite_forbidden
      weight capacity hard
  exact any_exact_finite_pattern_model_is_finitely_refutable
    _ _ hExact

#print axioms finite_refutations_give_exact_representation
#print axioms any_exact_finite_pattern_model_is_finitely_refutable
#print axioms finite_refutations_iff_exact_finite_patterns
#print axioms finite_refutations_force_downward_feasibility
#print axioms source_two_stage_maximal_from_physical_finite_refutations
#print axioms resource_feasibility_has_finite_refutations

end PhysicalBridges.IRFiniteRefutationCriterion
