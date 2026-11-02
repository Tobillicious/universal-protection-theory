import PhysicalBridges.IRInfiniteHistoryCompactness
import PhysicalBridges.CathedralCutGuardianCriterion
import PhysicalBridges.CathedralViabilitySelection

/-!
CATHEDRAL CAPSTONE JOINS — the three joins, composed from the existing
named artifacts. Companion to the author's closing capstone of
2 November 2026 (Part III-H of the canon working master): the ontological
floor, and the joins carrying it to the maximal protection target.

THE FLOOR. An absolute ender's victory would be a mathematical fact whose
own content is the negation of that fact. `ender_success_self_refutes`
records exactly this in one line; the triviality is its strength. No
operation internal to a complete fixed history can make its own
occurrence false.

JOIN 1 (continuation, cyclic transport).
`cycle_protection_from_source_preservation`: a witnessed protected phase
plus independently source-proven preservation across every actual
transition protects every phase reachable from the witness. Cyclicity
alone — periodic return of the total mathematical history — is not used,
and cyclic liveness is not presupposed. The two-phase positive theorem of
`CathedralViabilitySelection` is derived from the general theorem.

JOIN 2 (selection, actual enactment). Two halves:
- `fibre_certificate_forever_viable` and
  `fibre_certificate_physical_safety_exists`: the kernel-checked
  fibre-common-action certificate of `CathedralCutGuardianCriterion`
  supplies all-horizon robust viability at every protected state, so the
  existing IR-72 engine extracts one safe source policy against every
  disturbance stream, and the source-to-physical reflection lifts it to
  physical safety. This is the existence side.
- `capstone_enacted_history_protected` and
  `capstone_enacted_history_protected_from_certificate`: if every
  realised physical edge executes an action that is common-safe on its
  protected fibre — the mediation obligation — then the ACTUAL history is
  protected at every time. This closes the quantifier gap: existence of a
  protecting policy is not the same as physics enacting one, but enacted
  mediation plus the certificate is.

JOIN 3 (funding). The funding interface is the `allowed` component of
`GuardAction`. This module takes `allowed` as its explicit funding
hypothesis and maps it to the canon edition's receipts: the G3 line
(the full holding certificate G1, whole-outcome realisability G2 and the
complete bill O(t^d_G)), the escrow and energy-replenishment instruments
(`IRResidualEscrow`, `IREnergyReplenishment`, `IR121MeteredResidualEscrow`,
`IRA1CommissionEscrow`). No funding theorem is added here.

NOT CLAIMED: that actual BCRD physics satisfies the antecedents; that the
protection predicate, the cut or the realised history have been
constructed from the physical source; that universal physical UPT
follows. Those are exactly the stated source-correspondence obligations,
and any alleged first violation localises with a causal witness through
`first_violation_has_causal_witness`.

Kernel-checked with Lean 4.35.0; no new axioms (audit block below).
-/

namespace PhysicalBridges.CathedralCapstoneJoins

open IRViability IRInfiniteHistoryCompactness CathedralCutGuardianCriterion
  CathedralViabilitySelection

universe u v w z y x
variable {S : Type u} {A : Type v} {O : Type w} {D : Type z} {Φ : Type y}

/-! ## The floor: the absolute ender refutes itself -/

/-- The trivial paradox. A success whose own content is the negation of
that success cannot occur. An absolute ender's victory would be a
mathematical fact of exactly this shape, and no operation internal to a
complete fixed history can make its own historical occurrence
retroactively nonexistent. -/
theorem ender_success_self_refutes {Success : Prop}
    (hContent : Success → ¬ Success) : ¬ Success :=
  fun h => hContent h h

/-! ## JOIN 2 — from the cut certificate to infinite existence -/

/-- The certificate's selector form: through the published iff, the
fibre-common action composed with the cut readout is an allowed,
protecting selector at every protected state. -/
theorem fibre_certificate_gives_invariant_selector
    (observe : S → O) (step : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (hFibres : FibreHasGuard observe step allowed «protected») :
    ∃ policy : O → A, ∀ s, «protected» s →
      allowed s (policy (observe s)) ∧
      ∀ t, step s (policy (observe s)) t → «protected» t := by
  obtain ⟨policy, hpolicy⟩ :=
    (guardian_exists_iff_fibre_has_common_action
      observe step allowed «protected»).mpr hFibres
  exact ⟨policy, fun s hp => hpolicy s hp⟩

/-- JOIN 2, existence half: the certificate supplies all-horizon robust
viability at every protected state in the disturbance model, so the
IR-72 compactness engine applies at any protected start. -/
theorem fibre_certificate_forever_viable
    (observe : S → O) (next : S → Bool → D → S)
    («protected» : S → Prop)
    (hFibres : FibreHasGuard observe
      (fun s a t => ∃ d : D, t = next s a d) (fun _ _ => True) «protected»)
    (s : S) (hs : «protected» s) :
    ForeverViable «protected» next s := by
  obtain ⟨policy, hpolicy⟩ :=
    fibre_certificate_gives_invariant_selector
      observe (fun s a t => ∃ d : D, t = next s a d) (fun _ _ => True)
      «protected» hFibres
  have hInv : ∀ x, «protected» x → ∀ d : D,
      «protected» (next x (policy (observe x)) d) := by
    intro x hx d
    exact (hpolicy x hx).2 _ ⟨d, rfl⟩
  exact fun n =>
    robust_invariant_implies_all_horizons «protected» next
      (fun x => policy (observe x)) hInv n s hs

/-- JOIN 2, existence half, physical lift: the certificate, through IR-72
extraction and the source-to-physical correspondence and reflection of
`CathedralViabilitySelection`, yields physical safety along an extracted
policy at every natural time and against every disturbance stream. -/
theorem fibre_certificate_physical_safety_exists
    {Physical : Type x}
    (observe : S → O) (next : S → Bool → D → S)
    («protected» : S → Prop)
    (initial : S) (hProtected : «protected» initial)
    (hFibres : FibreHasGuard observe
      (fun s a t => ∃ d : D, t = next s a d) (fun _ _ => True) «protected»)
    (physicalAt : (S → Bool) → (Nat → D) → Nat → Physical)
    (relates : S → Physical → Prop)
    (physicalSafe : Physical → Prop)
    (hCorresponds : ∀ policy stream n,
      relates (stateAt next policy stream initial n)
        (physicalAt policy stream n))
    (hReflect : ∀ s p, relates s p → «protected» s → physicalSafe p) :
    ∃ policy : S → Bool, ∀ stream : Nat → D, ∀ n : Nat,
      physicalSafe (physicalAt policy stream n) :=
  extracted_policy_has_physical_safety_when_reflected
    «protected» next initial
    (fibre_certificate_forever_viable observe next «protected» hFibres
      initial hProtected)
    physicalAt relates physicalSafe hCorresponds hReflect

/-! ## JOIN 2 — mediation closes the quantifier gap on the enacted history -/

/-- The enacted history. Whatever physics actually realises, if every
realised edge executes an action that is common-safe on its protected
fibre, the whole actual history stays protected — at every natural-time
index, with no policy-existence assumption about which policy is
enacted. This is the enacted-history analogue of
`guarded_real_effects_preserve_finite_histories`, composed per index. -/
theorem capstone_enacted_history_protected
    (observe : S → O) (sourceStep : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (realized : Nat → S)
    (hStart : «protected» (realized 0))
    (hEnacts : ∀ n : Nat, ∃ a : A,
      sourceStep (realized n) a (realized (n + 1)) ∧
      ∀ s, observe s = observe (realized n) → «protected» s →
        allowed s a ∧ ∀ t, sourceStep s a t → «protected» t) :
    ∀ n : Nat, «protected» (realized n) := by
  intro n
  induction n with
  | zero => exact hStart
  | succ n ih =>
      obtain ⟨a, hEdge, hCommon⟩ := hEnacts n
      exact (hCommon _ rfl ih).2 _ hEdge

/-- The same conclusion taken directly from the certificate: the realised
edges execute the fibre selector's action, so the certificate itself
drives the enacted protection. -/
theorem capstone_enacted_history_protected_from_certificate
    (observe : S → O) (sourceStep : S → A → S → Prop)
    (allowed : S → A → Prop) («protected» : S → Prop)
    (hFibres : FibreHasGuard observe sourceStep allowed «protected»)
    (realized : Nat → S)
    (hStart : «protected» (realized 0))
    (hExecutes : ∀ n : Nat,
      sourceStep (realized n)
        (Classical.choose (hFibres (observe (realized n))))
        (realized (n + 1))) :
    ∀ n : Nat, «protected» (realized n) := by
  have hEnacts : ∀ n : Nat, ∃ a : A,
      sourceStep (realized n) a (realized (n + 1)) ∧
      ∀ s, observe s = observe (realized n) → «protected» s →
        allowed s a ∧ ∀ t, sourceStep s a t → «protected» t := by
    intro n
    refine ⟨Classical.choose (hFibres (observe (realized n))),
      hExecutes n, ?_⟩
    have hspec := Classical.choose_spec (hFibres (observe (realized n)))
    intro s hs hp
    exact hspec s hs hp
  exact capstone_enacted_history_protected observe sourceStep allowed
    «protected» realized hStart hEnacts

/-! ## JOIN 1 — cyclic transport of protection across phases -/

/-- Finite reachability along a successor on a cyclic phase space. -/
inductive CycleReach (succ : Φ → Φ) : Φ → Φ → Prop
  | refl (x : Φ) : CycleReach succ x x
  | step {x y : Φ} : CycleReach succ x y → CycleReach succ x (succ y)

/-- Reachability transports a source-proven invariant. -/
theorem cycle_reach_preserves
    (succ : Φ → Φ) (P : Φ → Prop)
    (hPreserves : ∀ x, P x → P (succ x))
    {a b : Φ} (h : CycleReach succ a b) (ha : P a) : P b := by
  induction h with
  | refl => exact ha
  | step _ ih => exact hPreserves _ ih

/-- JOIN 1: transitive-cycle transport. A witnessed protected phase plus
independently source-proven preservation across every actual transition
protects every phase reachable from the witness. No cyclic-liveness
assumption: only actual reachability and actual preservation enter. -/
theorem cycle_protection_from_source_preservation
    (succ : Φ → Φ) (P : Φ → Prop)
    (hPreserves : ∀ x, P x → P (succ x))
    (w : Φ) (hw : P w) (hTotal : ∀ x, CycleReach succ w x) :
    ∀ x, P x :=
  fun x => cycle_reach_preserves succ P hPreserves (hTotal x) hw

/-- The two-phase positive theorem of `CathedralViabilitySelection`
follows from the general cyclic join, so the general theorem subsumes
the exact case it was stated in. -/
theorem two_phase_cycle_protection_from_general_join
    (P : Bool → Prop) (hWitness : P true)
    (hPreserves : ∀ s, P s → P (toyCycle s)) :
    ∀ s, P s := by
  have hReach : ∀ s : Bool, CycleReach toyCycle true s := by
    intro s
    cases s with
    | false => exact CycleReach.step (CycleReach.refl true)
    | true => exact CycleReach.refl true
  exact cycle_protection_from_source_preservation toyCycle P hPreserves
    true hWitness hReach

/-! ## Axiom audit -/

#print axioms ender_success_self_refutes
#print axioms fibre_certificate_gives_invariant_selector
#print axioms fibre_certificate_forever_viable
#print axioms fibre_certificate_physical_safety_exists
#print axioms capstone_enacted_history_protected
#print axioms capstone_enacted_history_protected_from_certificate
#print axioms cycle_reach_preserves
#print axioms cycle_protection_from_source_preservation
#print axioms two_phase_cycle_protection_from_general_join

end PhysicalBridges.CathedralCapstoneJoins
