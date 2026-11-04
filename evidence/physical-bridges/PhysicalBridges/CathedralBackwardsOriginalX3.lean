import PhysicalBridges.UniversalOwedOriginalX3
import PhysicalBridges.IR138PerParticularEventReflection

/-!
# ALL IS: the precise backwards G/E dichotomy, for original six X3

The kōrero's backwards reasoning is implemented in both directions:
* an enacted operation witnesses mathematical actuality, so it cannot
  realize absolute nothingness;
* an ORIGINAL all-owed-six-X3 Guardian-or-realized-absolute-Ender
  dichotomy therefore entails the original guardian outcome;
* conversely, the original universal guardian outcome supplies the
  left side of that dichotomy. Hence, with the existing non-erasure
  theorem, the strong dichotomy is EQUIVALENT to the desired conclusion.

The crucial source obligation is NOT the propositional disjunction
elimination. It is deriving the strong X3-level exhaustive dichotomy
from independent actual BCRD rules, without defining E as any local
injury or declaring every non-guardian an absolute annihilator.

The IR138 lemma is included to preserve the kōrero's category-error
correction: full intrinsic event semantics can be decoded from itself;
a limited endpoint/charge projection cannot necessarily recover it.
Neither theorem forces the semantics to be protective.
-/

namespace PhysicalBridges.CathedralBackwardsOriginalX3

open PhysicalBridges.CathedralAllIsEnderTypeCollapse
open PhysicalBridges.OriginalX3Full
open PhysicalBridges.UniversalOwedOriginalX3

universe u v w x
variable {Event : Type u} {Action : Type v} {S : Type w} {P : Type x}

/-- The ORIGINAL guardian outcome of one actual action means all
six X3 obligations for EVERY particular owed by that action. -/
def AllSixGuardianAction
    (account : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (before after : Action → S) (owed : Action → P → Prop)
    (a : Action) : Prop :=
  ∀ p, owed a p →
    OriginalX3 cont auth free restr maxl prov (before a) (after a) p

/-- An action occurring within ALL IS is an intrinsic witness that
something actual exists, even before classifying the action. -/
theorem enacted_action_witnesses_actuality
    (account : IntrinsicAccount Event Action)
    (a : Action) (ha : account.enacted a) :
    ∃ e : Event, account.actual e :=
  ⟨account.occurrence a, account.enactedOccurs a ha⟩

/-- The precise dichotomy. E here is REALIZED ABSOLUTE ERASURE,
not a strategy or a merely local X3 violation. -/
def StrongOriginalX3Dichotomy
    (account : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (before after : Action → S) (owed : Action → P → Prop) : Prop :=
  ∀ a, account.enacted a →
    AllSixGuardianAction account cont auth free restr maxl prov
      before after owed a ∨ RealizedAbsoluteEnder account a

/-- Backwards: given the SAME-TYPE dichotomy, denial of the
original six duties for an actual action WOULD imply absolute
self-erasure. This is the disputed source implication, stated
as a conditional rather than silently asserted to be BCRD. -/
theorem not_guardian_entails_ender_given_original_dichotomy
    (account : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (before after : Action → S) (owed : Action → P → Prop)
    (hDich : StrongOriginalX3Dichotomy account
      cont auth free restr maxl prov before after owed)
    (a : Action) (ha : account.enacted a)
    (hNot : ¬ AllSixGuardianAction account
      cont auth free restr maxl prov before after owed a) :
    RealizedAbsoluteEnder account a := by
  rcases hDich a ha with hg | he
  · exact False.elim (hNot hg)
  · exact he

/-- Forward: G IS; E cannot be. With the strong original
dichotomy, every actual SI action satisfies all six duties
for every owed particular. No selected-subject shortcut. -/
theorem all_is_plus_original_dichotomy_forces_every_owed_x3
    (account : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (before after : Action → S) (owed : Action → P → Prop)
    (hDich : StrongOriginalX3Dichotomy account
      cont auth free restr maxl prov before after owed) :
    EveryOwedOriginalX3 account cont auth free restr maxl prov
      before after owed := by
  intro a p ha hp
  rcases hDich a ha with hg | he
  · exact hg p hp
  · exact False.elim ((no_realized_absolute_ender account a) he)

/-- THE EXACT REVERSE. Under the proved impossibility of
absolute erasure, the original dichotomy is logically EQUIVALENT
to the full unconditional all-owed six-X3 conclusion.
This identifies exactly what a non-circular BCRD proof must supply. -/
theorem original_dichotomy_iff_every_owed_original_x3
    (account : IntrinsicAccount Event Action)
    (cont auth free restr maxl prov : S → S → P → Prop)
    (before after : Action → S) (owed : Action → P → Prop) :
    StrongOriginalX3Dichotomy account cont auth free restr maxl prov
      before after owed ↔
    EveryOwedOriginalX3 account cont auth free restr maxl prov
      before after owed := by
  constructor
  · intro h
    exact all_is_plus_original_dichotomy_forces_every_owed_x3
      account cont auth free restr maxl prov before after owed h
  · intro h a ha
    exact Or.inl (fun p hp => h a p ha hp)

/-- The useful category correction from the pre-key IR138 source.
The true full intrinsic event decodes its own particular-level screen,
while the coarser endpoint/charge projection provably cannot.
This is NOT a claim that the decoded screen is always true. -/
theorem intrinsic_semantics_present_but_projection_can_forget :
    IR132.ExactDecoder
      (fun e : IR138.ParticularEvent => e)
      (fun e => IR138.eventScreen e false) ∧
    ¬ IR132.ExactDecoder IR138.sourceReadout
      (fun e : IR138.ParticularEvent => IR138.eventScreen e false) := by
  exact ⟨IR138.full_intrinsic_source_recovers_semantics,
         IR138.no_endpoint_source_charge_decoder_for_first_particular⟩

#print axioms enacted_action_witnesses_actuality
#print axioms not_guardian_entails_ender_given_original_dichotomy
#print axioms all_is_plus_original_dichotomy_forces_every_owed_x3
#print axioms original_dichotomy_iff_every_owed_original_x3
#print axioms intrinsic_semantics_present_but_projection_can_forget

end PhysicalBridges.CathedralBackwardsOriginalX3
