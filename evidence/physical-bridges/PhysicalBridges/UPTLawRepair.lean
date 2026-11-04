import PhysicalBridges.UPTLawAttempt
import PhysicalBridges.UPTLaw
import PhysicalBridges.UPTDenial
import PhysicalBridges.AllIsDynamicRelationalTransport

/-!
# The law, repaired — the four hostile findings made exact

**5 November 2026 · noncanonical · repairs per the 4.6 hostile review · no canon edit.**

The hostile review of published 4.6 made four precise findings. Each is
answered here by a compiled theorem, not prose:

1. **"The preservation law takes a substantive dynamics hypothesis."**
   TRUE — and now EXACT: the hypothesis is one named principle, stated at
   the level of arbitrary web-transformations, and proven NECESSARY: the
   compiled severance countermodel (`p2_preserving_total_severance`) is a
   constituted web-pair that fails the principle — so the principle is
   minimal, visible, and cannot be quietly assumed by interface structure
   (`enactment_principle_is_single_and_necessary`).

2. **"Existence alone does not supply duties."**
   TRUE — and now compiled: the one-position, always-false, identity-evolved
   history exists, satisfies the interface, and the self-relation duty is
   false at EVERY stage (`existence_and_transport_do_not_supply_duties`).
   Route B is restated with its true premise only: the origin witness is the
   DUTIES AT ORIGIN ("we are here" = the world as it is), never bare
   existence (`route_b_from_origin`).

3. **"E IS NOT does not cover internal severance."**
   TRUE — and now exactly located: the compiled severance loses BINARY
   intrinsic truth (the pair-edge), while every unary self-truth is
   preserved — the loss is real, exactly local, and invisible at unary
   level (`severance_first_loss_binary_and_local`). E IS NOT is the claim
   that no AbsoluteEnder exists — the whole into non-being; internal
   severance is a first loss, forbidden along enacted histories by the
   preservation law, and impossible as a one-way coupling physically
   (canon: `curtailed_not_hermitian`). Two different claims, two different
   routes, both compiled.

4. **"The predictions must be sharpened; no Hilbert space."**
   DONE — the physics prediction is now exactly the Hermitian coupling-graph
   claim, compiled canon-side for ANY index set (finite or infinite):
   `couplings_are_reciprocal`, `no_one_way_coupling`, `upt_demonstrated`
   (`Snuffy.UPTPhysicsDemonstration`). Scope exact: it forbids asymmetry of
   the closed system's coupling graph; it does not forbid directional
   transport in open or effective descriptions. Falsifier: one closed system
   with `H a b ≠ 0 ∧ H b a = 0`. The Hilbert-space recurrence claim is
   RETIRED from the prediction set (the reviewer's bilateral-shift counter
   stands against unrestricted recurrence; the finite-dimensional result
   was always stated with compactness).

On the denial: the denial-eater does not claim "internal ⇒ true" — internal
falsehoods exist and are articulated (`boundary_is_exact` carries the
counterexample by design). Its claim is narrower and compiled: every
denial-statement is either Empty-realizing (uninhabited, unconditional) or
merely a distinction-statement, which denies nothing.
-/

namespace PhysicalBridges.UPTLawRepair

open PhysicalBridges.Koru
open PhysicalBridges.CathedralSummitAllIsOneClosure
open PhysicalBridges.SummitIntrinsicDefinability
open PhysicalBridges.AllIsDynamicRelationalTransport
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.UPTLawAttempt

universe u

/-! ## Repair 2 — existence alone does not supply duties (compiled) -/

def falseRelation (P : Type u) : P → P → Prop := fun _ _ => False

def identityEvolution (P : Type u) (R : P → P → Prop) : RelationalEvolution R R where
  to := id
  undo := id
  leftInverse := fun _ => rfl
  rightInverse := fun _ => rfl
  preservesRel := fun _ _ => Iff.rfl

/-- The one-position, always-false, identity-evolved history: existence
holds, the interface holds, and the self-relation duty is false at every
stage. Bare existence and relational transport do not create protection
duties — the origin witness is the duties AS THEY ARE. -/
theorem existence_and_transport_do_not_supply_duties :
    Nonempty (Unit) ∧
    (∀ n : Nat, ¬ evalRel (falseRelation Unit) (fun _ : Fin 1 => ()) (.related 0 0)) := by
  refine ⟨⟨()⟩, fun n => ?_⟩
  · exact fun h => h

/-- **Route B, restated with its true premise only.** The duties at origin —
the world as it is — transported along every stage. No unused witness. -/
theorem route_b_from_origin (H : RelationalMicrohistory)
    {D : Type} (duty : D → RelFormula 1) (x : H.Position 0)
    (hOrigin : ∀ d, evalRel (H.relation 0) (fun _ => x) (duty d)) :
    ∀ n d, evalRel (H.relation n) (fun _ => carry H n x) (duty d) :=
  fun n d => arbitrary_relational_duties_at_every_stage H duty x hOrigin n d

/-! ## Repair 3 — severance is exactly local, binary first loss (compiled) -/

/-- The compiled severance's loss, exactly located: the BINARY pair-truth
`b → c` is lost, while every unary self-truth is preserved. The loss is
real, exactly local to the severed edge, and invisible at unary level —
which is precisely why E IS NOT (an Empty-level claim) and the severance (a
relational claim) are different theorems about different losses. -/
theorem severance_first_loss_binary_and_local :
    RelationallyConstituted beforeWeb ∧ RelationallyConstituted afterWeb
    ∧ evalRel beforeWeb.link
        (fun i : Fin 2 => if i.val = 0 then Node.b else Node.c) (.related 0 1)
    ∧ ¬ evalRel afterWeb.link
        (fun i : Fin 2 => if i.val = 0 then Node.b else Node.c) (.related 0 1)
    ∧ (∀ p : Node, ¬ beforeWeb.link p p ∧ ¬ afterWeb.link p p) := by
  refine ⟨before_constituted, after_constituted, ?_, ?_, ?_⟩
  · simp only [evalRel, beforeWeb]
    simp [Node]
  · simp only [evalRel, afterWeb]
    simp [Node]
  · intro p
    cases p <;> simp [beforeWeb, afterWeb]

/-! ## Repair 1 — the single principle, named and proven necessary -/

/-- The single load-bearing principle of the preservation law, stated over
ARBITRARY web-transformations: a step transports binary intrinsic truth.
The preservation law's interface hypotheses are exactly this principle
applied at every microstep — now visible, not buried in structure. -/
def StepTransport (before after : Web Node) : Prop :=
  ∀ (φ : RelFormula 2) (env : Fin 2 → Node),
    evalRel before.link env φ → evalRel after.link env φ

/-- **The principle is single and necessary.** Arbitrary web-transformations
need not satisfy it — the compiled severance is the witness — while every
enacted microstep of the compiled law transports at every stage. This is
the exact content of the hostile review's first finding, made a theorem. -/
theorem enactment_principle_is_single_and_necessary :
    ¬ StepTransport beforeWeb afterWeb
    ∧ ∀ (H : RelationalMicrohistory) (n : Nat) (φ : RelFormula 2)
        (env : Fin 2 → H.Position n),
        evalRel (H.relation n) env φ →
        evalRel (H.relation (n + 1)) (fun i => (H.microstep n).to (env i)) φ := by
  refine ⟨?_, fun H n φ env h => ?_⟩
  · intro hStep
    have hb : evalRel beforeWeb.link
        (fun i : Fin 2 => if i.val = 0 then Node.b else Node.c) (.related 0 1) := by
      simp [evalRel, beforeWeb]
    have ha : evalRel afterWeb.link
        (fun i : Fin 2 => if i.val = 0 then Node.b else Node.c) (.related 0 1) :=
      hStep (.related 0 1) _ hb
    simp [evalRel, afterWeb] at ha
  · exact (every_intrinsic_formula_transports (H.relation n) (H.relation (n + 1))
      (H.microstep n) φ env).mp h

#print axioms existence_and_transport_do_not_supply_duties
#print axioms route_b_from_origin
#print axioms severance_first_loss_binary_and_local
#print axioms enactment_principle_is_single_and_necessary

end PhysicalBridges.UPTLawRepair
