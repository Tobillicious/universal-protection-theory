/-
Snuffy — Canon Edition 4.2 working: the wavefront sweep succeeds and its
complete bill is O(t^{d_G}) (G3).

Vertices carry a shell index `layer`. Wave `k` applies the single-shot local
correction to shell `k`, reading the already-frozen interior as a static
boundary. Between waves, outer activity — the world and any agent — may write
anything outside the frozen interior, and nothing inside it (the TIWA write
fence, `TIWASource.outerUpdate_read_frozen`).

  * sweep_recovers — after `k` waves every vertex of the first `k` shells holds
    its target, whatever the outer activity: recovery succeeds and frozen
    vertices are never reworked (quiescence with the recovered state retained).
  * sweep_visits — each vertex is corrected in exactly one wave.
  * waves_from_spread — if the region needing recovery at age `t` lies within
    the first `c·t + r` shells (finite propagation), the sweep needs at most
    `c·t + r` waves (`TIWARecovery.BoundedWaves`).
  * sweep_bill — joined to `G3CompleteBill`: recovery succeeds on the whole
    region, and the complete metered bill satisfies
    `W ≤ (fixed + α + β + reset)(c + r)^d · t^d`, with a coefficient
    independent of age.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Snuffy.G3CompleteBill
import Snuffy.TIWARecovery

namespace Snuffy.G3Sweep

variable {V Val : Type*}

/-- One wave: shell `k` is corrected by the local map; every other vertex keeps
its value. -/
def wave (layer : V → ℕ) (corr : V → (V → Val) → Val) (k : ℕ) (s : V → Val) : V → Val :=
  fun v => if layer v = k then corr v s else s v

/-- The sweep with outer activity `outer k` before wave `k`. -/
def sweep (layer : V → ℕ) (corr : V → (V → Val) → Val)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ : V → Val) : ℕ → (V → Val)
  | 0 => s₀
  | k + 1 => wave layer corr k (outer k (sweep layer corr outer s₀ k))

/-- **The sweep recovers and stays recovered.** If the local correction of a
vertex returns its target whenever every inner vertex already holds its target
(single-shot correction against a gauge-fixed boundary), and outer activity
before wave `k` never writes the frozen interior (the TIWA fence), then after
`k` waves every vertex of the first `k` shells holds its target. -/
theorem sweep_recovers (layer : V → ℕ) (corr : V → (V → Val) → Val)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ target : V → Val)
    (hcorr : ∀ v s, (∀ u, layer u < layer v → s u = target u) → corr v s = target v)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v) :
    ∀ k v, layer v < k → sweep layer corr outer s₀ k v = target v := by
  intro k
  induction k with
  | zero => intro v hv; exact absurd hv (Nat.not_lt_zero _)
  | succ k ih =>
      intro v hv
      show wave layer corr k (outer k (sweep layer corr outer s₀ k)) v = target v
      unfold wave
      split_ifs with hk
      · apply hcorr
        intro u hu
        rw [hfence k _ u (by omega)]
        exact ih u (by omega)
      · rw [hfence k _ v (by omega)]
        exact ih v (by omega)

/-- **No rework.** A vertex is corrected in exactly one wave, its own shell. -/
theorem sweep_visits (layer : V → ℕ) (v : V) (N : ℕ) (hv : layer v < N) :
    ((Finset.range N).filter fun k => layer v = k).card = 1 := by
  rw [Finset.card_eq_one]
  refine ⟨layer v, ?_⟩
  ext k
  simp only [Finset.mem_filter, Finset.mem_range, Finset.mem_singleton]
  constructor
  · rintro ⟨-, h⟩; exact h.symm
  · rintro rfl; exact ⟨hv, rfl⟩

/-- **The wave count from finite propagation.** -/
theorem waves_from_spread (R : ℕ → ℕ) (c r : ℕ) (hspread : ∀ t, R t ≤ c * t + r) :
    Snuffy.TIWARecovery.BoundedWaves R c r := hspread

open Snuffy.G3CompleteBill in
/-- **G3: success and the complete bill.** At age `t`, sweep the `R t` shells
of the region needing recovery. Recovery succeeds on the whole region against
any fenced outer activity. If the complete metered ledger charges each wave
`k` at most `α k^(d-1) + β`, plus a metered rollback and fixed endpoints, and
the region grows at most linearly with age, the whole bill is at most an
age-independent constant times `t^d`. -/
theorem sweep_bill (layer : V → ℕ) (corr : V → (V → Val) → Val)
    (outer : ℕ → (V → Val) → (V → Val)) (s₀ target : V → Val)
    (hcorr : ∀ v s, (∀ u, layer u < layer v → s u = target u) → corr v s = target v)
    (hfence : ∀ k s v, layer v < k → outer k s v = s v)
    (R : ℕ → ℕ) (c r : ℕ) (hspread : ∀ t, R t ≤ c * t + r)
    (cost : ℕ → ℕ) (rollback : ℕ → Bool) (reset fixed α β d t : ℕ)
    (hd : 1 ≤ d) (ht : 1 ≤ t) (hR : 1 ≤ R t)
    (hcost : ∀ k ∈ Finset.range (R t), cost (k + 1) ≤ α * (k + 1) ^ (d - 1) + β) :
    (∀ v, layer v < R t → sweep layer corr outer s₀ (R t) v = target v) ∧
      cumulativeCharge cost rollback reset fixed (R t) ≤
        ((fixed + α + β + reset) * (c + r) ^ d) * t ^ d := by
  refine ⟨sweep_recovers layer corr outer s₀ target hcorr hfence (R t), ?_⟩
  let bill : WorkBill :=
    { timeSteps := t, waveCount := R t, dimensionalFactor := d,
      allocatedWork := cumulativeCharge cost rollback reset fixed (R t),
      scalingConstant := fixed + α + β + reset, tiwaSuccess := true,
      isBoundaryClosed := true, decoderSuccess := true }
  have hvalid : G3_ValidWorkBill bill :=
    valid_work_bill_from_complete_ledger bill cost rollback reset fixed α β hR hd rfl hcost
      le_rfl
  exact valid_bill_bound_in_age bill c r hvalid rfl ht
    (waves_from_spread R c r hspread t)

end Snuffy.G3Sweep
