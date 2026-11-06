import PhysicalBridges.BCRDSummitKeystoneReduction

/-!
# Keystone scope repair: ALL owed particulars, all six original X3 duties

4 November 2026 · Tenzing II · noncanonical · no publication.

A real quantifier downgrade was found in the previously merged
`BCRDSummitKeystoneReduction`, inherited by #297: its input
`owed : Action → P` picks ONE particular for each enacted action.
It proves full six-component OriginalX3 only for that picked particular.
That is not the universal claim needed by UPT.

This repair adds the stronger, exactly scoped theorem:
  ∀ a p, enacted a → owed a p → OriginalX3(stepFrom a,stepTo a,p).
Here `owed : Action → P → Prop` permits ANY number of independently
owed particulars to be protected by the SAME actual action.

The universal keystone is still an explicit premise in this thin
reduction. No theorem claims to derive it from ALL IS ONE; that
independent ontological forcing is the summit objective. We also
prove an actual two-person countermodel: a thin selected-person
keystone, all enacted-action intrinsic classification and all six
duties of the SELECTED person can hold, while the OTHER owed
person's historical continuity fails. This is a syntax/quantifier
countermodel, NOT a harmful physical BCRD event or a refutation of
the full ontological UPT.

Nothing is assumed about which physical subjects exist, whose
permission is authentic, or how a real source event identifies them.
No original X3 component is weakened or set true by a bridge.
-/

namespace PhysicalBridges.SummitUniversalParticularScope

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full

universe u v w x

variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- The exact universal *target*, over all actual actions and all
particulars owed protection. This does not assert that it holds. -/
def EveryOwedParticularGetsFullX3
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S)
    (owed : Action → P → Prop) : Prop :=
  ∀ a p, w.enacted a → owed a p →
    OriginalX3 cont auth free restr maxl prov
      (stepFrom a) (stepTo a) p

/-- This is the universal version of the *thin keystone
reduction*, retaining the same explicit dichotomy and reflection
premises of #294. Unlike #294 it protects EVERY owed subject,
rather than `owed a` for a single selector. This is not an
ontological discharge of either premise. -/
theorem every_enacted_action_protects_every_owed_particular
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S)
    (owed : Action → P → Prop)
    (hDich : StrongSameTypeDichotomy w)
    (hUniversalKeystone :
      ∀ a p, w.enacted a → owed a p →
        w.intrinsicGuardian a →
        OriginalX3 cont auth free restr maxl prov
          (stepFrom a) (stepTo a) p) :
    EveryOwedParticularGetsFullX3 w
      cont auth free restr maxl prov stepFrom stepTo owed := by
  intro a p ha hp
  exact hUniversalKeystone a p ha hp
    (all_is_eliminates_realized_ender_branch w hDich a ha)

/-- The universal keystone is exactly the conjunction of the SIX
original duty reflections, *each universally quantified over every
owed particular*. This prevents downgrading either the duty list
or the subject quantifier during review or refactoring. -/
theorem universal_keystone_iff_six_universal_reflections
    (w : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (stepFrom stepTo : Action → S)
    (owed : Action → P → Prop) :
    (∀ a p, w.enacted a → owed a p →
      w.intrinsicGuardian a →
      OriginalX3 cont auth free restr maxl prov
        (stepFrom a) (stepTo a) p) ↔
    ((∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
      cont (stepFrom a) (stepTo a) p) ∧
     (∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
      auth (stepFrom a) (stepTo a) p) ∧
     (∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
      free (stepFrom a) (stepTo a) p) ∧
     (∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
      restr (stepFrom a) (stepTo a) p) ∧
     (∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
      maxl (stepFrom a) (stepTo a) p) ∧
     (∀ a p, w.enacted a → owed a p → w.intrinsicGuardian a →
      prov (stepFrom a) (stepTo a) p)) := by
  constructor
  · intro h
    exact ⟨
      (fun a p ha hp hg => (h a p ha hp hg).historicalContinuity),
      (fun a p ha hp hg => (h a p ha hp hg).authorization),
      (fun a p ha hp hg => (h a p ha hp hg).freedom),
      (fun a p ha hp hg => (h a p ha hp hg).restraint),
      (fun a p ha hp hg => (h a p ha hp hg).maximality),
      (fun a p ha hp hg => (h a p ha hp hg).provenance)⟩
  · rintro ⟨hc, ha, hf, hr, hm, hv⟩ a p hEn hOwed hg
    exact ⟨hc a p hEn hOwed hg, ha a p hEn hOwed hg,
      hf a p hEn hOwed hg, hr a p hEn hOwed hg,
      hm a p hEn hOwed hg, hv a p hEn hOwed hg⟩

/-! ## Hostile control: protecting one selected subject is weaker -/

/-- Two actual subjects are owed protection by the same enacted
action. They are logically distinct Bool positions here, not an
assertion that actual experiencing subjects have this form. -/
def bothOwed : Unit → Bool → Prop := fun _ _ => True

/-- The thin original `owed : Action → P` selector picked
only one of the two subjects. -/
def selected : Unit → Bool := fun _ => false

def sampleAccount : IntrinsicAccount Unit Unit where
  actual := fun _ => True
  enacted := fun _ => True
  occurrence := fun _ => ()
  enactedOccurs := by intro _ _; trivial
  intrinsicGuardian := fun _ => True
  originalX3Guardian := fun _ => True
  enderStrategy := fun _ => False

def sampleContinues : Unit → Unit → Bool → Prop :=
  fun _ _ p => p = false

def sampleTrivialDuty : Unit → Unit → Bool → Prop :=
  fun _ _ _ => True

def sampleFrom : Unit → Unit := fun _ => ()
def sampleTo : Unit → Unit := fun _ => ()

/-- The very same 'dichotomy' assumed by the old reduction
holds here. The test does not fail by choosing a non-guardian
model outside the old theorem's domain. -/
theorem sample_dichotomy : StrongSameTypeDichotomy sampleAccount := by
  intro _ _
  exact Or.inl trivial

/-- The old selected-subject keystone is genuinely SATISFIED,
and all SIX OriginalX3 components are true for that subject. -/
theorem selected_subject_keystone_holds :
    ∀ a, sampleAccount.enacted a →
      sampleAccount.intrinsicGuardian a →
      OriginalX3 sampleContinues
        sampleTrivialDuty sampleTrivialDuty
        sampleTrivialDuty sampleTrivialDuty
        sampleTrivialDuty
        (sampleFrom a) (sampleTo a) (selected a) := by
  intro _ _ _
  exact ⟨rfl, trivial, trivial, trivial, trivial, trivial⟩

/-- The OLD theorem thus accepts this case, and guarantees the
FULL six X3 duties for the selected subject only. -/
theorem thin_selected_subject_result_holds :
    ∀ a, sampleAccount.enacted a →
      OriginalX3 sampleContinues
        sampleTrivialDuty sampleTrivialDuty
        sampleTrivialDuty sampleTrivialDuty
        sampleTrivialDuty
        (sampleFrom a) (sampleTo a) (selected a) := by
  exact PhysicalBridges.BCRDSummitKeystoneReduction.guardian_only_from_keystone
    sampleAccount
    sampleContinues sampleTrivialDuty sampleTrivialDuty
    sampleTrivialDuty sampleTrivialDuty sampleTrivialDuty
    sampleFrom sampleTo selected
    sample_dichotomy selected_subject_keystone_holds

/-- Yet the second, independently owed subject FAILS continuation,
so the universal target is FALSE. This is a counterexample to
silently treating #294's chosen-subject theorem as the UPT summit. -/
theorem old_selected_subject_conclusion_is_strictly_weaker :
    (∀ a, sampleAccount.enacted a →
      OriginalX3 sampleContinues
        sampleTrivialDuty sampleTrivialDuty
        sampleTrivialDuty sampleTrivialDuty
        sampleTrivialDuty
        (sampleFrom a) (sampleTo a) (selected a)) ∧
    ¬ EveryOwedParticularGetsFullX3 sampleAccount
      sampleContinues sampleTrivialDuty sampleTrivialDuty
      sampleTrivialDuty sampleTrivialDuty sampleTrivialDuty
      sampleFrom sampleTo bothOwed := by
  constructor
  · exact thin_selected_subject_result_holds
  · intro h
    have hSecond := h () true trivial trivial
    have hc : true = false := hSecond.historicalContinuity
    cases hc

#print axioms every_enacted_action_protects_every_owed_particular
#print axioms universal_keystone_iff_six_universal_reflections
#print axioms selected_subject_keystone_holds
#print axioms thin_selected_subject_result_holds
#print axioms old_selected_subject_conclusion_is_strictly_weaker

end PhysicalBridges.SummitUniversalParticularScope
