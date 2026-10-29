import Snuffy.Bridge
import Snuffy.WorkBilling
import Snuffy.G1FullDomain
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.InnerProductSpace.GramMatrix
import Mathlib.Analysis.Normed.Algebra.Exponential
import Mathlib.LinearAlgebra.Basis.Defs

namespace Snuffy.DecoderRetraction

universe u v

structure DecoderPair (A : Type u) (B : Type v) where
  encode : A → B
  decode : B → A
  retraction : ∀ a, decode (encode a) = a

theorem decode_encode {A : Type u} {B : Type v} (D : DecoderPair A B) (a : A) :
    D.decode (D.encode a) = a :=
  D.retraction a

/-- The existing finite nearest-codeword construction populates the retraction
interface and corrects every received state within the unique-decoding radius.
The retraction and radius guarantee are derived from `Bridge`; neither is
assumed as a field of an unspecified decoder. The physical source still has
to establish that its perturbations meet this same radius bound. -/
theorem finite_code_recovery {X : Type u} [MetricSpace X]
    (Code : Set X) (hfin : Code.Finite) (hne : Code.Nonempty)
    {dmin radius : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c')
    (hrad : 2 * radius < dmin) :
    ∃ D : DecoderPair Code X,
      (∀ c, D.encode c = (c : X)) ∧
      ∀ (c : Code) (y : X), dist y (c : X) ≤ radius → D.decode y = c := by
  obtain ⟨dec, hdec, hnear⟩ := Snuffy.Bridge.exists_nearest_decoder Code hfin hne
  let D : DecoderPair Code X := {
    encode := fun c => c.val
    decode := fun y => ⟨dec y, hdec y⟩
    retraction := by
      intro c
      apply Subtype.ext
      change dec (c : X) = (c : X)
      have hdist : dist (c : X) (dec (c : X)) ≤ 0 := by
        simpa only [dist_self] using hnear (c : X) (c : X) c.property
      exact (dist_eq_zero.mp (le_antisymm hdist dist_nonneg)).symm }
  refine ⟨D, fun _ => rfl, ?_⟩
  intro c y hy
  apply Subtype.ext
  change dec y = (c : X)
  exact Snuffy.Bridge.nearest_decodes hsep hrad hdec hnear c.property hy

/-- A continuation witness remains nonzero when its certified error is
strictly smaller than the record's distance from zero. The funded holding
construction supplies continuation; a work ceiling alone is not used as
a substitute for that witness. -/
theorem nonvanishing_of_continuation {X : Type u} [MetricSpace X] [Zero X]
    {Part : Type v} (rec : Part → X) (ε : ℝ) (state : Part → X) (x : Part)
    (hcontinues : Snuffy.Bridge.Continues rec ε state x)
    (hgap : ε < dist (rec x) 0) : state x ≠ 0 := by
  intro hzero
  change dist (state x) (rec x) ≤ ε at hcontinues
  rw [hzero, dist_comm] at hcontinues
  exact (not_le_of_gt hgap) hcontinues

/-- The finite-code recovery construction supplies a non-bottom fixed point
for its evaluation/transducer `encode ∘ decode` whenever the maintained code
contains a non-bottom record. This is a derived witness for the proposed
self-grounding equation; it introduces no new axiom and does not infer
existence from a work ceiling or from homology alone. -/
theorem finite_code_self_grounding {X : Type u} [MetricSpace X] [Bot X]
    (Code : Set X) (hfin : Code.Finite) (hne : Code.Nonempty)
    {dmin radius : ℝ}
    (hsep : ∀ c ∈ Code, ∀ c' ∈ Code, c ≠ c' → dmin ≤ dist c c')
    (hrad : 2 * radius < dmin) (record : Code) (hnonbot : (record : X) ≠ ⊥) :
    ∃ D : DecoderPair Code X,
      (∀ c, D.encode c = (c : X)) ∧
      (∀ (c : Code) (y : X), dist y (c : X) ≤ radius → D.decode y = c) ∧
      ∃ e : X, D.encode (D.decode e) = e ∧ D.encode (D.decode e) ≠ ⊥ := by
  obtain ⟨D, hencode, hcorrect⟩ := finite_code_recovery Code hfin hne hsep hrad
  have hfixed : D.encode (D.decode (record : X)) = (record : X) := by
    rw [← hencode record, D.retraction record]
  refine ⟨D, hencode, hcorrect, (record : X), hfixed, ?_⟩
  rw [hfixed]
  exact hnonbot

section BoundaryOperators

variable {H : Type u} {B : Type v}
variable [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
variable [NormedAddCommGroup B] [InnerProductSpace ℂ B] [CompleteSpace B]

omit [CompleteSpace H] [CompleteSpace B] in
/-- Complex linearity and preservation of the symplectic flux determine both
parts of the Hilbert inner product. This supplies the isometry step from the
stated flux identity, without postulating an isometry field. -/
theorem inner_preserved_from_symplectic_flux (E : H →ₗ[ℂ] B)
    (hflux : ∀ x y, (inner ℂ (E x) (E y)).im = (inner ℂ x y).im) (x y : H) :
    inner ℂ (E x) (E y) = inner ℂ x y := by
  apply Complex.ext
  · have h := hflux x (Complex.I • y)
    simpa [inner_smul_right] using h
  · exact hflux x y

/-- The encoder is built from the complex-linear source map and its proven
symplectic-flux identity. -/
def boundaryIsometry (E : H →ₗ[ℂ] B)
    (hflux : ∀ x y, (inner ℂ (E x) (E y)).im = (inner ℂ x y).im) : H →ₗᵢ[ℂ] B :=
  { toLinearMap := E
    norm_map' := (LinearMap.norm_map_iff_inner_map_map E).mpr
      (inner_preserved_from_symplectic_flux E hflux) }

theorem adjoint_decodes_isometry (E : H →ₗᵢ[ℂ] B) (x : H) :
    E.toContinuousLinearMap.adjoint (E x) = x := by
  exact congrArg (fun A : H →L[ℂ] H => A x) E.adjoint_comp_self

/-- The work/historical encoder's adjoint now populates the same decoder
interface used by the finite-record construction. -/
noncomputable def decoderFromSymplecticFlux (E : H →ₗ[ℂ] B)
    (hflux : ∀ x y, (inner ℂ (E x) (E y)).im = (inner ℂ x y).im) :
    DecoderPair H B :=
  { encode := boundaryIsometry E hflux
    decode := (boundaryIsometry E hflux).toContinuousLinearMap.adjoint
    retraction := adjoint_decodes_isometry (boundaryIsometry E hflux) }

/-- Transport a complete bulk-code observable to the boundary code range. -/
noncomputable def boundaryObservable (E : H →ₗᵢ[ℂ] B) (A : H →L[ℂ] H) : B →L[ℂ] B :=
  E.toContinuousLinearMap ∘L A ∘L E.toContinuousLinearMap.adjoint

theorem boundary_observable_on_code (E : H →ₗᵢ[ℂ] B) (A : H →L[ℂ] H) (x : H) :
    boundaryObservable E A (E x) = E (A x) := by
  simp [boundaryObservable, adjoint_decodes_isometry]

/-- Every code observable, including an observable of the stored historical
record, has its original expectation after the boundary transport. -/
theorem historical_query_preserved (E : H →ₗᵢ[ℂ] B) (A : H →L[ℂ] H) (x : H) :
    inner ℂ (E x) (boundaryObservable E A (E x)) = inner ℂ x (A x) := by
  rw [boundary_observable_on_code]
  exact E.inner_map_map x (A x)

/-- Transport preserves ordered operator words on the code. No commutation or
reordering of historical operations is used. -/
theorem historical_word_on_code (E : H →ₗᵢ[ℂ] B) (word : List (H →L[ℂ] H)) (x : H) :
    (word.map (boundaryObservable E)).prod (E x) = E (word.prod x) := by
  induction word with
  | nil => simp
  | cons A word ih =>
      simp only [List.map_cons, List.prod_cons, mul_apply_eq_comp]
      rw [ih, boundary_observable_on_code]

theorem historical_word_expectation (E : H →ₗᵢ[ℂ] B)
    (word : List (H →L[ℂ] H)) (x : H) :
    inner ℂ (E x) ((word.map (boundaryObservable E)).prod (E x)) =
      inner ℂ x (word.prod x) := by
  rw [historical_word_on_code]
  exact E.inner_map_map x (word.prod x)

/-- The boundary observable map preserves products, hence commutators, on
the represented code algebra. Its ambient identity is the code projector. -/
theorem boundary_observable_mul (E : H →ₗᵢ[ℂ] B) (A C : H →L[ℂ] H) :
    boundaryObservable E (A * C) =
      boundaryObservable E A * boundaryObservable E C := by
  ext y
  simp [boundaryObservable, adjoint_decodes_isometry]

theorem boundary_observable_commutator (E : H →ₗᵢ[ℂ] B) (A Q : H →L[ℂ] H) :
    boundaryObservable E (A * Q - Q * A) =
      boundaryObservable E A * boundaryObservable E Q -
        boundaryObservable E Q * boundaryObservable E A := by
  rw [show boundaryObservable E (A * Q - Q * A) =
      boundaryObservable E (A * Q) - boundaryObservable E (Q * A) by
        ext y
        simp [boundaryObservable]]
  rw [boundary_observable_mul, boundary_observable_mul]

omit [CompleteSpace H] [CompleteSpace B] in
/-- The source and boundary evolutions agree at every power, before taking
the convergent exponential series. -/
theorem powers_intertwine (E : H →L[ℂ] B) (F : B →L[ℂ] B) (G : H →L[ℂ] H)
    (h : ∀ x, F (E x) = E (G x)) (n : ℕ) (x : H) :
    (F ^ n) (E x) = E ((G ^ n) x) := by
  induction n with
  | zero => simp
  | succ n ih =>
      simp only [pow_succ', mul_apply_eq_comp]
      rw [ih, h]

/-- Exact bounded-operator exponential transport, obtained from the
norm-convergent power series. No infinite-work limiting decoder is used. -/
theorem exponential_intertwines (E : H →L[ℂ] B) (F : B →L[ℂ] B)
    (G : H →L[ℂ] H) (h : ∀ x, F (E x) = E (G x)) (x : H) :
    NormedSpace.exp F (E x) = E (NormedSpace.exp G x) := by
  have hb := (NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) F).mapL
    (ContinuousLinearMap.apply ℂ B (E x))
  have hh := ((NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) G).mapL
    (ContinuousLinearMap.apply ℂ H x)).mapL E
  apply HasSum.unique hb
  simpa only [ContinuousLinearMap.apply_apply, smul_apply,
    map_smul, powers_intertwine E F G h] using hh

/-- Analytic conjugation by the effective bounded generator. The physical
modular parameter is the imaginary value `z = I*s`; self-adjointness supplies
unitarity there. The algebraic transport is valid for every complex `z`. -/
noncomputable def historicalFlow (G A : H →L[ℂ] H) (z : ℂ) : H →L[ℂ] H :=
  NormedSpace.exp (z • G) * A * NormedSpace.exp ((-z) • G)

/-- Conjugation is a linear map of the complete operator algebra. -/
noncomputable def historicalFlowLinear (G : H →L[ℂ] H) (z : ℂ) :
    (H →L[ℂ] H) →ₗ[ℂ] (H →L[ℂ] H) where
  toFun := fun A => historicalFlow G A z
  map_add' A C := by simp [historicalFlow, mul_add, add_mul]
  map_smul' c A := by simp [historicalFlow]

theorem historical_flow_roundtrip (G A : H →L[ℂ] H) (z : ℂ) :
    historicalFlow G (historicalFlow G A (-z)) z = A := by
  have hexp : NormedSpace.exp (z • G) * NormedSpace.exp ((-z) • G) = 1 := by
    have hall (F : H →L[ℂ] H) :
        F ∈ Metric.eball (0 : H →L[ℂ] H)
          (NormedSpace.expSeries ℂ (H →L[ℂ] H)).radius := by
      rw [NormedSpace.expSeries_radius_eq_top]
      exact Metric.mem_eball.mpr (edist_lt_top _ _)
    rw [neg_smul, ← NormedSpace.exp_add_of_commute_of_mem_ball (𝕂 := ℂ)
      (Commute.refl (z • G)).neg_right (hall _) (hall _),
      add_neg_cancel, NormedSpace.exp_zero]
  change NormedSpace.exp (z • G) *
      (NormedSpace.exp ((-z) • G) * A * NormedSpace.exp ((-(-z)) • G)) *
      NormedSpace.exp ((-z) • G) = A
  rw [neg_neg]
  calc
    _ = (NormedSpace.exp (z • G) * NormedSpace.exp ((-z) • G)) * A *
        (NormedSpace.exp (z • G) * NormedSpace.exp ((-z) • G)) := by
      simp only [mul_assoc]
    _ = A := by rw [hexp, one_mul, mul_one]

/-- A derived dual smearing kernel for a complete finite operator basis.
At every flow parameter it reconstructs the original operator exactly.
A normalized integrable average of this identity gives the continuous
modular smearing formula without a regularization error. -/
theorem historical_dual_kernel {ι : Type*} [Fintype ι]
    (b : Module.Basis ι ℂ (H →L[ℂ] H)) (G A : H →L[ℂ] H) (z : ℂ) :
    ∑ i, b.repr (historicalFlow G A (-z)) i • historicalFlow G (b i) z = A := by
  calc
    _ = historicalFlowLinear G z
        (∑ i, b.repr (historicalFlow G A (-z)) i • b i) := by
      rw [map_sum]
      simp only [map_smul]
      rfl
    _ = A := by
      rw [b.sum_repr]
      exact historical_flow_roundtrip G A z

theorem work_shifted_flow_on_code (E : H →ₗᵢ[ℂ] B)
    (K W A : H →L[ℂ] H) (β z : ℂ) (x : H) :
    historicalFlow (boundaryObservable E K + β • boundaryObservable E W)
      (boundaryObservable E A) z (E x) =
    E (historicalFlow (K + β • W) A z x) := by
  have hinter (c : ℂ) (y : H) :
      (c • (boundaryObservable E K + β • boundaryObservable E W)) (E y) =
      E ((c • (K + β • W)) y) := by
    simp [boundary_observable_on_code]
  have hexp (c : ℂ) (y : H) :
      NormedSpace.exp (c • (boundaryObservable E K + β • boundaryObservable E W))
          (E y) = E (NormedSpace.exp (c • (K + β • W)) y) :=
    exponential_intertwines E.toContinuousLinearMap _ _ (hinter c) y
  change NormedSpace.exp (z • (boundaryObservable E K + β • boundaryObservable E W))
      (boundaryObservable E A
        (NormedSpace.exp ((-z) •
          (boundaryObservable E K + β • boundaryObservable E W)) (E x))) = _
  rw [hexp (-z), boundary_observable_on_code, hexp z]
  rfl

/-- Ordered historical words form a genuine Gram kernel after acting on the
state. Time ordering stays inside each word; it is not moved through the
inner product as an unjustified positivity step. -/
theorem historical_gram_preserved {ι : Type*} (E : H →ₗᵢ[ℂ] B)
    (words : ι → List (H →L[ℂ] H)) (x : H) :
    Matrix.gram ℂ (fun i => ((words i).map (boundaryObservable E)).prod (E x)) =
      Matrix.gram ℂ (fun i => (words i).prod x) := by
  ext i j
  simp only [Matrix.gram_apply, historical_word_on_code, E.inner_map_map]

theorem historical_gram_nondegenerate {ι : Type*} [Fintype ι] [DecidableEq ι]
    (E : H →ₗᵢ[ℂ] B) (words : ι → List (H →L[ℂ] H)) (x : H)
    (h : LinearIndependent ℂ (fun i => (words i).prod x)) :
    (Matrix.gram ℂ
      (fun i => ((words i).map (boundaryObservable E)).prod (E x))).det ≠ 0 := by
  rw [historical_gram_preserved]
  exact Matrix.det_gram_ne_zero_iff_linearIndependent.mpr h

end BoundaryOperators

/-- An explicit encoder for a finite historical code: move every code
coordinate to its assigned boundary coordinate and set unused coordinates to
zero. Capacity is met by an actual embedding, not a hash or homology quotient. -/
noncomputable def coordinateBoundaryEncoder {m n : ℕ} (hcapacity : m ≤ n) :
    EuclideanSpace ℂ (Fin m) →ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n) :=
  LinearIsometry.piLpExtendByZero 2 ℂ ℂ (Fin.castLEEmb hcapacity)

theorem coordinate_boundary_roundtrip {m n : ℕ} (hcapacity : m ≤ n)
    (x : EuclideanSpace ℂ (Fin m)) :
    (coordinateBoundaryEncoder hcapacity).toContinuousLinearMap.adjoint
      (coordinateBoundaryEncoder hcapacity x) = x :=
  adjoint_decodes_isometry (coordinateBoundaryEncoder hcapacity) x

theorem boundary_capacity_necessary {m n : ℕ}
    (E : EuclideanSpace ℂ (Fin m) →ₗᵢ[ℂ] EuclideanSpace ℂ (Fin n)) : m ≤ n := by
  have h := LinearMap.finrank_le_finrank_of_injective E.injective
  simpa using h

section ReversibleHandoff

variable {ι R : Type*} [Fintype ι] [Fintype R]

/-- Swap the bulk register with a reserved boundary register and leave an
arbitrary reference register untouched. This is an actual unitary coordinate
permutation of the joint Hilbert space. -/
noncomputable def handoffSwap :
    EuclideanSpace ℂ ((ι × ι) × R) ≃ₗᵢ[ℂ] EuclideanSpace ℂ ((ι × ι) × R) :=
  LinearIsometryEquiv.piLpCongrLeft 2 ℂ ℂ
    ((Equiv.prodComm ι ι).prodCongr (Equiv.refl R))

/-- With a blank reserved boundary register, the swap moves the complete
possibly reference-entangled payload to the boundary and leaves the bulk
register blank. It performs no copying of an unknown quantum state. -/
theorem handoff_moves_reference_payload [DecidableEq ι] (blank : ι)
    (χ : ι × R → ℂ) :
    handoffSwap
        (WithLp.toLp 2 (fun p : (ι × ι) × R =>
          if p.1.2 = blank then χ (p.1.1, p.2) else 0)) =
      WithLp.toLp 2 (fun p : (ι × ι) × R =>
        if p.1.1 = blank then χ (p.1.2, p.2) else 0) := by
  rfl

theorem handoff_preserves_norm (ψ : EuclideanSpace ℂ ((ι × ι) × R)) :
    ‖handoffSwap ψ‖ = ‖ψ‖ :=
  (handoffSwap : EuclideanSpace ℂ ((ι × ι) × R) ≃ₗᵢ[ℂ] _).norm_map ψ

/-- The same hardware permutation implements the inverse handoff. -/
theorem handoff_roundtrip (ψ : EuclideanSpace ℂ ((ι × ι) × R)) :
    handoffSwap (handoffSwap ψ) = ψ := by
  rfl

end ReversibleHandoff

/-- A full input transcript is assigned actual boundary coordinates using
its alphabet-derived capacity. The resulting isometry acts on arbitrary
superpositions of transcript labels. -/
noncomputable def transcriptBoundaryEncoder {X C Ev : Type*}
    [Fintype X] [Fintype C] [Fintype Ev] (N initialBits inputBits : ℕ)
    (hinit : Fintype.card X ≤ 2 ^ initialBits)
    (hinput : Fintype.card (C × Ev) ≤ 2 ^ inputBits) :
    EuclideanSpace ℂ (Snuffy.G1FullDomain.TranscriptAt X C Ev N) →ₗᵢ[ℂ]
      EuclideanSpace ℂ (Fin (2 ^ (initialBits + inputBits * N))) :=
  LinearIsometry.piLpExtendByZero 2 ℂ ℂ
    ((Fintype.equivFin (Snuffy.G1FullDomain.TranscriptAt X C Ev N)).toEmbedding.trans
      (Fin.castLEEmb (Snuffy.G1FullDomain.transcript_capacity N initialBits inputBits
        hinit hinput)))

def cnotLeft {Bits : Type*} (p : (Bits → Bool) × (Bits → Bool)) :
    (Bits → Bool) × (Bits → Bool) :=
  (p.1, fun i => Bool.xor (p.1 i) (p.2 i))

def cnotRight {Bits : Type*} (p : (Bits → Bool) × (Bits → Bool)) :
    (Bits → Bool) × (Bits → Bool) :=
  (fun i => Bool.xor (p.1 i) (p.2 i), p.2)

/-- Three parallel CNOT layers implement the register swap: exactly three
logical gates per payload bit, before physical gate/fault charges are added. -/
theorem parallel_cnot_handoff {Bits : Type*} (p : (Bits → Bool) × (Bits → Bool)) :
    cnotLeft (cnotRight (cnotLeft p)) = (p.2, p.1) := by
  apply Prod.ext <;> funext i <;>
    cases h₁ : p.1 i <;> cases h₂ : p.2 i <;> simp [cnotLeft, cnotRight, h₁, h₂]

/-- There is a single logical owner of the complete payload, either live or
sealed. A handoff moves this owner; it does not erase an unencoded record. -/
inductive ArchivePayload (A : Type u) (B : Type v) where
  | live (record : A)
  | sealed (encoded : B)

def archiveRead {A : Type u} {B : Type v} (D : DecoderPair A B) :
    ArchivePayload A B → A
  | .live record => record
  | .sealed encoded => D.decode encoded

def archiveMove {A : Type u} {B : Type v} (D : DecoderPair A B) :
    ArchivePayload A B → ArchivePayload A B
  | .live record => .sealed (D.encode record)
  | .sealed encoded => .sealed encoded

/-- The actual charged transition preserves every query of the full record,
including its represented relations. A noncommitting attempt retains the
record and is still charged. Quantum payload movement has the reversible
reference-preserving swap implementation above. -/
theorem charged_archive_handoff {A : Type u} {B : Type v}
    (D : DecoderPair A B) (q : Snuffy.WorkBilling.HandoffCharge) (commit : Bool)
    (s : Snuffy.WorkBilling.ChargedState (ArchivePayload A B))
    (hfunded : q.total ≤ s.escrow) :
    let s' := Snuffy.WorkBilling.chargedAttempt (archiveMove D) q commit s hfunded
    archiveRead D s'.payload = archiveRead D s.payload ∧
      s'.spent = s.spent + q.total ∧
      s'.escrow + s'.spent = s.escrow + s.spent := by
  have hread : ∀ p, archiveRead D (archiveMove D p) = archiveRead D p := by
    intro p
    cases p with
    | live record => exact D.retraction record
    | sealed encoded => rfl
  refine ⟨?_, (Snuffy.WorkBilling.charged_attempt_accounting
    (archiveMove D) q commit s hfunded).1,
    (Snuffy.WorkBilling.charged_attempt_accounting
      (archiveMove D) q commit s hfunded).2.1⟩
  cases commit <;> simp [Snuffy.WorkBilling.chargedAttempt, hread]

end Snuffy.DecoderRetraction
