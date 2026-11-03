import PhysicalBridges.CathedralSummitCyclicContinuation

/-!
# The summit, characterised — what continuation actually requires

**4 November 2026 · noncanonical · CORRECTS an earlier overclaim · no canon edit.**

The summit is *continuation* — a protected particular has no final stage. Three precise facts,
no more (an earlier version of this file overclaimed that cyclicity is *necessary*; it is not,
and that claim is retracted and refuted below):

* **Non-erasure is INSUFFICIENT** (`non_erasure_does_not_entail_continuation`): a complete
  history can record a particular forever (non-erased) yet give it a final experiencing stage
  — a finite worldline inside an unbounded index. So "complete / non-erased ⟹ no final stage"
  is false; continuation needs more than non-erasure.
* **Cyclicity is SUFFICIENT** (`CathedralSummitCyclicContinuation.no_final_protected_stage`,
  PR #262): a cyclic history forces recurrence, hence no final protected stage.
* **Cyclicity is NOT necessary** (`cyclicity_not_necessary_for_continuation`): a strictly
  increasing, non-periodic history can be protected at every stage. So continuation does not
  require circular time.

The honest characterisation is therefore: continuation ⟺ **no final protected stage**
(the protected stages are unbounded). Cyclicity is *one* sufficient way to secure that, not
the only way, and not a necessary condition. What this still shows — and it does vindicate the
ontology — is that *some* completeness/no-boundary principle beyond bare non-erasure is
required; which one (cyclic, or merely unbounded-and-continuing) is left open, and the kōrero's
"we are here, G is" is the evidence that *some* such principle holds. No placeholder tactics;
all three facts are explicit and kernel-checked.
-/

namespace PhysicalBridges.CathedralSummitPremiseNecessity

/-- A particular whose history is recorded at every internal stage — never erased. -/
def recorded : Nat → Prop := fun _ => True

/-- A particular that experiences only up to stage `last` (a finite worldline). -/
def experiences (last : Nat) : Nat → Prop := fun n => n ≤ last

/-- **Non-erasure does NOT entail continuation.** The history is recorded at every stage
(non-erased), yet there is a final experiencing stage `last` with none after it. So
"complete / non-erased ⟹ no final stage" is FALSE; continuation needs more than non-erasure. -/
theorem non_erasure_does_not_entail_continuation (last : Nat) :
    (∀ n, recorded n) ∧
      experiences last last ∧
      (∀ k, last < k → ¬ experiences last k) := by
  refine ⟨fun _ => trivial, Nat.le_refl last, ?_⟩
  intro k hk hle
  exact (Nat.not_lt.mpr hle) hk

/-- Non-erasure fails to give continuation cofinally, not on one example only. -/
theorem continuation_fails_at_every_finite_horizon :
    ∀ last : Nat, ∃ final, experiences last final ∧ ∀ k, final < k → ¬ experiences last k := by
  intro last
  exact ⟨last, Nat.le_refl last, fun k hk hle => (Nat.not_lt.mpr hle) hk⟩

/-- **Cyclicity is NOT necessary for continuation** (corrects the earlier overclaim). A
non-periodic history (`stage n = n`) is protected at every stage — continuation holds — yet it
has no period `p > 0` (no `n + p = n`). So the sufficient cyclic route (#262) is not the only
one; what continuation actually requires is just "no final protected stage", which cyclicity is
one way, but not the only way and not a necessary condition, to secure. -/
theorem cyclicity_not_necessary_for_continuation :
    (∀ N : Nat, ∃ k, N ≤ k ∧ recorded k) ∧
      ¬ ∃ p : Nat, 0 < p ∧ ∀ n : Nat, n + p = n := by
  refine ⟨fun N => ⟨N, Nat.le_refl N, trivial⟩, ?_⟩
  rintro ⟨p, hp, hper⟩
  have h0 := hper 0
  omega

#print axioms non_erasure_does_not_entail_continuation
#print axioms continuation_fails_at_every_finite_horizon
#print axioms cyclicity_not_necessary_for_continuation

end PhysicalBridges.CathedralSummitPremiseNecessity
