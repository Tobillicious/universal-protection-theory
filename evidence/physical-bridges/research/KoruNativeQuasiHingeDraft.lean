/-!
# Koru radial correspondence and quasi-hinge — research candidate
This module is intentionally unimported pending pinned Lean compilation.
The relation KoruCorresponds is a RADIAL MODEL PREORDER, not the
whole-physical Complete Koru and not the original six X3 obligations.
-/
import research.KoruThermoHingeDraft

namespace KoruThermoHingeDraft

/-- A radial comparison with respect to the model fixed point.
    Does not assert lossless correspondence of full objective wholes. -/
def KoruCorresponds {M : Type} (C : ContractionPillar M)
    (x y : M) : Prop :=
  C.dist x C.G * C.kDen ≤ C.dist y C.G * C.kDen

structure KoruHinge {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M) where
  pi : S → M
  koruStep : ∀ s, KoruCorresponds C (pi (P.f s))
    (C.phi (pi s))

/-- Exact commutation is sufficient for radial correspondence. -/
def StrictHinge.toKoruHinge {S M : Type}
    {P : ProcessPillar S} {C : ContractionPillar M}
    (hinge : StrictHinge P C) : KoruHinge P C where
  pi := hinge.pi
  koruStep := by
    intro s
    unfold KoruCorresponds
    rw [hinge.commutes s]

/-- Six abstract process/contraction invariants, NOT the original six X3. -/
structure KoruQuasiSixModelInvariants {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : KoruHinge P C) : Prop where
  witnessed : (S → False) → False
  zeroDistanceFixedPoints : ∀ G', C.phi G' = G' →
    C.dist C.G G' = 0
  fixedPersists : ∀ n,
    iterate C.phi n C.G = C.G
  conserves : ∀ n,
    P.energy (iterate P.f n P.s0) = P.energy P.s0
  contractsProjected : ∀ n,
    C.dist (hinge.pi (iterate P.f (n + 1) P.s0)) C.G *
        C.kDen ≤
    C.kNum *
      C.dist (hinge.pi (iterate P.f n P.s0)) C.G
  entropy : ∀ n,
    P.entropy P.s0 ≤ P.entropy (iterate P.f n P.s0)

/-- The quasi-hinge supplies contraction without an explicit drift term.
    All other fields are reused directly from the same process and model. -/
theorem koru_quasi_six_model_invariants {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : KoruHinge P C) :
    KoruQuasiSixModelInvariants P C hinge := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro ender
    exact ender P.s0
  · intro G' hG'
    cases hEq : C.dist C.G G' with
    | zero => rfl
    | succ d =>
        exfalso
        have hC := C.contracts C.G G'
        rw [C.hFixed, hG', hEq] at hC
        have hLt :
            C.kNum * (d + 1) <
              (d + 1) * C.kDen := by
          simpa only [Nat.mul_comm] using
            (Nat.mul_lt_mul_of_pos_right C.kLt (Nat.succ_pos d))
        exact (Nat.not_lt_of_ge hC) hLt
  · intro n
    induction n with
    | zero => rfl
    | succ k ih =>
        calc
          iterate C.phi (k + 1) C.G =
              C.phi (iterate C.phi k C.G) := rfl
          _ = C.phi C.G := congrArg C.phi ih
          _ = C.G := C.hFixed
  · intro n
    induction n with
    | zero => rfl
    | succ k ih =>
        calc
          P.energy (iterate P.f (k + 1) P.s0)
              = P.energy (P.f (iterate P.f k P.s0)) := rfl
          _ = P.energy (iterate P.f k P.s0) := P.conserves _
          _ = P.energy P.s0 := ih
  · intro n
    have hStep :
        KoruCorresponds C
          (hinge.pi (iterate P.f (n + 1) P.s0))
          (C.phi (hinge.pi (iterate P.f n P.s0))) :=
      hinge.koruStep (iterate P.f n P.s0)
    have hContract :
        C.dist (C.phi (hinge.pi (iterate P.f n P.s0)))
            C.G * C.kDen ≤
          C.kNum *
            C.dist (hinge.pi (iterate P.f n P.s0)) C.G := by
      simpa only [C.hFixed] using
        C.contracts (hinge.pi (iterate P.f n P.s0)) C.G
    exact Nat.le_trans hStep hContract
  · intro n
    induction n with
    | zero => exact Nat.le_refl _
    | succ k ih =>
        exact Nat.le_trans ih
          (P.monotoneEntropy (iterate P.f k P.s0))


/-- Radial correspondence is transitive, independently of symmetry,
    separation, or a triangle inequality for dist. -/
theorem koru_corresponds_transitive {M : Type}
    (C : ContractionPillar M) {x y z : M}
    (hxy : KoruCorresponds C x y)
    (hyz : KoruCorresponds C y z) :
    KoruCorresponds C x z :=
  Nat.le_trans hxy hyz

/-- The fixed point is unchanged under any finite number of model steps. -/
theorem koru_fixed_point_all_steps {M : Type}
    (C : ContractionPillar M) (n : Nat) :
    iterate C.phi n C.G = C.G := by
  induction n with
  | zero => rfl
  | succ n ih =>
      calc
        iterate C.phi (n + 1) C.G =
            C.phi (iterate C.phi n C.G) := rfl
        _ = C.phi C.G := congrArg C.phi ih
        _ = C.G := C.hFixed

/-- Powers of the Nat contraction factors bound the projected distance
    after any finite number of steps; no division or Delta. -/
theorem koru_n_step_contraction_decay {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : KoruHinge P C) (n : Nat) :
    C.dist (hinge.pi (iterate P.f n P.s0)) C.G *
        C.kDen ^ n ≤
      C.kNum ^ n * C.dist (hinge.pi P.s0) C.G := by
  induction n with
  | zero =>
      simp
  | succ n ih =>
      have hStep :=
        (koru_quasi_six_model_invariants P C hinge).contractsProjected n
      have hScaled :=
        Nat.mul_le_mul_right (C.kDen ^ n) hStep
      have hNext :
          C.dist (hinge.pi (iterate P.f (n + 1) P.s0))
              C.G * C.kDen ^ (n + 1) ≤
            C.kNum *
              (C.dist (hinge.pi (iterate P.f n P.s0))
                C.G * C.kDen ^ n) := by
        simpa [pow_succ, Nat.mul_assoc, Nat.mul_comm,
          Nat.mul_left_comm] using hScaled
      calc
        C.dist (hinge.pi (iterate P.f (n + 1) P.s0))
            C.G * C.kDen ^ (n + 1) ≤
            C.kNum *
              (C.dist (hinge.pi (iterate P.f n P.s0))
                C.G * C.kDen ^ n) := hNext
        _ ≤ C.kNum *
              (C.kNum ^ n *
                C.dist (hinge.pi P.s0) C.G) :=
            Nat.mul_le_mul_left C.kNum ih
        _ = C.kNum ^ (n + 1) *
              C.dist (hinge.pi P.s0) C.G := by
            simp [pow_succ, Nat.mul_assoc,
              Nat.mul_comm, Nat.mul_left_comm]

/-- Successive scaled envelope bound from the N-step result
    and the single-step radial contraction inequality. -/
theorem koru_successive_bound_step {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : KoruHinge P C) (n : Nat) :
    C.dist (hinge.pi (iterate P.f (n + 1) P.s0))
        C.G * C.kDen ^ (n + 1) ≤
      C.kNum *
        (C.kNum ^ n * C.dist (hinge.pi P.s0) C.G) := by
  have hNext :=
    koru_n_step_contraction_decay P C hinge (n + 1)
  simpa [pow_succ, Nat.mul_assoc, Nat.mul_comm,
    Nat.mul_left_comm] using hNext

#print axioms koru_corresponds_transitive
#print axioms koru_fixed_point_all_steps
#print axioms koru_n_step_contraction_decay
#print axioms koru_successive_bound_step


/-- Positive denominator follows constructively from kNum < kDen. -/
theorem koru_denominator_positive {M : Type}
    (C : ContractionPillar M) : 0 < C.kDen :=
  Nat.lt_of_le_of_lt (Nat.zero_le _) C.kLt

/-- A Nat product with positive second factor cannot be zero
    unless the first factor vanishes. -/
private theorem zero_of_mul_le_zero
    (a b : Nat) (hb : 0 < b) (h : a * b ≤ 0) : a = 0 := by
  cases ha : a with
  | zero => rfl
  | succ k =>
      have hp : 0 < (k + 1) * b :=
        Nat.mul_pos (Nat.succ_pos k) hb
      have hn : ¬ (0 < (k + 1) * b) := Nat.not_lt_of_ge (by
        simpa only [ha] using h)
      exact False.elim (hn hp)

/-- A zero radial offset survives any KoruCorresponds predecessor. -/
theorem koru_corresponds_zero_distance {M : Type}
    (C : ContractionPillar M) {x y : M}
    (hKoru : KoruCorresponds C x y)
    (hZeroY : C.dist y C.G = 0) :
    C.dist x C.G = 0 := by
  unfold KoruCorresponds at hKoru
  rw [hZeroY] at hKoru
  have h : C.dist x C.G * C.kDen ≤ 0 := by
    simpa using hKoru
  exact zero_of_mul_le_zero _ _ (koru_denominator_positive C) h

/-- No reflexive-distance axiom was assumed: contraction at G,G
    itself forces the Nat-valued self-distance to be zero. -/
theorem koru_fixed_self_distance_zero {M : Type}
    (C : ContractionPillar M) :
    C.dist C.G C.G = 0 :=
  (koru_quasi_six_model_invariants
    ({ f := id, s0 := (), energy := fun _ => 0,
       conserves := by intro _; rfl,
       entropy := fun _ => 0,
       monotoneEntropy := by intro _; exact Nat.le_refl _ } :
      ProcessPillar Unit)
    C
    ({ pi := fun _ => C.G, koruStep := by
       intro _
       unfold KoruCorresponds
       rw [C.hFixed] } : KoruHinge
      ({ f := id, s0 := (), energy := fun _ => 0,
         conserves := by intro _; rfl,
         entropy := fun _ => 0,
         monotoneEntropy := by intro _; exact Nat.le_refl _ } :
        ProcessPillar Unit) C)).zeroDistanceFixedPoints C.G C.hFixed

/-- The projected orbit and model dynamics preserve zero radial offset. -/
theorem koru_fixed_point_stability_and_zero_pinning {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : KoruHinge P C) :
    (∀ n, iterate C.phi n C.G = C.G) ∧
    (∀ x, C.dist x C.G = 0 →
      C.dist (C.phi x) C.G = 0) ∧
    (∀ n,
      C.dist (hinge.pi (iterate P.f n P.s0)) C.G = 0 →
      C.dist (hinge.pi (iterate P.f (n + 1) P.s0)) C.G = 0) := by
  refine ⟨koru_fixed_point_all_steps C, ?_, ?_⟩
  · intro x hx
    have hc := C.contracts x C.G
    rw [C.hFixed, hx] at hc
    have h : C.dist (C.phi x) C.G * C.kDen ≤ 0 := by
      simpa using hc
    exact zero_of_mul_le_zero _ _ (koru_denominator_positive C) h
  · intro n hn
    have hc :=
      (koru_quasi_six_model_invariants P C hinge).contractsProjected n
    rw [hn] at hc
    have h : C.dist (hinge.pi (iterate P.f (n + 1) P.s0))
        C.G * C.kDen ≤ 0 := by
      simpa using hc
    exact zero_of_mul_le_zero _ _ (koru_denominator_positive C) h

#print axioms koru_corresponds_zero_distance
#print axioms koru_fixed_point_stability_and_zero_pinning

#print axioms koru_quasi_six_model_invariants

end KoruThermoHingeDraft
