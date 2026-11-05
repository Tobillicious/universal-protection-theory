import PhysicalBridges.KoruObjectiveWholeU
import PhysicalBridges.OriginalKoruSummitJoin
import PhysicalBridges.IR132ExactBoundaryReconstruction

/-!
# The existing Lean banks sharpen the objective-U Koru theorem

6 November 2026. Additive work stacked on #344.

This module REUSES the historical summit banks instead of inventing a
replacement Koru, an external description of U or a semantic X3 oracle.

1. OriginalKoruSummitJoin already proves that relational individuation
   in one web makes Koru articulate precisely every distinct pair.
   We specialize its theorem to the whole objective operator context
   derived in #344. Then exact frozen-W transport yields that same
   result through every modeled stage.

2. IR132ExactBoundaryReconstruction establishes an exact-decoder
   criterion. #344's two distinct whole contexts with identical event
   projections produce a genuine no-go: no function of that local
   subject/action/effect view, even with perfect computation and any
   number of W steps, can exactly reconstruct the WHOLE source context.

   This contrasts objective mathematical structure with information
   available at a partial cut. It does NOT say that intrinsic facts
   reside outside U, that authorization is external or that W violates
   the six original X3 duties.

The user-defined ontological Koru, all original six-X3 duties and the
frozen summit remain entirely unchanged. The new result is scoped to
the independently fixed finite W source, not full cosmological U.
-/

namespace PhysicalBridges.KoruBankReuseObjectiveJoin

open PhysicalBridges.FrozenBCRDEvents
open PhysicalBridges.Koru
open PhysicalBridges.KoruCompositionalExpression
open PhysicalBridges.KoruWholeEventEnactment
open PhysicalBridges.KoruObjectiveWholeU

/-- The old Cathedral and the new operator-indexed objective-U model
have literally the same internal source relation when viewed as webs.
No additional predicate is attached to a subject. -/
def asOriginalCathedralWeb (U : FiniteObjectiveU) :
    PhysicalBridges.CathedralIntrinsicArticulation.Web Index where
  link := (sourceWholeWeb U).link

/-- The historical source-bank criterion for exact intrinsic
individuation: a position's complete relational profile distinguishes
it from every genuinely different position. This is not assumed for
all arbitrary possible U; it is a substantive, separately checkable
property of the whole represented web. -/
def IntrinsicallyIndividuatedObjective (U : FiniteObjectiveU) : Prop :=
  PhysicalBridges.CathedralIntrinsicArticulation.RelationallyIndividuated
    (asOriginalCathedralWeb U)

/-- REUSE of the ORIGINAL summit Koru proof, not a new Koru
definition: when the entire objective relation individuates every
position, Koru holds precisely for genuine distinctions. -/
theorem original_banked_koru_exactly_separates_distinct_objective_positions
    (U : FiniteObjectiveU)
    (hIndividuated : IntrinsicallyIndividuatedObjective U)
    (i j : Index) :
    koru (sourceWholeWeb U) i j ↔ i ≠ j := by
  change koru
    (PhysicalBridges.OriginalKoruSummitJoin.asKoruWeb
      (asOriginalCathedralWeb U)) i j ↔ i ≠ j
  exact
    PhysicalBridges.OriginalKoruSummitJoin.koru_iff_genuine_distinction
      (asOriginalCathedralWeb U) hIndividuated i j

/-- The original bank and #344 now JOIN: every intrinsic distinction
of a relationally individuated complete source object remains Koru-
articulated at ALL finite physically generated frozen-W stages. -/
theorem original_banked_koru_individuation_survives_every_W_stage
    (U : FiniteObjectiveU)
    (hIndividuated : IntrinsicallyIndividuatedObjective U)
    (i j : Index) (n : Nat) :
    koru (sourceWholeWeb (objectiveAt U n))
      (trackedPosition i n) (trackedPosition j n) ↔ i ≠ j := by
  exact
    (objective_Koru_is_exact_under_W U i j n).trans
      (original_banked_koru_exactly_separates_distinct_objective_positions
        U hIndividuated i j)

/-- The local view read from a physically evolved objective source.
The roles are tracked through the SAME generator. -/
def LocalEventCut (n : Nat) (U : FiniteObjectiveU) :
    WholeOperatorEvent :=
  eventViewedInObjective (objectiveAt U n)
    (trackedPosition 0 n) (trackedPosition 1 n)
    (trackedPosition 2 n)

/-- Reuse the EXACT banked IR132 decoder criterion to show no
universal exact reconstruction of the ORIGINAL whole U exists from
that local triple, even if the complete local expression tree is
recorded after arbitrarily many W steps. -/
theorem no_exact_local_cut_decoder_for_entire_initial_U
    (n : Nat) :
    ¬ PhysicalBridges.IR132.ExactDecoder
      (LocalEventCut n) (fun U : FiniteObjectiveU => U) := by
  intro hDecoder
  have hFibre :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      (LocalEventCut n) (fun U : FiniteObjectiveU => U) hDecoder
  have hSame :
      LocalEventCut n uniformObjective =
        LocalEventCut n changedElsewhereObjective := by
    exact (local_event_projection_gap_persists_at_every_W_stage n).1
  exact local_event_cannot_be_identified_with_objective_U.2
    (hFibre uniformObjective changedElsewhereObjective hSame)

/-- The obstruction is not merely that the local event forgot the
INITIAL whole: it cannot reconstruct the entire CURRENT objective
source either. The complete W dynamics retains the distinction
that the local projection discards. -/
theorem no_exact_local_cut_decoder_for_entire_current_U
    (n : Nat) :
    ¬ PhysicalBridges.IR132.ExactDecoder
      (LocalEventCut n) (fun U : FiniteObjectiveU => objectiveAt U n) := by
  intro hDecoder
  have hFibre :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      (LocalEventCut n)
      (fun U : FiniteObjectiveU => objectiveAt U n) hDecoder
  have hPair := local_event_projection_gap_persists_at_every_W_stage n
  have hSame :
      LocalEventCut n uniformObjective =
        LocalEventCut n changedElsewhereObjective := hPair.1
  exact hPair.2 (hFibre uniformObjective changedElsewhereObjective hSame)

/-- Direct banked synthesis: a nontrivial intrinsic Koru is present
at every stage of a real frozen-W history, yet no universal
event-only reconstruction of the complete objective exists. Neither
source truth nor full physical authority is obtained from the cut. -/
theorem nontrivial_koru_and_incomplete_local_cut_coexist
    (n : Nat) :
    koru (sourceWholeWeb (objectiveAt KoruWitnessObjective n))
      (trackedPosition 2 n) (trackedPosition 3 n) ∧
    ¬ PhysicalBridges.IR132.ExactDecoder
      (LocalEventCut n) (fun U : FiniteObjectiveU => objectiveAt U n) :=
  ⟨genuine_Koru_distinction_survives_entire_W_history n,
    no_exact_local_cut_decoder_for_entire_current_U n⟩

#print axioms original_banked_koru_exactly_separates_distinct_objective_positions
#print axioms original_banked_koru_individuation_survives_every_W_stage
#print axioms no_exact_local_cut_decoder_for_entire_initial_U
#print axioms no_exact_local_cut_decoder_for_entire_current_U
#print axioms nontrivial_koru_and_incomplete_local_cut_coexist

end PhysicalBridges.KoruBankReuseObjectiveJoin
