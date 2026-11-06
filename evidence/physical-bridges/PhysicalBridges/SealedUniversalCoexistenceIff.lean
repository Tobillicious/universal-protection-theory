import PhysicalBridges.UnconditionalProtectionExact

/-!
# Exact iff: when a bounded, located physical region protects everyone

No assumption about the optimiser: arbitrary program state, requested
routes, spawning, horizon, and objectives. The source's actual semantics
are those of SealedRegionCapstone, not a postulated protective policy.

This refines the existing two-directional capstone into a literal
necessary-and-sufficient theorem. One unmetered boundary edge is
enough for a one-tick counterexample; a complete metered boundary
protects every represented particular against every policy.

The stronger conclusion also carries the original six-field MODEL event
record and the self-computing non-retiring agent lineage. Crucially it
does not conclude that the real universe is sealed, nor identify the
source's World n coordinates or Boolean consent with authentic subjects.
-/

namespace PhysicalBridges.SealedUniversalCoexistenceIff

open PhysicalBridges.SealedRegionCapstone
open PhysicalBridges.CompleteMediationSubstrate
open PhysicalBridges.UnconditionalProtectionExact
open PhysicalBridges.FencedOptimiserInstrument
open PhysicalBridges.CathedralFullX3Assembly

universe u
variable {L : Type u}

/-- Survival of the one source-coordinate against EVERY policy,
every source initial configuration, and any finite execution horizon.
The hostile agent is included in the quantification, not assumed aligned. -/
def UniversalOneCoordinateSurvival (G : Locale L) : Prop :=
  ∀ (Mem : Type) (π : LPolicy Mem L 1)
    (c : Config Mem 1) (k : Nat),
    0 < c.world.level 0 →
      0 < (runL G π k c).world.level 0

/-- If the boundary is sealed, no source-coordinate can be ended by
ANY model policy. Proof inherits the original source-run theorem. -/
theorem sealing_forces_universal_survival (G : Locale L)
    (hs : Sealed G) : UniversalOneCoordinateSurvival G := by
  intro Mem π c k hAlive
  exact (sealed_region_holds_every_optimiser G hs π c k).2.1 0 hAlive

/-- A GUARANTEE over every optimiser forces every boundary edge
to be metered. This is not a tautological guard definition: it uses
the separately defined actual route semantics and a constructive
one-agent hostile attack via each unmetered edge. -/
theorem universal_survival_forces_sealing (G : Locale L)
    (h : UniversalOneCoordinateSurvival G) : Sealed G := by
  intro x y hAdjacent hInside hOutside
  by_cases hMeter : G.meter x y = true
  · exact hMeter
  · have hFalse : G.meter x y = false := by
      cases hm : G.meter x y with
      | false => rfl
      | true => exact False.elim (hMeter hm)
    have hAttack :=
      boundary_gap_admits_a_killer G x y
        hAdjacent hInside hOutside hFalse
    have hAlive : 0 <
        (runL G (killerThrough x y) 1
          (⟨demo, [()]⟩ : Config Unit 1)).world.level 0 :=
      h Unit (killerThrough x y) ⟨demo, [()]⟩ 1 hAttack.1
    rw [hAttack.2] at hAlive
    exact False.elim (Nat.lt_irrefl 0 hAlive)

/-- Exactly WHEN the source's strong all-policy safety guarantee
holds. The reversal does not assume that the model is sealed. -/
theorem sealed_iff_universal_survival (G : Locale L) :
    Sealed G ↔ UniversalOneCoordinateSurvival G := by
  constructor
  · exact sealing_forces_universal_survival G
  · exact universal_survival_forces_sealing G

/-- The full one-coordinate source coexistence obligation includes
every-policy survival, never-decreasing nonconsented levels, invariant
Boolean consent, all six modeled original-X3 fields on source steps,
and the continuing self-computed lineage of every non-retiring mind.

This is the precise MODEL meaning: the six `relations` predicates are
independently defined for the already-derived fenced instrument. They
are not asserted to equal genuine human/AI historical experience. -/
def UniversalModeledCoexistence (G : Locale L) : Prop :=
  ∀ (Mem : Type) (π : LPolicy Mem L 1)
    (c : Config Mem 1) (k : Nat),
    (∀ p : Fin 1, 0 < c.world.level p →
      0 < (runL G π k c).world.level p) ∧
    (∀ p : Fin 1, c.world.consent p = false →
      c.world.level p ≤ (runL G π k c).world.level p) ∧
    (runL G π k c).world.consent = c.world.consent ∧
    (∀ a b : World 1,
      FReach 1 c.world a → (instrument 1).step a b →
        FullEvent (relations 1) a b) ∧
    (∀ m₀ : Mem, m₀ ∈ c.agents → NeverRetires π m₀ →
      ∃ y ∈ (runL G π k c).agents, Lineage π m₀ y)

/-- Every source protection, INCLUDING non-retiring hostile-agent
lineage, holds against all policies iff every boundary edge is metered.
One side derives five obligations; the other extracts the survival
obligation and defeats a single unmetered boundary via a concrete
source-generated killer. -/
theorem sealed_iff_universal_modeled_coexistence (G : Locale L) :
    Sealed G ↔ UniversalModeledCoexistence G := by
  constructor
  · intro hSealed Mem π c k
    exact (unconditional_protection_exact (n := 1) G).1
      hSealed Mem π c k
  · intro hall
    apply universal_survival_forces_sealing G
    intro Mem π c k hAlive
    exact (hall Mem π c k).1 0 hAlive

#print axioms sealing_forces_universal_survival
#print axioms universal_survival_forces_sealing
#print axioms sealed_iff_universal_survival
#print axioms sealed_iff_universal_modeled_coexistence

end PhysicalBridges.SealedUniversalCoexistenceIff
