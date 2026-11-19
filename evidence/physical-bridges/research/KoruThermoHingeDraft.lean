/-!
# Triadic hinge: six model invariants, liveness, faithful readouts
Draft Lean 4 module. Not compiled in this session; deliberately NOT imported.
The full matterspacetime Koru and original six X3 are NOT redefined here.
-/
namespace KoruThermoHingeDraft

def iterate {α : Type} (g : α → α) : Nat → α → α
  | 0, x => x
  | n + 1, x => g (iterate g n x)

structure ProcessPillar (S : Type) where
  f : S → S
  s0 : S
  energy : S → Nat
  conserves : ∀ s, energy (f s) = energy s
  entropy : S → Nat
  monotoneEntropy : ∀ s, entropy s ≤ entropy (f s)

structure ContractionPillar (M : Type) where
  phi : M → M
  dist : M → M → Nat
  kNum : Nat
  kDen : Nat
  kLt : kNum < kDen
  contracts : ∀ x y, dist (phi x) (phi y) * kDen ≤
    kNum * dist x y
  G : M
  hFixed : phi G = G

structure StrictHinge {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M) where
  pi : S → M
  commutes : ∀ s, pi (P.f s) = C.phi (pi s)

/-- A six-field mathematical INVARIANT bundle, not the canonical
    OriginalX3 of Universal Protection Theory. -/
structure SixModelInvariants {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : StrictHinge P C) : Prop where
  witnessed : (S → False) → False
  conserves : ∀ n, P.energy (iterate P.f n P.s0) =
    P.energy P.s0
  entropy : ∀ n, P.entropy P.s0 ≤
    P.entropy (iterate P.f n P.s0)
  zeroDistanceFixedPoints : ∀ G', C.phi G' = G' →
    C.dist C.G G' = 0
  fixedPersists : ∀ n, iterate C.phi n C.G = C.G
  contractsProjected : ∀ n,
    C.dist (hinge.pi (iterate P.f (n + 1) P.s0)) C.G *
        C.kDen ≤
    C.kNum *
      C.dist (hinge.pi (iterate P.f n P.s0)) C.G

theorem triadic_g_bridge {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : StrictHinge P C) :
    SixModelInvariants P C hinge := by
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩
  · intro ender
    exact ender P.s0
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
    induction n with
    | zero => exact Nat.le_refl _
    | succ k ih =>
        exact Nat.le_trans ih
          (P.monotoneEntropy (iterate P.f k P.s0))
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
          iterate C.phi (k + 1) C.G
              = C.phi (iterate C.phi k C.G) := rfl
          _ = C.phi C.G := congrArg C.phi ih
          _ = C.G := C.hFixed
  · intro n
    have hStep :
        hinge.pi (iterate P.f (n + 1) P.s0) =
          C.phi (hinge.pi (iterate P.f n P.s0)) :=
      hinge.commutes (iterate P.f n P.s0)
    calc
      C.dist (hinge.pi (iterate P.f (n + 1) P.s0)) C.G *
          C.kDen
          = C.dist
              (C.phi (hinge.pi (iterate P.f n P.s0)))
              (C.phi C.G) * C.kDen := by
                rw [hStep, C.hFixed]
      _ ≤ C.kNum *
          C.dist (hinge.pi (iterate P.f n P.s0)) C.G :=
        C.contracts _ _

def ExactDecoder {M O : Type} (c : M → O)
    (live : M → Prop) : Type :=
  { dec : O → Bool // ∀ m, dec (c m) = true ↔ live m }

/-- An incomplete cut cannot decode two conflicting objective facts. -/
theorem strict_hinge_category_error {S M O : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : StrictHinge P C)
    (c : M → O) (live : M → Prop)
    (s : S) (hLiveS : live (hinge.pi s))
    (a : M) (hCut : c (hinge.pi s) = c a)
    (hNotLiveA : ¬ live a) :
    ExactDecoder c live → False := by
  intro ⟨dec, hSpec⟩
  have hTrue : dec (c (hinge.pi s)) = true :=
    (hSpec (hinge.pi s)).mpr hLiveS
  have hFalse : dec (c a) ≠ true := by
    intro hEq
    exact hNotLiveA ((hSpec a).mp hEq)
  rw [hCut] at hTrue
  exact hFalse hTrue

/-- Live remains true on the projected trajectory if it is initially
    true and closed under phi. This is a model predicate only. -/
theorem hinge_live_persistence_and_contraction {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : StrictHinge P C)
    (live : M → Prop)
    (hClosed : ∀ m, live m → live (C.phi m))
    (hInitLive : live (hinge.pi P.s0))
    (n : Nat) :
    live (hinge.pi (iterate P.f n P.s0)) ∧
    (C.dist (hinge.pi (iterate P.f (n + 1) P.s0)) C.G *
        C.kDen ≤
      C.kNum *
        C.dist (hinge.pi (iterate P.f n P.s0)) C.G) := by
  constructor
  · induction n with
    | zero => exact hInitLive
    | succ k ih =>
        have hStep :
            hinge.pi (iterate P.f (k + 1) P.s0) =
              C.phi (hinge.pi (iterate P.f k P.s0)) :=
          hinge.commutes (iterate P.f k P.s0)
        rw [hStep]
        exact hClosed _ ih
  · exact (triadic_g_bridge P C hinge).contractsProjected n


/-- Quasi-commuting error inequality. A strict hinge is supplied here for
    compatibility with the triadic stack; the proof itself does NOT use
    hinge.commutes. Consequently it also applies to a projection supplied
    independently, once that premise is factored out in a later module.
    delta is a bound, not a measured physical uncertainty by definition. -/
theorem quasi_commuting_distance_bound {S M : Type}
    (P : ProcessPillar S) (C : ContractionPillar M)
    (hinge : StrictHinge P C)
    (n delta : Nat)
    (hTri : ∀ x y z, C.dist x z ≤
      C.dist x y + C.dist y z)
    (hDrift :
      C.dist (hinge.pi (iterate P.f (n + 1) P.s0))
        (C.phi (hinge.pi (iterate P.f n P.s0))) ≤ delta) :
    C.dist (hinge.pi (iterate P.f (n + 1) P.s0))
        C.G * C.kDen ≤
      C.kNum * C.dist
        (hinge.pi (iterate P.f n P.s0)) C.G +
        delta * C.kDen := by
  let x := hinge.pi (iterate P.f n P.s0)
  let y := hinge.pi (iterate P.f (n + 1) P.s0)
  have hTriangle :
      C.dist y C.G ≤
        C.dist y (C.phi x) +
          C.dist (C.phi x) C.G :=
    hTri y (C.phi x) C.G
  have hBound :
      C.dist y C.G ≤
        delta + C.dist (C.phi x) C.G :=
    Nat.le_trans hTriangle
      (Nat.add_le_add_right hDrift _)
  have hContract :
      C.dist (C.phi x) C.G * C.kDen ≤
        C.kNum * C.dist x C.G := by
    simpa only [C.hFixed] using C.contracts x C.G
  have hScale := Nat.mul_le_mul_right C.kDen hBound
  have hSum :
      (delta + C.dist (C.phi x) C.G) *
          C.kDen ≤
        delta * C.kDen +
          C.kNum * C.dist x C.G := by
    rw [Nat.add_mul]
    exact Nat.add_le_add_left hContract _
  have hFinal := Nat.le_trans hScale hSum
  simpa only [Nat.add_comm] using hFinal

#print axioms triadic_g_bridge
#print axioms strict_hinge_category_error
#print axioms hinge_live_persistence_and_contraction
#print axioms quasi_commuting_distance_bound

end KoruThermoHingeDraft
