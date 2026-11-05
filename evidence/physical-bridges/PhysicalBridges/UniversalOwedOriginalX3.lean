import PhysicalBridges.BCRDSummitKeystoneReduction

/-!
# Exact universal-owed quantification in the original six-X3 summit

The old #290 theorem chose ONE `owed a` for each action. This faithful
strengthening protects EVERY actual owed particular `p` for each enacted
action and retains all six fields of OriginalX3Full.OriginalX3.

The proof does not weaken or invent the missing source reflection.
Both the SAME-TYPE guardian/ender dichotomy and ALL-OWED keystone are
visible premises; the latter is exactly equivalent to the desired
universal six-X3 conclusion under the dichotomy. This prevents a
selected-particular certificate being advertised as universal UPT.
-/

namespace PhysicalBridges.UniversalOwedOriginalX3

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w x
variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- The MAXIMAL duty scope: each enacted action, each owed particular,
and every one of the original six duties on THAT same actual transition. -/
def EveryOwedOriginalX3
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P → Prop) : Prop :=
  ∀ a p, w.enacted a → owed a p →
    OriginalX3 cont auth free restr maxl prov (stepFrom a) (stepTo a) p

/-- Precisely the still-required source reflection, with NO
selected-particular narrowing and no protection-as-admissibility rule. -/
def AllOwedKeystone
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P → Prop) : Prop :=
  ∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
    OriginalX3 cont auth free restr maxl prov (stepFrom a) (stepTo a) p

/-- Exact all-particular version of the #290 summit. The positive
conclusion is NOT stated with an X3 proxy or one selected `owed a`. -/
theorem guardian_only_for_every_owed_particular
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P → Prop)
    (hDich : StrongSameTypeDichotomy w)
    (hKeystone :
      AllOwedKeystone w cont auth free restr maxl prov stepFrom stepTo owed) :
    EveryOwedOriginalX3 w cont auth free restr maxl prov
      stepFrom stepTo owed := by
  intro a p hEnacted hOwed
  exact hKeystone a p hEnacted hOwed
    (all_is_eliminates_realized_ender_branch w hDich a hEnacted)

/-- There is NO hidden free discharge: under the dichotomy the
all-owed keystone is logically equivalent to the all-owed X3 outcome.
A future proof must derive its content from actual source semantics. -/
theorem all_owed_keystone_iff_universal_x3
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S) (owed : Action → P → Prop)
    (hDich : StrongSameTypeDichotomy w) :
    AllOwedKeystone w cont auth free restr maxl prov stepFrom stepTo owed ↔
    EveryOwedOriginalX3 w cont auth free restr maxl prov stepFrom stepTo owed := by
  constructor
  · intro h
    exact guardian_only_for_every_owed_particular w
      cont auth free restr maxl prov stepFrom stepTo owed hDich h
  · intro h a p hEnacted hOwed _hIntrinsic
    exact h a p hEnacted hOwed

/-- A real negative control for the old selected-owed interface:
a full six-X3 proof at one selected particular is compatible with
the failure of historical continuity for a different owed particular. -/
def selectedOnlyContinuity : Unit → Unit → Bool → Prop :=
  fun _ _ p => p = true

def universalOtherDuty : Unit → Unit → Bool → Prop :=
  fun _ _ _ => True

theorem selected_owed_certificate_does_not_cover_every_particular :
    OriginalX3 selectedOnlyContinuity universalOtherDuty
      universalOtherDuty universalOtherDuty universalOtherDuty universalOtherDuty
      () () true ∧
    ¬ (∀ p : Bool,
      OriginalX3 selectedOnlyContinuity universalOtherDuty
        universalOtherDuty universalOtherDuty universalOtherDuty universalOtherDuty
        () () p) := by
  constructor
  · exact ⟨rfl, trivial, trivial, trivial, trivial, trivial⟩
  · intro h
    have hBad := (h false).historicalContinuity
    exact (by decide : ¬ (false = true)) hBad

#print axioms guardian_only_for_every_owed_particular
#print axioms all_owed_keystone_iff_universal_x3
#print axioms selected_owed_certificate_does_not_cover_every_particular

end PhysicalBridges.UniversalOwedOriginalX3
