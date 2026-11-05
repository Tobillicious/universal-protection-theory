import PhysicalBridges.SummitIntrinsicDefinability
import PhysicalBridges.OriginalX3Full
import PhysicalBridges.CathedralAllIsEnderTypeCollapse

/-!
# Source-derived forcing for all six original duties, with no guardian premise

A positive, directly composed route from the original #279 intrinsic-formula
invariance to ORIGINAL SIX-X3 for EVERY owed particular, not one representative.

- The source relation R does not name guardian or protection.
- Every action's SOURCE transport is supplied as a whole-relation automorphism.
- All six duty forms contain only R, equality, connectives and quantifiers.
- The final actual-X3 identification is NOT built into the formulas or
  the action-admissibility definition. It is an explicitly independent,
  per-duty physical/subject-semantic reflection to be proved from BCRD.
- No partial semantics, subjective perspective, historical carrier or
  name-only action label is silently promoted to genuine authorization.

This is a six-duty source-preservation composition and a precise remaining
source/semantics interface, NOT an unconditional physical UPT proof.
-/

namespace PhysicalBridges.IntrinsicSixSourceForcing

open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w

/-- Six separately coded propositions of ONE intrinsic source relation.
The four slots can describe the same subject, event, source and effect;
no named atomic predicates or X3 status are present in the language. -/
structure SixRelationalDuties where
  continuity : RelFormula 4
  authorization : RelFormula 4
  freedom : RelFormula 4
  restraint : RelFormula 4
  maximality : RelFormula 4
  provenance : RelFormula 4

/-- The conjunction names ALL six original fields; these are merely
intrinsic source reports until independent physical semantics are proved. -/
def SourceSixHold {P : Type u} (R : P → P → Prop)
    (d : SixRelationalDuties) (env : Fin 4 → P) : Prop :=
  evalRel R env d.continuity ∧
  evalRel R env d.authorization ∧
  evalRel R env d.freedom ∧
  evalRel R env d.restraint ∧
  evalRel R env d.maximality ∧
  evalRel R env d.provenance

/-- No X3 or guardian premise: the original #279 syntactic-induction
theorem preserves every one of six independent intrinsic source reports
under one and the same actual source automorphism. -/
theorem source_six_preserved_by_whole_relation
    {P : Type u} (R : P → P → Prop)
    (transport : RelationalAutomorphism R)
    (d : SixRelationalDuties) (env : Fin 4 → P)
    (h : SourceSixHold R d env) :
    SourceSixHold R d (fun i => transport.to (env i)) := by
  rcases h with ⟨hc, ha, hf, hr, hm, hp⟩
  exact ⟨(intrinsic_formula_is_automorphism_invariant
            R transport d.continuity env).mp hc,
         (intrinsic_formula_is_automorphism_invariant
            R transport d.authorization env).mp ha,
         (intrinsic_formula_is_automorphism_invariant
            R transport d.freedom env).mp hf,
         (intrinsic_formula_is_automorphism_invariant
            R transport d.restraint env).mp hr,
         (intrinsic_formula_is_automorphism_invariant
            R transport d.maximality env).mp hm,
         (intrinsic_formula_is_automorphism_invariant
            R transport d.provenance env).mp hp⟩

/-- Explicit single source for the actual subject/action correspondence.
Every field is an independently justified semantic *reflection*, NOT
a protection assumption hiding in the definition of an allowed step. -/
structure SourceSixReflections
    {Event : Type u} {Action : Type v} {P : Type w}
    (account : IntrinsicAccount Event Action)
    (R : P → P → Prop) (d : SixRelationalDuties)
    (transport : Action → RelationalAutomorphism R)
    (slots : Action → P → Fin 4 → P)
    (owed : Action → P → Prop)
    (cont auth free restr maxl prov : P → P → P → Prop)
    (before after : Action → P) : Prop where
  continuity : ∀ a p, account.enacted a → owed a p →
      evalRel R (fun i => (transport a).to (slots a p i)) d.continuity →
      cont (before a) (after a) p
  authorization : ∀ a p, account.enacted a → owed a p →
      evalRel R (fun i => (transport a).to (slots a p i)) d.authorization →
      auth (before a) (after a) p
  freedom : ∀ a p, account.enacted a → owed a p →
      evalRel R (fun i => (transport a).to (slots a p i)) d.freedom →
      free (before a) (after a) p
  restraint : ∀ a p, account.enacted a → owed a p →
      evalRel R (fun i => (transport a).to (slots a p i)) d.restraint →
      restr (before a) (after a) p
  maximality : ∀ a p, account.enacted a → owed a p →
      evalRel R (fun i => (transport a).to (slots a p i)) d.maximality →
      maxl (before a) (after a) p
  provenance : ∀ a p, account.enacted a → owed a p →
      evalRel R (fun i => (transport a).to (slots a p i)) d.provenance →
      prov (before a) (after a) p

/-- A direct six-X3 forcing theorem from intrinsic source conservation
and six separately sourced semantic reflections. It has NO hKeystone
and NO guardian/ender dichotomy premise. The physical source's ability
to populate these inputs is the honest unclosed source question. -/
theorem source_preservation_forces_six_x3_for_every_owed
    {Event : Type u} {Action : Type v} {P : Type w}
    (account : IntrinsicAccount Event Action)
    (R : P → P → Prop) (d : SixRelationalDuties)
    (transport : Action → RelationalAutomorphism R)
    (slots : Action → P → Fin 4 → P)
    (owed : Action → P → Prop)
    (cont auth free restr maxl prov : P → P → P → Prop)
    (before after : Action → P)
    (hInitially : ∀ a p, account.enacted a → owed a p →
      SourceSixHold R d (slots a p))
    (hMeaning : SourceSixReflections account R d
      transport slots owed cont auth free restr maxl prov before after) :
    ∀ a p, account.enacted a → owed a p →
      OriginalX3 cont auth free restr maxl prov (before a) (after a) p := by
  intro a p ha hp
  have hSource := source_six_preserved_by_whole_relation
    R (transport a) d (slots a p) (hInitially a p ha hp)
  rcases hSource with ⟨hc, hAut, hFree, hRest, hMax, hProv⟩
  exact ⟨hMeaning.continuity a p ha hp hc,
         hMeaning.authorization a p ha hp hAut,
         hMeaning.freedom a p ha hp hFree,
         hMeaning.restraint a p ha hp hRest,
         hMeaning.maximality a p ha hp hMax,
         hMeaning.provenance a p ha hp hProv⟩

#print axioms source_six_preserved_by_whole_relation
#print axioms source_preservation_forces_six_x3_for_every_owed

end PhysicalBridges.IntrinsicSixSourceForcing
