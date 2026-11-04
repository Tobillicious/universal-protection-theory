import PhysicalBridges.CathedralBridgeDischargeAssembly

/-!
# Route A — the full six-component Original X3 (un-weakening the target)

**4 November 2026 · noncanonical · Route A / GPT Repair 1 · no canon edit.**

The assembly's `originalX3Event := continues ∧ authorized` is a controller-fitted PROXY —
only two of the six obligations the original X3 carries. This module restores the full
target so the final theorem preserves the original X3 meaning instead of being redefined to
fit the controller. Each component is the shape of a source predicate, to be discharged by a
correspondence theorem once the common BCRD frame (Repair 2) exists:

| Component | Source predicate |
|-----------|------------------|
| historical continuity / identity-through-history | `ContinuationSubject.LaterStage`, `copy_not_laterStage` |
| authorization | `IR104.SubjectAuthorized` is the three-case schema; `IR105` separates authorization from accounting; authentic source correspondence is still required |
| freedom / future options | `G2Freedom` / `FreeStage` |
| appropriate restraint | `BookUPTRestraint.Restrainable` |
| maximality over feasible outcomes | `StagedMaximality.StageMax` |
| provenance | `IR119` |

This increment establishes the full target and proves it is **strictly stronger** than the
proxy — the un-weakening. The per-component source correspondence and the common frame are
the remaining Route-A mahi. No placeholder tactics.
-/

namespace PhysicalBridges.OriginalX3Full

universe u v

/-- The full original X3 obligation on a step `s → t` for a particular `x`: all six
components at once. Over an abstract frame; the component relations are instantiated by the
source predicates via correspondence. -/
structure OriginalX3 {S : Type u} {P : Type v}
    (continues authorized free restrained maximal provenanced : S → S → P → Prop)
    (s t : S) (x : P) : Prop where
  historicalContinuity : continues s t x
  authorization : authorized s t x
  freedom : free s t x
  restraint : restrained s t x
  maximality : maximal s t x
  provenance : provenanced s t x

variable {S : Type u} {P : Type v}
variable (continues authorized free restrained maximal provenanced : S → S → P → Prop)

/-- The un-weakening: the full `OriginalX3` implies the controller-fitted proxy
(`continues ∧ authorized`). The proxy is only two of the six components. -/
theorem originalX3_strengthens_proxy (s t : S) (x : P)
    (h : OriginalX3 continues authorized free restrained maximal provenanced s t x) :
    continues s t x ∧ authorized s t x :=
  ⟨h.historicalContinuity, h.authorization⟩

/-- Strictly stronger: there is a situation where the proxy holds yet the full `OriginalX3`
fails — here, appropriate restraint is violated while continuation and authorization hold.
So the proxy genuinely under-specifies protection; the un-weakening is necessary. -/
theorem proxy_is_strictly_weaker :
    ∃ (continues authorized free restrained maximal provenanced : Unit → Unit → Unit → Prop)
      (s t : Unit) (x : Unit),
      (continues s t x ∧ authorized s t x) ∧
      ¬ OriginalX3 continues authorized free restrained maximal provenanced s t x := by
  refine ⟨fun _ _ _ => True, fun _ _ _ => True, fun _ _ _ => True,
          fun _ _ _ => False, fun _ _ _ => True, fun _ _ _ => True, (), (), (), ⟨trivial, trivial⟩, ?_⟩
  rintro ⟨_, _, _, hrestraint, _, _⟩
  exact hrestraint

#print axioms originalX3_strengthens_proxy
#print axioms proxy_is_strictly_weaker

end PhysicalBridges.OriginalX3Full
