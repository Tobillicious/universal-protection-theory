import PhysicalBridges.CathedralCutGuardianCriterion

/-!
# Cyclic splice transfer and the PR #205 cut-guardian criterion

The minimal seam theorem consumes block agreement on the modeled CUT.
G2Splice.block_splice_run supplies it when the cut is the complete modeled
node assignment; a coarser quotient needs a separate compatibility proof.
The common starting cut and period are encoded by the shared closure target.

The guardian join additionally consumes an actual guarded source path.
It does not infer safe-action composition, source mediation, resources,
physical cyclicity, or original-X3 semantics from seam injectivity.
-/

namespace PhysicalBridges.CyclicSpliceTransfer

universe u v w x y z

variable {Node : Type u} {Value : Type v} {Block : Type w}

/-- Minimal theorem boundary: injectivity makes all donor terminal cuts
equal to a closed reference cut. Covering block agreement therefore
forces the spliced terminal cut to be the same cut, and hence closed.
No locality of the seam itself is needed. -/
theorem injective_seam_splice_closed
    (block : Block → Node → Prop)
    (hCover : ∀ n, ∃ b, block b n)
    (seam : (Node → Value) → (Node → Value))
    (hInjective : Function.Injective seam)
    (initial reference : Node → Value)
    (terminal : Block → (Node → Value))
    (spliced : Node → Value)
    (hReference : seam reference = initial)
    (hClosed : ∀ b, seam (terminal b) = initial)
    (hAgreement : ∀ b n, block b n → spliced n = terminal b n) :
    seam spliced = initial := by
  have hTerminal : ∀ b, terminal b = reference := by
    intro b
    exact hInjective ((hClosed b).trans hReference.symm)
  have hEndpoint : spliced = reference := by
    funext n
    obtain ⟨b, hb⟩ := hCover n
    exact (hAgreement b n hb).trans (congrFun (hTerminal b) n)
  exact (congrArg seam hEndpoint).trans hReference

open CathedralCutGuardianCriterion

/-- Factoring the entire allowed-safe-action predicate through a cut,
with inhabited safe choices, is sufficient for PR #205's criterion.
PR #205 only needs a COMMON safe selector on each protected fibre;
equality of the whole safe-action sets is not necessary. -/
theorem factored_nonempty_actions_have_fibre_guard
    {Source : Type x} {Action : Type y} {Observation : Type z}
    (observe : Source → Observation)
    (step : Source → Action → Source → Prop)
    (allowed : Source → Action → Prop) («protected» : Source → Prop)
    (safeAt : Observation → Action → Prop)
    (hFactors : ∀ s a, «protected» s →
      (GuardAction step allowed «protected» s a ↔ safeAt (observe s) a))
    (hNonempty : ∀ o, ∃ a, safeAt o a) :
    FibreHasGuard observe step allowed «protected» := by
  intro o
  obtain ⟨a, ha⟩ := hNonempty o
  refine ⟨a, ?_⟩
  intro s hs hp
  apply (hFactors s a hp).mpr
  simpa [hs] using ha

/-- Exact join with PR #205. Choice supplies one cut-only guardian.
Every spliced endpoint actually reached under that guardian is protected;
if its boundary agrees blockwise with the closed donors, it is cyclic too.

`PolicyReach` is the explicit execution/mediation obligation. Donor safety
alone does not assert that arbitrary mixed actions lie in this relation.
-/
theorem fibre_common_guardian_preserves_cyclic_splices
    {Source : Type x} {Action : Type y}
    (cut : Source → (Node → Value))
    (step : Source → Action → Source → Prop)
    (allowed : Source → Action → Prop) («protected» : Source → Prop)
    (hFibre : FibreHasGuard cut step allowed «protected»)
    (block : Block → Node → Prop)
    (hCover : ∀ n, ∃ b, block b n)
    (seam : (Node → Value) → (Node → Value))
    (hInjective : Function.Injective seam)
    (initial reference : Source)
    (donor : Block → Source)
    (hInitial : «protected» initial)
    (hReference : seam (cut reference) = cut initial)
    (hClosed : ∀ b, seam (cut (donor b)) = cut initial) :
    ∃ policy : (Node → Value) → Action,
      (∀ s, «protected» s →
        GuardAction step allowed «protected» s (policy (cut s))) ∧
      ∀ spliced : Source,
        IR109.PolicyReach step policy cut initial spliced →
        (∀ b n, block b n → cut spliced n = cut (donor b) n) →
        «protected» spliced ∧ seam (cut spliced) = cut initial := by
  obtain ⟨policy, hPolicy⟩ :=
    (guardian_exists_iff_fibre_has_common_action
      cut step allowed «protected»).mpr hFibre
  refine ⟨policy, hPolicy, ?_⟩
  intro spliced hPath hAgreement
  refine ⟨?_, ?_⟩
  · exact guardian_preserves_all_finite_source_paths
      cut step allowed «protected» policy hPolicy hPath hInitial
  · exact injective_seam_splice_closed
      block hCover seam hInjective (cut initial) (cut reference)
      (fun b => cut (donor b)) (cut spliced)
      hReference hClosed hAgreement

end PhysicalBridges.CyclicSpliceTransfer
