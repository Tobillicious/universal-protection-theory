import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Tactic.Linarith

/-! The exact metric conclusion from a uniformly bounded embedding
perturbation. Obtaining that embedding bound from a physical heat kernel
is a separate operator-dynamics theorem. -/
namespace GeminiThirteenMetric

theorem embedding_distance_stability {I V : Type*} [PseudoMetricSpace V]
    (first second : I → V) (epsilon : ℝ)
    (close : ∀ i, dist (first i) (second i) ≤ epsilon) (i j : I) :
    |dist (first i) (first j)-dist (second i) (second j)| ≤ 2*epsilon := by
  have upper := dist_dist_dist_le (first i) (first j) (second i) (second j)
  rw [Real.dist_eq] at upper
  linarith [close i,close j]

theorem protected_close_edge_margin (original perturbed threshold epsilon : ℝ)
    (distortion : |original-perturbed| ≤ epsilon)
    (margin : original+epsilon < threshold) : perturbed < threshold := by
  have lower := (abs_le.mp distortion).1
  linarith

theorem protected_separated_edge_margin (original perturbed threshold epsilon : ℝ)
    (distortion : |original-perturbed| ≤ epsilon)
    (margin : threshold < original-epsilon) : threshold < perturbed := by
  have upper := (abs_le.mp distortion).2
  linarith

end GeminiThirteenMetric

