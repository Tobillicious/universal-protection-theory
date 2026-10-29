import Mathlib

/-! Follow-up to 3.6, outside the sealed edition. Exact algebra for the supplied
GAD qubit channel, and an arbitrary-length classical conditional-record bound.
The channel matrix interpretation is proved on paper in READOUT.md. This file
does not assert a quantum instrument or retained-side-information certificate.
-/
namespace UPTReadoutFollowup

def outDiag (a g occupation : ℝ) := (1-g)*a+g*(1-occupation)
def outDet (a coherence g occupation : ℝ) :=
  outDiag a g occupation*(1-outDiag a g occupation)-(1-g)*coherence

theorem determinant_identity (a coherence g occupation : ℝ) :
    outDet a coherence g occupation =
      g*occupation*(1-occupation) + g*(1-g)*(a-(1-occupation))^2 +
        (1-g)*(a*(1-a)-coherence) := by
  unfold outDet outDiag
  ring

theorem determinant_lower (a coherence g occupation : ℝ)
    (hg0 : 0 ≤ g) (hg1 : g ≤ 1) (hc : coherence ≤ a*(1-a)) :
    g*occupation*(1-occupation) ≤ outDet a coherence g occupation := by
  rw [determinant_identity]
  have h1 : 0 ≤ g*(1-g)*(a-(1-occupation))^2 :=
    mul_nonneg (mul_nonneg hg0 (by linarith)) (sq_nonneg _)
  have h2 : 0 ≤ (1-g)*(a*(1-a)-coherence) :=
    mul_nonneg (by linarith) (by linarith)
  linarith

theorem strictly_positive_determinant (a coherence g occupation : ℝ)
    (hg0 : 0 < g) (hg1 : g ≤ 1) (hn0 : 0 < occupation) (hn1 : occupation < 1)
    (hc : coherence ≤ a*(1-a)) : 0 < outDet a coherence g occupation := by
  have hp : 0 < g*occupation*(1-occupation) :=
    mul_pos (mul_pos hg0 hn0) (by linarith)
  exact hp.trans_le (determinant_lower a coherence g occupation hg0.le hg1 hc)

/-- For a positive two-level trace-one state, its smaller eigenvalue is at
    least its determinant. The supplied matrix has already been identified
    with this spectral data in the paper proof. -/
theorem spectral_lower (lo hi det bound : ℝ) (hl : 0 ≤ lo)
    (_hh : 0 ≤ hi) (trace : lo+hi=1) (product : lo*hi=det)
    (hb : bound ≤ det) : bound ≤ lo := by
  have hh1 : hi ≤ 1 := by linarith
  have hm := mul_le_mul_of_nonneg_left hh1 hl
  nlinarith

def weight (K : List Bool → Bool → ℝ) : List Bool → List Bool → ℝ
  | _, [] => 1
  | h, b :: rest => K h b * weight K (h++[b]) rest

theorem weight_nonnegative (G : List Bool → Bool → ℝ)
    (hG : ∀ h b, 0 ≤ G h b) (h path : List Bool) : 0 ≤ weight G h path := by
  induction path generalizing h with
  | nil => simp [weight]
  | cons b rest ih => exact mul_nonneg (hG h b) (ih (h++[b]))

/-- The gamma law may adapt to observed history, but is the same law for
    each world. K is any world's actual conditional law, not its marginals. -/
theorem conditional_record_lower (K G : List Bool → Bool → ℝ) (eta : ℝ)
    (he : 0 ≤ eta) (hG : ∀ h b, 0 ≤ G h b)
    (minor : ∀ h b, eta*G h b ≤ K h b) (h path : List Bool) :
    eta^path.length * weight G h path ≤ weight K h path := by
  induction path generalizing h with
  | nil => simp [weight]
  | cons b rest ih =>
      have hK : 0 ≤ K h b := (mul_nonneg he (hG h b)).trans (minor h b)
      have hR : 0 ≤ eta^rest.length * weight G (h++[b]) rest :=
        mul_nonneg (pow_nonneg he _) (weight_nonnegative G hG _ _)
      simp only [List.length_cons, weight]
      calc eta^(rest.length+1)*(G h b*weight G (h++[b]) rest)
          = (eta*G h b)*(eta^rest.length*weight G (h++[b]) rest) := by rw [pow_succ]; ring
        _ ≤ K h b * weight K (h++[b]) rest := mul_le_mul (minor h b) (ih (h++[b])) hR hK

def total (G : List Bool → Bool → ℝ) : List Bool → Nat → ℝ
  | _, 0 => 1
  | h, n+1 => G h false*total G (h++[false]) n + G h true*total G (h++[true]) n

theorem baseline_normalized (G : List Bool → Bool → ℝ)
    (norm : ∀ h, G h false+G h true=1) (h : List Bool) (n : Nat) : total G h n=1 := by
  induction n generalizing h with
  | zero => rfl
  | succ n ih => simp [total, ih, norm]

end UPTReadoutFollowup

