import PhysicalBridges.SummitNoPrivilegedMindDerivation
import PhysicalBridges.IntrinsicSixSourceForcing

/-!
# The assembly: six duties, every owed particular, every stage

5 November 2026. Noncanonical. No canon prose changed.

Combines `IntrinsicSixSourceForcing` (six duties written in one relation, preserved under a
whole-relation automorphism, with no guardian or dichotomy premise) with
`SummitProductionFromIntrinsic` (stages, production, circular time).

The premises are the step as a whole-relation automorphism, the six duties written in that relation
and holding once, and each duty's reflection into the particular's actual X3 at each stage. No
guardian predicate, no dichotomy and no selected-subject shortcut appears. Whether actual BCRD
supplies a relation with this content is what this module does not establish.
-/

namespace PhysicalBridges.SummitLawAssembly

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.SummitProductionFromIntrinsic
open PhysicalBridges.IntrinsicSixSourceForcing
open PhysicalBridges.OriginalX3Full

universe u v

variable {P : Type u}

/-- The six source duties, true once, hold of the transported slots at every later stage. -/
theorem six_duties_at_every_stage {R : P → P → Prop} (A : RelationalAutomorphism R)
    (d : SixRelationalDuties) (env : Fin 4 → P) (h : SourceSixHold R d env) :
    ∀ n, SourceSixHold R d (fun i => stage A (env i) n) := by
  intro n
  induction n with
  | zero => exact h
  | succ k ih => exact source_six_preserved_by_whole_relation R A d _ ih

/-- **The assembled law, for every owed particular.** With the step a whole-relation automorphism,
one starting point where the six source duties hold, and the six reflections at each stage, every
owed particular has its full six-component original X3 at every stage, and the particular's chain
never breaks. -/
theorem assembled_six_x3_forever {Q : Type v} {R : P → P → Prop} (A : RelationalAutomorphism R)
    (d : SixRelationalDuties) (owed : Q → Prop) (slots : Q → Fin 4 → P)
    (start : ∀ q, owed q → SourceSixHold R d (slots q))
    (cont auth free restr maxl prov : Nat → Nat → Q → Prop)
    (reflect : ∀ q n, owed q → SourceSixHold R d (fun i => stage A (slots q i) n) →
      OriginalX3 cont auth free restr maxl prov n (n + 1) q)
    (x : P) (here : R x (A.to x)) :
    (∀ q n, owed q → OriginalX3 cont auth free restr maxl prov n (n + 1) q) ∧
      ∀ n, R (stage A x n) (stage A x (n + 1)) :=
  ⟨fun q n hq => reflect q n hq (six_duties_at_every_stage A d (slots q) (start q hq) n),
   we_are_here_forever A x here⟩

#print axioms six_duties_at_every_stage
#print axioms assembled_six_x3_forever

end PhysicalBridges.SummitLawAssembly
