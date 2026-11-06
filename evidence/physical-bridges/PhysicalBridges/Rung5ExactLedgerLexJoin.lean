/-
RUNG 5 — EXACT FINITE-METER / ORIGINAL LEX ORDER JOIN (2026-11-03)

The quantised action-level bound of FinitaryActionMenu is connected to
IR-69's all-finite-subsets resource ledger and IR-71's original
UPTExist.LexAlignedL two-priority greatestness predicate.

This is an EXACT interface theorem, not a compactness axiom:
  (1) recorded nonnegative quanta yield the per-fact menu bound;
  (2) the specified resource/hard-conflict model has a global original
      two-priority maximal outcome with every mandatory fact retained;
  (3) if a larger actual feasible universe is soundly covered by that
      model AND the selected candidate is actually realisable, the
      *same* original-order maximality holds over that actual universe.

Important scope: Nat-indexed two-priority retention facts, finite-witness
nonnegative additive costs, finite hard exclusions, and an independently
feasible mandatory baseline. The construction does NOT assert that
finite choices per tick alone entail infinite-horizon compactness, that
physical X3 feasibility has this exact resource representation, or that
the selected outcome is realised in actual hardware.
-/
import PhysicalBridges.FinitaryActionMenu
import PhysicalBridges.IRMandatoryBaselineMaximality

namespace PhysicalBridges.Rung5ExactLedgerLexJoin

open IRCoupledFinitaryTwoStage

/-- A physical action's resource charge is an integer number of meter
quanta. Each resource channel has its own positive quantum δ r. -/
def quantumWeight (δ : Nat → Nat)
    (quanta : Nat → Fact → Nat) (r : Nat) (f : Fact) : Nat :=
  quanta r f * δ r

/-- All-finite-subsets metered model with independently specified
finite hard incompatibilities. The menu is NOT a filtered safe subset:
every original retention outcome is tested against the same ledger. -/
def MeteredFeasible (δ : Nat → Nat)
    (quanta : Nat → Fact → Nat) (capacity : Nat → Nat)
    (hard : List Fact → Prop) (s : Outcome) : Prop :=
  IRResourceDerivedClosure.CapacityFeasible
    (quantumWeight δ quanta) capacity hard s

/-- From the full finite-subset meter ledger, each particular retained
at a site/channel has at most capacity/δ distinguishable quanta.
This derives the local menu bound from the resource ledger, rather
than silently asserting global finiteness from a per-tick estimate. -/
theorem retained_fact_quanta_bounded
    (δ : Nat → Nat) (quanta : Nat → Fact → Nat)
    (capacity : Nat → Nat) (hard : List Fact → Prop)
    (s : Outcome) (hMeter : MeteredFeasible δ quanta capacity hard s)
    (r : Nat) (hδ : 0 < δ r) (f : Fact) (hf : s f) :
    quanta r f ≤ capacity r / δ r := by
  have hBudget :=
    hMeter.1 r [f] (by simp)
      (by
        intro g hg
        have heq : g = f := by simpa using hg
        subst g
        exact hf)
  change quanta r f * δ r ≤ capacity r at hBudget
  exact FinitaryActionMenu.menu_levels_bounded
    (capacity r) (δ r) hδ (quanta r f) hBudget

/-- Exact Rung-5-to-IR-71 join. No compactness axiom and no deletion
of mandatory protections. Maximality is over the FULL family of
metered outcomes in the original UPTExist two-stage LexBetter order.
Its only substantive input is that the mandatory baseline itself
satisfies the specified resource and conflict model. -/
theorem metered_mandatory_original_lex_maximal
    (δ : Nat → Nat) (quanta : Nat → Fact → Nat)
    (capacity : Nat → Nat) (hard : List Fact → Prop)
    (required : Outcome)
    (hRequired : MeteredFeasible δ quanta capacity hard required) :
    UPTExist.LexAlignedL
      (fun s => MeteredFeasible δ quanta capacity hard s ∧
        UPTExist.Sub required s)
      ([firstKey, secondKey] : List (Outcome → Nat → Prop))
      (IRMandatoryBaselineMaximality.finalProtected
        (IRResourceDerivedClosure.DerivedForbidden
          (quantumWeight δ quanta) capacity hard) required) := by
  exact IRMandatoryBaselineMaximality.resource_capacity_plus_mandatory_baseline_maximal
    (quantumWeight δ quanta) capacity hard required hRequired

/-- Full-actual-feasible-universe transport with obligations EXPOSED.
Completeness says every ACTUAL admissible outcome satisfies the ledger
(no unaccounted better competitor). Realisability says the selected
outcome is ACTUALLY feasible (not merely safe in the model).
Neither premise is inferred from mathematical quantisation alone.

No requirement to identify actual feasibility with the entire model:
one-sided coverage + one real candidate is sufficient. -/
theorem actual_full_universe_original_lex_maximal
    (δ : Nat → Nat) (quanta : Nat → Fact → Nat)
    (capacity : Nat → Nat) (hard : List Fact → Prop)
    (required : Outcome) (actual : Outcome → Prop)
    (hRequired : actual required)
    (hComplete : ∀ s, actual s →
      MeteredFeasible δ quanta capacity hard s)
    (hRealized : actual
      (IRMandatoryBaselineMaximality.finalProtected
        (IRResourceDerivedClosure.DerivedForbidden
          (quantumWeight δ quanta) capacity hard) required)) :
    UPTExist.LexAlignedL
      (fun s => actual s ∧ UPTExist.Sub required s)
      ([firstKey, secondKey] : List (Outcome → Nat → Prop))
      (IRMandatoryBaselineMaximality.finalProtected
        (IRResourceDerivedClosure.DerivedForbidden
          (quantumWeight δ quanta) capacity hard) required) := by
  have hModel :=
    metered_mandatory_original_lex_maximal
      δ quanta capacity hard required (hComplete required hRequired)
  constructor
  · exact ⟨hRealized, hModel.1.2⟩
  · intro other hActual hBetter
    exact hModel.2 other
      ⟨hComplete other hActual.1, hActual.2⟩ hBetter

#print axioms retained_fact_quanta_bounded
#print axioms metered_mandatory_original_lex_maximal
#print axioms actual_full_universe_original_lex_maximal

end PhysicalBridges.Rung5ExactLedgerLexJoin
