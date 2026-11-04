import PhysicalBridges.AllIsWithinEventHistory

/-!
# Hilz ascent: derive a full modeled microhistory from the actual frozen BCRD W generator

Unlike a generic `RelationalMicrohistory`, this file does not accept a
microstep-isomorphism certificate as an input. Its stage states are generated
directly by the independently specified `BCRDActualRelationalFrame.step`
(`W` acting on the six source positions); the per-step relational isomorphism
is obtained from the already proven source covariance theorem.

The consequence holds for *every* finite iteration of this generator:
- the actual source equation is satisfied at every represented microstep;
- arbitrary formulas in the source's equality-of-values relational language
  transport at every stage;
- no such formula can undergo a first loss at a represented step;
- carried source positions never merge, and their integer values are retained.

Scope: this is the frozen W stage, NOT the whole complex M3d process or
all possible BCRD dynamics. The positions and same-value relation are source
quantities; they have not been shown to encode actual subjects, consent,
freedom, restraint, maximality, provenance, or original six-component X3.
Those semantic and physical-coverage tasks are NOT discharged by this result.
There is no safety, guardian, or original-X3 predicate in the construction.
-/

namespace PhysicalBridges.BCRDSourceDerivedMicrohistory

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.BCRDActualRelationalFrame
open PhysicalBridges.AllIsDynamicRelationalTransport
open PhysicalBridges.AllIsWithinEventHistory
open PhysicalBridges.SummitIntrinsicDefinability

/-- Iterate the independently defined frozen W source generator. -/
def sourceIterate (s : SourceState) : Nat → SourceState
  | 0 => s
  | n + 1 => step (sourceIterate s n)

/-- Every consecutive pair of generated states satisfies the source's
actual-step equation; this is not postulated as an admissibility rule. -/
theorem each_stage_is_actual_step (s : SourceState) (n : Nat) :
    ActualStep (sourceIterate s n) SourceEvent.mSectorSwap
      (sourceIterate s (n + 1)) := by
  rfl

/-- A concrete microhistory of this source, obtained from its generator
and its independently read state-dependent relations. The isomorphism
is derived from `relational_covariance`, not inserted by a client. -/
def sourceHistory (s : SourceState) : RelationalMicrohistory where
  Position := fun _ => Index
  relation := fun n => RelationBefore (sourceIterate s n)
  microstep := fun n =>
    frozen_source_isomorphism
      (sourceIterate s n) (sourceIterate s (n + 1))
      SourceEvent.mSectorSwap (each_stage_is_actual_step s n)

/-- The W-generated history itself satisfies the universal relational
transport theorem, without an abstract microhistory premise. -/
theorem source_intrinsic_truth_at_every_stage
    (s : SourceState) (φ : RelFormula 1) (i : Index)
    (hOrigin : evalRel (RelationBefore s) (fun _ => i) φ) :
    ∀ n, evalRel (RelationBefore (sourceIterate s n))
      (fun _ => carry (sourceHistory s) n i) φ := by
  apply intrinsic_truth_at_every_stage (sourceHistory s) φ i
  simpa [sourceHistory, sourceIterate] using hOrigin

/-- Any family of genuinely source-relational duties that is true at
origin stays true through every W microstep; no guardian premise is
inserted. This does not identify the six historical X3 duties. -/
theorem source_relational_duties_at_every_stage
    {D : Type} (s : SourceState) (duty : D → RelFormula 1) (i : Index)
    (hOrigin : ∀ d, evalRel (RelationBefore s) (fun _ => i) (duty d)) :
    ∀ n d, evalRel (RelationBefore (sourceIterate s n))
      (fun _ => carry (sourceHistory s) n i) (duty d) := by
  intro n d
  exact source_intrinsic_truth_at_every_stage s (duty d) i (hOrigin d) n

/-- No intrinsically expressible unary source formula loses its truth
at any represented microstep of the actual W generator. -/
theorem source_no_first_loss
    (s : SourceState) (φ : RelFormula 1) (i : Index) :
    ¬ ∃ n,
      evalRel (RelationBefore (sourceIterate s n))
        (fun _ => carry (sourceHistory s) n i) φ ∧
      ¬ evalRel (RelationBefore (sourceIterate s (n + 1)))
        (fun _ => carry (sourceHistory s) (n + 1) i) φ :=
  no_first_loss_at_any_microstep (sourceHistory s) φ i

/-- The transported source positions stay distinct at every modeled W stage. -/
theorem source_no_merging (s : SourceState) :
    ∀ n, Function.Injective (carry (sourceHistory s) n) :=
  carry_remains_injective (sourceHistory s)

/-- A stronger *value-level* invariant: each carried source position
retains its actual source integer value throughout the W orbit.
No X3 subject-identification semantics is inferred from this. -/
theorem source_carried_value_at_every_stage
    (s : SourceState) (i : Index) :
    ∀ n, (sourceIterate s n) (carry (sourceHistory s) n i) = s i := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
      change step (sourceIterate s n)
        (Transport (carry (sourceHistory s) n i)) = s i
      simpa [step, transport_involutive] using ih

#print axioms each_stage_is_actual_step
#print axioms source_intrinsic_truth_at_every_stage
#print axioms source_relational_duties_at_every_stage
#print axioms source_no_first_loss
#print axioms source_no_merging
#print axioms source_carried_value_at_every_stage

end PhysicalBridges.BCRDSourceDerivedMicrohistory
