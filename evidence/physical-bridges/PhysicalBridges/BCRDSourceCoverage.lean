import PhysicalBridges.FrozenBCRDEvents
import PhysicalBridges.BCRDIdentityCharge

/-!
# Source-coverage theorem — what the frozen operator does and does not certify

Addresses Tenzing's standing caveat on the PR A operator algebra (#286): *do not
promote from the frozen 6-D M3d source to all of BCRD without a source-coverage
theorem.* This module states the coverage **honestly and in bounds**.

## Provenance (not re-proved here; CI-gated elsewhere)
The frozen tables in `FrozenBCRDEvents` are byte-for-byte copies of two pinned
`physics-lane` test fixtures (`check_bcrd_identity_charge.py`, ref
`2b50c811…`): the M3d accessibility event and the M6/M7 parity. They are
certified only over **integer/real** entries, and their own header states they
"are not a replacement state model for general complex density states." So the
certified physical domain is the finite set of pure basis densities on the six
source positions — NOT arbitrary `Matrix6`, and NOT the full complex BCRD
dynamics.

### `evolve` is the W-stage only, not the compound M3d process
Per Tenzing's PR-B source reconnaissance (#286 review; `PR-B-PINNED-COMPLEX-M3D-SOURCE-HANDOFF`), the full M3d process in the pinned source is a **multi-stage complex** evolution `W → C_LM → U_MR → C_LM` (e.g. with `θ=π/4`, `|M0⟩ --W--> |M1⟩ --C_LM--> (|M1⟩ - i|L1⟩)/√2`, a nonzero L-sector amplitude). The frozen integer tables, and hence `evolve = WρWᵀ`, capture **only the `W` relation-bit-swap stage** and its integer endpoint `|M1⟩⟨M1|` — NOT the true complex multi-stage M3d endpoint. Every "event" in this module names that W-stage, not the compound process; the complex multi-stage source lives in PR B's modules (#285), not here. So an exact `Fin 6` position-valued history over `evolve` must not be promoted to a faithful history of the entire compound M3d process.

## What is proved
1. `coverage_action` — on the certified domain the event acts **exactly** as the
   basis-label permutation `W`.
2. `coverage_closed` — the event maps the certified domain **into itself**.
3. `certified_domain_is_proper` — the certified domain is a **proper** subset of
   `Matrix6` (witness: the identity is not a certified density), so results about
   the frozen operator do not silently generalise to all states.

## What is NOT claimed
No embedding of the full compound M3d process (W-stage only — see above) and no
correspondence to the full complex BCRD source. Its exact complex multi-stage form
is formalised in PR B (#285), not in this module's imports. No identity / consent /
subject semantics (that is PR B). This module fixes the scope; it does not extend it.
-/
namespace PhysicalBridges.BCRDSourceCoverage

open FrozenBCRDEvents
open BCRDIdentityCharge (SourceBasisDensity)

/-- The certified physical domain: the pure basis densities `|k⟩⟨k|` on the six
source positions. (Reuses `BCRDIdentityCharge.SourceBasisDensity`.) -/
abbrev CertifiedDensity (rho : Matrix6) : Prop := SourceBasisDensity rho

/-- On the certified domain the frozen event acts **exactly** as the basis-label
permutation `W`: `evolve |k⟩⟨k| = |perm k⟩⟨perm k|`. Entrywise exhaustive check
against the exact integer tables. -/
theorem coverage_action_entry :
    ∀ i a b : Index,
      evolve (matrixUnit i i) a b = matrixUnit (permutation i) (permutation i) a b := by
  decide

/-- …as a matrix identity. -/
theorem coverage_action (i : Index) :
    evolve (matrixUnit i i) = matrixUnit (permutation i) (permutation i) := by
  funext a b; exact coverage_action_entry i a b

/-- **Coverage closure.** The frozen event maps the certified domain into itself:
a certified density evolves to a certified density. -/
theorem coverage_closed (rho : Matrix6) (h : CertifiedDensity rho) :
    CertifiedDensity (evolve rho) := by
  obtain ⟨i, rfl⟩ := h
  exact ⟨permutation i, coverage_action i⟩

/-- Every certified density has unit trace (normalised pure state). A fixed,
checkable property of the whole certified domain. -/
theorem certified_trace_one : ∀ i : Index, trace (matrixUnit i i) = 1 := by decide

/-- **The certified domain is proper.** The identity operator is not a certified
density, so the frozen operator's established properties are scoped to the
certified sector and do not generalise to arbitrary `Matrix6` (let alone to the
full complex BCRD source). Proof: a certified density has unit trace; the identity
has trace 6. -/
theorem certified_domain_is_proper : ¬ CertifiedDensity identityMatrix := by
  rintro ⟨i, h⟩
  have htr : trace identityMatrix = trace (matrixUnit i i) := by rw [h]
  have h6 : trace identityMatrix = 6 := by decide
  have h1 : trace (matrixUnit i i) = 1 := certified_trace_one i
  omega

/-- Consistency with the single demonstrated event: coverage reproduces the
frozen `|M0⟩⟨M0| → |M1⟩⟨M1|` witness. -/
theorem coverage_matches_event :
    evolve densityBefore = densityAfter := by
  funext a b
  have h : ∀ x y : Index, evolve densityBefore x y = densityAfter x y := by decide
  exact h a b

end PhysicalBridges.BCRDSourceCoverage
