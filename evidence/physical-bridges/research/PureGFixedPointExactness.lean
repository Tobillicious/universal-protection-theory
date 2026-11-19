import research.KoruNativeQuasiHingeDraft

/-!
# Exact fixed-point uniqueness for the Pure G radial hinge (additive)
The previously checked theorem proves zero distance to an existing fixed
point. The stronger *equality* of fixed points requires the explicitly
stated point-separation property of the model distance.

This does not redefine the whole Complete Koru, derive a physical
subject semantics or change any original X3 theorem.
-/

namespace KoruThermoHingeDraft

/-- Zero modeled distance between arbitrary fixed points follows from
the strict Nat contraction; no metric separation is presumed. -/
theorem koru_fixed_point_zero_distance
    {M : Type} (C : ContractionPillar M) (G' : M)
    (hG' : C.phi G' = G') :
    C.dist C.G G' = 0 := by
  cases hd : C.dist C.G G' with
  | zero => rfl
  | succ d =>
      exfalso
      have hc := C.contracts C.G G'
      rw [C.hFixed, hG', hd] at hc
      have hlt : C.kNum * (d + 1) <
          (d + 1) * C.kDen := by
        simpa only [Nat.mul_comm] using
          (Nat.mul_lt_mul_of_pos_right C.kLt (Nat.succ_pos d))
      exact (Nat.not_lt_of_ge hc) hlt

/-- Equality-based uniqueness needs a distance that separates states.
This condition is independent of the previous Koru radial inequality. -/
theorem koru_fixed_point_eq_if_separated
    {M : Type} (C : ContractionPillar M)
    (hSeparates : ∀ x y, C.dist x y = 0 → x = y)
    (G' : M) (hG' : C.phi G' = G') :
    G' = C.G := by
  have hZero := koru_fixed_point_zero_distance C G' hG'
  exact (hSeparates C.G G' hZero).symm

/-- A radial zero-distance equation is not, without separation, a
proof that the full states are identical. -/
theorem radial_zero_respects_point_separation
    {M : Type} (C : ContractionPillar M)
    (hSeparates : ∀ x y, C.dist x y = 0 → x = y)
    (x : M) (hZero : C.dist x C.G = 0) :
    x = C.G :=
  hSeparates x C.G hZero

#print axioms koru_fixed_point_zero_distance
#print axioms koru_fixed_point_eq_if_separated
#print axioms radial_zero_respects_point_separation

end KoruThermoHingeDraft
