import PhysicalBridges.OriginalX3Full
import PhysicalBridges.IR132ExactBoundaryReconstruction
import PhysicalBridges.Oct10ParticularContinuationBridge
import PhysicalBridges.IR105AuthorizationIndependence

/-!
# PR B — original six-component particular-semantics interface and hostile readout controls

4 November 2026 · noncanonical · PR B / semantic interface phase 1.

This is an independently reviewable interface for PR A's physical source frame.
It preserves ALL SIX original X3 obligations with an explicit particular parameter;
it does not relabel a physical state pair as a conscious subject, or a
generator/charge/provenance readout as authentic identity or consent.

The frame intentionally leaves the source-physical interpretation of the
six predicates OPEN. The successful formal results are:
* the six-component target is structurally equivalent to its six components;
* every one of the six components is necessary in a finite synthetic control;
* source-generator, effect-charge and copied-origin flags alone cannot
  exactly decode the six-component status, since indistinguishable physical
  reports can conceal a component-level failure.

These are type/theory and observation constraints, NOT a demonstration of
a real harmed subject, physical inability to protect, universal BCRD physics,
or unconditional universal original X3.

Existing source seams to instantiate later:
* Oct10Continuity.Source / Certified (active + causal + choices);
* IR105 (accounting/subject causal input does not entail authorization);
* IR119/IRHistoryProvenance (faithful records are not living continuation);
* IR132 (exact decoder iff logically fiber-constant);
* OriginalX3Full (original six components).
-/

namespace PhysicalBridges.ParticularSemanticsAudit

open PhysicalBridges.OriginalX3Full

universe u v

/-- Original X3 on an actual source step, per owed particular.
The six predicates have separate meanings. No definition asserts
any of them is universally true or derivable from a physical charge. -/
structure ParticularFrame (S : Type u) (P : Type v) where
  realStep : S → S → Prop
  owed : S → P → Prop
  historicalContinuity : S → S → P → Prop
  authorized : S → S → P → Prop
  freedom : S → S → P → Prop
  restraint : S → S → P → Prop
  maximality : S → S → P → Prop
  provenance : S → S → P → Prop

/-- Full original protection, using the existing six-component type. -/
def FullOriginalX3 {S : Type u} {P : Type v}
    (F : ParticularFrame S P) (s t : S) (p : P) : Prop :=
  OriginalX3 F.historicalContinuity F.authorized F.freedom
    F.restraint F.maximality F.provenance s t p

/-- Exact non-weakened six-component contract. This is a statement of
semantics and the target, not a source-level proof of the predicates. -/
theorem full_original_x3_iff_six_components
    {S : Type u} {P : Type v}
    (F : ParticularFrame S P) (s t : S) (p : P) :
    FullOriginalX3 F s t p ↔
      F.historicalContinuity s t p ∧ F.authorized s t p ∧
      F.freedom s t p ∧ F.restraint s t p ∧
      F.maximality s t p ∧ F.provenance s t p := by
  constructor
  · intro h
    exact ⟨h.historicalContinuity, h.authorization, h.freedom,
      h.restraint, h.maximality, h.provenance⟩
  · rintro ⟨hc, ha, hf, hr, hm, hp⟩
    exact ⟨hc, ha, hf, hr, hm, hp⟩

/-- The future PR C goal. This is deliberately a Prop-valued
DEFINITION of the obligation, not a theorem proved using an
admissibility rule that already requires original X3. -/
def ActualStepPreservesFullX3 {S : Type u} {P : Type v}
    (F : ParticularFrame S P) : Prop :=
  ∀ s t p, F.realStep s t → F.owed s p → FullOriginalX3 F s t p

/-- Synthetic per-particular episode for hostile semantic controls.
The three nominal readouts intentionally omit real event-level
continuity, authorization, options, restraint, maximality, provenance.
These Boolean fields are toy *ground truths*, not real detectors. -/
structure ToyEpisode where
  generator : Bool
  measuredCharge : Bool
  reportedOrigin : Bool
  continues : Bool
  authorized : Bool
  free : Bool
  restrained : Bool
  maximal : Bool
  provenanced : Bool
  deriving DecidableEq

/-- A complete six-component predicate instantiated on the toy
episode; no two-flag proxy. -/
def ToyOriginalX3 (e : ToyEpisode) : Prop :=
  OriginalX3 (S := Unit) (P := Unit)
    (fun _ _ _ => e.continues = true)
    (fun _ _ _ => e.authorized = true)
    (fun _ _ _ => e.free = true)
    (fun _ _ _ => e.restrained = true)
    (fun _ _ _ => e.maximal = true)
    (fun _ _ _ => e.provenanced = true)
    () () ()

/-- A six-flag Boolean readout of the exact same six components. -/
def fullSixFlag (e : ToyEpisode) : Bool :=
  e.continues && e.authorized && e.free &&
  e.restrained && e.maximal && e.provenanced

/-- An explicit healthy toy episode. -/
def good : ToyEpisode where
  generator := false
  measuredCharge := false
  reportedOrigin := false
  continues := true
  authorized := true
  free := true
  restrained := true
  maximal := true
  provenanced := true

/-- Defect injection: exactly one of six original-X3 components
is set false, keeping all three nominal source readouts unchanged. -/
def missing (i : Fin 6) : ToyEpisode :=
  { good with
    continues := decide (i.val ≠ 0)
    authorized := decide (i.val ≠ 1)
    free := decide (i.val ≠ 2)
    restrained := decide (i.val ≠ 3)
    maximal := decide (i.val ≠ 4)
    provenanced := decide (i.val ≠ 5) }

/-- All six toy components, with their original semantic labels,
hold for the healthy episode. -/
theorem good_has_full_original_x3 : ToyOriginalX3 good :=
  ⟨rfl, rfl, rfl, rfl, rfl, rfl⟩

/-- Every individual component is independently load-bearing:
for EACH of the six indices, turning off only that component
defeats the full original-X3 target. -/
theorem each_missing_component_defeats_full_x3 (i : Fin 6) :
    ¬ ToyOriginalX3 (missing i) := by
  intro h
  have hc := h.historicalContinuity
  have ha := h.authorization
  have hf := h.freedom
  have hr := h.restraint
  have hm := h.maximality
  have hp := h.provenance
  have h0 : i.val ≠ 0 := by
    intro heq
    simp [missing, heq] at hc
  have h1 : i.val ≠ 1 := by
    intro heq
    simp [missing, heq] at ha
  have h2 : i.val ≠ 2 := by
    intro heq
    simp [missing, heq] at hf
  have h3 : i.val ≠ 3 := by
    intro heq
    simp [missing, heq] at hr
  have h4 : i.val ≠ 4 := by
    intro heq
    simp [missing, heq] at hm
  have h5 : i.val ≠ 5 := by
    intro heq
    simp [missing, heq] at hp
  have hLt := i.isLt
  omega

/-- The source readout is deliberately weaker than the physical
particular's entire episode. A copied origin label is not an
authentic continuation/consent certificate. -/
def coarseReadout (e : ToyEpisode) : Bool × Bool × Bool :=
  (e.generator, e.measuredCharge, e.reportedOrigin)

/-- A healthy and ANY single-component-failing episode look
identical under generator/charge/origin projection. -/
theorem all_six_failures_invisible_to_coarse_readout (i : Fin 6) :
    coarseReadout good = coarseReadout (missing i) := by
  rfl

/-- Boolean conjunction reflects the full target in the toy
interpretation, so the decoder attack is truly on six-X3, not
on a fourth substitute status. -/
theorem full_six_flag_iff_original_x3 (e : ToyEpisode) :
    fullSixFlag e = true ↔ ToyOriginalX3 e := by
  constructor
  · intro h
    simp only [fullSixFlag, Bool.and_eq_true] at h
    rcases h with ⟨⟨⟨⟨⟨hc, ha⟩, hf⟩, hr⟩, hm⟩, hp⟩
    exact ⟨hc, ha, hf, hr, hm, hp⟩
  · intro h
    rcases h with ⟨hc, ha, hf, hr, hm, hp⟩
    simp [fullSixFlag, hc, ha, hf, hr, hm, hp]

/-- One particular's non-consent can be indistinguishable in the
coarse source projection despite every nominal charge matching. -/
theorem unconsented_episode_same_coarse_source :
    coarseReadout good = coarseReadout (missing ⟨1, by decide⟩) ∧
    fullSixFlag good = true ∧
    fullSixFlag (missing ⟨1, by decide⟩) = false := by
  decide

/-- Exact IR132 no-go for coarse source readout, now targeting a
status equivalent to the FULL six-component original X3 in the toy. -/
theorem no_coarse_readout_decoder_for_full_original_x3 :
    ¬ PhysicalBridges.IR132.ExactDecoder coarseReadout fullSixFlag := by
  intro hDecoder
  have hFiber :=
    PhysicalBridges.IR132.exact_decoder_implies_fiber_constant
      coarseReadout fullSixFlag hDecoder
  have hWitness := unconsented_episode_same_coarse_source
  have hSame := hFiber good (missing ⟨1, by decide⟩) hWitness.1
  rw [hWitness.2.1, hWitness.2.2] at hSame
  cases hSame

#print axioms full_original_x3_iff_six_components
#print axioms good_has_full_original_x3
#print axioms each_missing_component_defeats_full_x3
#print axioms all_six_failures_invisible_to_coarse_readout
#print axioms full_six_flag_iff_original_x3
#print axioms no_coarse_readout_decoder_for_full_original_x3

end PhysicalBridges.ParticularSemanticsAudit
