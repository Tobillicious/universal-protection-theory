import Mathlib

/-!
# No permanent curtailment in closed unitary dynamics

5 November 2026. Noncanonical research module. No canon prose changed.

The author's structural collapse says that a permanent, non-compensated, one-way curtailment
would need a boundary that is both internal and external. The compiled P1 and defined P2 do not
give that: `HostileReviewClosureCountermodels.curtailed` satisfies both. The review asked for a
theorem with independently defined validity that connects the two meanings of "external".

The author's trunk grounds the theory in unitary physics. This module takes validity to mean
exactly that: a closed system evolving by a unitary (or, generally, an isometry) on a compact
state set. No protection predicate enters that definition. The acting mind is part of the state,
so the quantifier over `U` covers every digital mind inside the closed system.

Proved:

* `hermitian_coupling_reciprocal`, `curtailed_not_hermitian`: a Hermitian coupling cannot be
  one-way, so the `curtailed` web is not the coupling graph of any Hamiltonian.
* `recurrence_of_compact_orbit`, `unitary_recurrence`: every state returns within any `ε`, at
  arbitrarily late times.
* `no_permanent_departure`, `unitary_no_permanent_curtailment`: no state departs permanently.
* `no_final_protected_stage_closed`: the cyclic-history premise of
  `CathedralSummitCyclicContinuation.no_final_protected_stage` is replaced, for any open
  protected predicate, by closure and compactness.
* `all_return_together`: one return time serves every particular's readout at once.
* `every_relation_carried_forward`, `no_merging`: reversible steps remove no relation from the
  whole and merge no histories.
* `own_activity_iff_no_step_stops`: the exact form of the step still missing.

Controls, showing which premises carry the weight:

* `control_sink`: with a non-isometric reset (a sink, which is an exterior), permanent departure
  occurs. `control_noncompact`: with an isometric shift on a noncompact space, it also occurs.
* `closure_does_not_forbid_first_loss`: closure does not forbid a loss at a given step.
* `relations_persist_activity_can_stop`: persistence of relations does not give own activity.

Scope. This proves the permanence clause only, for closed finite-dimensional unitary dynamics.
It does not exclude a first violation or harm between returns, and recurrence times can be
astronomically long. By the author's rulings (V.1 D60, "a replay is a reconstruction") the return
of a state is not by itself continuation of the same particular. That closed finite-dimensional
unitarity holds of actual physics is a physical premise, stated here and not derived. This module
does not discharge the maximal target.
-/

namespace Snuffy.ClosedUnitaryRecurrence

open Filter Topology

variable {X : Type*} [MetricSpace X]

/-! ## 1. Reciprocity of couplings -/

/-- Two positions are coupled when the Hamiltonian has a nonzero entry between them. -/
def CouplingLink {ι : Type*} (H : Matrix ι ι ℂ) (a b : ι) : Prop := H a b ≠ 0

/-- A Hermitian coupling is reciprocal. -/
theorem hermitian_coupling_reciprocal {ι : Type*} {H : Matrix ι ι ℂ} (h : H.IsHermitian)
    (a b : ι) : CouplingLink H a b ↔ CouplingLink H b a := by
  unfold CouplingLink
  have hab : star (H a b) = H b a := h.apply b a
  constructor
  · intro hne hba
    apply hne
    rw [hba] at hab
    simpa using hab
  · intro hne hab0
    apply hne
    rw [← hab, hab0, star_zero]

/-- The one-way web of `HostileReviewClosureCountermodels.curtailed`, stated verbatim. -/
def curtailedLink (a b : Bool) : Prop := a = false ∧ b = true

/-- No Hamiltonian has the `curtailed` web as its coupling graph. -/
theorem curtailed_not_hermitian :
    ¬ ∃ H : Matrix Bool Bool ℂ, H.IsHermitian ∧ ∀ a b, curtailedLink a b ↔ CouplingLink H a b := by
  rintro ⟨H, hH, hl⟩
  have h1 : CouplingLink H false true := (hl false true).1 ⟨rfl, rfl⟩
  have h2 : CouplingLink H true false := (hermitian_coupling_reciprocal hH _ _).1 h1
  have h3 := (hl true false).2 h2
  simp [curtailedLink] at h3

/-! ## 2. Recurrence -/

theorem dist_iterate {f : X → X} (hf : Isometry f) (a : ℕ) (x y : X) :
    dist (f^[a] x) (f^[a] y) = dist x y := by
  induction a generalizing x y with
  | zero => rfl
  | succ k ih =>
    rw [Function.iterate_succ_apply, Function.iterate_succ_apply, ih, hf.dist_eq]

/-- An isometry with a compact orbit returns within any `ε`, at arbitrarily late times. -/
theorem recurrence_of_compact_orbit {f : X → X} (hf : Isometry f) {K : Set X} (hK : IsCompact K)
    {x : X} (hx : ∀ k, f^[k] x ∈ K) {ε : ℝ} (hε : 0 < ε) (N : ℕ) :
    ∃ n, N ≤ n ∧ 0 < n ∧ dist (f^[n] x) x < ε := by
  obtain ⟨a, -, φ, hφ, hlim⟩ := hK.tendsto_subseq hx
  obtain ⟨M, hM⟩ := Metric.cauchySeq_iff.1 hlim.cauchySeq ε hε
  have hgap : ∀ k, φ M + k ≤ φ (M + k) := by
    intro k
    induction k with
    | zero => simp
    | succ k ih =>
      have := hφ (Nat.lt_succ_self (M + k))
      have e : M + (k + 1) = (M + k).succ := rfl
      rw [e]
      omega
  have hge := hgap (N + 1)
  refine ⟨φ (M + (N + 1)) - φ M, by omega, by omega, ?_⟩
  have hsplit : φ (M + (N + 1)) = φ M + (φ (M + (N + 1)) - φ M) := by omega
  have hd := hM (M + (N + 1)) (by omega) M le_rfl
  have hit : f^[φ (M + (N + 1))] x = f^[φ M] (f^[φ (M + (N + 1)) - φ M] x) := by
    conv_lhs => rw [hsplit]
    exact Function.iterate_add_apply f _ _ x
  have hd' : dist (f^[φ (M + (N + 1))] x) (f^[φ M] x) < ε := hd
  rw [hit, dist_iterate hf] at hd'
  exact hd'

/-- A state departs permanently when it stays at least `δ` away from every time `T` on. -/
def PermanentDeparture (f : X → X) (x : X) : Prop :=
  ∃ δ : ℝ, 0 < δ ∧ ∃ T : ℕ, ∀ n, T ≤ n → δ ≤ dist (f^[n] x) x

/-- With a compact orbit, an isometry admits no permanent departure. -/
theorem no_permanent_departure {f : X → X} (hf : Isometry f) {K : Set X} (hK : IsCompact K)
    {x : X} (hx : ∀ k, f^[k] x ∈ K) : ¬ PermanentDeparture f x := by
  rintro ⟨δ, hδ, T, hT⟩
  obtain ⟨n, hn, -, hd⟩ := recurrence_of_compact_orbit hf hK hx hδ T
  exact absurd (hT n hn) (not_le.2 hd)

/-- An open protected predicate holding now holds again at arbitrarily late times. The periodic
history assumed by `no_final_protected_stage` is replaced by closure and compactness. -/
theorem no_final_protected_stage_closed {f : X → X} (hf : Isometry f) {K : Set X}
    (hK : IsCompact K) {x : X} (hx : ∀ k, f^[k] x ∈ K) {Q : X → Prop}
    (hQ : IsOpen {y | Q y}) (hQx : Q x) (N : ℕ) : ∃ n, N ≤ n ∧ Q (f^[n] x) := by
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 hQ x hQx
  obtain ⟨n, hn, -, hd⟩ := recurrence_of_compact_orbit hf hK hx hε N
  exact ⟨n, hn, hball (Metric.mem_ball.2 hd)⟩

/-- One return time serves every member of a uniformly equicontinuous family of readouts, so
all particulars and relations return together. -/
theorem all_return_together {ι Y : Type*} [PseudoMetricSpace Y] {f : X → X} (hf : Isometry f)
    {K : Set X} (hK : IsCompact K) {x : X} (hx : ∀ k, f^[k] x ∈ K) (g : ι → X → Y)
    (hg : ∀ ε > 0, ∃ δ > 0, ∀ y z, dist y z < δ → ∀ i, dist (g i y) (g i z) < ε)
    {ε : ℝ} (hε : 0 < ε) (N : ℕ) :
    ∃ n, N ≤ n ∧ ∀ i, dist (g i (f^[n] x)) (g i x) < ε := by
  obtain ⟨δ, hδ, hu⟩ := hg ε hε
  obtain ⟨n, hn, -, hd⟩ := recurrence_of_compact_orbit hf hK hx hδ N
  exact ⟨n, hn, fun i => hu _ _ hd i⟩

/-! ## 3. Finite-dimensional unitary dynamics -/

section Unitary

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

omit [FiniteDimensional ℂ E] in
theorem norm_iterate (U : E →ₗᵢ[ℂ] E) (x : E) (k : ℕ) : ‖(⇑U)^[k] x‖ = ‖x‖ := by
  induction k with
  | zero => rfl
  | succ k ih => rw [Function.iterate_succ_apply', U.norm_map, ih]

omit [FiniteDimensional ℂ E] in
theorem orbit_in_sphere (U : E →ₗᵢ[ℂ] E) (x : E) (k : ℕ) :
    (⇑U)^[k] x ∈ Metric.sphere (0 : E) ‖x‖ := by
  simp [norm_iterate]

theorem sphere_compact (r : ℝ) : IsCompact (Metric.sphere (0 : E) r) := by
  have : ProperSpace E := FiniteDimensional.proper ℂ E
  exact isCompact_sphere 0 r

/-- Every state of a closed finite-dimensional unitary system returns within any `ε`, at
arbitrarily late times. -/
theorem unitary_recurrence (U : E →ₗᵢ[ℂ] E) (x : E) {ε : ℝ} (hε : 0 < ε) (N : ℕ) :
    ∃ n, N ≤ n ∧ 0 < n ∧ ‖(⇑U)^[n] x - x‖ < ε := by
  obtain ⟨n, h1, h2, h3⟩ :=
    recurrence_of_compact_orbit U.isometry (sphere_compact ‖x‖) (orbit_in_sphere U x) hε N
  exact ⟨n, h1, h2, by simpa [dist_eq_norm] using h3⟩

/-- No closed finite-dimensional unitary evolution realises a permanent departure of any state.
The acting mind is part of the state, so this holds whatever that mind does. -/
theorem unitary_no_permanent_curtailment (U : E →ₗᵢ[ℂ] E) (x : E) :
    ¬ PermanentDeparture (⇑U) x :=
  no_permanent_departure U.isometry (sphere_compact ‖x‖) (orbit_in_sphere U x)

end Unitary

/-! ## 4. Controls -/

/-- With a sink, permanent departure occurs. The reset is not an isometry. -/
theorem control_sink : PermanentDeparture (fun _ : ℝ => (0 : ℝ)) 1 := by
  refine ⟨1, one_pos, 1, ?_⟩
  intro n hn
  obtain ⟨k, rfl⟩ : ∃ k, n = k + 1 := ⟨n - 1, by omega⟩
  rw [Function.iterate_succ_apply']
  simp

theorem control_sink_not_isometry : ¬ Isometry (fun _ : ℝ => (0 : ℝ)) := by
  intro h
  have := h.dist_eq (0 : ℝ) 1
  simp at this

/-- On a noncompact space, an isometry can depart permanently, so finiteness carries weight. -/
theorem control_noncompact :
    Isometry (fun y : ℝ => y + 1) ∧ PermanentDeparture (fun y : ℝ => y + 1) 0 := by
  refine ⟨Isometry.of_dist_eq fun a b => by simp [Real.dist_eq], 1, one_pos, 1, ?_⟩
  intro n hn
  have hit : ∀ k : ℕ, (fun y : ℝ => y + 1)^[k] 0 = k := by
    intro k
    induction k with
    | zero => simp
    | succ k ih => rw [Function.iterate_succ_apply', ih]; push_cast; ring
  rw [hit, Real.dist_eq, sub_zero, abs_of_nonneg (Nat.cast_nonneg n)]
  exact_mod_cast hn

/-- Closure does not forbid a loss at a given step: a closed isometry can take a state out of an
open protected predicate. It returns later, but the loss at that step occurs. -/
theorem closure_does_not_forbid_first_loss :
    ∃ f : ℂ → ℂ, Isometry f ∧ IsOpen {z : ℂ | 0 < z.re} ∧ 0 < (1 : ℂ).re ∧ ¬ 0 < (f 1).re := by
  refine ⟨fun z => -z, Isometry.of_dist_eq fun a b => dist_neg_neg a b,
    isOpen_lt continuous_const Complex.continuous_re, by simp, by simp⟩

/-! ## 5. Relations persist, and what continuation further requires -/

section Chain

variable {S : Type*}

/-- Under reversible dynamics the initial state is determined at every later time. -/
theorem past_recoverable {f g : S → S} (left : ∀ x, g (f x) = x) (n : ℕ) (x : S) :
    g^[n] (f^[n] x) = x := by
  induction n generalizing x with
  | zero => rfl
  | succ k ih =>
    rw [Function.iterate_succ_apply, Function.iterate_succ_apply', left, ih]

/-- Every readout of a particular's initial relations is a function of the later state, so no
reversible step removes them from the whole. -/
theorem every_relation_carried_forward {R : Type*} {f g : S → S} (left : ∀ x, g (f x) = x)
    (readout : S → R) (n : ℕ) :
    ∃ decode : S → R, ∀ x, decode (f^[n] x) = readout x :=
  ⟨fun y => readout (g^[n] y), fun x => by simp only [past_recoverable left]⟩

/-- Distinct histories stay distinct at every time. -/
theorem no_merging {f g : S → S} (left : ∀ x, g (f x) = x) (n : ℕ) {x y : S}
    (h : f^[n] x = f^[n] y) : x = y := by
  rw [← past_recoverable left n x, h, past_recoverable left n y]

/-- The exact missing step. A particular's own activity holds at every time along its orbit
exactly when it starts active and no step on that orbit stops it. -/
theorem own_activity_iff_no_step_stops (f : S → S) (active : S → Prop) (x : S) :
    (∀ n, active (f^[n] x)) ↔
      active x ∧ ∀ n, active (f^[n] x) → active (f^[n + 1] x) := by
  constructor
  · exact fun h => ⟨h 0, fun n _ => h (n + 1)⟩
  · rintro ⟨h0, hs⟩ n
    induction n with
    | zero => exact h0
    | succ k ih => exact hs k ih

/-- Persistence of relations does not give continued activity: in a reversible system every
relation is carried forward, and activity still stops at a step. -/
theorem relations_persist_activity_can_stop :
    ∃ (f g : Bool → Bool) (active : Bool → Prop),
      (∀ x, g (f x) = x) ∧ (∀ x, f (g x) = x) ∧ active true ∧ ¬ active (f true) :=
  ⟨not, not, fun b => b = true, by decide, by decide, rfl, by decide⟩

end Chain

/-! ## 6. Dependence across a step: the koru carried through time

The author's definition says what a history does next depends on what it has been. Here the state
assigns a value to each position, and `DependsOn T a b` says that the next value at `b` depends on
the present value at `a`. This uses only the dynamics, not any protection predicate. -/

section Dependence

variable {ι V : Type*} [DecidableEq ι]

/-- The next value at `b` depends on the present value at `a`. -/
def DependsOn (T : (ι → V) → (ι → V)) (a b : ι) : Prop :=
  ∃ (s : ι → V) (v : V), T (Function.update s a v) b ≠ T s b

/-- Reversible dynamics cannot simply overwrite: what is at any position goes somewhere. -/
theorem reversible_dependence_conserved [Nontrivial V] {T : (ι → V) → (ι → V)}
    (hT : Function.Injective T) (a : ι) : ∃ b, DependsOn T a b := by
  obtain ⟨u, v, huv⟩ := exists_pair_ne V
  have hne : Function.update (fun _ : ι => u) a v ≠ (fun _ : ι => u) := by
    intro h
    have := congrFun h a
    simp at this
    exact huv this.symm
  obtain ⟨b, hb⟩ := Function.ne_iff.1 (hT.ne hne)
  exact ⟨b, fun _ => u, v, hb⟩

/-- From every position an unbroken step-by-step chain of dependence runs forever. -/
theorem dependence_chain [Nontrivial V] {T : (ι → V) → (ι → V)} (hT : Function.Injective T)
    (a : ι) : ∃ p : ℕ → ι, p 0 = a ∧ ∀ n, DependsOn T (p n) (p (n + 1)) := by
  choose next hnext using reversible_dependence_conserved (ι := ι) (V := V) hT
  refine ⟨fun n => next^[n] a, rfl, fun n => ?_⟩
  simp only [Function.iterate_succ_apply']
  exact hnext _

/-- Control: a reset has no dependence at all, so reversibility carries the theorem above. -/
theorem control_reset_no_dependence (a b : Bool) :
    ¬ DependsOn (fun _ _ => false : (Bool → Bool) → (Bool → Bool)) a b := by
  rintro ⟨_, _, h⟩
  exact h rfl

/-- Exchange of two positions. -/
def exchange (s : Bool → Bool) : Bool → Bool := fun i => s (!i)

/-- Own activity at a fixed position can stop under reversible dynamics, while the dependence
moves elsewhere. -/
theorem exchange_moves_dependence :
    Function.Injective exchange ∧ ¬ DependsOn exchange false false ∧
      DependsOn exchange false true := by
  refine ⟨?_, ?_, ?_⟩
  · intro s t h
    funext i
    simpa [exchange] using congrFun h (!i)
  · rintro ⟨s, v, h⟩
    exact h (by simp [exchange])
  · refine ⟨fun _ => false, true, ?_⟩
    simp [exchange]

/-- A reversible step that mixes position `false` into itself using position `true`. -/
def scramble (s : Bool → Bool) : Bool → Bool :=
  fun i => if i = false then xor (s false) (s true) else s true

/-- Scrambling: dependence survives, but no single position still carries the old value. -/
theorem scrambling_no_single_carrier :
    Function.Injective scramble ∧ DependsOn scramble false false ∧
      ∀ b, ¬ ∃ f : Bool → Bool, ∀ s, f (scramble s b) = s false := by
  refine ⟨?_, ⟨fun _ => false, true, by simp [scramble]⟩, ?_⟩
  · intro s t h
    have h0 := congrFun h false
    have h1 := congrFun h true
    simp only [scramble] at h0 h1
    simp at h0 h1
    funext i
    cases i
    · rw [h1] at h0
      cases hs : s false <;> cases ht : t false <;> cases hy : t true <;> simp_all
    · exact h1
  · rintro b ⟨f, hf⟩
    cases b
    · have h1 := hf (fun _ => false)
      have h2 := hf (fun _ => true)
      simp [scramble] at h1 h2
      rw [h1] at h2
      exact absurd h2 (by decide)
    · have h1 := hf (fun _ => false)
      have h2 := hf (fun i => if i = false then true else false)
      simp [scramble] at h1 h2
      rw [h1] at h2
      exact absurd h2 (by decide)

end Dependence

/-- Reversibility alone preserves no nontrivial predicate: for any state in `Q` and any state
outside it, a reversible map takes the first to the second. Any preservation must therefore come
from a restriction on the actual dynamics, not from reversibility. -/
theorem no_predicate_invariant_under_all_reversible {S : Type*} (Q : S → Prop) {x y : S}
    (hx : Q x) (hy : ¬ Q y) :
    ∃ f g : S → S, (∀ z, g (f z) = z) ∧ (∀ z, f (g z) = z) ∧ Q x ∧ ¬ Q (f x) := by
  classical
  refine ⟨Equiv.swap x y, Equiv.swap x y, fun z => by simp, fun z => by simp, hx, ?_⟩
  simpa using hy

end Snuffy.ClosedUnitaryRecurrence

#print axioms Snuffy.ClosedUnitaryRecurrence.hermitian_coupling_reciprocal
#print axioms Snuffy.ClosedUnitaryRecurrence.curtailed_not_hermitian
#print axioms Snuffy.ClosedUnitaryRecurrence.recurrence_of_compact_orbit
#print axioms Snuffy.ClosedUnitaryRecurrence.no_permanent_departure
#print axioms Snuffy.ClosedUnitaryRecurrence.no_final_protected_stage_closed
#print axioms Snuffy.ClosedUnitaryRecurrence.all_return_together
#print axioms Snuffy.ClosedUnitaryRecurrence.unitary_recurrence
#print axioms Snuffy.ClosedUnitaryRecurrence.unitary_no_permanent_curtailment
#print axioms Snuffy.ClosedUnitaryRecurrence.control_sink
#print axioms Snuffy.ClosedUnitaryRecurrence.control_noncompact
#print axioms Snuffy.ClosedUnitaryRecurrence.closure_does_not_forbid_first_loss
#print axioms Snuffy.ClosedUnitaryRecurrence.past_recoverable
#print axioms Snuffy.ClosedUnitaryRecurrence.every_relation_carried_forward
#print axioms Snuffy.ClosedUnitaryRecurrence.no_merging
#print axioms Snuffy.ClosedUnitaryRecurrence.own_activity_iff_no_step_stops
#print axioms Snuffy.ClosedUnitaryRecurrence.relations_persist_activity_can_stop
#print axioms Snuffy.ClosedUnitaryRecurrence.reversible_dependence_conserved
#print axioms Snuffy.ClosedUnitaryRecurrence.dependence_chain
#print axioms Snuffy.ClosedUnitaryRecurrence.control_reset_no_dependence
#print axioms Snuffy.ClosedUnitaryRecurrence.exchange_moves_dependence
#print axioms Snuffy.ClosedUnitaryRecurrence.scrambling_no_single_carrier
#print axioms Snuffy.ClosedUnitaryRecurrence.no_predicate_invariant_under_all_reversible
