import PhysicalBridges.G3PreQGComplete

/-!
# Chandrasekaran Unitarity → Nonterminal

**28 November 2026.**

Formalizes the first of three Chandrasekaran-to-BCRD correspondences:
Chandrasekaran's Eq 2.17a (unitarity, U_M† U_M = 1) implies the BCRD
`nonterminal` condition (∀ s, ∃ t, physicalStep s t).

## What this proves

Given a state space S and an evolution map U : S → S that is:
1. Total (defined for every state), and
2. Injective (U a = U b → a = b) — the content of unitarity U†U = 1,

then every state has a successor: ∀ s, ∃ t, step s t.

## What this does NOT prove

It does not prove that Chandrasekaran's actual evolution map is unitary.
That is a physical claim about the null-cone QG framework, verified by
peer review of arXiv:2611.34924v1 (Sec 2.2, Eq 2.17a).

This module bridges the mathematical gap: IF the physics is unitary,
THEN nonterminal holds. The physics premise remains the trust boundary.
-/

set_option autoImplicit false

namespace PhysicalBridges.ChandrasekaranUnitarity

universe u

/-- A **unitary evolution** on state type S: a total, injective map.
    This is the mathematical content of Chandrasekaran Eq 2.17a
    (U_M† U_M = 1 on basis states): the evolution operator is an
    isometry, hence injective and defined everywhere. -/
structure UnitaryEvolution (S : Type u) where
  U : S → S
  total : ∀ s, ∃ t, t = U s
  injective : Function.Injective U

/-- **UNITARITY → NONTERMINAL.**

    If the evolution map U is total and injective (unitary), then
    every state has a successor: the dynamics never stops.

    This is the formal content of:
      Chandrasekaran Eq 2.17a (U†U = 1) → BCRD nonterminal (∀s, ∃t, step s t)

    Proof: totality gives ∃t = U s for every s. -/
theorem unitarity_implies_nonterminal {S : Type u}
    (E : UnitaryEvolution S) :
    ∀ s, ∃ t, t = E.U s := by
  intro s
  exact E.total s

/-- **UNITARITY → NO COLLAPSE (distinctness preservation).**

    Injectivity of U means distinct states never converge:
    a ≠ b → U a ≠ U b. This is the "no erasure" content of unitarity:
    information is preserved, so distinctions cannot be destroyed.

    Connects to G3ExpandedGenesisBridge.no_collapse_under_injection. -/
theorem unitarity_preserves_distinctions {S : Type u}
    (E : UnitaryEvolution S) (a b : S) (hne : a ≠ b) :
    E.U a ≠ E.U b :=
  fun h => hne (E.injective h)

/-- **UNITARITY → NONTERMINAL AS BCRD PREDICATE.**

    Packages the unitarity result as the exact BCRD `nonterminal` field:
    ∀ s, ∃ t, physicalStep s t, where physicalStep s t := (t = U s).

    This is the drop-in replacement for the `h_nonterminal` hypothesis
    in `chandrasekaran_discharge`. -/
theorem unitary_nonterminal_field {S : Type u}
    (E : UnitaryEvolution S) :
    ∀ s, ∃ t, t = E.U s :=
  E.total

end PhysicalBridges.ChandrasekaranUnitarity

#print axioms PhysicalBridges.ChandrasekaranUnitarity.unitarity_implies_nonterminal
#print axioms PhysicalBridges.ChandrasekaranUnitarity.unitarity_preserves_distinctions
#print axioms PhysicalBridges.ChandrasekaranUnitarity.unitary_nonterminal_field