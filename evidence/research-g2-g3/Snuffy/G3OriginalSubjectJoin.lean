import Snuffy.G3Sweep

/-!
# G3: recovery for every explicitly owed subject

The subject-to-vertex correspondence is explicit, never inferred from
a proxy. The proof reuses the original G3 sweep and does not replace
the six original X3 obligations. No claim of actual-world coverage.
Not yet independently Lean-compiled.
-/

namespace Snuffy.G3OriginalSubjectJoin

/-- Every owed particular whose actual recovery vertex is in the
designated sweep region is restored to the target by that same sweep.
The source correspondence and coverage remain visible hypotheses. -/
theorem owed_subjects_recovered_by_same_sweep
    {Part V Val : Type*}
    (owed : Part → Prop)
    (vertex : Part → V)
    (layer : V → Nat)
    (corr : V → (V → Val) → Val)
    (outer : Nat → (V → Val) → (V → Val))
    (initial target : V → Val)
    (N : Nat)
    (hcorr : ∀ v s,
      (∀ u, layer u < layer v → s u = target u) →
      corr v s = target v)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v)
    (hcoverage : ∀ p, owed p → layer (vertex p) < N) :
    ∀ p, owed p →
      Snuffy.G3Sweep.sweep layer corr outer initial N (vertex p) =
        target (vertex p) := by
  intro p hp
  exact Snuffy.G3Sweep.sweep_recovers
    layer corr outer initial target hcorr hfence
    N (vertex p) (hcoverage p hp)

end Snuffy.G3OriginalSubjectJoin
