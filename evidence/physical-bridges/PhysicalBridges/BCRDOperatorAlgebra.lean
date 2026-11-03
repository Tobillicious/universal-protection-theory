import PhysicalBridges.FrozenBCRDEvents
import PhysicalBridges.BCRDActualRelationalFrame

/-!
# PR A (addendum) — The frozen operator is a *-automorphism

Answers Tenzing's formal review of PR A (#286): the demonstrated event
`evolve_realises_event` checks the actual matrix evolution on the single basis
density `|M0⟩⟨M0|`; `step` acts on *arbitrary* six-position configurations. This
module supplies the missing correspondence connecting the two representations —
and, as it turns out, the full operator-algebra automorphism it rests on —
entirely in this mathlib-free lane.

The engine is a single per-entry lemma, `evolve_entry`: conjugation by the frozen
unitary `W` (a permutation matrix) merely permutes row/column indices,
`evolve A i j = A (permutation i) (permutation j)`. Proven by a finite case
split over `Fin 6`, it reduces every operator-algebra law to a reindexing. No
`ring`/`norm_num` (which this lane lacks) is needed; the earlier deferral of this
result to a mathlib-enabled lane is hereby discharged in-lane.

**Boundary discipline (unchanged from PR A).** This is algebraic/representational
covariance of the frozen operator. It is NOT consent, agency, subject continuity,
or any OriginalX3 component (PR B, #285), and establishes no first-violation
necessity (PR C). It is scoped to the frozen 6×6 integer source operator — it does
not promote to all of BCRD without a separate source-coverage theorem.
-/
namespace PhysicalBridges.BCRDOperatorAlgebra

open FrozenBCRDEvents

/-! ## The frozen unitary's entries, as clean arithmetic -/

/-- `W i j = 1` exactly when `j = permutation i`, else `0`. Proven by exhaustive
check — this is the lever that lets `simp` compute, replacing the opaque
`ofRows`/`List.getD` lookups with a decidable condition. -/
theorem wUpdate_apply : ∀ i j : Index, wUpdate i j = if j = permutation i then 1 else 0 := by
  decide

/-- The six values of the frozen position permutation (M-sector `2↔3` swap),
as rewrite rules. -/
@[simp] theorem permutation_0 : permutation 0 = 0 := by decide
@[simp] theorem permutation_1 : permutation 1 = 1 := by decide
@[simp] theorem permutation_2 : permutation 2 = 3 := by decide
@[simp] theorem permutation_3 : permutation 3 = 2 := by decide
@[simp] theorem permutation_4 : permutation 4 = 4 := by decide
@[simp] theorem permutation_5 : permutation 5 = 5 := by decide

/-- The permutation is an involution: `perm ∘ perm = id`. -/
theorem permutation_involutive : ∀ x : Index, permutation (permutation x) = x := by decide

/-! ## The master lemma -/

/-- **Conjugation by `W` permutes indices.** For the frozen operator
`evolve A = W A Wᵀ`, every entry satisfies `evolve A i j = A (perm i) (perm j)`.
Arbitrary `A`; proven by a finite `Fin 6 × Fin 6` case split (`omega` kills the
out-of-range branches, `simp` with the lever and `decide := true` closes the six
real indices against each column). -/
theorem evolve_entry (A : Matrix6) (i j : Index) :
    evolve A i j = A (permutation i) (permutation j) := by
  obtain ⟨i, hi⟩ := i; obtain ⟨j, hj⟩ := j
  rcases i with _|_|_|_|_|_|i <;> rcases j with _|_|_|_|_|_|j <;>
    first
      | omega
      | simp (config := { decide := true }) [evolve, mul, transpose, wUpdate_apply]

/-! ## The *-automorphism `Φ(A) = W A Wᵀ` -/

/-- Trace preservation: `tr(Φ A) = tr A`. A reindex of the diagonal by the
permutation. -/
theorem evolve_preserves_trace (A : Matrix6) : trace (evolve A) = trace A := by
  simp only [trace, evolve_entry, permutation_0, permutation_1, permutation_2,
    permutation_3, permutation_4, permutation_5]
  omega

/-- Multiplication preservation (algebra homomorphism): `Φ(A B) = Φ(A) Φ(B)`. -/
theorem evolve_preserves_product (A B : Matrix6) :
    evolve (mul A B) = mul (evolve A) (evolve B) := by
  funext i j
  simp only [mul, evolve_entry, permutation_0, permutation_1, permutation_2,
    permutation_3, permutation_4, permutation_5]
  omega

/-- Adjoint preservation: `Φ(Aᵀ) = (Φ A)ᵀ`. The frozen entries are real integers,
so transpose is the adjoint `†`; this is `Φ(A†) = (Φ A)†`. -/
theorem evolve_preserves_transpose (A : Matrix6) :
    evolve (transpose A) = transpose (evolve A) := by
  funext i j; simp only [transpose, evolve_entry]

/-- Unit preservation: `Φ(I) = I`. -/
theorem evolve_preserves_identity : evolve identityMatrix = identityMatrix := by
  funext i j
  have h : ∀ a b : Index, evolve identityMatrix a b = identityMatrix a b := by decide
  exact h i j

/-- Invertibility: `Φ` is its own inverse (`W` is involutive), hence a bijection
of the operator algebra. -/
theorem evolve_involutive (A : Matrix6) : evolve (evolve A) = A := by
  funext i j; simp only [evolve_entry, permutation_involutive]

/-- The **trace bilinear form** `tr(A B)` is preserved: `tr(Φ(A) Φ(B)) = tr(A B)`
(from product + trace). NOTE (correcting an earlier mislabel, per Tenzing's #286
review): this is the trace form, which is *not* the Hilbert–Schmidt / Frobenius
inner product — that is `⟨A,B⟩ = tr(Aᵀ B)`, with an adjoint on one argument; see
`evolve_preserves_frobenius` below for the genuine HS statement. -/
theorem evolve_preserves_trace_form (A B : Matrix6) :
    trace (mul (evolve A) (evolve B)) = trace (mul A B) := by
  rw [← evolve_preserves_product]; exact evolve_preserves_trace _

/-- The **Hilbert–Schmidt / Frobenius inner product** `⟨A,B⟩ = tr(Aᵀ B)` is
preserved: `tr((Φ A)ᵀ (Φ B)) = tr(Aᵀ B)`. Follows directly from the existing
adjoint, product and trace lemmas — `Φ` is an isometry for the HS metric, as a
real orthogonal conjugation must be. -/
theorem evolve_preserves_frobenius (A B : Matrix6) :
    trace (mul (transpose (evolve A)) (evolve B)) = trace (mul (transpose A) B) := by
  rw [← evolve_preserves_transpose, ← evolve_preserves_product]
  exact evolve_preserves_trace _

/-! ## The source correspondence Tenzing asked for

Diagonal configurations are the states `step` acts on; the frozen operator carries
each to the `step`-image, connecting the arbitrary-configuration `step` of PR A to
the actual matrix operator — not just the single demonstrated basis density. -/

/-- The diagonal density with configuration `s` on the diagonal. -/
def diagonal (s : BCRDActualRelationalFrame.SourceState) : Matrix6 :=
  fun i j => if i = j then s i else 0

/-- **`Φ(diag s) = diag(step s)`** for every six-position integer configuration
`s`, where `step` is PR A's independently-specified generator action
(`BCRDActualRelationalFrame.step`). This is the general correspondence promised by
the single-density `evolve_realises_event`. -/
theorem evolve_diagonal (s : BCRDActualRelationalFrame.SourceState) :
    evolve (diagonal s) = diagonal (BCRDActualRelationalFrame.step s) := by
  funext i j
  obtain ⟨i, hi⟩ := i; obtain ⟨j, hj⟩ := j
  rcases i with _|_|_|_|_|_|i <;> rcases j with _|_|_|_|_|_|j <;>
    first
      | omega
      | simp (config := { decide := true })
          [evolve, mul, transpose, wUpdate_apply, diagonal,
           BCRDActualRelationalFrame.step, BCRDActualRelationalFrame.Transport]

/-- Consistency with the single-event anchor: the diagonal correspondence
reproduces `evolve_realises_event` on `|M0⟩⟨M0| → |M1⟩⟨M1|`. -/
theorem evolve_diagonal_matches_event :
    ∀ i j : Index, evolve densityBefore i j = densityAfter i j := by decide

end PhysicalBridges.BCRDOperatorAlgebra
