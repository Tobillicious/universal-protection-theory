import Mathlib

/-! Joint readout floor with retained memory (23 October 2026, ZCode). Outside the
sealed 3.6 edition; repairs Paper 11 Theorem 7D as diagnosed in READOUT.md.

A. The completely positive reset certificate for the supplied GAD readout channel.
   READOUT.md proved Phi(rho) >= 2gN(1-N)·(I/2) for every state: a *positive-map*
   minorisation. The joint theorem with retained quantum memory needs the stronger
   *completely positive* order, Phi - lambda·Tr(·)(I/2) CP, which by Choi holds exactly
   when the Choi matrix J(Phi) - (lambda/2)·I_4 is positive semidefinite. We prove the
   real quadratic form of that shifted Choi matrix is nonnegative for
   lambda = N·g²·(1-N), and that the positive-map constant fails the test (block
   determinant -7/64 at g = N = 1/2). The identification of the matrix entries with
   GAD's Choi matrix, and Choi's theorem, are the paper proof in READOUT-JOINT.md.

B. The scalar skeleton of the joint record bound over an arbitrary outcome alphabet
   with history-dependent reset coefficients, and the hard-readout-count floor. The
   operator-algebraic composition (CP monotonicity, reset component of the instrument,
   partial trace) is the paper proof; its exact instance is checked in
   checks/readout_joint.py. This file does not construct a quantum instrument.
-/
namespace UPTReadoutJoint

/-! ### A. CP reset certificate for GAD -/

/-- Choi-matrix data of GAD in the basis |00>,|01>,|10>,|11>, with damping g and
excited-state occupation N: two isolated diagonals and the {|00>,|11>} block
(a, d) coupled by c with c² = 1 - g. -/
def iso01 (g N : ℝ) : ℝ := N*g
def iso10 (g N : ℝ) : ℝ := (1-N)*g
def blockA (g N : ℝ) : ℝ := 1 - N*g
def blockD (g N : ℝ) : ℝ := 1 - g + N*g

/-- The completely positive reset coefficient certified against the reset state I/2. -/
def cpCoeff (g N : ℝ) : ℝ := N*g^2*(1-N)

theorem block_det_identity (g N : ℝ) :
    blockA g N * blockD g N - (1-g) = cpCoeff g N := by
  unfold blockA blockD cpCoeff; ring

/-- Shifting the block by s = cpCoeff/2 leaves determinant minus coupling equal to
    cpCoeff·g/2 + cpCoeff²/4, manifestly nonnegative. -/
theorem shifted_det_identity (g N : ℝ) :
    (blockA g N - cpCoeff g N/2)*(blockD g N - cpCoeff g N/2) - (1-g)
      = cpCoeff g N * g/2 + (cpCoeff g N)^2/4 := by
  unfold blockA blockD cpCoeff; ring

theorem cp_coeff_nonneg (g N : ℝ) (_hg : 0 ≤ g) (hN0 : 0 ≤ N) (hN1 : N ≤ 1) :
    0 ≤ cpCoeff g N := by
  unfold cpCoeff; have : 0 ≤ 1 - N := by linarith
  positivity

theorem cp_coeff_pos (g N : ℝ) (hg : 0 < g) (hN0 : 0 < N) (hN1 : N < 1) :
    0 < cpCoeff g N := by
  unfold cpCoeff; have : 0 < 1 - N := by linarith
  positivity

theorem iso01_shift_nonneg (g N : ℝ) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) (hN0 : 0 ≤ N)
    (_hN1 : N ≤ 1) : 0 ≤ iso01 g N - cpCoeff g N/2 := by
  unfold iso01 cpCoeff
  have h1 : 0 ≤ N*g*(1 - g/2) := mul_nonneg (mul_nonneg hN0 hg0) (by linarith)
  have h2 : 0 ≤ N*g*(g*N/2) := mul_nonneg (mul_nonneg hN0 hg0) (by positivity)
  nlinarith

theorem iso10_shift_nonneg (g N : ℝ) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) (_hN0 : 0 ≤ N)
    (hN1 : N ≤ 1) : 0 ≤ iso10 g N - cpCoeff g N/2 := by
  unfold iso10 cpCoeff
  have h1 : 0 ≤ (1-N)*g*(1 - N*g/2) :=
    mul_nonneg (mul_nonneg (by linarith) hg0) (by nlinarith)
  nlinarith

theorem blockA_shift_nonneg (g N : ℝ) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) (hN0 : 0 ≤ N)
    (hN1 : N ≤ 1) : 0 ≤ blockA g N - cpCoeff g N/2 := by
  unfold blockA cpCoeff
  have h1 : N*g ≤ N := by nlinarith
  have h2 : N*g^2*(1-N) ≤ N*(1-N) := by
    have : g^2 ≤ 1 := by nlinarith
    have : 0 ≤ N*(1-N) := mul_nonneg hN0 (by linarith)
    nlinarith
  have h3 : 0 ≤ (1-N)*(2-N) := mul_nonneg (by linarith) (by linarith)
  nlinarith

theorem blockD_shift_nonneg (g N : ℝ) (hg0 : 0 ≤ g) (hg1 : g ≤ 1) (hN0 : 0 ≤ N)
    (hN1 : N ≤ 1) : 0 ≤ blockD g N - cpCoeff g N/2 := by
  have h := iso01_shift_nonneg g N hg0 hg1 hN0 hN1
  unfold blockD; unfold iso01 at h
  linarith

theorem block_shifted_det_nonneg (g N : ℝ) (hg0 : 0 ≤ g) (hN0 : 0 ≤ N) (hN1 : N ≤ 1) :
    0 ≤ (blockA g N - cpCoeff g N/2)*(blockD g N - cpCoeff g N/2) - (1-g) := by
  rw [shifted_det_identity]
  have := cp_coeff_nonneg g N hg0 hN0 hN1
  positivity

/-- A real symmetric 2×2 matrix with nonnegative diagonal and nonnegative determinant
    has nonnegative quadratic form. -/
theorem quad_form_nonneg (a c d x y : ℝ) (ha : 0 ≤ a) (hd : 0 ≤ d) (hdet : c*c ≤ a*d) :
    0 ≤ a*x^2 + 2*c*x*y + d*y^2 := by
  rcases eq_or_lt_of_le ha with h0 | hpos
  · subst h0
    have hc : c = 0 := by nlinarith [mul_self_nonneg c]
    subst hc
    nlinarith [mul_nonneg hd (sq_nonneg y)]
  · have key : a*(a*x^2 + 2*c*x*y + d*y^2) = (a*x + c*y)^2 + (a*d - c*c)*y^2 := by ring
    have hprod : 0 ≤ a*(a*x^2 + 2*c*x*y + d*y^2) := by
      rw [key]
      exact add_nonneg (sq_nonneg _) (mul_nonneg (by linarith) (sq_nonneg _))
    by_contra hneg
    have hlt : a*x^2 + 2*c*x*y + d*y^2 < 0 := not_le.mp hneg
    have : a*(a*x^2 + 2*c*x*y + d*y^2) < 0 := mul_neg_of_pos_of_neg hpos hlt
    linarith

/-- **CP reset certificate.** The quadratic form of J(GAD) - (cpCoeff/2)·I_4 is
    nonnegative on every real vector (v00, v01, v10, v11), for every 0 ≤ g ≤ 1 and
    0 ≤ N ≤ 1, with coupling c² = 1 - g. By Choi, GAD - cpCoeff·Tr(·)(I/2) is
    completely positive: the readout has a genuine reset component of weight
    N·g²·(1-N) that survives tensoring with any retained memory. -/
theorem choi_form_nonneg (g N c v00 v01 v10 v11 : ℝ) (hg0 : 0 ≤ g) (hg1 : g ≤ 1)
    (hN0 : 0 ≤ N) (hN1 : N ≤ 1) (hc : c*c = 1 - g) :
    0 ≤ (iso01 g N - cpCoeff g N/2)*v01^2 + (iso10 g N - cpCoeff g N/2)*v10^2 +
      ((blockA g N - cpCoeff g N/2)*v00^2 + 2*c*v00*v11 +
        (blockD g N - cpCoeff g N/2)*v11^2) := by
  have h01 := iso01_shift_nonneg g N hg0 hg1 hN0 hN1
  have h10 := iso10_shift_nonneg g N hg0 hg1 hN0 hN1
  have hA := blockA_shift_nonneg g N hg0 hg1 hN0 hN1
  have hD := blockD_shift_nonneg g N hg0 hg1 hN0 hN1
  have hdet : c*c ≤ (blockA g N - cpCoeff g N/2)*(blockD g N - cpCoeff g N/2) := by
    have := block_shifted_det_nonneg g N hg0 hN0 hN1
    linarith
  have hblock := quad_form_nonneg _ c _ v00 v11 hA hD hdet
  have t1 := mul_nonneg h01 (sq_nonneg v01)
  have t2 := mul_nonneg h10 (sq_nonneg v10)
  linarith

/-- **Control.** The positive-map constant 2gN(1-N) of READOUT.md is not a CP
    coefficient: at g = N = 1/2 its shifted block determinant is -7/64 < 0, so the
    shifted Choi matrix is indefinite. Marginal positivity does not compose through
    retained memory; the CP constant 1/16 at the same point does. -/
theorem positive_constant_not_cp :
    (blockA (1/2) (1/2) - (2*(1/2)*(1/2)*(1-(1/2)))/2) *
      (blockD (1/2) (1/2) - (2*(1/2)*(1/2)*(1-(1/2)))/2) - (1-(1/2)) = -7/64 := by
  norm_num [blockA, blockD]

theorem cp_constant_at_half_half : cpCoeff (1/2) (1/2) = 1/16 := by
  norm_num [cpCoeff]

/-! ### B. Scalar skeleton of the joint record bound, any alphabet -/

variable {Y : Type}

/-- Likelihood of a record along a path, from history h, under conditional kernel K. -/
def weight (K : List Y → Y → ℝ) : List Y → List Y → ℝ
  | _, [] => 1
  | h, y :: rest => K h y * weight K (h ++ [y]) rest

/-- The product of history-dependent reset coefficients along a path. -/
def chain (eta : List Y → ℝ) : List Y → List Y → ℝ
  | _, [] => 1
  | h, y :: rest => eta h * chain eta (h ++ [y]) rest

theorem weight_nonneg (G : List Y → Y → ℝ) (hG : ∀ h y, 0 ≤ G h y) (h path : List Y) :
    0 ≤ weight G h path := by
  induction path generalizing h with
  | nil => simp [weight]
  | cons y rest ih => exact mul_nonneg (hG h y) (ih (h ++ [y]))

theorem chain_nonneg (eta : List Y → ℝ) (he : ∀ h, 0 ≤ eta h) (h path : List Y) :
    0 ≤ chain eta h path := by
  induction path generalizing h with
  | nil => simp [chain]
  | cons y rest ih => exact mul_nonneg (he h) (ih (h ++ [y]))

/-- **Joint record bound (scalar skeleton).** If after every history h the actual
    conditional law K dominates eta h · G(·|h) with G world-independent, every complete
    record has likelihood at least chain·Γ. With retained quantum memory the same
    induction runs in the CP order on the instrument (paper proof); this is its weight. -/
theorem joint_record_lower (K G : List Y → Y → ℝ) (eta : List Y → ℝ)
    (he : ∀ h, 0 ≤ eta h) (hG : ∀ h y, 0 ≤ G h y)
    (minor : ∀ h y, eta h * G h y ≤ K h y) (h path : List Y) :
    chain eta h path * weight G h path ≤ weight K h path := by
  induction path generalizing h with
  | nil => simp [chain, weight]
  | cons y rest ih =>
      have hK : 0 ≤ K h y := (mul_nonneg (he h) (hG h y)).trans (minor h y)
      have hR : 0 ≤ chain eta (h ++ [y]) rest * weight G (h ++ [y]) rest :=
        mul_nonneg (chain_nonneg eta he _ _) (weight_nonneg G hG _ _)
      simp only [chain, weight]
      calc eta h * chain eta (h ++ [y]) rest * (G h y * weight G (h ++ [y]) rest)
          = (eta h * G h y) * (chain eta (h ++ [y]) rest * weight G (h ++ [y]) rest) := by ring
        _ ≤ K h y * weight K (h ++ [y]) rest := mul_le_mul (minor h y) (ih (h ++ [y])) hR hK

theorem chain_ge_pow (eta : List Y → ℝ) (etaMin : ℝ) (h0 : 0 ≤ etaMin)
    (hmin : ∀ h, etaMin ≤ eta h) (h path : List Y) :
    etaMin ^ path.length ≤ chain eta h path := by
  induction path generalizing h with
  | nil => simp [chain]
  | cons y rest ih =>
      simp only [List.length_cons, chain, pow_succ]
      have := ih (h ++ [y])
      have hc := chain_nonneg eta (fun h' => le_trans h0 (hmin h')) (h ++ [y]) rest
      calc etaMin ^ rest.length * etaMin
          ≤ chain eta (h ++ [y]) rest * eta h :=
            mul_le_mul this (hmin h) h0 hc
        _ = eta h * chain eta (h ++ [y]) rest := by ring

/-- **Hard readout count.** With at most H readouts and every reset coefficient at least
    etaMin ≤ 1, the common component of every complete record is at least etaMin^H·Γ.
    Without a hard count the floor etaMin^N tends to zero: a stopping rule that may
    continue indefinitely inherits no uniform positive floor. -/
theorem hard_count_floor (K G : List Y → Y → ℝ) (eta : List Y → ℝ) (etaMin : ℝ)
    (h0 : 0 ≤ etaMin) (h1 : etaMin ≤ 1) (hmin : ∀ h, etaMin ≤ eta h)
    (hG : ∀ h y, 0 ≤ G h y) (minor : ∀ h y, eta h * G h y ≤ K h y)
    (H : ℕ) (h path : List Y) (hlen : path.length ≤ H) :
    etaMin ^ H * weight G h path ≤ weight K h path := by
  have he : ∀ h', 0 ≤ eta h' := fun h' => le_trans h0 (hmin h')
  have hpow : etaMin ^ H ≤ etaMin ^ path.length := pow_le_pow_of_le_one h0 h1 hlen
  have hchain := chain_ge_pow eta etaMin h0 hmin h path
  have hw := weight_nonneg G hG h path
  calc etaMin ^ H * weight G h path
      ≤ chain eta h path * weight G h path :=
        mul_le_mul_of_nonneg_right (le_trans hpow hchain) hw
    _ ≤ weight K h path := joint_record_lower K G eta he hG minor h path

end UPTReadoutJoint

