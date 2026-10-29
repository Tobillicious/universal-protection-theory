/-
Snuffy — Canon Edition v4.1: the gate-set clause of premise 2 derived — every
unitary is exactly a finite product of two-level unitaries (Part I premise 2;
§17; with `Trotter.lloyd_simulation`).

A two-level unitary acts as the identity outside one pair of basis vectors
`{e_i, e_j}`. A universal simulator whose gates are the two-level unitaries
therefore implements every local factor of a Lie–Trotter product exactly.

  * mul_of_idOutside — a matrix that is the identity outside `{i, j}` changes
    only rows `i` and `j` of what it multiplies.
  * givens_unitary, givens_idOutside, givens_mulVec_i, givens_mulVec_j,
    givens_mulVec_other — the Givens rotation on `(i, j)` built from
    `(α, β) = (x_i, x_j)` is a two-level unitary sending `x_i` to
    `√(|x_i|² + |x_j|²)` and `x_j` to `0`, leaving every other entry alone.
  * two_level_decomposition — every unitary of dimension `n ≥ 2` is a finite
    product of two-level unitaries.

Zero `sorry`. Mathlib rev 56a005855ea1.
-/

import Mathlib.LinearAlgebra.UnitaryGroup
import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.Sqrt
import Mathlib.Data.Fintype.BigOperators

open Matrix Finset ComplexConjugate

namespace Snuffy.TwoLevel

variable {n : ℕ}

/-- `V` is the identity outside the pair `{i, j}`. -/
def IdOutside (V : Matrix (Fin n) (Fin n) ℂ) (i j : Fin n) : Prop :=
  ∀ a b, ¬ ((a = i ∨ a = j) ∧ (b = i ∨ b = j)) → V a b = (1 : Matrix (Fin n) (Fin n) ℂ) a b

/-- A two-level unitary. -/
def IsTwoLevel (V : Matrix (Fin n) (Fin n) ℂ) : Prop :=
  V ∈ unitaryGroup (Fin n) ℂ ∧ ∃ i j, i ≠ j ∧ IdOutside V i j

/-- **Two-level matrices touch two rows.** -/
theorem mul_of_idOutside {V : Matrix (Fin n) (Fin n) ℂ} {i j : Fin n} (hij : i ≠ j)
    (hV : IdOutside V i j) (M : Matrix (Fin n) (Fin n) ℂ) (a b : Fin n) :
    (V * M) a b = if a = i ∨ a = j then V a i * M i b + V a j * M j b else M a b := by
  rw [mul_apply]
  split_ifs with ha
  · refine Fintype.sum_eq_add i j hij fun c hc => ?_
    rw [hV a c (by tauto), one_apply_ne (by rintro rfl; tauto), zero_mul]
  · rw [Fintype.sum_eq_single a fun c hc => ?_]
    · rw [hV a a (by tauto), one_apply_eq, one_mul]
    · rw [hV a c (by tauto), one_apply_ne (Ne.symm hc), zero_mul]

/-- The norm of the pair `(α, β)`, as a complex number. -/
noncomputable def rad (α β : ℂ) : ℂ := ((Real.sqrt (Complex.normSq α + Complex.normSq β) : ℝ) : ℂ)

theorem rad_mul_self (α β : ℂ) : rad α β * rad α β = α * conj α + β * conj β := by
  unfold rad
  rw [← Complex.ofReal_mul,
    Real.mul_self_sqrt (add_nonneg (Complex.normSq_nonneg _) (Complex.normSq_nonneg _)),
    Complex.ofReal_add,
    Complex.mul_conj, Complex.mul_conj]

theorem conj_rad (α β : ℂ) : conj (rad α β) = rad α β := Complex.conj_ofReal _

/-- The Givens rotation on `(i, j)` built from `(α, β)`. -/
noncomputable def givens (i j : Fin n) (α β : ℂ) : Matrix (Fin n) (Fin n) ℂ := fun a b =>
  if a = i then (if b = i then conj α / rad α β else if b = j then conj β / rad α β else 0)
  else if a = j then (if b = i then -β / rad α β else if b = j then α / rad α β else 0)
  else if a = b then 1 else 0

theorem givens_idOutside {i j : Fin n} (hij : i ≠ j) (α β : ℂ) : IdOutside (givens i j α β) i j := by
  intro a b h
  simp only [givens, one_apply]
  by_cases ha : a = i
  · subst ha
    have hb : b ≠ a ∧ b ≠ j := by tauto
    simp [hb.1, hb.2, Ne.symm hb.1]
  · by_cases hb' : a = j
    · subst hb'
      have hb : b ≠ i ∧ b ≠ a := by tauto
      simp [ha, hb.1, hb.2, Ne.symm hb.2]
    · simp [ha, hb']

/-- **The Givens rotation is unitary** whenever `(α, β) ≠ 0`. -/
theorem givens_unitary {i j : Fin n} (hij : i ≠ j) {α β : ℂ} (hr : rad α β ≠ 0) :
    givens i j α β ∈ unitaryGroup (Fin n) ℂ := by
  rw [mem_unitaryGroup_iff]
  ext a b
  rw [mul_of_idOutside hij (givens_idOutside hij α β)]
  have hrr := rad_mul_self α β
  simp only [star_apply, givens, one_apply]
  have hji : j ≠ i := Ne.symm hij
  split_ifs <;> subst_vars <;> simp_all [conj_rad] <;> field_simp <;>
    first
    | linear_combination -hrr
    | linear_combination hrr
    | ring_nf

theorem one_idOutside (i j : Fin n) : IdOutside (1 : Matrix (Fin n) (Fin n) ℂ) i j :=
  fun _ _ _ => rfl

theorem rad_eq_zero {α β : ℂ} (h : rad α β = 0) : α = 0 ∧ β = 0 := by
  unfold rad at h
  rw [Complex.ofReal_eq_zero, Real.sqrt_eq_zero (add_nonneg (Complex.normSq_nonneg _)
    (Complex.normSq_nonneg _))] at h
  have ha := Complex.normSq_nonneg α
  have hb := Complex.normSq_nonneg β
  exact ⟨Complex.normSq_eq_zero.mp (by linarith), Complex.normSq_eq_zero.mp (by linarith)⟩

/-- The elimination step on `(i, j)`: the Givens rotation when `(α, β) ≠ 0`,
the identity otherwise. -/
noncomputable def elim (i j : Fin n) (α β : ℂ) : Matrix (Fin n) (Fin n) ℂ :=
  if rad α β = 0 then 1 else givens i j α β

theorem elim_unitary {i j : Fin n} (hij : i ≠ j) (α β : ℂ) : elim i j α β ∈ unitaryGroup (Fin n) ℂ := by
  unfold elim
  split_ifs with h
  · exact one_mem _
  · exact givens_unitary hij h

theorem elim_idOutside {i j : Fin n} (hij : i ≠ j) (α β : ℂ) : IdOutside (elim i j α β) i j := by
  unfold elim
  split_ifs
  · exact one_idOutside i j
  · exact givens_idOutside hij α β

/-- **The step's effect on column `m`.** With `α = W i m`, `β = W j m`, the step
sends entry `j` of column `m` to `0`. -/
theorem elim_kills {i j : Fin n} (hij : i ≠ j) (W : Matrix (Fin n) (Fin n) ℂ) (m : Fin n) :
    (elim i j (W i m) (W j m) * W) j m = 0 := by
  rw [mul_of_idOutside hij (elim_idOutside hij _ _)]
  simp only [or_true, ↓reduceIte]
  unfold elim
  split_ifs with h
  · obtain ⟨-, hb⟩ := rad_eq_zero h
    simp [one_apply, Ne.symm hij, hb]
  · simp [givens, Ne.symm hij]
    ring

/-- Two-level matrices leave the other rows alone. -/
theorem idOutside_row {V : Matrix (Fin n) (Fin n) ℂ} {i j : Fin n} (hij : i ≠ j)
    (hV : IdOutside V i j) (W : Matrix (Fin n) (Fin n) ℂ) {a : Fin n} (ha : a ≠ i ∧ a ≠ j) (b : Fin n) :
    (V * W) a b = W a b := by
  have h : ¬ (a = i ∨ a = j) := by tauto
  rw [mul_of_idOutside hij hV]
  simp only [h, ↓reduceIte]

/-- Standard columns: the first columns of `W` are basis vectors. -/
def StdCols (W : Matrix (Fin n) (Fin n) ℂ) (P : Fin n → Prop) : Prop :=
  ∀ c, P c → ∀ a, W a c = (1 : Matrix (Fin n) (Fin n) ℂ) a c

/-- A two-level step on rows `i, j` keeps any standard column `c ∉ {i, j}`. -/
theorem idOutside_keeps_col {V : Matrix (Fin n) (Fin n) ℂ} {i j : Fin n} (hij : i ≠ j)
    (hV : IdOutside V i j) (W : Matrix (Fin n) (Fin n) ℂ) {c : Fin n} (hci : c ≠ i) (hcj : c ≠ j)
    (hc : ∀ a, W a c = (1 : Matrix (Fin n) (Fin n) ℂ) a c) :
    ∀ a, (V * W) a c = (1 : Matrix (Fin n) (Fin n) ℂ) a c := by
  intro a
  rw [mul_of_idOutside hij hV]
  split_ifs with ha
  · rw [hc i, hc j, one_apply_ne (Ne.symm hci), one_apply_ne (Ne.symm hcj), mul_zero, mul_zero,
      add_zero, one_apply_ne]
    rintro rfl
    rcases ha with rfl | rfl <;> tauto
  · exact hc a

/-- **Above the diagonal the column vanishes.** In a unitary whose columns
`c < m` are standard, column `m` has zero entries in rows `a < m`. -/
theorem col_zero_above {W : Matrix (Fin n) (Fin n) ℂ} (hW : W ∈ unitaryGroup (Fin n) ℂ) {m : Fin n}
    (hstd : StdCols W (· < m)) {a : Fin n} (ha : a < m) : W a m = 0 := by
  have h := congrFun (congrFun (mem_unitaryGroup_iff'.mp hW) a) m
  rw [mul_apply, one_apply_ne (ne_of_lt ha)] at h
  rw [Fintype.sum_eq_single a fun c hc => by
    rw [star_apply, hstd a ha c, one_apply_ne hc, star_zero, zero_mul]] at h
  rwa [star_apply, hstd a ha a, one_apply_eq, star_one, one_mul] at h

/-- **Below the diagonal, cleared.** For a unitary with standard columns `c < m`,
a product of two-level unitaries (on pairs `(m, k)`, `k > m`) keeps it unitary,
keeps those columns, and zeroes column `m` below the diagonal. -/
theorem clear_below {W : Matrix (Fin n) (Fin n) ℂ} (hW : W ∈ unitaryGroup (Fin n) ℂ) (m : Fin n)
    (hstd : StdCols W (· < m)) (S : Finset (Fin n)) (hS : ∀ k ∈ S, m < k) :
    ∃ Ls : List (Matrix (Fin n) (Fin n) ℂ), (∀ V ∈ Ls, IsTwoLevel V) ∧
      Ls.prod * W ∈ unitaryGroup (Fin n) ℂ ∧ StdCols (Ls.prod * W) (· < m) ∧
      ∀ k ∈ S, (Ls.prod * W) k m = 0 := by
  classical
  induction S using Finset.induction_on with
  | empty => exact ⟨[], by simp, by simpa using hW, by simpa using hstd, by simp⟩
  | insert k S hk ih =>
    obtain ⟨Ls, hLs, hU, hcols, hzero⟩ := ih fun k' hk' => hS k' (mem_insert_of_mem hk')
    have hmk : m ≠ k := ne_of_lt (hS k (mem_insert_self k S))
    set W' := Ls.prod * W
    set G := elim m k (W' m m) (W' k m)
    have hG2 : IsTwoLevel G := ⟨elim_unitary hmk _ _, m, k, hmk, elim_idOutside hmk _ _⟩
    refine ⟨G :: Ls, ?_, ?_, ?_, ?_⟩
    · intro V hV
      rcases List.mem_cons.mp hV with rfl | hV
      · exact hG2
      · exact hLs V hV
    · rw [List.prod_cons, Matrix.mul_assoc]
      exact mul_mem hG2.1 hU
    · intro c hc
      rw [List.prod_cons, Matrix.mul_assoc]
      exact idOutside_keeps_col hmk (elim_idOutside hmk _ _) W' (ne_of_lt hc)
        (ne_of_lt (hc.trans (hS k (mem_insert_self k S)))) (hcols c hc)
    · intro k' hk'
      rw [List.prod_cons, Matrix.mul_assoc]
      rcases mem_insert.mp hk' with rfl | hk'
      · exact elim_kills hmk W' m
      · rw [idOutside_row hmk (elim_idOutside hmk _ _) W'
          ⟨ne_of_gt (hS k' (mem_insert_of_mem hk')), fun h => hk (h ▸ hk')⟩]
        exact hzero k' hk'

/-- The phase fix on `(m, p)`: multiply row `m` by `conj z`. -/
def phase (m : Fin n) (z : ℂ) : Matrix (Fin n) (Fin n) ℂ := fun a b =>
  if a = m ∧ b = m then conj z else (1 : Matrix (Fin n) (Fin n) ℂ) a b

theorem phase_idOutside (m p : Fin n) (z : ℂ) : IdOutside (phase m z) m p := by
  intro a b h
  have h' : ¬ (a = m ∧ b = m) := by tauto
  simp only [phase, h', ↓reduceIte]

theorem phase_unitary {m p : Fin n} (hmp : m ≠ p) {z : ℂ} (hz : conj z * z = 1) :
    phase m z ∈ unitaryGroup (Fin n) ℂ := by
  rw [mem_unitaryGroup_iff]
  ext a b
  rw [mul_of_idOutside hmp (phase_idOutside m p z)]
  simp only [star_apply, phase, one_apply]
  split_ifs <;> subst_vars <;> simp_all

/-- The phase gate multiplies row `m` by `conj z`. -/
theorem phase_mul_apply (m : Fin n) (z : ℂ) (W : Matrix (Fin n) (Fin n) ℂ) (a b : Fin n) :
    (phase m z * W) a b = if a = m then conj z * W m b else W a b := by
  rw [mul_apply, Fintype.sum_eq_single a fun c hc => by
    simp only [phase, one_apply_ne (Ne.symm hc)]
    split_ifs with h
    · exact absurd (h.2.trans h.1.symm) hc
    · simp]
  simp only [phase, one_apply_eq]
  split_ifs with h1 h2 h2 <;> simp_all

/-- **One more standard column.** -/
theorem next_column (hn : 2 ≤ n) {W : Matrix (Fin n) (Fin n) ℂ} (hW : W ∈ unitaryGroup (Fin n) ℂ)
    (m : Fin n) (hstd : StdCols W (· < m)) :
    ∃ Ls : List (Matrix (Fin n) (Fin n) ℂ), (∀ V ∈ Ls, IsTwoLevel V) ∧
      Ls.prod * W ∈ unitaryGroup (Fin n) ℂ ∧ StdCols (Ls.prod * W) (· ≤ m) := by
  classical
  obtain ⟨Ls, hLs, hU, hcols, hzero⟩ :=
    clear_below hW m hstd (univ.filter fun k => m < k) (fun k hk => (mem_filter.mp hk).2)
  set W' := Ls.prod * W with hW'
  -- column m of W' vanishes off the diagonal
  have hoff : ∀ a, a ≠ m → W' a m = 0 := by
    intro a ham
    rcases lt_or_gt_of_ne ham with h | h
    · exact col_zero_above hU hcols h
    · exact hzero a (mem_filter.mpr ⟨mem_univ _, h⟩)
  have hunit : conj (W' m m) * W' m m = 1 := by
    have h := congrFun (congrFun (mem_unitaryGroup_iff'.mp hU) m) m
    rw [mul_apply, one_apply_eq, Fintype.sum_eq_single m fun a ha => by
      rw [hoff a ha, mul_zero]] at h
    simpa [star_apply] using h
  -- a partner index p ≠ m
  obtain ⟨p, hmp⟩ : ∃ p : Fin n, m ≠ p := by
    by_cases h0 : m.val = 0
    · exact ⟨⟨1, by omega⟩, fun h => by simp [Fin.ext_iff] at h; omega⟩
    · exact ⟨⟨0, by omega⟩, fun h => h0 (by simp [Fin.ext_iff] at h; exact h)⟩
  have hV2 : IsTwoLevel (phase m (W' m m)) :=
    ⟨phase_unitary hmp hunit, m, p, hmp, phase_idOutside m p _⟩
  refine ⟨phase m (W' m m) :: Ls, ?_, ?_, ?_⟩
  · intro X hX
    rcases List.mem_cons.mp hX with rfl | hX
    · exact hV2
    · exact hLs X hX
  · rw [List.prod_cons, Matrix.mul_assoc]
    exact mul_mem hV2.1 hU
  · intro c hc a
    rw [List.prod_cons, Matrix.mul_assoc, ← hW', phase_mul_apply]
    rcases lt_or_eq_of_le hc with hc | heq
    · have hcm : c ≠ m := ne_of_lt hc
      split_ifs with ha
      · rw [ha, hcols c hc m, one_apply_ne (Ne.symm hcm), mul_zero]
      · exact hcols c hc a
    · rw [heq]
      split_ifs with ha
      · rw [ha, hunit, one_apply_eq]
      · rw [hoff a ha, one_apply_ne ha]

theorem star_list_prod' (L : List (Matrix (Fin n) (Fin n) ℂ)) :
    star L.prod = (L.map star).reverse.prod := by
  induction L with
  | nil => simp
  | cons V L ih =>
    rw [List.prod_cons, star_mul, ih, List.map_cons, List.reverse_cons, List.prod_append,
      List.prod_singleton]

theorem star_twoLevel {V : Matrix (Fin n) (Fin n) ℂ} (hV : IsTwoLevel V) : IsTwoLevel (star V) := by
  obtain ⟨hU, i, j, hij, hout⟩ := hV
  refine ⟨Unitary.star_mem hU, i, j, hij, fun a b h => ?_⟩
  rw [star_apply, hout b a (by tauto), one_apply, one_apply]
  by_cases hab : b = a
  · subst hab; simp
  · simp [hab, Ne.symm hab]

/-- **The gate-set clause.** Every unitary of dimension `n ≥ 2` is a finite
product of two-level unitaries. -/
theorem two_level_decomposition (hn : 2 ≤ n) {U : Matrix (Fin n) (Fin n) ℂ}
    (hU : U ∈ unitaryGroup (Fin n) ℂ) :
    ∃ Ls : List (Matrix (Fin n) (Fin n) ℂ), (∀ V ∈ Ls, IsTwoLevel V) ∧ U = Ls.prod := by
  -- standardise the columns one at a time
  have key : ∀ m : ℕ, m ≤ n → ∃ Ls : List (Matrix (Fin n) (Fin n) ℂ), (∀ V ∈ Ls, IsTwoLevel V) ∧
      Ls.prod * U ∈ unitaryGroup (Fin n) ℂ ∧ StdCols (Ls.prod * U) (fun c => c.val < m) := by
    intro m
    induction m with
    | zero => exact fun _ => ⟨[], by simp, by simpa using hU, fun c hc => absurd hc (Nat.not_lt_zero _)⟩
    | succ m ih =>
      intro hm
      obtain ⟨Ls, hLs, hW, hstd⟩ := ih (by omega)
      obtain ⟨Ls', hLs', hW', hstd'⟩ :=
        next_column hn hW ⟨m, by omega⟩ (fun c hc => hstd c (by simpa [Fin.lt_def] using hc))
      refine ⟨Ls' ++ Ls, ?_, ?_, ?_⟩
      · intro V hV
        rcases List.mem_append.mp hV with hV | hV
        · exact hLs' V hV
        · exact hLs V hV
      · rw [List.prod_append, Matrix.mul_assoc]; exact hW'
      · intro c hc
        rw [List.prod_append, Matrix.mul_assoc]
        exact hstd' c (by simp [Fin.le_def]; omega)
  obtain ⟨Ls, hLs, -, hstd⟩ := key n le_rfl
  have hone : Ls.prod * U = 1 := by
    ext a c
    exact hstd c c.isLt a
  have hprodU : Ls.prod ∈ unitaryGroup (Fin n) ℂ := by
    have : ∀ L : List (Matrix (Fin n) (Fin n) ℂ), (∀ V ∈ L, IsTwoLevel V) →
        L.prod ∈ unitaryGroup (Fin n) ℂ := by
      intro L hL
      induction L with
      | nil => exact one_mem _
      | cons V L ih =>
        rw [List.prod_cons]
        exact mul_mem (hL V (List.mem_cons_self ..)).1 (ih fun X hX => hL X (List.mem_cons_of_mem _ hX))
    exact this Ls hLs
  refine ⟨(Ls.map star).reverse, ?_, ?_⟩
  · intro V hV
    rw [List.mem_reverse, List.mem_map] at hV
    obtain ⟨X, hX, rfl⟩ := hV
    exact star_twoLevel (hLs X hX)
  · rw [← star_list_prod']
    calc U = (star Ls.prod * Ls.prod) * U := by rw [mem_unitaryGroup_iff'.mp hprodU, Matrix.one_mul]
      _ = star Ls.prod * (Ls.prod * U) := by rw [Matrix.mul_assoc]
      _ = star Ls.prod := by rw [hone, Matrix.mul_one]

end Snuffy.TwoLevel
